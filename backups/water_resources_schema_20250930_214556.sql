--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4 (Debian 15.4-1.pgdg110+1)
-- Dumped by pg_dump version 15.4 (Debian 15.4-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: geouser
--

CREATE SCHEMA tiger;


ALTER SCHEMA tiger OWNER TO geouser;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: geouser
--

CREATE SCHEMA tiger_data;


ALTER SCHEMA tiger_data OWNER TO geouser;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: geouser
--

CREATE SCHEMA topology;


ALTER SCHEMA topology OWNER TO geouser;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: geouser
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: boreholes; Type: TABLE; Schema: public; Owner: geouser
--

CREATE TABLE public.boreholes (
    id integer NOT NULL,
    borehole_id character varying(50) NOT NULL,
    drilling_company character varying(200),
    total_depth_m numeric(8,2),
    pump_capacity_lph numeric(10,2),
    drilling_cost numeric(12,2),
    completion_date date,
    status character varying(30) DEFAULT 'active'::character varying,
    name character varying(200),
    description text,
    feature_type character varying(20) DEFAULT 'borehole'::character varying,
    geom public.geometry(Point,4326) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.boreholes OWNER TO geouser;

--
-- Name: boreholes_id_seq; Type: SEQUENCE; Schema: public; Owner: geouser
--

CREATE SEQUENCE public.boreholes_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.boreholes_id_seq OWNER TO geouser;

--
-- Name: boreholes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: geouser
--

ALTER SEQUENCE public.boreholes_id_seq OWNED BY public.boreholes.id;


--
-- Name: feature_construction_details; Type: TABLE; Schema: public; Owner: geouser
--

CREATE TABLE public.feature_construction_details (
    id integer NOT NULL,
    feature_id character varying(255) NOT NULL,
    feature_type character varying(50) NOT NULL,
    contractor_name character varying(255) NOT NULL,
    contractor_license character varying(100),
    contractor_contact character varying(255),
    construction_method character varying(255) NOT NULL,
    construction_start_date date NOT NULL,
    construction_end_date date NOT NULL,
    construction_duration_days integer NOT NULL,
    construction_cost numeric(12,2) NOT NULL,
    depth_m numeric(8,2) NOT NULL,
    diameter_m numeric(8,2),
    length_m numeric(8,2),
    width_m numeric(8,2),
    lining_material character varying(255),
    materials_used text[],
    equipment_used text[],
    warranty_period_months integer,
    quality_certificate_number character varying(100),
    environmental_compliance character varying(255),
    project_status character varying(50) DEFAULT 'Completed'::character varying,
    quality_rating integer,
    final_inspection_date date,
    additional_notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT feature_construction_details_quality_rating_check CHECK (((quality_rating >= 1) AND (quality_rating <= 5)))
);


ALTER TABLE public.feature_construction_details OWNER TO geouser;

--
-- Name: TABLE feature_construction_details; Type: COMMENT; Schema: public; Owner: geouser
--

COMMENT ON TABLE public.feature_construction_details IS 'Detailed construction information for water infrastructure features';


--
-- Name: feature_construction_details_id_seq; Type: SEQUENCE; Schema: public; Owner: geouser
--

CREATE SEQUENCE public.feature_construction_details_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feature_construction_details_id_seq OWNER TO geouser;

--
-- Name: feature_construction_details_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: geouser
--

ALTER SEQUENCE public.feature_construction_details_id_seq OWNED BY public.feature_construction_details.id;


--
-- Name: feature_maintenance_activities; Type: TABLE; Schema: public; Owner: geouser
--

CREATE TABLE public.feature_maintenance_activities (
    id integer NOT NULL,
    feature_id character varying(50) NOT NULL,
    feature_type character varying(20) NOT NULL,
    activity_date date NOT NULL,
    activity_type character varying(50) NOT NULL,
    activity_status character varying(20) NOT NULL,
    priority character varying(10) NOT NULL,
    cost numeric(8,2) NOT NULL,
    duration_hours integer NOT NULL,
    technician character varying(100) NOT NULL,
    description text NOT NULL,
    parts_replaced text[],
    equipment_used text[],
    effectiveness_rating integer,
    next_maintenance_date date,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT feature_maintenance_activities_activity_status_check CHECK (((activity_status)::text = ANY ((ARRAY['completed'::character varying, 'in_progress'::character varying, 'scheduled'::character varying, 'overdue'::character varying])::text[]))),
    CONSTRAINT feature_maintenance_activities_effectiveness_rating_check CHECK (((effectiveness_rating >= 1) AND (effectiveness_rating <= 5))),
    CONSTRAINT feature_maintenance_activities_feature_type_check CHECK (((feature_type)::text = ANY ((ARRAY['well'::character varying, 'pond'::character varying, 'borehole'::character varying])::text[]))),
    CONSTRAINT feature_maintenance_activities_priority_check CHECK (((priority)::text = ANY ((ARRAY['low'::character varying, 'medium'::character varying, 'high'::character varying])::text[])))
);


ALTER TABLE public.feature_maintenance_activities OWNER TO geouser;

--
-- Name: feature_maintenance_activities_id_seq; Type: SEQUENCE; Schema: public; Owner: geouser
--

CREATE SEQUENCE public.feature_maintenance_activities_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feature_maintenance_activities_id_seq OWNER TO geouser;

--
-- Name: feature_maintenance_activities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: geouser
--

ALTER SEQUENCE public.feature_maintenance_activities_id_seq OWNED BY public.feature_maintenance_activities.id;


--
-- Name: feature_water_quality_reports; Type: TABLE; Schema: public; Owner: geouser
--

CREATE TABLE public.feature_water_quality_reports (
    id integer NOT NULL,
    feature_id character varying(50) NOT NULL,
    feature_type character varying(20) NOT NULL,
    test_date date NOT NULL,
    ph_level numeric(3,1) NOT NULL,
    tds_ppm integer NOT NULL,
    conductivity integer NOT NULL,
    turbidity numeric(4,1) NOT NULL,
    temperature numeric(4,1) NOT NULL,
    ecoli_count integer DEFAULT 0 NOT NULL,
    coliform_count integer DEFAULT 0 NOT NULL,
    overall_quality character varying(20) NOT NULL,
    testing_laboratory character varying(100) NOT NULL,
    next_test_due_date date,
    recommended_treatment text,
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT feature_water_quality_reports_feature_type_check CHECK (((feature_type)::text = ANY ((ARRAY['well'::character varying, 'pond'::character varying, 'borehole'::character varying])::text[]))),
    CONSTRAINT feature_water_quality_reports_overall_quality_check CHECK (((overall_quality)::text = ANY ((ARRAY['excellent'::character varying, 'good'::character varying, 'fair'::character varying, 'poor'::character varying, 'unacceptable'::character varying])::text[])))
);


ALTER TABLE public.feature_water_quality_reports OWNER TO geouser;

--
-- Name: feature_water_quality_reports_id_seq; Type: SEQUENCE; Schema: public; Owner: geouser
--

CREATE SEQUENCE public.feature_water_quality_reports_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.feature_water_quality_reports_id_seq OWNER TO geouser;

--
-- Name: feature_water_quality_reports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: geouser
--

ALTER SEQUENCE public.feature_water_quality_reports_id_seq OWNED BY public.feature_water_quality_reports.id;


--
-- Name: maintenance_history; Type: TABLE; Schema: public; Owner: geouser
--

CREATE TABLE public.maintenance_history (
    id integer NOT NULL,
    feature_id character varying(255) NOT NULL,
    maintenance_date date NOT NULL,
    maintenance_type character varying(100) NOT NULL,
    description text NOT NULL,
    technician_name character varying(255),
    cost numeric(10,2),
    parts_replaced text[],
    hours_spent numeric(4,1),
    next_maintenance_due date,
    urgency_level character varying(20) DEFAULT 'Routine'::character varying,
    completion_status character varying(20) DEFAULT 'Completed'::character varying,
    before_photos text[],
    after_photos text[],
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.maintenance_history OWNER TO geouser;

--
-- Name: TABLE maintenance_history; Type: COMMENT; Schema: public; Owner: geouser
--

COMMENT ON TABLE public.maintenance_history IS 'Maintenance records and schedules for water infrastructure features';


--
-- Name: maintenance_history_id_seq; Type: SEQUENCE; Schema: public; Owner: geouser
--

CREATE SEQUENCE public.maintenance_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.maintenance_history_id_seq OWNER TO geouser;

--
-- Name: maintenance_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: geouser
--

ALTER SEQUENCE public.maintenance_history_id_seq OWNED BY public.maintenance_history.id;


--
-- Name: ponds; Type: TABLE; Schema: public; Owner: geouser
--

CREATE TABLE public.ponds (
    id integer NOT NULL,
    pond_id character varying(50) NOT NULL,
    name character varying(200) NOT NULL,
    surface_area_sqm numeric(12,2),
    maximum_depth_m numeric(6,2),
    is_perennial boolean DEFAULT false,
    primary_use character varying(50),
    capacity_liters bigint,
    status character varying(30) DEFAULT 'active'::character varying,
    description text,
    feature_type character varying(20) DEFAULT 'pond'::character varying,
    geom public.geometry(Point,4326) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.ponds OWNER TO geouser;

--
-- Name: ponds_id_seq; Type: SEQUENCE; Schema: public; Owner: geouser
--

CREATE SEQUENCE public.ponds_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ponds_id_seq OWNER TO geouser;

--
-- Name: ponds_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: geouser
--

ALTER SEQUENCE public.ponds_id_seq OWNED BY public.ponds.id;


--
-- Name: wells; Type: TABLE; Schema: public; Owner: geouser
--

CREATE TABLE public.wells (
    id integer NOT NULL,
    well_id character varying(50) NOT NULL,
    owner character varying(200),
    well_type character varying(50),
    depth_m numeric(8,2),
    static_water_level_m numeric(8,2),
    yield_liters_per_hour numeric(10,2),
    status character varying(30) DEFAULT 'active'::character varying,
    name character varying(200),
    description text,
    feature_type character varying(20) DEFAULT 'well'::character varying,
    geom public.geometry(Point,4326) NOT NULL,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.wells OWNER TO geouser;

--
-- Name: v_water_infrastructure_comprehensive; Type: VIEW; Schema: public; Owner: geouser
--

CREATE VIEW public.v_water_infrastructure_comprehensive AS
 SELECT wells.well_id AS id,
    wells.name,
    'well'::text AS type,
    wells.feature_type,
    wells.well_type AS subtype,
    wells.depth_m,
    wells.owner,
    wells.status,
    wells.description,
    wells.geom
   FROM public.wells
UNION ALL
 SELECT ponds.pond_id AS id,
    ponds.name,
    'pond'::text AS type,
    ponds.feature_type,
    ponds.primary_use AS subtype,
    ponds.maximum_depth_m AS depth_m,
    'Community'::character varying AS owner,
    ponds.status,
    ponds.description,
    ponds.geom
   FROM public.ponds
UNION ALL
 SELECT boreholes.borehole_id AS id,
    boreholes.name,
    'borehole'::text AS type,
    boreholes.feature_type,
    'drilled'::character varying AS subtype,
    boreholes.total_depth_m AS depth_m,
    boreholes.drilling_company AS owner,
    boreholes.status,
    boreholes.description,
    boreholes.geom
   FROM public.boreholes;


ALTER TABLE public.v_water_infrastructure_comprehensive OWNER TO geouser;

--
-- Name: water_management_zones_detailed; Type: TABLE; Schema: public; Owner: geouser
--

CREATE TABLE public.water_management_zones_detailed (
    id integer NOT NULL,
    zone_id character varying(50) NOT NULL,
    zone_name character varying(200) NOT NULL,
    zone_type character varying(50) NOT NULL,
    administrative_level character varying(30) NOT NULL,
    total_infrastructure_count integer DEFAULT 0,
    wells_count integer DEFAULT 0,
    boreholes_count integer DEFAULT 0,
    ponds_count integer DEFAULT 0,
    zone_status character varying(30) DEFAULT 'active'::character varying,
    population_served integer DEFAULT 0,
    area_km2 numeric(10,2),
    water_stress_level character varying(20) DEFAULT 'moderate'::character varying,
    priority_level character varying(20) DEFAULT 'medium'::character varying,
    management_agency character varying(100),
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    last_updated timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    notes text,
    geom public.geometry(Polygon,4326)
);


ALTER TABLE public.water_management_zones_detailed OWNER TO geouser;

--
-- Name: v_water_management_zones_detailed; Type: VIEW; Schema: public; Owner: geouser
--

CREATE VIEW public.v_water_management_zones_detailed AS
 SELECT water_management_zones_detailed.zone_id AS id,
    water_management_zones_detailed.zone_name AS name,
    water_management_zones_detailed.zone_type AS type,
    water_management_zones_detailed.administrative_level,
    water_management_zones_detailed.total_infrastructure_count,
    water_management_zones_detailed.wells_count,
    water_management_zones_detailed.boreholes_count,
    water_management_zones_detailed.ponds_count,
    water_management_zones_detailed.zone_status AS status,
    water_management_zones_detailed.population_served,
    water_management_zones_detailed.area_km2,
    water_management_zones_detailed.water_stress_level,
    water_management_zones_detailed.priority_level,
    water_management_zones_detailed.management_agency,
    water_management_zones_detailed.notes,
    water_management_zones_detailed.geom
   FROM public.water_management_zones_detailed;


ALTER TABLE public.v_water_management_zones_detailed OWNER TO geouser;

--
-- Name: water_management_zones_detailed_id_seq; Type: SEQUENCE; Schema: public; Owner: geouser
--

CREATE SEQUENCE public.water_management_zones_detailed_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.water_management_zones_detailed_id_seq OWNER TO geouser;

--
-- Name: water_management_zones_detailed_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: geouser
--

ALTER SEQUENCE public.water_management_zones_detailed_id_seq OWNED BY public.water_management_zones_detailed.id;


--
-- Name: water_quality_history; Type: TABLE; Schema: public; Owner: geouser
--

CREATE TABLE public.water_quality_history (
    id integer NOT NULL,
    feature_id character varying(255) NOT NULL,
    test_date date NOT NULL,
    ph_level numeric(3,2),
    turbidity_ntu numeric(8,2),
    tds_ppm integer,
    chlorine_residual_ppm numeric(4,2),
    bacteria_count_cfu integer,
    nitrate_ppm numeric(6,2),
    fluoride_ppm numeric(4,2),
    arsenic_ppb numeric(6,2),
    iron_ppm numeric(5,2),
    manganese_ppm numeric(5,2),
    hardness_ppm integer,
    conductivity_us_cm integer,
    temperature_c numeric(4,1),
    dissolved_oxygen_ppm numeric(4,2),
    test_lab character varying(255),
    lab_technician character varying(255),
    compliance_status character varying(50),
    notes text,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.water_quality_history OWNER TO geouser;

--
-- Name: TABLE water_quality_history; Type: COMMENT; Schema: public; Owner: geouser
--

COMMENT ON TABLE public.water_quality_history IS 'Historical water quality test results for water infrastructure features';


--
-- Name: water_quality_history_id_seq; Type: SEQUENCE; Schema: public; Owner: geouser
--

CREATE SEQUENCE public.water_quality_history_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.water_quality_history_id_seq OWNER TO geouser;

--
-- Name: water_quality_history_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: geouser
--

ALTER SEQUENCE public.water_quality_history_id_seq OWNED BY public.water_quality_history.id;


--
-- Name: wells_id_seq; Type: SEQUENCE; Schema: public; Owner: geouser
--

CREATE SEQUENCE public.wells_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.wells_id_seq OWNER TO geouser;

--
-- Name: wells_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: geouser
--

ALTER SEQUENCE public.wells_id_seq OWNED BY public.wells.id;


--
-- Name: boreholes id; Type: DEFAULT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.boreholes ALTER COLUMN id SET DEFAULT nextval('public.boreholes_id_seq'::regclass);


--
-- Name: feature_construction_details id; Type: DEFAULT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.feature_construction_details ALTER COLUMN id SET DEFAULT nextval('public.feature_construction_details_id_seq'::regclass);


--
-- Name: feature_maintenance_activities id; Type: DEFAULT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.feature_maintenance_activities ALTER COLUMN id SET DEFAULT nextval('public.feature_maintenance_activities_id_seq'::regclass);


--
-- Name: feature_water_quality_reports id; Type: DEFAULT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.feature_water_quality_reports ALTER COLUMN id SET DEFAULT nextval('public.feature_water_quality_reports_id_seq'::regclass);


--
-- Name: maintenance_history id; Type: DEFAULT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.maintenance_history ALTER COLUMN id SET DEFAULT nextval('public.maintenance_history_id_seq'::regclass);


--
-- Name: ponds id; Type: DEFAULT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.ponds ALTER COLUMN id SET DEFAULT nextval('public.ponds_id_seq'::regclass);


--
-- Name: water_management_zones_detailed id; Type: DEFAULT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.water_management_zones_detailed ALTER COLUMN id SET DEFAULT nextval('public.water_management_zones_detailed_id_seq'::regclass);


--
-- Name: water_quality_history id; Type: DEFAULT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.water_quality_history ALTER COLUMN id SET DEFAULT nextval('public.water_quality_history_id_seq'::regclass);


--
-- Name: wells id; Type: DEFAULT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.wells ALTER COLUMN id SET DEFAULT nextval('public.wells_id_seq'::regclass);


--
-- Name: boreholes boreholes_borehole_id_key; Type: CONSTRAINT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.boreholes
    ADD CONSTRAINT boreholes_borehole_id_key UNIQUE (borehole_id);


--
-- Name: boreholes boreholes_pkey; Type: CONSTRAINT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.boreholes
    ADD CONSTRAINT boreholes_pkey PRIMARY KEY (id);


--
-- Name: feature_construction_details feature_construction_details_feature_id_key; Type: CONSTRAINT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.feature_construction_details
    ADD CONSTRAINT feature_construction_details_feature_id_key UNIQUE (feature_id);


--
-- Name: feature_construction_details feature_construction_details_pkey; Type: CONSTRAINT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.feature_construction_details
    ADD CONSTRAINT feature_construction_details_pkey PRIMARY KEY (id);


--
-- Name: feature_maintenance_activities feature_maintenance_activities_pkey; Type: CONSTRAINT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.feature_maintenance_activities
    ADD CONSTRAINT feature_maintenance_activities_pkey PRIMARY KEY (id);


--
-- Name: feature_water_quality_reports feature_water_quality_reports_pkey; Type: CONSTRAINT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.feature_water_quality_reports
    ADD CONSTRAINT feature_water_quality_reports_pkey PRIMARY KEY (id);


--
-- Name: maintenance_history maintenance_history_pkey; Type: CONSTRAINT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.maintenance_history
    ADD CONSTRAINT maintenance_history_pkey PRIMARY KEY (id);


--
-- Name: ponds ponds_pkey; Type: CONSTRAINT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.ponds
    ADD CONSTRAINT ponds_pkey PRIMARY KEY (id);


--
-- Name: ponds ponds_pond_id_key; Type: CONSTRAINT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.ponds
    ADD CONSTRAINT ponds_pond_id_key UNIQUE (pond_id);


--
-- Name: water_management_zones_detailed water_management_zones_detailed_pkey; Type: CONSTRAINT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.water_management_zones_detailed
    ADD CONSTRAINT water_management_zones_detailed_pkey PRIMARY KEY (id);


--
-- Name: water_management_zones_detailed water_management_zones_detailed_zone_id_key; Type: CONSTRAINT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.water_management_zones_detailed
    ADD CONSTRAINT water_management_zones_detailed_zone_id_key UNIQUE (zone_id);


--
-- Name: water_quality_history water_quality_history_pkey; Type: CONSTRAINT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.water_quality_history
    ADD CONSTRAINT water_quality_history_pkey PRIMARY KEY (id);


--
-- Name: wells wells_pkey; Type: CONSTRAINT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.wells
    ADD CONSTRAINT wells_pkey PRIMARY KEY (id);


--
-- Name: wells wells_well_id_key; Type: CONSTRAINT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.wells
    ADD CONSTRAINT wells_well_id_key UNIQUE (well_id);


--
-- Name: idx_boreholes_geom; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_boreholes_geom ON public.boreholes USING gist (geom);


--
-- Name: idx_feature_construction_contractor; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_feature_construction_contractor ON public.feature_construction_details USING btree (contractor_name);


--
-- Name: idx_feature_construction_feature_id; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_feature_construction_feature_id ON public.feature_construction_details USING btree (feature_id);


--
-- Name: idx_feature_construction_status; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_feature_construction_status ON public.feature_construction_details USING btree (project_status);


--
-- Name: idx_feature_construction_type; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_feature_construction_type ON public.feature_construction_details USING btree (feature_type);


--
-- Name: idx_feature_maintenance_activities_activity_date; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_feature_maintenance_activities_activity_date ON public.feature_maintenance_activities USING btree (activity_date DESC);


--
-- Name: idx_feature_maintenance_activities_feature_id; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_feature_maintenance_activities_feature_id ON public.feature_maintenance_activities USING btree (feature_id);


--
-- Name: idx_feature_water_quality_reports_feature_id; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_feature_water_quality_reports_feature_id ON public.feature_water_quality_reports USING btree (feature_id);


--
-- Name: idx_feature_water_quality_reports_test_date; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_feature_water_quality_reports_test_date ON public.feature_water_quality_reports USING btree (test_date DESC);


--
-- Name: idx_maintenance_date; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_maintenance_date ON public.maintenance_history USING btree (maintenance_date);


--
-- Name: idx_maintenance_feature_id; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_maintenance_feature_id ON public.maintenance_history USING btree (feature_id);


--
-- Name: idx_maintenance_type; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_maintenance_type ON public.maintenance_history USING btree (maintenance_type);


--
-- Name: idx_maintenance_urgency; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_maintenance_urgency ON public.maintenance_history USING btree (urgency_level);


--
-- Name: idx_ponds_geom; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_ponds_geom ON public.ponds USING gist (geom);


--
-- Name: idx_water_management_zones_geom; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_water_management_zones_geom ON public.water_management_zones_detailed USING gist (geom);


--
-- Name: idx_water_management_zones_zone_id; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_water_management_zones_zone_id ON public.water_management_zones_detailed USING btree (zone_id);


--
-- Name: idx_water_quality_compliance; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_water_quality_compliance ON public.water_quality_history USING btree (compliance_status);


--
-- Name: idx_water_quality_feature_id; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_water_quality_feature_id ON public.water_quality_history USING btree (feature_id);


--
-- Name: idx_water_quality_test_date; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_water_quality_test_date ON public.water_quality_history USING btree (test_date);


--
-- Name: idx_wells_geom; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_wells_geom ON public.wells USING gist (geom);


--
-- PostgreSQL database dump complete
--

