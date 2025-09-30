package com.waterresources.api;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import javax.ws.rs.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.HashMap;

@Path("/features")
@ApplicationScoped
@Produces(MediaType.APPLICATION_JSON)
@Consumes(MediaType.APPLICATION_JSON)
public class WaterFeatureAnalysisService {

    @PersistenceContext(unitName = "waterResourcesPU")
    private EntityManager entityManager;

    @GET
    @Path("/construction-details/{featureId}")
    public Response getConstructionDetails(@PathParam("featureId") String featureId) {
        try {
            Query query = entityManager.createNativeQuery(
                "SELECT " +
                "contractor_name, construction_method, construction_start_date, " +
                "construction_end_date, construction_duration_days, construction_cost, " +
                "depth_m, diameter_m, length_m, width_m, lining_material, " +
                "array_to_string(materials_used, ',') as materials_used_str, " +
                "array_to_string(equipment_used, ',') as equipment_used_str, warranty_period_months, " +
                "quality_certificate_number, environmental_compliance, " +
                "project_status, quality_rating, final_inspection_date, " +
                "additional_notes, feature_type " +
                "FROM feature_construction_details WHERE feature_id = ?");
            
            query.setParameter(1, featureId);
            
            Object[] result = (Object[]) query.getSingleResult();
            
            if (result != null) {
                Map<String, Object> data = new HashMap<>();
                data.put("contractor_name", result[0]);
                data.put("construction_method", result[1]);
                data.put("construction_start_date", result[2]);
                data.put("construction_end_date", result[3]);
                data.put("construction_duration_days", result[4]);
                data.put("construction_cost", result[5]);
                data.put("depth_m", result[6]);
                data.put("diameter_m", result[7]);
                data.put("length_m", result[8]);
                data.put("width_m", result[9]);
                data.put("lining_material", result[10]);
                data.put("materials_used", result[11]);
                data.put("equipment_used", result[12]);
                data.put("warranty_period_months", result[13]);
                data.put("quality_certificate_number", result[14]);
                data.put("environmental_compliance", result[15]);
                data.put("project_status", result[16]);
                data.put("quality_rating", result[17]);
                data.put("final_inspection_date", result[18]);
                data.put("additional_notes", result[19]);
                data.put("feature_type", result[20]);
                
                return Response.ok(data).build();
            } else {
                Map<String, String> error = new HashMap<>();
                error.put("error", "No construction details found for this feature");
                return Response.status(404).entity(error).build();
            }
            
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Database query failed: " + e.getMessage());
            return Response.status(500).entity(error).build();
        }
    }

    @GET
    @Path("/water-quality/{featureId}")
    public Response getWaterQualityReports(@PathParam("featureId") String featureId) {
        try {
            Query query = entityManager.createNativeQuery(
                "SELECT " +
                "test_date, ph_level, tds_ppm, conductivity, turbidity, " +
                "temperature, ecoli_count, coliform_count, overall_quality, " +
                "testing_laboratory, next_test_due_date, recommended_treatment, notes " +
                "FROM feature_water_quality_reports WHERE feature_id = ? " +
                "ORDER BY test_date DESC");
            
            query.setParameter(1, featureId);
            
            @SuppressWarnings("unchecked")
            List<Object[]> results = query.getResultList();
            
            List<Map<String, Object>> data = new ArrayList<>();
            for (Object[] result : results) {
                Map<String, Object> report = new HashMap<>();
                report.put("test_date", result[0]);
                report.put("ph_level", result[1]);
                report.put("tds_ppm", result[2]);
                report.put("conductivity", result[3]);
                report.put("turbidity", result[4]);
                report.put("temperature", result[5]);
                report.put("ecoli_count", result[6]);
                report.put("coliform_count", result[7]);
                report.put("overall_quality", result[8]);
                report.put("testing_laboratory", result[9]);
                report.put("next_test_due_date", result[10]);
                report.put("recommended_treatment", result[11]);
                report.put("notes", result[12]);
                data.add(report);
            }
            
            return Response.ok(data).build();
            
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Database query failed: " + e.getMessage());
            return Response.status(500).entity(error).build();
        }
    }

    @GET
    @Path("/maintenance/{featureId}")
    public Response getMaintenanceActivities(@PathParam("featureId") String featureId) {
        try {
            Query query = entityManager.createNativeQuery(
                "SELECT " +
                "activity_date, activity_type, activity_status, priority, " +
                "cost, duration_hours, technician, description, " +
                "array_to_string(parts_replaced, ',') as parts_replaced_str, " +
                "array_to_string(equipment_used, ',') as equipment_used_str, effectiveness_rating, " +
                "next_maintenance_date, notes " +
                "FROM feature_maintenance_activities WHERE feature_id = ? " +
                "ORDER BY activity_date DESC");
            
            query.setParameter(1, featureId);
            
            @SuppressWarnings("unchecked")
            List<Object[]> results = query.getResultList();
            
            List<Map<String, Object>> data = new ArrayList<>();
            for (Object[] result : results) {
                Map<String, Object> activity = new HashMap<>();
                activity.put("activity_date", result[0]);
                activity.put("activity_type", result[1]);
                activity.put("activity_status", result[2]);
                activity.put("priority", result[3]);
                activity.put("cost", result[4]);
                activity.put("duration_hours", result[5]);
                activity.put("technician", result[6]);
                activity.put("description", result[7]);
                activity.put("parts_replaced", result[8]);
                activity.put("equipment_used", result[9]);
                activity.put("effectiveness_rating", result[10]);
                activity.put("next_maintenance_date", result[11]);
                activity.put("notes", result[12]);
                data.add(activity);
            }
            
            return Response.ok(data).build();
            
        } catch (Exception e) {
            Map<String, String> error = new HashMap<>();
            error.put("error", "Database query failed: " + e.getMessage());
            return Response.status(500).entity(error).build();
        }
    }
}