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
-- Name: ponds id; Type: DEFAULT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.ponds ALTER COLUMN id SET DEFAULT nextval('public.ponds_id_seq'::regclass);


--
-- Name: water_management_zones_detailed id; Type: DEFAULT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.water_management_zones_detailed ALTER COLUMN id SET DEFAULT nextval('public.water_management_zones_detailed_id_seq'::regclass);


--
-- Name: wells id; Type: DEFAULT; Schema: public; Owner: geouser
--

ALTER TABLE ONLY public.wells ALTER COLUMN id SET DEFAULT nextval('public.wells_id_seq'::regclass);


--
-- Data for Name: boreholes; Type: TABLE DATA; Schema: public; Owner: geouser
--

COPY public.boreholes (id, borehole_id, drilling_company, total_depth_m, pump_capacity_lph, drilling_cost, completion_date, status, name, description, feature_type, geom, created_at) FROM stdin;
1	borehole_1	Chad Drilling Co.	65.00	1800.00	22000.00	2024-02-15	active	Central Chad Borehole 1	High-capacity borehole with submersible pump	borehole	0101000020E61000007E8CB96B09E932407A36AB3E57DB2940	2025-09-30 13:02:57.935835
2	borehole_2	Sahara Water Solutions	72.00	2000.00	25000.00	2024-03-20	active	Eastern Chad Borehole	Deep borehole serving remote communities	borehole	0101000020E61000003F575BB1BFEC3440C9E53FA4DFDE2C40	2025-09-30 13:02:57.935835
3	borehole_3	Lake Chad Engineering	58.00	1600.00	18500.00	2024-01-10	active	Northern Chad Borehole	Solar-powered borehole system	borehole	0101000020E6100000E7FBA9F1D21D314003098A1F634E2E40	2025-09-30 13:02:57.935835
4	borehole_4	Deep Well Drilling Co	78.00	450.00	\N	2020-11-18	active	Abeche Deep Borehole	High-capacity borehole for urban water supply	borehole	0101000020E6100000B6F3FDD478B93440764F1E166ACD2B40	2025-09-30 13:20:15.192464
5	borehole_5	Agricultural Development Agency	65.00	380.00	\N	2021-04-22	active	Guereda Agricultural Borehole	Agricultural borehole with modern irrigation setup	borehole	0101000020E6100000AAF1D24D62E03440545227A089702E40	2025-09-30 13:20:15.192464
6	borehole_north_chad	\N	55.00	\N	\N	\N	active	Northern Chad Test Borehole	Test borehole in northern region	borehole	0101000020E610000065C22FF5F3263140F6234564585D2E40	2025-09-30 16:36:46.566532
\.


--
-- Data for Name: feature_construction_details; Type: TABLE DATA; Schema: public; Owner: geouser
--

COPY public.feature_construction_details (id, feature_id, feature_type, contractor_name, contractor_license, contractor_contact, construction_method, construction_start_date, construction_end_date, construction_duration_days, construction_cost, depth_m, diameter_m, length_m, width_m, lining_material, materials_used, equipment_used, warranty_period_months, quality_certificate_number, environmental_compliance, project_status, quality_rating, final_inspection_date, additional_notes, created_at, updated_at) FROM stdin;
1	well_central_chad	well	Sahel Water Contractors Ltd	SWC-2023-001	contact@sahelwater.td	Rotary Drilling with PVC Casing	2023-01-15	2023-02-28	44	15750.00	45.00	0.20	\N	\N	PVC Schedule 40	{"PVC Casing 8\\" diameter","Bentonite Clay","Gravel Pack","Concrete Wellhead"}	{"Rotary Drilling Rig","Water Pump",Compressor,"Welding Equipment"}	24	WQ-CD-2023-078	Compliant with Chad Water Ministry Standards	Completed	4	2023-03-05	High-yield well serving 250+ households. Water quality excellent.	2025-09-30 17:01:43.087913	2025-09-30 17:01:43.087913
2	well_north_chad	well	Desert Wells Engineering	DWE-2023-012	info@desertwells.td	Hand Drilling with Steel Casing	2023-03-10	2023-04-15	36	12300.00	32.00	0.15	\N	\N	Galvanized Steel	{"Steel Casing 6\\" diameter","Sand Filter","Concrete Apron","Hand Pump"}	{"Hand Drilling Tools","Portable Compressor","Hand Pump Installation Kit"}	18	WQ-NC-2023-045	Environmental Impact Assessment Approved	Completed	5	2023-04-20	Community-managed well with excellent sustainability track record.	2025-09-30 17:01:43.087913	2025-09-30 17:01:43.087913
3	well_eastern_chad	well	East Chad Infrastructure Co.	ECIC-2023-007	projects@eastchad.td	Machine Drilling with Submersible Pump	2023-05-01	2023-06-10	40	22500.00	55.00	0.25	\N	\N	HDPE Casing	{"HDPE Casing 10\\" diameter","Submersible Pump","Control Panel","Distribution Network"}	{"Truck-mounted Drilling Rig",Crane,"Electrical Installation Tools"}	36	WQ-EC-2023-089	Full Environmental Compliance Certificate	Completed	4	2023-06-15	Modern well system with automated controls and distribution network.	2025-09-30 17:01:43.087913	2025-09-30 17:01:43.087913
4	pond_central_chad	pond	Sahel Water Contractors Ltd	SWC-2023-002	contact@sahelwater.td	Excavation with Clay Lining	2023-02-01	2023-03-20	47	28750.00	3.50	\N	\N	\N	Compacted Clay with Plastic Liner	{"Clay Liner","Plastic Sheeting","Gabion Retaining Walls","Inlet/Outlet Pipes"}	{Excavator,Compactor,"Dump Trucks","Water Pumps"}	24	WQ-PD-2023-134	Wildlife Protection Measures Implemented	Completed	4	2023-03-25	Community water storage pond with 50,000L capacity. Includes livestock watering area.	2025-09-30 17:01:43.087913	2025-09-30 17:01:43.087913
5	pond_northern_chad	pond	Aqua Solutions Chad	ASC-2023-018	build@aquasolutions.td	Excavation with Concrete Lining	2023-04-05	2023-05-25	50	35600.00	4.00	\N	\N	\N	Reinforced Concrete	{"Reinforced Concrete","Waterproof Membrane","Steel Reinforcement","Filtration System"}	{Excavator,"Concrete Mixer",Crane,"Vibrating Equipment"}	60	WQ-PN-2023-167	Advanced Water Quality Treatment Systems	Completed	5	2023-05-30	Modern concrete-lined pond with integrated filtration and treatment systems.	2025-09-30 17:01:43.087913	2025-09-30 17:01:43.087913
6	borehole_central_chad	borehole	Chad Drilling Specialists	CDS-2023-025	drilling@chadspec.td	Percussion Drilling with Steel Casing	2023-06-01	2023-07-05	34	18900.00	75.00	0.18	\N	\N	Stainless Steel Schedule 80	{"Stainless Steel Casing","Grout Seal","Wellhead Protection","Test Pumping Equipment"}	{"Percussion Drilling Rig","Air Compressor","Test Pump","Water Quality Testing Kit"}	30	WQ-BC-2023-201	Groundwater Protection Compliance Certificate	Completed	4	2023-07-10	Deep groundwater access point with excellent yield and water quality.	2025-09-30 17:01:43.087913	2025-09-30 17:01:43.087913
7	borehole_eastern_chad	borehole	Professional Well Services	PWS-2023-031	service@prowell.td	Rotary Drilling with Monitoring Equipment	2023-07-15	2023-08-20	36	21200.00	68.00	0.20	\N	\N	PVC with Steel Screen	{"PVC Casing with Steel Screen","Bentonite Grout","Monitoring Equipment","Data Logger"}	{"Rotary Drilling Rig","Mud Circulation System","Monitoring Equipment","Installation Tools"}	24	WQ-BE-2023-245	Continuous Monitoring System Approved	Completed	5	2023-08-25	Advanced borehole with real-time monitoring and data collection systems.	2025-09-30 17:01:43.087913	2025-09-30 17:01:43.087913
8	abeche_community_well	well	Sahel Infrastructure Ltd	SIL-2023-089	+235 99 12 34 56	Manual Drilling with Hand Pump	2023-01-15	2023-02-28	44	12500.00	38.50	0.15	\N	\N	PVC Schedule 40	{"PVC Casing 6\\" diameter","Bentonite Clay","Gravel Pack","Hand Pump System"}	{"Manual Drilling Rig","Hand Tools","Water Testing Kit"}	18	WQ-CD-2023-089	Compliant with Chad Water Ministry Standards	Completed	4	2023-03-05	Community well serving 180 households. Manual pump requires regular maintenance.	2025-09-30 18:18:44.251018	2025-09-30 18:18:44.251018
9	abeche_deep_well	well	Desert Water Solutions	DWS-2022-156	+235 99 87 65 43	Rotary Drilling with Submersible Pump	2022-09-10	2022-11-22	73	28750.00	85.20	0.25	\N	\N	Steel Casing with PVC Liner	{"Steel Casing 10\\" diameter","PVC Liner 8\\" diameter","Submersible Pump","Control Panel"}	{"Rotary Drilling Rig",Crane,"Electrical Installation Equipment",Generator}	36	WQ-CD-2022-156	Environmental Impact Assessment Approved	Completed	5	2022-11-28	Deep aquifer access. High yield well with automated pumping system.	2025-09-30 18:18:44.251018	2025-09-30 18:18:44.251018
10	adre_border_well	well	Chad-Sudan Water Co.	CSWC-2023-234	+235 99 55 44 33	Percussion Drilling with Solar Pump	2023-04-01	2023-05-20	49	19800.00	52.00	0.20	\N	\N	PVC Schedule 80	{"PVC Casing 8\\" diameter","Solar Panel System","Battery Storage","Distribution Network"}	{"Percussion Drilling Rig","Solar Installation Kit","Electrical Components"}	24	WQ-CD-2023-234	Cross-border Environmental Compliance	Completed	4	2023-05-25	Solar-powered well serving border communities. Sustainable energy solution.	2025-09-30 18:18:44.251018	2025-09-30 18:18:44.251018
11	adre_area_test_well	well	Exploration Water Services	EWS-2023-078	+235 99 22 11 88	Test Drilling with Temporary Pump	2023-06-15	2023-07-10	25	8500.00	28.50	0.12	\N	\N	Temporary PVC Casing	{"PVC Casing 5\\" diameter","Temporary Pump","Flow Meter","Water Samples"}	{"Portable Drilling Rig","Testing Equipment","Sample Collection Kit"}	6	WQ-CD-2023-078	Exploratory Drilling Permit	Completed	3	2023-07-12	Exploratory well for aquifer assessment. Limited production capacity.	2025-09-30 18:18:44.251018	2025-09-30 18:18:44.251018
12	doba_community_well	well	Southern Chad Contractors	SCC-2022-345	+235 99 77 66 55	Rotary Drilling with Community Hand Pump	2022-11-01	2022-12-20	49	14750.00	42.80	0.18	\N	\N	PVC Schedule 40	{"PVC Casing 7\\" diameter","Community Hand Pump","Concrete Platform","Drainage System"}	{"Rotary Drilling Rig","Concrete Mixer","Hand Tools","Water Quality Kit"}	24	WQ-CD-2022-345	Community Development Approval	Completed	4	2022-12-28	Community-managed well with training provided for local maintenance.	2025-09-30 18:18:44.251018	2025-09-30 18:18:44.251018
13	guereda_village_well	well	Guereda Water Cooperative	GWC-2023-123	+235 99 33 22 77	Hand Drilling with Rope Pump	2023-03-01	2023-04-15	45	6800.00	22.00	0.10	\N	\N	PVC Schedule 20	{"PVC Casing 4\\" diameter","Rope Pump System","Well Head Protection","Manual Tools"}	{"Hand Drilling Tools","Rope Pump Kit","Basic Construction Tools"}	12	WQ-CD-2023-123	Village Council Approval	Completed	3	2023-04-18	Village-built well using local labor and training. Cost-effective solution.	2025-09-30 18:18:44.251018	2025-09-30 18:18:44.251018
14	moundou_community_well	well	Southwest Water Development	SWD-2023-567	+235 99 88 99 00	Rotary Drilling with Electric Pump	2023-02-10	2023-04-05	54	22400.00	48.50	0.22	\N	\N	Steel Casing with Concrete Lining	{"Steel Casing 9\\" diameter","Electric Pump","Power Connection","Water Tank"}	{"Rotary Drilling Rig","Electrical Installation","Concrete Equipment","Lifting Equipment"}	30	WQ-CD-2023-567	Municipal Development Approval	Completed	5	2023-04-10	Municipal well with electric pump and storage tank. Serves multiple neighborhoods.	2025-09-30 18:18:44.251018	2025-09-30 18:18:44.251018
15	ndjamena_community_well_1	well	Capital City Water Works	CCWW-2022-890	+235 99 11 22 33	Advanced Rotary Drilling with Automated System	2022-08-15	2022-10-30	76	45200.00	95.50	0.30	\N	\N	Steel Casing with Stainless Steel Screen	{"Steel Casing 12\\" diameter","Stainless Steel Screen","Variable Speed Pump","SCADA System"}	{"Advanced Drilling Rig","SCADA Installation","Electrical Systems","Control Room Equipment"}	60	WQ-CD-2022-890	Capital City Development Standards	Completed	5	2022-11-05	Advanced municipal well with automated monitoring and control systems.	2025-09-30 18:18:44.251018	2025-09-30 18:18:44.251018
16	northern_chad_test_well	well	Desert Exploration Co.	DEC-2023-456	+235 99 44 55 66	Exploration Drilling with Monitoring Equipment	2023-05-01	2023-06-15	45	18900.00	68.00	0.15	\N	\N	PVC with Monitoring Equipment	{"PVC Casing 6\\" diameter","Data Loggers","Pressure Sensors","Sampling Equipment"}	{"Exploration Drilling Rig","Monitoring Equipment","Data Collection Systems"}	18	WQ-CD-2023-456	Research and Development Permit	Completed	4	2023-06-18	Research well for aquifer studies. Equipped with continuous monitoring systems.	2025-09-30 18:18:44.251018	2025-09-30 18:18:44.251018
17	sarh_traditional_well	well	Traditional Wells Restoration	TWR-2023-789	+235 99 66 77 88	Traditional Restoration with Modern Safety	2023-01-20	2023-03-10	49	9200.00	18.50	0.25	\N	\N	Stone and Mortar with Safety Features	{"Natural Stone","Cement Mortar","Safety Rails","Pulley System"}	{"Traditional Tools","Safety Equipment","Stone Working Tools","Pulley Installation"}	12	WQ-CD-2023-789	Cultural Heritage Compliance	Completed	3	2023-03-15	Restored traditional well with modern safety features. Cultural heritage preservation.	2025-09-30 18:18:44.251018	2025-09-30 18:18:44.251018
18	abeche_deep_borehole	borehole	Deep Aquifer Specialists	DAS-2022-678	+235 99 12 34 56	Deep Rotary Drilling with Advanced Logging	2022-10-01	2023-01-15	106	85600.00	180.50	0.35	\N	\N	Steel Casing with Gravel Pack	{"Steel Casing 14\\" diameter","Gravel Pack","Bentonite Seal","Submersible Pump System"}	{"Heavy Duty Drilling Rig","Geological Logging Equipment","Pump Installation Rig"}	60	WQ-CD-2022-678	Deep Aquifer Exploitation Permit	Completed	5	2023-01-20	Deep borehole accessing confined aquifer. High yield with excellent water quality.	2025-09-30 18:18:44.316644	2025-09-30 18:18:44.316644
19	central_chad_borehole_1	borehole	Chad Drilling Consortium	CDC-2023-345	+235 99 87 65 43	Rotary Drilling with Multi-Zone Completion	2023-02-15	2023-05-30	104	72400.00	125.00	0.30	\N	\N	Multi-Zone Steel Casing	{"Steel Casing 12\\" diameter","Zone Isolation Packers","Multi-Level Pump","Control Valves"}	{"Rotary Drilling Rig","Zone Completion Equipment","Multi-Pump System"}	48	WQ-CD-2023-345	Multi-Zone Aquifer Development	Completed	5	2023-06-05	Advanced borehole with multiple aquifer zones. Optimized water production.	2025-09-30 18:18:44.316644	2025-09-30 18:18:44.316644
20	eastern_chad_borehole	borehole	Eastern Development Corp	EDC-2022-890	+235 99 55 44 33	Percussion Drilling with Solar Pumping	2022-12-01	2023-03-20	109	54800.00	95.80	0.25	\N	\N	PVC Casing with Solar Integration	{"PVC Casing 10\\" diameter","Solar Panel Array","Battery Bank","Inverter System"}	{"Percussion Drilling Rig","Solar Installation Equipment","Electrical Components"}	36	WQ-CD-2022-890	Renewable Energy Integration Approval	Completed	4	2023-03-25	Solar-powered borehole system. Sustainable and environmentally friendly.	2025-09-30 18:18:44.316644	2025-09-30 18:18:44.316644
21	guereda_agricultural_borehole	borehole	Agricultural Water Solutions	AWS-2023-567	+235 99 22 11 88	Agricultural Drilling with Irrigation System	2023-04-01	2023-07-15	105	68200.00	110.00	0.28	\N	\N	Agricultural Grade Steel Casing	{"Steel Casing 11\\" diameter","Irrigation Pump","Distribution Network","Control Systems"}	{"Agricultural Drilling Rig","Irrigation Equipment","Network Installation Tools"}	42	WQ-CD-2023-567	Agricultural Development Permit	Completed	4	2023-07-20	Agricultural borehole with irrigation system. Supports local farming operations.	2025-09-30 18:18:44.316644	2025-09-30 18:18:44.316644
22	northern_chad_borehole	borehole	Northern Development Agency	NDA-2023-234	+235 99 77 66 55	Desert Drilling with Wind Power	2023-01-10	2023-04-25	105	62100.00	88.50	0.22	\N	\N	Corrosion-Resistant Steel	{"Stainless Steel Casing 9\\" diameter","Wind Turbine","Pump Controller","Storage Tank"}	{"Desert Drilling Rig","Wind Power Installation","Storage Equipment"}	36	WQ-CD-2023-234	Desert Environment Compliance	Completed	4	2023-04-30	Wind-powered borehole for desert communities. Adapted for harsh conditions.	2025-09-30 18:18:44.316644	2025-09-30 18:18:44.316644
23	northern_chad_test_borehole	borehole	Geological Survey Chad	GSC-2023-456	+235 99 33 22 77	Research Drilling with Monitoring	2023-03-15	2023-06-30	107	45600.00	150.00	0.20	\N	\N	Research Grade Equipment	{"Monitoring Casing 8\\" diameter","Data Collection Equipment","Sample Ports","Logging Instruments"}	{"Research Drilling Rig","Geological Logging Equipment","Monitoring Installation"}	24	WQ-CD-2023-456	Geological Research Permit	Completed	5	2023-07-05	Research borehole for geological and hydrological studies. Scientific monitoring.	2025-09-30 18:18:44.316644	2025-09-30 18:18:44.316644
24	abeche_seasonal_pond	pond	Pond Construction Specialists	PCS-2022-123	+235 99 88 99 00	Excavation with Clay Lining	2022-11-01	2023-01-20	80	28500.00	3.50	\N	45.00	30.00	Compacted Clay with Bentonite	{"Bentonite Clay","Gravel Base","Overflow Pipe","Access Ramp"}	{Excavator,"Compaction Equipment","Survey Equipment","Pipe Installation"}	24	WQ-CD-2022-123	Seasonal Water Storage Permit	Completed	4	2023-01-25	Seasonal pond for rainwater harvesting. Clay lining prevents seepage.	2025-09-30 18:18:44.318654	2025-09-30 18:18:44.318654
25	adre_water_reserve	pond	Water Storage Solutions	WSS-2023-789	+235 99 11 22 33	Engineered Excavation with Synthetic Liner	2023-02-01	2023-04-30	88	45200.00	4.20	\N	60.00	40.00	HDPE Geomembrane Liner	{"HDPE Liner 2mm","Geotextile Protection","Inlet Structure","Outlet Control"}	{"Large Excavator","Liner Installation Equipment","Welding Equipment"}	36	WQ-CD-2023-789	Water Reserve Development Permit	Completed	5	2023-05-05	Large water reserve with synthetic liner. Long-term water storage capacity.	2025-09-30 18:18:44.318654	2025-09-30 18:18:44.318654
26	adre_area_test_pond	pond	Experimental Water Systems	EWS-2023-456	+235 99 44 55 66	Test Excavation with Monitoring	2023-05-15	2023-07-10	56	18200.00	2.00	\N	25.00	15.00	Natural Clay with Monitoring	{"Natural Clay Lining","Water Level Sensors","Quality Monitors","Sampling Points"}	{"Mini Excavator","Monitoring Equipment","Installation Tools"}	12	WQ-CD-2023-456	Experimental Water Project	Completed	3	2023-07-15	Test pond for water storage experiments. Equipped with monitoring systems.	2025-09-30 18:18:44.318654	2025-09-30 18:18:44.318654
27	central_chad_test_pond	pond	Central Development Works	CDW-2023-234	+235 99 66 77 88	Standard Excavation with Concrete Lining	2023-03-01	2023-05-15	75	32400.00	3.00	\N	35.00	25.00	Reinforced Concrete	{"Concrete Mix","Steel Reinforcement",Waterproofing,"Control Structures"}	{Excavator,"Concrete Mixer","Reinforcement Tools","Finishing Equipment"}	48	WQ-CD-2023-234	Municipal Water Storage	Completed	4	2023-05-20	Concrete-lined pond for municipal water storage. Durable construction.	2025-09-30 18:18:44.318654	2025-09-30 18:18:44.318654
28	chari_river_pond	pond	River Management Authority	RMA-2022-567	+235 99 12 34 56	River-Fed Excavation with Natural Lining	2022-09-15	2022-12-10	86	22800.00	2.80	\N	50.00	35.00	Natural River Sediment	{"River Sediment","Rock Armoring","Inlet Channel","Fish Ladder"}	{"Amphibious Excavator","Rock Placement Equipment","Channel Tools"}	18	WQ-CD-2022-567	River Ecosystem Management	Completed	4	2022-12-15	River-connected pond supporting ecosystem and water supply. Fish habitat included.	2025-09-30 18:18:44.318654	2025-09-30 18:18:44.318654
29	lake_chad_retention_pond	pond	Lake Chad Basin Authority	LCBA-2023-890	+235 99 87 65 43	Large Scale Excavation with Multi-Layer Lining	2023-01-15	2023-06-30	166	125600.00	5.50	\N	120.00	80.00	Multi-Layer Composite	{"Clay Base Layer","Geomembrane Liner","Protection Layer","Wave Protection"}	{"Fleet of Excavators","Liner Installation Crew","Quality Control Equipment"}	60	WQ-CD-2023-890	Lake Chad Basin Management	Completed	5	2023-07-05	Large retention pond connected to Lake Chad. Critical water infrastructure.	2025-09-30 18:18:44.318654	2025-09-30 18:18:44.318654
30	logone_valley_pond	pond	Valley Development Corp	VDC-2022-345	+235 99 55 44 33	Valley Excavation with Flood Control	2022-10-01	2023-01-30	121	38900.00	4.00	\N	65.00	45.00	Clay with Flood Barriers	{"Compacted Clay","Flood Barriers",Spillway,"Access Roads"}	{"Heavy Excavator","Barrier Construction","Road Equipment"}	30	WQ-CD-2022-345	Flood Management Integration	Completed	4	2023-02-05	Valley pond with integrated flood control. Seasonal water management.	2025-09-30 18:18:44.318654	2025-09-30 18:18:44.318654
42	borehole_1	borehole	Chad Drilling Consortium	CDC-2023-345	+235 99 87 65 43	Rotary Drilling with Multi-Zone Completion	2023-02-15	2023-05-30	104	72400.00	125.00	0.30	\N	\N	Multi-Zone Steel Casing	{"Steel Casing 12\\" diameter","Zone Isolation Packers","Multi-Level Pump","Control Valves"}	{"Rotary Drilling Rig","Zone Completion Equipment","Multi-Pump System"}	48	WQ-CD-2023-345	Multi-Zone Aquifer Development	Completed	5	2023-06-05	Advanced borehole with multiple aquifer zones. Optimized water production.	2025-09-30 19:08:53.364097	2025-09-30 19:08:53.364097
43	borehole_2	borehole	Eastern Development Corp	EDC-2022-890	+235 99 55 44 33	Percussion Drilling with Solar Pumping	2022-12-01	2023-03-20	109	54800.00	95.80	0.25	\N	\N	PVC Casing with Solar Integration	{"PVC Casing 10\\" diameter","Solar Panel Array","Battery Bank","Inverter System"}	{"Percussion Drilling Rig","Solar Installation Equipment","Electrical Components"}	36	WQ-CD-2022-890	Renewable Energy Integration Approval	Completed	4	2023-03-25	Solar-powered borehole system. Sustainable and environmentally friendly.	2025-09-30 19:08:53.364097	2025-09-30 19:08:53.364097
44	borehole_3	borehole	Northern Development Agency	NDA-2023-234	+235 99 77 66 55	Desert Drilling with Wind Power	2023-01-10	2023-04-25	105	62100.00	88.50	0.22	\N	\N	Corrosion-Resistant Steel	{"Stainless Steel Casing 9\\" diameter","Wind Turbine","Pump Controller","Storage Tank"}	{"Desert Drilling Rig","Wind Power Installation","Storage Equipment"}	36	WQ-CD-2023-234	Desert Environment Compliance	Completed	4	2023-04-30	Wind-powered borehole for desert communities. Adapted for harsh conditions.	2025-09-30 19:08:53.364097	2025-09-30 19:08:53.364097
45	borehole_4	borehole	Deep Aquifer Specialists	DAS-2022-678	+235 99 12 34 56	Deep Rotary Drilling with Advanced Logging	2022-10-01	2023-01-15	106	85600.00	180.50	0.35	\N	\N	Steel Casing with Gravel Pack	{"Steel Casing 14\\" diameter","Gravel Pack","Bentonite Seal","Submersible Pump System"}	{"Heavy Duty Drilling Rig","Geological Logging Equipment","Pump Installation Rig"}	60	WQ-CD-2022-678	Deep Aquifer Exploitation Permit	Completed	5	2023-01-20	Deep borehole accessing confined aquifer. High yield with excellent water quality.	2025-09-30 19:08:53.364097	2025-09-30 19:08:53.364097
46	borehole_5	borehole	Agricultural Water Solutions	AWS-2023-567	+235 99 22 11 88	Agricultural Drilling with Irrigation System	2023-04-01	2023-07-15	105	68200.00	110.00	0.28	\N	\N	Agricultural Grade Steel Casing	{"Steel Casing 11\\" diameter","Irrigation Pump","Distribution Network","Control Systems"}	{"Agricultural Drilling Rig","Irrigation Equipment","Network Installation Tools"}	42	WQ-CD-2023-567	Agricultural Development Permit	Completed	4	2023-07-20	Agricultural borehole with irrigation system. Supports local farming operations.	2025-09-30 19:08:53.364097	2025-09-30 19:08:53.364097
47	borehole_north_chad	borehole	Geological Survey Chad	GSC-2023-456	+235 99 33 22 77	Research Drilling with Monitoring	2023-03-15	2023-06-30	107	45600.00	150.00	0.20	\N	\N	Research Grade Equipment	{"Monitoring Casing 8\\" diameter","Data Collection Equipment","Sample Ports","Logging Instruments"}	{"Research Drilling Rig","Geological Logging Equipment","Monitoring Installation"}	24	WQ-CD-2023-456	Geological Research Permit	Completed	5	2023-07-05	Research borehole for geological and hydrological studies. Scientific monitoring.	2025-09-30 19:08:53.364097	2025-09-30 19:08:53.364097
48	pond_1	pond	Lake Chad Basin Authority	LCBA-2023-890	+235 99 87 65 43	Large Scale Excavation with Multi-Layer Lining	2023-01-15	2023-06-30	166	125600.00	5.50	\N	120.00	80.00	Multi-Layer Composite	{"Clay Base Layer","Geomembrane Liner","Protection Layer","Wave Protection"}	{"Fleet of Excavators","Liner Installation Crew","Quality Control Equipment"}	60	WQ-CD-2023-890	Lake Chad Basin Management	Completed	5	2023-07-05	Large retention pond connected to Lake Chad. Critical water infrastructure.	2025-09-30 19:08:53.366273	2025-09-30 19:08:53.366273
49	pond_2	pond	River Management Authority	RMA-2022-567	+235 99 12 34 56	River-Fed Excavation with Natural Lining	2022-09-15	2022-12-10	86	22800.00	2.80	\N	50.00	35.00	Natural River Sediment	{"River Sediment","Rock Armoring","Inlet Channel","Fish Ladder"}	{"Amphibious Excavator","Rock Placement Equipment","Channel Tools"}	18	WQ-CD-2022-567	River Ecosystem Management	Completed	4	2022-12-15	River-connected pond supporting ecosystem and water supply. Fish habitat included.	2025-09-30 19:08:53.366273	2025-09-30 19:08:53.366273
50	pond_3	pond	Valley Development Corp	VDC-2022-345	+235 99 55 44 33	Valley Excavation with Flood Control	2022-10-01	2023-01-30	121	38900.00	4.00	\N	65.00	45.00	Clay with Flood Barriers	{"Compacted Clay","Flood Barriers",Spillway,"Access Roads"}	{"Heavy Excavator","Barrier Construction","Road Equipment"}	30	WQ-CD-2022-345	Flood Management Integration	Completed	4	2023-02-05	Valley pond with integrated flood control. Seasonal water management.	2025-09-30 19:08:53.366273	2025-09-30 19:08:53.366273
51	pond_4	pond	Pond Construction Specialists	PCS-2022-123	+235 99 88 99 00	Excavation with Clay Lining	2022-11-01	2023-01-20	80	28500.00	3.50	\N	45.00	30.00	Compacted Clay with Bentonite	{"Bentonite Clay","Gravel Base","Overflow Pipe","Access Ramp"}	{Excavator,"Compaction Equipment","Survey Equipment","Pipe Installation"}	24	WQ-CD-2022-123	Seasonal Water Storage Permit	Completed	4	2023-01-25	Seasonal pond for rainwater harvesting. Clay lining prevents seepage.	2025-09-30 19:08:53.366273	2025-09-30 19:08:53.366273
52	pond_5	pond	Water Storage Solutions	WSS-2023-789	+235 99 11 22 33	Engineered Excavation with Synthetic Liner	2023-02-01	2023-04-30	88	45200.00	4.20	\N	60.00	40.00	HDPE Geomembrane Liner	{"HDPE Liner 2mm","Geotextile Protection","Inlet Structure","Outlet Control"}	{"Large Excavator","Liner Installation Equipment","Welding Equipment"}	36	WQ-CD-2023-789	Water Reserve Development Permit	Completed	5	2023-05-05	Large water reserve with synthetic liner. Long-term water storage capacity.	2025-09-30 19:08:53.366273	2025-09-30 19:08:53.366273
53	pond_adre_area	pond	Experimental Water Systems	EWS-2023-456	+235 99 44 55 66	Test Excavation with Monitoring	2023-05-15	2023-07-10	56	18200.00	2.00	\N	25.00	15.00	Natural Clay with Monitoring	{"Natural Clay Lining","Water Level Sensors","Quality Monitors","Sampling Points"}	{"Mini Excavator","Monitoring Equipment","Installation Tools"}	12	WQ-CD-2023-456	Experimental Water Project	Completed	3	2023-07-15	Test pond for water storage experiments. Equipped with monitoring systems.	2025-09-30 19:08:53.366273	2025-09-30 19:08:53.366273
54	well_1	well	Capital City Water Works	CCWW-2022-890	+235 99 11 22 33	Advanced Rotary Drilling with Automated System	2022-08-15	2022-10-30	76	45200.00	95.50	0.30	\N	\N	Steel Casing with Stainless Steel Screen	{"Steel Casing 12\\" diameter","Stainless Steel Screen","Variable Speed Pump","SCADA System"}	{"Advanced Drilling Rig","SCADA Installation","Electrical Systems","Control Room Equipment"}	60	WQ-CD-2022-890	Capital City Development Standards	Completed	5	2022-11-05	Advanced municipal well with automated monitoring and control systems.	2025-09-30 19:09:43.972606	2025-09-30 19:09:43.972606
55	well_2	well	Southwest Water Development	SWD-2023-567	+235 99 88 99 00	Rotary Drilling with Electric Pump	2023-02-10	2023-04-05	54	22400.00	48.50	0.22	\N	\N	Steel Casing with Concrete Lining	{"Steel Casing 9\\" diameter","Electric Pump","Power Connection","Water Tank"}	{"Rotary Drilling Rig","Electrical Installation","Concrete Equipment","Lifting Equipment"}	30	WQ-CD-2023-567	Municipal Development Approval	Completed	5	2023-04-10	Municipal well with electric pump and storage tank. Serves multiple neighborhoods.	2025-09-30 19:10:06.2799	2025-09-30 19:10:06.2799
56	well_3	well	Traditional Wells Restoration	TWR-2023-789	+235 99 66 77 88	Traditional Restoration with Modern Safety	2023-01-20	2023-03-10	49	9200.00	18.50	0.25	\N	\N	Stone and Mortar with Safety Features	{"Natural Stone","Cement Mortar","Safety Rails","Pulley System"}	{"Traditional Tools","Safety Equipment","Stone Working Tools","Pulley Installation"}	12	WQ-CD-2023-789	Cultural Heritage Compliance	Completed	3	2023-03-15	Restored traditional well with modern safety features. Cultural heritage preservation.	2025-09-30 19:10:06.2799	2025-09-30 19:10:06.2799
57	well_4	well	Desert Water Solutions	DWS-2022-156	+235 99 87 65 43	Rotary Drilling with Submersible Pump	2022-09-10	2022-11-22	73	28750.00	85.20	0.25	\N	\N	Steel Casing with PVC Liner	{"Steel Casing 10\\" diameter","PVC Liner 8\\" diameter","Submersible Pump","Control Panel"}	{"Rotary Drilling Rig",Crane,"Electrical Installation Equipment",Generator}	36	WQ-CD-2022-156	Environmental Impact Assessment Approved	Completed	5	2022-11-28	Deep aquifer access. High yield well with automated pumping system.	2025-09-30 19:10:06.2799	2025-09-30 19:10:06.2799
58	well_5	well	Southern Chad Contractors	SCC-2022-345	+235 99 77 66 55	Rotary Drilling with Community Hand Pump	2022-11-01	2022-12-20	49	14750.00	42.80	0.18	\N	\N	PVC Schedule 40	{"PVC Casing 7\\" diameter","Community Hand Pump","Concrete Platform","Drainage System"}	{"Rotary Drilling Rig","Concrete Mixer","Hand Tools","Water Quality Kit"}	24	WQ-CD-2022-345	Community Development Approval	Completed	4	2022-12-28	Community-managed well with training provided for local maintenance.	2025-09-30 19:11:30.197886	2025-09-30 19:11:30.197886
59	well_6	well	Sahel Infrastructure Ltd	SIL-2023-089	+235 99 12 34 56	Manual Drilling with Hand Pump	2023-01-15	2023-02-28	44	12500.00	38.50	0.15	\N	\N	PVC Schedule 40	{"PVC Casing 6\\" diameter","Bentonite Clay","Gravel Pack","Hand Pump System"}	{"Manual Drilling Rig","Hand Tools","Water Testing Kit"}	18	WQ-CD-2023-089	Compliant with Chad Water Ministry Standards	Completed	4	2023-03-05	Community well serving 180 households. Manual pump requires regular maintenance.	2025-09-30 19:11:30.197886	2025-09-30 19:11:30.197886
60	well_7	well	Chad-Sudan Water Co.	CSWC-2023-234	+235 99 55 44 33	Percussion Drilling with Solar Pump	2023-04-01	2023-05-20	49	19800.00	52.00	0.20	\N	\N	PVC Schedule 80	{"PVC Casing 8\\" diameter","Solar Panel System","Battery Storage","Distribution Network"}	{"Percussion Drilling Rig","Solar Installation Kit","Electrical Components"}	24	WQ-CD-2023-234	Cross-border Environmental Compliance	Completed	4	2023-05-25	Solar-powered well serving border communities. Sustainable energy solution.	2025-09-30 19:11:30.197886	2025-09-30 19:11:30.197886
61	well_8	well	Guereda Water Cooperative	GWC-2023-123	+235 99 33 22 77	Hand Drilling with Rope Pump	2023-03-01	2023-04-15	45	6800.00	22.00	0.10	\N	\N	PVC Schedule 20	{"PVC Casing 4\\" diameter","Rope Pump System","Well Head Protection","Manual Tools"}	{"Hand Drilling Tools","Rope Pump Kit","Basic Construction Tools"}	12	WQ-CD-2023-123	Village Council Approval	Completed	3	2023-04-18	Village-built well using local labor and training. Cost-effective solution.	2025-09-30 19:13:06.718701	2025-09-30 19:13:06.718701
62	well_click_test	well	Test Drilling Services	TDS-2023-TEST	+235 99 00 11 22	Test Drilling for Location Verification	2023-09-01	2023-09-15	14	5500.00	25.00	0.12	\N	\N	Temporary PVC Casing	{"PVC Casing 5\\" diameter","Test Pump","Basic Equipment"}	{"Portable Drilling Rig","Test Equipment"}	6	WQ-CD-2023-TEST	Test Location Permit	Completed	3	2023-09-18	Test well for click location functionality demonstration.	2025-09-30 19:13:06.718701	2025-09-30 19:13:06.718701
63	well_adre_area	well	Exploration Water Services	EWS-2023-078	+235 99 22 11 88	Test Drilling with Temporary Pump	2023-06-15	2023-07-10	25	8500.00	28.50	0.12	\N	\N	Temporary PVC Casing	{"PVC Casing 5\\" diameter","Temporary Pump","Flow Meter","Water Samples"}	{"Portable Drilling Rig","Testing Equipment","Sample Collection Kit"}	6	WQ-CD-2023-078	Exploratory Drilling Permit	Completed	3	2023-07-12	Exploratory well for aquifer assessment. Limited production capacity.	2025-09-30 19:13:06.718701	2025-09-30 19:13:06.718701
\.


--
-- Data for Name: feature_maintenance_activities; Type: TABLE DATA; Schema: public; Owner: geouser
--

COPY public.feature_maintenance_activities (id, feature_id, feature_type, activity_date, activity_type, activity_status, priority, cost, duration_hours, technician, description, parts_replaced, equipment_used, effectiveness_rating, next_maintenance_date, notes, created_at) FROM stdin;
1	well_1	well	2024-03-15	Pump Maintenance	completed	medium	1200.00	4	Ahmed Hassan - Senior Technician	Routine pump inspection, bearing replacement, and performance testing	{"Pump bearings","Seal kit","Oil filter"}	{"Pump hoist","Pressure gauge",Multimeter}	4	2024-09-15	Pump efficiency improved by 15%	2025-09-30 12:49:01.819806
2	well_1	well	2024-06-20	Well Cleaning	completed	high	2500.00	8	Mohamed Idriss - Well Specialist	Deep well cleaning, sediment removal, and disinfection	{"Chlorine tablets","Sand filter media"}	{"Well cleaning equipment","Pressure washer","Water testing kit"}	5	2024-12-20	Significant improvement in water quality and flow rate	2025-09-30 12:49:01.819806
3	well_1	well	2024-09-10	Electrical System Check	completed	low	650.00	3	Ibrahim Seid - Electrician	Electrical connections inspection, control panel maintenance	{"Control relay","Electrical wire"}	{Multimeter,"Wire strippers","Voltage tester"}	4	2025-03-10	All electrical systems functioning properly	2025-09-30 12:49:01.819806
4	well_1	well	2025-01-15	Annual Inspection	scheduled	medium	1800.00	6	Ahmed Hassan - Senior Technician	Comprehensive annual inspection and preventive maintenance	{"TBD based on inspection"}	{"Inspection tools","Testing equipment"}	\N	2025-07-15	Scheduled comprehensive maintenance	2025-09-30 12:49:01.819806
5	borehole_1	borehole	2024-04-05	Submersible Pump Service	completed	high	3200.00	12	Ousmane Deby - Pump Engineer	Submersible pump removal, overhaul, and reinstallation	{Impeller,"Motor bearings","Cable splice kit"}	{"Crane truck","Pressure testing unit","Cable puller"}	5	2024-10-05	Pump restored to optimal performance	2025-09-30 12:49:01.819806
6	borehole_1	borehole	2024-07-12	Casing Inspection	completed	medium	1500.00	6	Hassan Ali - Borehole Technician	Video inspection of borehole casing and structural integrity check	{"Casing clamps"}	{"Downhole camera","Logging equipment"}	4	2025-01-12	Minor wear detected, no immediate action required	2025-09-30 12:49:01.819806
7	borehole_1	borehole	2024-10-18	Water Treatment System	completed	medium	2100.00	5	Fatima Mahamat - Water Treatment Specialist	Iron removal system maintenance and filter replacement	{"Iron removal filters","Backwash valve"}	{"Water testing kit","Filter tools"}	4	2025-04-18	Iron content reduced to acceptable levels	2025-09-30 12:49:01.819806
8	pond_1	pond	2024-05-10	Algae Control	completed	high	2800.00	16	Dr. Abakar Mahamat - Aquatic Specialist	Algae bloom management, water treatment, and ecosystem balancing	{"Algaecide treatment","Beneficial bacteria","Aeration stones"}	{"Water treatment pump","Aeration system","Water quality meter"}	4	2024-08-10	Algae levels controlled, water clarity improved	2025-09-30 12:49:01.819806
9	pond_1	pond	2024-08-22	Liner Inspection	completed	medium	1800.00	8	Mahamat Saleh - Infrastructure Inspector	HDPE liner inspection, minor repairs, and protective measures	{"HDPE patch material",Sealant}	{"Underwater inspection tools","Welding equipment"}	5	2025-02-22	Liner integrity confirmed, minor patches applied	2025-09-30 12:49:01.819806
10	pond_1	pond	2024-11-30	Sediment Removal	in_progress	medium	3500.00	24	Chad Earth Works Team	Sediment dredging and pond capacity restoration	{"Filter media"}	{"Dredging equipment","Sediment pumps"}	\N	2025-05-30	Currently removing accumulated sediment	2025-09-30 12:49:01.819806
11	guereda_village_well	well	2023-05-10	Rope Pump Maintenance	completed	medium	180.00	3	Village Technician - Haroun Moussa	Rope pump system maintenance and rope replacement	{"Pump Rope","Pulley Bearings"}	{"Village Tools","Rope Installation Kit"}	3	2023-11-10	Village-managed maintenance successful	2025-09-30 18:18:44.339405
12	moundou_community_well	well	2023-05-15	Electric Pump Service	completed	high	1200.00	6	Municipal Electrician - Jean-Claude Ngarta	Electric pump motor service and electrical system check	{"Motor Capacitor","Electrical Contacts"}	{"Electrical Testing Equipment"}	4	2024-05-15	Municipal system efficiency improved	2025-09-30 18:18:44.339405
13	ndjamena_community_well_1	well	2022-12-10	SCADA System Update	completed	low	2500.00	8	Automation Specialist - Advanced Systems Team	SCADA system software update and sensor calibration	{"Software License","Sensor Calibration Kit"}	{"Computer Equipment","Calibration Tools"}	5	2023-12-10	Automated monitoring system optimized	2025-09-30 18:18:44.339405
14	northern_chad_test_well	well	2023-07-05	Monitoring Equipment Service	completed	medium	950.00	4	Research Technician - Dr. Amina Bashir	Data logger service and monitoring equipment calibration	{"Data Logger Battery","Sensor Cables"}	{"Calibration Equipment","Data Tools"}	4	2024-07-05	Research monitoring equipment functioning perfectly	2025-09-30 18:18:44.339405
15	sarh_traditional_well	well	2023-04-01	Traditional Well Restoration	completed	high	400.00	8	Traditional Well Master - Elder Brahim	Stone work repair and traditional safety improvements	{"Natural Stone","Traditional Mortar"}	{"Traditional Tools","Stone Working Equipment"}	3	2024-04-01	Traditional methods preserve cultural heritage	2025-09-30 18:18:44.339405
16	guereda_agricultural_borehole	borehole	2023-08-20	Irrigation System Service	completed	medium	3200.00	12	Irrigation Specialist - Agricultural Team	Irrigation pump service and distribution network maintenance	{"Irrigation Pumps","Distribution Valves"}	{"Irrigation Equipment","Network Tools"}	4	2024-08-20	Agricultural irrigation system optimized	2025-09-30 18:18:44.339405
17	northern_chad_borehole	borehole	2023-06-10	Wind Power System Service	completed	medium	2200.00	10	Wind Energy Technician - Renewable Team	Wind turbine maintenance and power system optimization	{"Wind Turbine Parts","Power Controllers"}	{"Wind Service Equipment"}	4	2024-06-10	Wind power system efficiency excellent	2025-09-30 18:18:44.339405
18	northern_chad_test_borehole	borehole	2023-08-15	Research Equipment Maintenance	completed	low	1500.00	6	Research Equipment Specialist	Geological monitoring equipment service and data system update	{"Monitoring Sensors","Data Storage"}	{"Research Equipment"}	5	2024-08-15	Research monitoring systems excellent condition	2025-09-30 18:18:44.339405
19	adre_water_reserve	pond	2023-06-15	Liner System Inspection	completed	high	2800.00	16	Large Pond Specialist Team	HDPE liner comprehensive inspection and inlet structure service	{"Liner Repair Kit","Inlet Seals"}	{"Liner Testing Equipment","Repair Tools"}	5	2024-06-15	Large reserve liner system in excellent condition	2025-09-30 18:18:44.339405
20	adre_area_test_pond	pond	2023-08-10	Monitoring System Calibration	completed	low	600.00	4	Experimental Systems Technician	Water monitoring sensors calibration and data system check	{"Sensor Batteries","Calibration Solutions"}	{"Calibration Equipment"}	4	2024-08-10	Experimental monitoring systems accurate	2025-09-30 18:18:44.339405
21	central_chad_test_pond	pond	2023-06-20	Concrete Lining Maintenance	completed	medium	1800.00	14	Concrete Specialist - Municipal Works	Concrete liner crack repair and control structure service	{"Concrete Repair Material",Sealants}	{"Concrete Repair Equipment"}	4	2024-06-20	Concrete pond structure maintained excellent condition	2025-09-30 18:18:44.339405
22	logone_valley_pond	pond	2023-03-30	Flood Control System Check	completed	high	2500.00	20	Flood Management Team	Spillway maintenance and flood barrier inspection	{"Spillway Gates","Barrier Reinforcement"}	{"Heavy Maintenance Equipment"}	4	2024-03-30	Flood control systems ready for next season	2025-09-30 18:18:44.339405
23	abeche_community_well	well	2023-04-15	Hand Pump Repair	completed	high	350.00	4	Local Technician - Abakar Ahmed	Hand pump cylinder replacement and seal maintenance	{"Pump Cylinder","Rubber Seals"}	{"Hand Tools","Pump Jack"}	4	2023-10-15	Pump efficiency restored to 90%	2025-09-30 18:21:07.85591
24	abeche_community_well	well	2023-07-20	Well Head Cleaning	completed	medium	150.00	2	Community Volunteer - Fatima Hassan	Well head sanitization and protective cover repair	{"Cleaning Supplies","Cover Repair Kit"}	{"Cleaning Equipment","Basic Tools"}	4	2024-01-20	Improved hygiene and protection	2025-09-30 18:21:07.85591
25	abeche_community_well	well	2023-10-15	Quarterly Inspection	completed	low	100.00	3	Regional Inspector - Mohamed Saleh	Routine quarterly safety and performance inspection	{}	{"Inspection Tools","Water Testing Kit"}	4	2024-01-15	All systems functioning normally	2025-09-30 18:21:07.85591
26	abeche_deep_well	well	2023-01-10	Submersible Pump Service	completed	medium	2200.00	8	Pump Specialist - Ali Mahmoud	Annual submersible pump inspection and motor service	{"Motor Bearings",Impeller}	{"Pump Hoist","Motor Testing Equipment"}	5	2024-01-10	Pump performance optimized, efficiency increased 12%	2025-09-30 18:21:07.85591
27	abeche_deep_well	well	2023-06-15	Control Panel Upgrade	completed	low	850.00	6	Electrical Technician - Ibrahim Yousif	Control panel modernization and safety improvements	{"Control Relays","Safety Switches"}	{"Electrical Tools","Testing Equipment"}	4	2025-06-15	Enhanced safety and automated controls	2025-09-30 18:21:07.85591
28	abeche_deep_well	well	2024-01-10	Annual Comprehensive Service	scheduled	medium	2800.00	12	Deep Well Team - Specialized Crew	Complete system inspection, pump service, and performance testing	{"TBD based on inspection"}	{"Full Service Equipment"}	\N	2025-01-10	Comprehensive annual maintenance scheduled	2025-09-30 18:21:07.85591
29	guereda_village_well	well	2023-05-10	Rope Pump Maintenance	completed	medium	180.00	3	Village Technician - Haroun Moussa	Rope pump system maintenance and rope replacement	{"Pump Rope","Pulley Bearings"}	{"Village Tools","Rope Installation Kit"}	3	2023-11-10	Village-managed maintenance successful	2025-09-30 18:21:07.85591
30	moundou_community_well	well	2023-05-15	Electric Pump Service	completed	high	1200.00	6	Municipal Electrician - Jean-Claude Ngarta	Electric pump motor service and electrical system check	{"Motor Capacitor","Electrical Contacts"}	{"Electrical Testing Equipment"}	4	2024-05-15	Municipal system efficiency improved	2025-09-30 18:21:07.85591
31	ndjamena_community_well_1	well	2022-12-10	SCADA System Update	completed	low	2500.00	8	Automation Specialist - Advanced Systems Team	SCADA system software update and sensor calibration	{"Software License","Sensor Calibration Kit"}	{"Computer Equipment","Calibration Tools"}	5	2023-12-10	Automated monitoring system optimized	2025-09-30 18:21:07.85591
32	northern_chad_test_well	well	2023-07-05	Monitoring Equipment Service	completed	medium	950.00	4	Research Technician - Dr. Amina Bashir	Data logger service and monitoring equipment calibration	{"Data Logger Battery","Sensor Cables"}	{"Calibration Equipment","Data Tools"}	4	2024-07-05	Research monitoring equipment functioning perfectly	2025-09-30 18:21:07.85591
33	sarh_traditional_well	well	2023-04-01	Traditional Well Restoration	completed	high	400.00	8	Traditional Well Master - Elder Brahim	Stone work repair and traditional safety improvements	{"Natural Stone","Traditional Mortar"}	{"Traditional Tools","Stone Working Equipment"}	3	2024-04-01	Traditional methods preserve cultural heritage	2025-09-30 18:21:07.85591
34	abeche_deep_borehole	borehole	2023-03-01	Deep Pump Overhaul	completed	high	8500.00	16	Deep Drilling Specialist - Hassan Mahamat	Complete pump system overhaul and performance optimization	{"Pump Assembly","Drive Shaft","Pump Controller"}	{"Heavy Lifting Equipment","Pump Testing Rig"}	5	2024-03-01	Pump performance increased 18%, excellent condition	2025-09-30 18:21:07.856849
35	abeche_deep_borehole	borehole	2023-08-15	Geological Monitoring	completed	low	1200.00	6	Hydrogeologist - Dr. Khadija Omar	Aquifer monitoring and geological assessment	{}	{"Logging Equipment","Monitoring Instruments"}	5	2024-08-15	Aquifer stable, excellent recharge rates	2025-09-30 18:21:07.856849
36	central_chad_borehole_1	borehole	2023-07-20	Multi-Zone System Service	completed	medium	4200.00	12	Multi-Zone Specialist - Ahmed Zakaria	Zone isolation system inspection and pump synchronization	{"Zone Packers","Control Valves"}	{"Zone Testing Equipment","Synchronization Tools"}	5	2024-07-20	All zones operating optimally, perfect isolation	2025-09-30 18:21:07.856849
37	central_chad_borehole_1	borehole	2023-11-10	Production Optimization	completed	low	1800.00	8	Production Engineer - Mariam Abdallah	Flow rate optimization and energy efficiency improvements	{"Flow Controllers"}	{"Flow Measurement Equipment"}	4	2024-11-10	Energy consumption reduced 12%	2025-09-30 18:21:07.856849
38	guereda_agricultural_borehole	borehole	2023-08-20	Irrigation System Service	completed	medium	3200.00	12	Irrigation Specialist - Agricultural Team	Irrigation pump service and distribution network maintenance	{"Irrigation Pumps","Distribution Valves"}	{"Irrigation Equipment","Network Tools"}	4	2024-08-20	Agricultural irrigation system optimized	2025-09-30 18:21:07.856849
39	northern_chad_borehole	borehole	2023-06-10	Wind Power System Service	completed	medium	2200.00	10	Wind Energy Technician - Renewable Team	Wind turbine maintenance and power system optimization	{"Wind Turbine Parts","Power Controllers"}	{"Wind Service Equipment"}	4	2024-06-10	Wind power system efficiency excellent	2025-09-30 18:21:07.856849
40	northern_chad_test_borehole	borehole	2023-08-15	Research Equipment Maintenance	completed	low	1500.00	6	Research Equipment Specialist	Geological monitoring equipment service and data system update	{"Monitoring Sensors","Data Storage"}	{"Research Equipment"}	5	2024-08-15	Research monitoring systems excellent condition	2025-09-30 18:21:07.856849
41	abeche_seasonal_pond	pond	2023-03-30	Sediment Removal	completed	high	2200.00	24	Excavation Team - Pond Specialists	Annual sediment removal and capacity restoration	{}	{Excavator,"Sediment Removal Equipment"}	4	2024-03-30	Storage capacity restored to 95%	2025-09-30 18:21:07.857635
42	abeche_seasonal_pond	pond	2023-08-15	Clay Lining Repair	completed	medium	1200.00	12	Lining Specialist - Omar Hassan	Clay lining inspection and crack repair	{"Bentonite Clay",Sealant}	{"Compaction Equipment","Repair Tools"}	4	2024-08-15	Lining integrity restored, minimal seepage	2025-09-30 18:21:07.857635
43	abeche_seasonal_pond	pond	2023-11-20	Pre-Season Preparation	completed	low	400.00	6	Maintenance Crew	Inlet cleaning and overflow system check	{"Filter Media"}	{"Cleaning Equipment"}	3	2024-05-20	Ready for next rainy season	2025-09-30 18:21:07.857635
44	adre_water_reserve	pond	2023-06-15	Liner System Inspection	completed	high	2800.00	16	Large Pond Specialist Team	HDPE liner comprehensive inspection and inlet structure service	{"Liner Repair Kit","Inlet Seals"}	{"Liner Testing Equipment","Repair Tools"}	5	2024-06-15	Large reserve liner system in excellent condition	2025-09-30 18:21:07.857635
45	central_chad_test_pond	pond	2023-06-20	Concrete Lining Maintenance	completed	medium	1800.00	14	Concrete Specialist - Municipal Works	Concrete liner crack repair and control structure service	{"Concrete Repair Material",Sealants}	{"Concrete Repair Equipment"}	4	2024-06-20	Concrete pond structure maintained excellent condition	2025-09-30 18:21:07.857635
46	logone_valley_pond	pond	2023-03-30	Flood Control System Check	completed	high	2500.00	20	Flood Management Team	Spillway maintenance and flood barrier inspection	{"Spillway Gates","Barrier Reinforcement"}	{"Heavy Maintenance Equipment"}	4	2024-03-30	Flood control systems ready for next season	2025-09-30 18:21:07.857635
47	well_1	well	2023-08-01	SCADA System Update	completed	low	2500.00	8	Automation Specialist Team	SCADA system software update and sensor calibration	{"Software License","Sensor Kit"}	{"Computer Equipment","Calibration Tools"}	5	2024-08-01	Automated monitoring system optimized	2025-09-30 19:15:22.862888
48	borehole_1	borehole	2023-08-01	Multi-Zone System Service	completed	medium	4200.00	12	Multi-Zone Specialist	Zone isolation system inspection and pump synchronization	{"Zone Packers","Control Valves"}	{"Zone Testing Equipment"}	5	2024-08-01	All zones operating optimally	2025-09-30 19:15:22.862888
49	pond_1	pond	2023-08-01	Liner System Inspection	completed	high	3500.00	18	Geomembrane Specialist Team	Complete liner system inspection and minor repairs	{"Liner Patches","Welding Materials"}	{"Leak Detection Equipment"}	5	2024-08-01	Liner integrity excellent	2025-09-30 19:15:22.862888
51	pond_3	pond	2025-08-15	routine_inspection	completed	medium	850.00	6	Khadija Al-Hassan	Seasonal pond inspection and cleaning before rainy season	{"Intake Filter","Sediment Screens"}	{"Water Pump","Cleaning Equipment"}	4	2026-02-15	Pond in good condition, minor sediment removal completed	2025-09-30 20:45:05.28414
52	pond_3	pond	2025-05-20	algae_treatment	completed	high	1200.00	8	Omar Deby	Algae bloom treatment and water quality restoration	{"Chemical Treatment",Bio-Filter}	{"Treatment Pump","Testing Kit"}	5	2025-11-20	Successful algae treatment, water quality restored to acceptable levels	2025-09-30 20:45:05.28414
53	pond_3	pond	2025-02-10	liner_repair	completed	high	2100.00	12	Fatima Mahamat	Emergency liner repair after dry season cracking	{"HDPE Liner Patch",Sealant}	{Excavator,"Welding Equipment"}	4	2025-08-10	Major liner repair completed, no further leaks detected	2025-09-30 20:45:05.28414
54	pond_3	pond	2024-11-05	capacity_upgrade	completed	medium	3500.00	24	Ibrahim Al-Rashid	Pond capacity expansion for increased storage	{"Additional Liner","Spillway Extension"}	{"Heavy Excavator","Compaction Equipment"}	5	2025-05-05	Capacity increased by 30%, improved water storage for dry season	2025-09-30 20:45:05.28414
55	pond_2	pond	2025-07-10	structural_inspection	completed	medium	750.00	5	Ahmed Hassan	Annual structural integrity check	{"Safety Barriers"}	{"Inspection Tools"}	4	2026-01-10	Structural integrity good, minor safety barrier replacement	2025-09-30 20:45:22.103328
56	pond_2	pond	2025-04-15	water_treatment	completed	high	950.00	7	Aisha Mahamat	Water quality improvement treatment	{"Filter Media"}	{"Filtration System"}	5	2025-10-15	Water quality significantly improved	2025-09-30 20:45:22.103328
57	pond_4	pond	2025-06-25	sediment_removal	completed	medium	1100.00	10	Omar Al-Rashid	Annual sediment dredging	{"Dredging Equipment"}	{Excavator,"Dump Truck"}	4	2026-06-25	Sediment removed, capacity restored	2025-09-30 20:45:22.103328
58	pond_4	pond	2025-03-12	emergency_repair	completed	high	1800.00	14	Fatima Al-Hassan	Emergency spillway repair after flooding	{"Concrete Mix",Rebar}	{"Concrete Mixer","Welding Tools"}	3	2025-09-12	Emergency repairs completed, spillway functional	2025-09-30 20:45:22.103328
59	pond_5	pond	2025-05-30	maintenance_upgrade	completed	medium	1350.00	8	Ibrahim Saleh	System upgrade and preventive maintenance	{"Control Valves","Monitoring Equipment"}	{"Installation Tools"}	5	2025-11-30	Upgrade successful, improved monitoring capabilities	2025-09-30 20:45:22.103328
\.


--
-- Data for Name: feature_water_quality_reports; Type: TABLE DATA; Schema: public; Owner: geouser
--

COPY public.feature_water_quality_reports (id, feature_id, feature_type, test_date, ph_level, tds_ppm, conductivity, turbidity, temperature, ecoli_count, coliform_count, overall_quality, testing_laboratory, next_test_due_date, recommended_treatment, notes, created_at) FROM stdin;
1	well_1	well	2024-02-01	7.2	245	390	0.8	26.5	0	0	excellent	Chad National Water Quality Lab	2024-08-01	No treatment required	Excellent potable water source	2025-09-30 12:49:01.81862
2	well_1	well	2024-04-01	7.1	258	410	1.2	27.8	0	2	good	Chad National Water Quality Lab	2024-10-01	Monthly chlorination recommended	Minor coliform detection	2025-09-30 12:49:01.81862
3	well_1	well	2024-06-01	7.3	235	375	0.6	28.2	0	0	excellent	Chad National Water Quality Lab	2024-12-01	Continue current maintenance	Optimal water quality maintained	2025-09-30 12:49:01.81862
4	well_1	well	2024-08-01	7.0	270	425	1.5	29.1	1	3	good	Chad National Water Quality Lab	2025-02-01	Disinfection required	Slight bacterial contamination	2025-09-30 12:49:01.81862
5	well_1	well	2024-09-15	7.2	252	395	0.9	28.5	0	0	excellent	Chad National Water Quality Lab	2025-03-15	Maintain current protocols	Quality restored after treatment	2025-09-30 12:49:01.81862
6	well_2	well	2024-02-15	6.8	320	485	2.1	25.8	3	8	fair	Sahara Testing Services	2024-08-15	UV disinfection recommended	Higher TDS levels detected	2025-09-30 12:49:01.81862
7	well_2	well	2024-04-15	7.0	295	450	1.8	26.5	0	2	good	Sahara Testing Services	2024-10-15	Quarterly testing advised	Improvement after maintenance	2025-09-30 12:49:01.81862
8	well_2	well	2024-06-15	6.9	310	470	2.3	27.2	2	5	fair	Sahara Testing Services	2024-12-15	Water treatment system needed	Seasonal quality variation	2025-09-30 12:49:01.81862
9	well_2	well	2024-08-15	7.1	285	430	1.6	28.0	0	1	good	Sahara Testing Services	2025-02-15	Continue monitoring	Quality stabilizing	2025-09-30 12:49:01.81862
10	well_2	well	2024-09-20	7.0	298	445	1.9	27.8	1	3	good	Sahara Testing Services	2025-03-20	Bi-monthly chlorination	Acceptable for community use	2025-09-30 12:49:01.81862
11	borehole_1	borehole	2024-02-10	7.4	180	285	0.5	25.2	0	0	excellent	Central Lab Chad	2024-08-10	No treatment required	Premium groundwater quality	2025-09-30 12:49:01.81862
12	borehole_1	borehole	2024-04-10	7.3	195	300	0.7	26.1	0	0	excellent	Central Lab Chad	2024-10-10	Continue current management	Consistently high quality	2025-09-30 12:49:01.81862
13	borehole_1	borehole	2024-06-10	7.5	175	275	0.4	26.8	0	1	excellent	Central Lab Chad	2024-12-10	Routine monitoring sufficient	Exceptional purity maintained	2025-09-30 12:49:01.81862
14	borehole_1	borehole	2024-08-10	7.2	205	315	0.9	27.5	0	0	excellent	Central Lab Chad	2025-02-10	Maintain protective measures	High-quality deep aquifer	2025-09-30 12:49:01.81862
15	borehole_1	borehole	2024-09-25	7.4	188	290	0.6	26.9	0	0	excellent	Central Lab Chad	2025-03-25	No action required	Reliable water source	2025-09-30 12:49:01.81862
16	pond_1	pond	2024-02-25	8.1	450	685	12.5	24.8	85	150	poor	Lake Chad Environmental Lab	2024-05-25	Algae treatment and filtration required	High algae content typical for surface water	2025-09-30 12:49:01.81862
17	pond_1	pond	2024-05-25	7.8	420	640	8.2	28.2	45	95	fair	Lake Chad Environmental Lab	2024-08-25	UV treatment before use	Improvement after algae management	2025-09-30 12:49:01.81862
18	pond_1	pond	2024-08-25	7.9	385	590	6.8	29.5	25	60	fair	Lake Chad Environmental Lab	2024-11-25	Sand filtration recommended	Seasonal quality improvement	2025-09-30 12:49:01.81862
19	pond_1	pond	2024-09-30	8.0	410	615	9.1	28.8	55	110	fair	Lake Chad Environmental Lab	2024-12-30	Multi-stage treatment needed	Requires treatment for potable use	2025-09-30 12:49:01.81862
24	abeche_community_well	well	2023-03-15	7.1	280	420	1.2	27.5	0	2	good	Chad National Water Quality Lab	2023-09-15	Monthly chlorination	Minor coliform detection, treatment recommended	2025-09-30 18:21:07.849886
25	abeche_community_well	well	2023-06-15	7.3	265	398	0.8	28.2	0	0	excellent	Chad National Water Quality Lab	2023-12-15	Continue current maintenance	Quality improved after treatment	2025-09-30 18:21:07.849886
26	abeche_community_well	well	2023-09-15	7.2	275	412	1.0	26.8	0	1	good	Chad National Water Quality Lab	2024-03-15	Quarterly monitoring	Stable water quality maintained	2025-09-30 18:21:07.849886
27	abeche_deep_well	well	2022-12-01	7.4	220	335	0.5	25.0	0	0	excellent	Chad National Water Quality Lab	2023-06-01	No treatment required	Deep aquifer provides excellent quality	2025-09-30 18:21:07.849886
28	abeche_deep_well	well	2023-06-01	7.3	225	340	0.6	25.5	0	0	excellent	Chad National Water Quality Lab	2024-06-01	Annual monitoring sufficient	Consistently excellent quality	2025-09-30 18:21:07.849886
29	adre_border_well	well	2023-05-30	7.0	295	445	1.5	29.0	1	3	fair	Cross-Border Lab Services	2023-11-30	Disinfection and filtration	Higher mineralization, treatment needed	2025-09-30 18:21:07.849886
30	adre_border_well	well	2023-08-30	7.2	285	430	1.0	28.5	0	1	good	Cross-Border Lab Services	2024-02-28	Continue treatment	Improvement after treatment implementation	2025-09-30 18:21:07.849886
31	doba_community_well	well	2023-01-10	6.9	315	472	2.0	30.2	2	5	fair	Southern Chad Lab	2023-07-10	Immediate disinfection required	Elevated bacteria levels detected	2025-09-30 18:21:07.849886
32	doba_community_well	well	2023-04-10	7.1	305	458	1.5	29.8	0	2	good	Southern Chad Lab	2023-10-10	Monthly disinfection	Bacterial levels reduced	2025-09-30 18:21:07.849886
33	doba_community_well	well	2023-07-10	7.2	298	447	1.2	29.5	0	1	good	Southern Chad Lab	2024-01-10	Continue monitoring	Stable improvement maintained	2025-09-30 18:21:07.849886
34	guereda_village_well	well	2023-04-25	7.0	340	510	2.5	31.0	2	8	fair	Village Testing Cooperative	2023-10-25	Local disinfection methods	Village-managed well, local treatment methods applied	2025-09-30 18:21:07.849886
35	moundou_community_well	well	2023-04-20	7.4	258	387	0.9	28.5	0	1	good	Municipal Lab Services	2023-10-20	Monthly monitoring	Municipal system maintains good quality	2025-09-30 18:21:07.849886
36	ndjamena_community_well_1	well	2022-11-15	7.6	195	293	0.4	26.0	0	0	excellent	Capital City Lab	2023-11-15	Automated monitoring	Advanced system maintains excellent quality	2025-09-30 18:21:07.849886
37	northern_chad_test_well	well	2023-06-25	7.2	275	413	1.1	29.5	0	2	good	Research Laboratory	2023-12-25	Research-grade treatment	Research well with monitoring equipment	2025-09-30 18:21:07.849886
38	sarh_traditional_well	well	2023-03-20	6.8	385	578	3.0	30.5	3	12	poor	Traditional Water Testing	2023-09-20	Traditional purification methods	Traditional well requires conventional treatment	2025-09-30 18:21:07.849886
39	abeche_deep_borehole	borehole	2023-02-01	7.8	185	280	0.3	23.5	0	0	excellent	Deep Aquifer Testing Lab	2024-02-01	No treatment required	Pristine deep aquifer water	2025-09-30 18:21:07.85401
40	abeche_deep_borehole	borehole	2023-08-01	7.7	190	285	0.4	24.0	0	0	excellent	Deep Aquifer Testing Lab	2024-08-01	Annual monitoring	Consistent excellent quality	2025-09-30 18:21:07.85401
41	central_chad_borehole_1	borehole	2023-06-15	7.5	245	365	0.7	26.2	0	0	excellent	Multi-Zone Analysis Lab	2024-06-15	Selective zone monitoring	Multi-zone completion provides optimal quality	2025-09-30 18:21:07.85401
42	central_chad_borehole_1	borehole	2023-09-15	7.6	240	360	0.6	25.8	0	0	excellent	Multi-Zone Analysis Lab	2024-12-15	Continue selective pumping	Zone isolation maintaining quality	2025-09-30 18:21:07.85401
43	eastern_chad_borehole	borehole	2023-04-01	7.3	265	398	0.9	27.8	0	0	excellent	Solar System Water Lab	2023-10-01	UV sterilization available	Solar UV system provides additional safety	2025-09-30 18:21:07.85401
44	eastern_chad_borehole	borehole	2023-07-01	7.4	260	390	0.8	28.2	0	0	excellent	Solar System Water Lab	2024-01-01	UV system functioning well	Solar disinfection effective	2025-09-30 18:21:07.85401
45	guereda_agricultural_borehole	borehole	2023-07-30	7.5	235	353	0.8	27.0	0	0	excellent	Agricultural Testing Lab	2024-07-30	Irrigation quality monitoring	Excellent quality for agricultural use	2025-09-30 18:21:07.85401
46	northern_chad_borehole	borehole	2023-05-15	7.3	290	435	1.0	28.8	0	1	good	Desert Conditions Lab	2023-11-15	Wind-powered UV treatment	Wind power system provides additional treatment	2025-09-30 18:21:07.85401
47	northern_chad_test_borehole	borehole	2023-07-20	7.7	210	315	0.5	24.5	0	0	excellent	Geological Research Lab	2024-07-20	Research monitoring only	Research-grade monitoring and analysis	2025-09-30 18:21:07.85401
48	abeche_seasonal_pond	pond	2023-02-15	8.2	450	675	15.0	22.0	8	25	poor	Surface Water Testing Lab	2023-05-15	Multi-stage treatment required	Seasonal pond requires treatment before use	2025-09-30 18:21:07.855045
49	abeche_seasonal_pond	pond	2023-05-15	7.8	420	630	12.0	25.5	3	15	fair	Surface Water Testing Lab	2023-08-15	Coagulation and disinfection	Improvement with settling time	2025-09-30 18:21:07.855045
50	abeche_seasonal_pond	pond	2023-08-15	7.6	385	578	8.0	28.0	1	8	fair	Surface Water Testing Lab	2023-11-15	Disinfection before use	Quality improves during dry season	2025-09-30 18:21:07.855045
51	lake_chad_retention_pond	pond	2023-07-15	8.0	380	570	8.5	29.5	2	12	fair	Lake Chad Monitoring Station	2023-10-15	Sedimentation and chlorination	Large volume provides natural treatment	2025-09-30 18:21:07.855045
52	lake_chad_retention_pond	pond	2023-10-15	7.9	365	548	7.0	27.0	1	8	good	Lake Chad Monitoring Station	2024-01-15	Basic disinfection	Natural processes improving quality	2025-09-30 18:21:07.855045
53	chari_river_pond	pond	2023-01-01	7.5	395	593	12.0	24.0	4	18	fair	River System Lab	2023-04-01	Biological treatment recommended	River connection maintains flow	2025-09-30 18:21:07.855045
54	chari_river_pond	pond	2023-04-01	7.6	385	578	10.0	26.5	2	12	fair	River System Lab	2023-07-01	Continue biological treatment	Fish population helping with biological treatment	2025-09-30 18:21:07.855045
55	chari_river_pond	pond	2023-07-01	7.7	375	563	8.5	28.8	1	8	good	River System Lab	2023-10-01	Maintenance of ecosystem	Ecosystem approach showing results	2025-09-30 18:21:07.855045
56	adre_water_reserve	pond	2023-05-20	7.8	320	480	5.0	26.0	1	10	fair	Reserve Management Lab	2023-11-20	Multi-stage treatment system	Large reserve requires treatment before distribution	2025-09-30 18:21:07.855045
57	adre_area_test_pond	pond	2023-07-25	8.1	365	548	8.0	27.5	3	15	fair	Experimental Water Lab	2023-10-25	Test treatment protocols	Experimental treatments being evaluated	2025-09-30 18:21:07.855045
58	central_chad_test_pond	pond	2023-05-30	7.7	295	443	3.0	28.0	1	5	good	Municipal Testing Center	2023-11-30	Concrete pond maintenance	Concrete lining maintains good quality	2025-09-30 18:21:07.855045
59	logone_valley_pond	pond	2023-02-15	7.9	420	630	10.0	25.0	5	20	poor	Valley Management Lab	2023-08-15	Flood management treatment	Valley flooding affects seasonal quality	2025-09-30 18:21:07.855045
60	well_1	well	2023-09-01	7.6	195	293	0.4	26.0	0	0	excellent	Capital City Lab	2024-09-01	Automated monitoring	Advanced municipal system maintains excellent quality	2025-09-30 19:14:44.838054
61	borehole_1	borehole	2023-09-01	7.5	245	365	0.7	26.2	0	0	excellent	Multi-Zone Analysis Lab	2024-09-01	Selective zone monitoring	Multi-zone completion provides optimal quality	2025-09-30 19:14:44.838054
62	pond_1	pond	2023-09-01	8.0	380	570	8.5	29.5	2	12	fair	Lake Chad Monitoring Station	2024-09-01	Sedimentation and chlorination	Large volume provides natural treatment	2025-09-30 19:14:44.838054
63	pond_3	pond	2025-09-15	7.2	245	380	2.1	24.5	0	5	good	Chad Water Analysis Lab	2025-12-15	Regular monitoring recommended	Water quality within acceptable limits for seasonal pond usage	2025-09-30 20:52:20.606162
64	pond_3	pond	2025-06-20	6.8	280	420	3.2	26.8	2	12	fair	Sahel Water Quality Institute	2025-09-20	Filtration and UV treatment recommended	Slightly elevated bacterial levels due to seasonal algae bloom	2025-09-30 20:52:20.606162
65	pond_3	pond	2025-03-10	7.5	190	310	1.8	22.1	0	3	excellent	NDjamena Testing Center	2025-06-10	No treatment required	Excellent water quality after liner repair and system cleaning	2025-09-30 20:52:20.606162
66	pond_3	pond	2024-12-05	6.9	320	485	4.1	19.8	5	18	poor	Regional Health Laboratory	2025-03-05	Chlorination and boiling advised	Water quality degraded, requires treatment before consumption	2025-09-30 20:52:20.606162
67	pond_3	pond	2024-09-12	7.1	260	395	2.5	25.3	1	8	good	Chad Water Analysis Lab	2024-12-12	Standard filtration recommended	Good quality maintained with regular maintenance program	2025-09-30 20:52:20.606162
68	pond_2	pond	2025-08-25	7.0	220	350	1.9	23.8	0	4	good	Sahel Water Quality Institute	2025-11-25	Regular monitoring	Stable water quality with good bacterial control	2025-09-30 20:52:42.959455
69	pond_2	pond	2025-05-15	6.7	290	440	3.5	27.2	3	15	fair	Chad Water Analysis Lab	2025-08-15	UV treatment recommended	Seasonal quality variation, treatment advised	2025-09-30 20:52:42.959455
70	pond_2	pond	2025-02-08	7.3	185	295	1.6	21.4	0	2	excellent	Regional Health Laboratory	2025-05-08	No treatment needed	Excellent quality after structural improvements	2025-09-30 20:52:42.959455
71	pond_4	pond	2025-07-30	6.9	310	470	4.2	28.1	4	20	poor	NDjamena Testing Center	2025-10-30	Chlorination required	Poor quality due to sediment buildup, dredging needed	2025-09-30 20:52:42.959455
72	pond_4	pond	2025-04-18	7.4	200	320	2.0	24.0	1	6	good	Chad Water Analysis Lab	2025-07-18	Standard filtration	Good quality after emergency repairs	2025-09-30 20:52:42.959455
73	pond_4	pond	2025-01-12	6.6	350	520	5.1	18.9	8	25	poor	Sahel Water Quality Institute	2025-04-12	Boiling and chlorination required	Poor quality requiring immediate treatment	2025-09-30 20:52:42.959455
74	pond_5	pond	2025-09-05	7.6	175	280	1.2	22.7	0	1	excellent	Regional Health Laboratory	2025-12-05	No treatment required	Excellent quality after system upgrade	2025-09-30 20:52:42.959455
75	pond_5	pond	2025-06-12	7.1	235	365	2.3	25.5	1	7	good	Chad Water Analysis Lab	2025-09-12	Light filtration recommended	Good water quality with minor seasonal variations	2025-09-30 20:52:42.959455
76	pond_5	pond	2025-03-20	7.0	265	410	2.8	24.8	2	11	fair	NDjamena Testing Center	2025-06-20	UV treatment advised	Fair quality before upgrade implementation	2025-09-30 20:52:42.959455
\.


--
-- Data for Name: ponds; Type: TABLE DATA; Schema: public; Owner: geouser
--

COPY public.ponds (id, pond_id, name, surface_area_sqm, maximum_depth_m, is_perennial, primary_use, capacity_liters, status, description, feature_type, geom, created_at) FROM stdin;
1	pond_1	Lake Chad Retention Pond	250000.00	3.50	t	irrigation	875000000	active	Large irrigation pond near Lake Chad	pond	0101000020E6100000A089B0E1E9352C40BEC1172653A52B40	2025-09-30 13:02:57.935005
2	pond_2	Chari River Pond	180000.00	2.80	t	fishery	504000000	active	Fish farming pond along Chari River	pond	0101000020E6100000C9E53FA4DF9E2E4055302AA913B02640	2025-09-30 13:02:57.935005
3	pond_3	Logone Valley Pond	320000.00	4.00	f	irrigation	1280000000	active	Seasonal irrigation pond in fertile valley	pond	0101000020E61000004CA60A462525304003098A1F63AE2440	2025-09-30 13:02:57.935005
4	pond_4	Abeche Seasonal Pond	2800.00	3.20	f	Livestock	\N	active	Seasonal water storage for livestock	pond	0101000020E6100000D200DE0209CA344051DA1B7C61722B40	2025-09-30 13:20:15.191579
5	pond_5	Adre Water Reserve	1950.00	2.80	f	Municipal	\N	active	Municipal water reserve with treatment facility	pond	0101000020E61000003F575BB1BF9C3440FB3A70CE88322B40	2025-09-30 13:20:15.191579
6	pond_adre_area	Adre Area Test Pond	1500.00	\N	f	\N	\N	active	Test pond near clicked coordinates	pond	0101000020E6100000FCE4284014983440CA17B49080312B40	2025-09-30 13:31:14.071136
7	pond_central_chad	Central Chad Test Pond	1200.00	\N	f	\N	\N	active	Test pond in central region	pond	0101000020E6100000CC0BB08F4E4D2C409207228B34B92B40	2025-09-30 13:31:14.071136
\.


--
-- Data for Name: water_management_zones_detailed; Type: TABLE DATA; Schema: public; Owner: geouser
--

COPY public.water_management_zones_detailed (id, zone_id, zone_name, zone_type, administrative_level, total_infrastructure_count, wells_count, boreholes_count, ponds_count, zone_status, population_served, area_km2, water_stress_level, priority_level, management_agency, created_date, last_updated, notes, geom) FROM stdin;
1	ZONE_CDT_001	N'Djamena Water Management Zone	urban	regional	15	8	5	2	active	1200000	1250.50	high	high	Chad National Water Authority	2025-09-30 21:25:47.075164	2025-09-30 21:25:47.075164	Primary urban water management zone covering capital city	0103000020E610000001000000050000000000000000002D409A9999999999274033333333333330409A9999999999274033333333333330409A999999999929400000000000002D409A999999999929400000000000002D409A99999999992740
2	ZONE_CDT_002	Sahel Agricultural Water Zone	rural	regional	12	6	3	3	active	450000	2800.30	moderate	high	Regional Agricultural Water Board	2025-09-30 21:25:47.075164	2025-09-30 21:25:47.075164	Primary agricultural zone with seasonal water management needs	0103000020E610000001000000050000000000000000002E40000000000000214000000000000032400000000000002140000000000000324000000000000025400000000000002E4000000000000025400000000000002E400000000000002140
3	ZONE_CDT_003	Eastern Border Water Management Zone	border	provincial	8	4	2	2	active	180000	1950.70	high	medium	Eastern Region Water Committee	2025-09-30 21:25:47.075164	2025-09-30 21:25:47.075164	Cross-border water management with Sudan coordination	0103000020E61000000100000005000000000000000000344000000000000028400000000000803640000000000000284000000000008036400000000000002D4000000000000034400000000000002D4000000000000034400000000000002840
4	ZONE_CDT_004	Sahara Desert Water Conservation Zone	desert	special	5	2	2	1	active	75000	3200.80	extreme	high	Desert Water Conservation Authority	2025-09-30 21:25:47.075164	2025-09-30 21:25:47.075164	Specialized desert water management with conservation focus	0103000020E610000001000000050000000000000000003040000000000000324000000000000034400000000000003240000000000000344000000000000035400000000000003040000000000000354000000000000030400000000000003240
5	ZONE_CDT_005	Western Highlands Water Zone	highland	regional	10	7	2	1	active	320000	1680.40	low	medium	Highland Water Management Authority	2025-09-30 21:25:47.075164	2025-09-30 21:25:47.075164	Highland region with natural spring water sources	0103000020E610000001000000050000000000000000002A400000000000002C400000000000002F400000000000002C400000000000002F4000000000008030400000000000002A4000000000008030400000000000002A400000000000002C40
6	ZONE_CDT_006	Lake Chad Basin Management Zone	basin	international	18	9	6	3	active	600000	2150.90	moderate	high	Lake Chad Basin Commission	2025-09-30 21:25:47.075164	2025-09-30 21:25:47.075164	Transboundary water management for Lake Chad region	0103000020E610000001000000050000000000000000002B4000000000000029400000000000002E4000000000000029400000000000002E400000000000002C400000000000002B400000000000002C400000000000002B400000000000002940
\.


--
-- Data for Name: wells; Type: TABLE DATA; Schema: public; Owner: geouser
--

COPY public.wells (id, well_id, owner, well_type, depth_m, static_water_level_m, yield_liters_per_hour, status, name, description, feature_type, geom, created_at) FROM stdin;
1	well_1	Chad Community 1	tube_well	45.00	8.00	1200.00	active	NDjamena Community Well 1	Primary water source for urban community	well	0101000020E61000003FC6DCB5841C2E4069006F8104452840	2025-09-30 13:02:57.927052
2	well_2	Chad Community 2	tube_well	38.00	9.00	1000.00	active	Moundou Community Well	Secondary water source with good yield	well	0101000020E6100000F697DD938715304052499D8026222140	2025-09-30 13:02:57.927052
3	well_3	Chad Community 3	traditional	28.00	7.00	800.00	active	Sarh Traditional Well	Traditional community well with hand pump	well	0101000020E61000008638D6C56D643240287E8CB96B492240	2025-09-30 13:02:57.927052
4	well_4	Chad Community 4	tube_well	52.00	12.00	1500.00	active	Abeche Deep Well	Deep well serving large community	well	0101000020E6100000865AD3BCE3D43440B8AF03E78CA82B40	2025-09-30 13:02:57.927052
5	well_5	Chad Community 5	community	35.00	10.00	1100.00	active	Doba Community Well	Oil region community water source	well	0101000020E610000061545227A0D93040CDCCCCCCCC4C2140	2025-09-30 13:02:57.927052
6	well_6	Abeche Municipality	Hand Pump	45.00	12.00	\N	active	Abeche Community Well	Community well serving eastern suburbs	well	0101000020E6100000A2B437F8C2D43440E10B93A982B12B40	2025-09-30 13:20:15.18339
7	well_7	Border Development Authority	Solar Pump	38.00	8.50	\N	active	Adre Border Well	Solar-powered well near Sudan border	well	0101000020E61000003D9B559FAB8D34405A643BDF4FED2A40	2025-09-30 13:20:15.18339
8	well_8	Guereda Village Council	Hand Pump	52.00	15.00	\N	maintenance	Guereda Village Well	Traditional hand pump well, needs maintenance	well	0101000020E610000040A4DFBE0EEC344057EC2FBB27AF2E40	2025-09-30 13:20:15.18339
9	well_click_test	Test Authority	\N	35.00	\N	\N	active	Test Well at Click Location	Well for testing click functionality	well	0101000020E6100000466117450FB834405649641F64992B40	2025-09-30 13:21:32.134796
10	well_adre_area	Adre Municipality	\N	40.00	\N	\N	active	Adre Area Test Well	Test well near clicked coordinates	well	0101000020E61000003599F1B6D29734403D80457EFD302B40	2025-09-30 13:31:04.09569
11	well_central_chad	Central Chad Authority	\N	35.00	\N	\N	active	Central Chad Test Well	Test well in central region	well	0101000020E61000003F74417DCB4C2C400470B378B1B82B40	2025-09-30 13:31:04.09569
12	well_north_chad	Northern Chad Authority	\N	42.00	\N	\N	active	Northern Chad Test Well	Test well in northern region	well	0101000020E61000009F76F86BB2263140698CD651D55C2E40	2025-09-30 16:36:37.483729
\.


--
-- Name: boreholes_id_seq; Type: SEQUENCE SET; Schema: public; Owner: geouser
--

SELECT pg_catalog.setval('public.boreholes_id_seq', 6, true);


--
-- Name: feature_construction_details_id_seq; Type: SEQUENCE SET; Schema: public; Owner: geouser
--

SELECT pg_catalog.setval('public.feature_construction_details_id_seq', 63, true);


--
-- Name: feature_maintenance_activities_id_seq; Type: SEQUENCE SET; Schema: public; Owner: geouser
--

SELECT pg_catalog.setval('public.feature_maintenance_activities_id_seq', 59, true);


--
-- Name: feature_water_quality_reports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: geouser
--

SELECT pg_catalog.setval('public.feature_water_quality_reports_id_seq', 76, true);


--
-- Name: ponds_id_seq; Type: SEQUENCE SET; Schema: public; Owner: geouser
--

SELECT pg_catalog.setval('public.ponds_id_seq', 7, true);


--
-- Name: water_management_zones_detailed_id_seq; Type: SEQUENCE SET; Schema: public; Owner: geouser
--

SELECT pg_catalog.setval('public.water_management_zones_detailed_id_seq', 6, true);


--
-- Name: wells_id_seq; Type: SEQUENCE SET; Schema: public; Owner: geouser
--

SELECT pg_catalog.setval('public.wells_id_seq', 12, true);


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
-- Name: idx_wells_geom; Type: INDEX; Schema: public; Owner: geouser
--

CREATE INDEX idx_wells_geom ON public.wells USING gist (geom);


--
-- PostgreSQL database dump complete
--

