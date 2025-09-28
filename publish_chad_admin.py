#!/usr/bin/env python3
import requests
import json

# GeoServer connection details
GEOSERVER_URL = "http://geoserver:8080/geoserver/rest"
GEOSERVER_USER = "admin"
GEOSERVER_PASS = "geoserver"
WORKSPACE = "chad"

def create_workspace():
    """Creates the chad workspace if it doesn't exist."""
    url = f"{GEOSERVER_URL}/workspaces/{WORKSPACE}"
    response = requests.get(url, auth=(GEOSERVER_USER, GEOSERVER_PASS))
    if response.status_code == 200:
        print(f"Workspace '{WORKSPACE}' already exists.")
        return True

    url = f"{GEOSERVER_URL}/workspaces"
    headers = {"Content-type": "text/xml"}
    data = f"<workspace><name>{WORKSPACE}</name></workspace>"
    response = requests.post(url, auth=(GEOSERVER_USER, GEOSERVER_PASS), headers=headers, data=data)
    if response.status_code == 201:
        print(f"Workspace '{WORKSPACE}' created successfully.")
        return True
    else:
        print(f"Error creating workspace '{WORKSPACE}': {response.text}")
        return False

def create_shapefile_datastore(store_name, shapefile_path):
    """Creates a shapefile datastore."""
    url = f"{GEOSERVER_URL}/workspaces/{WORKSPACE}/datastores"
    headers = {"Content-type": "application/xml"}
    data = f"""
    <dataStore>
        <name>{store_name}</name>
        <connectionParameters>
            <entry key="url">file:{shapefile_path}</entry>
            <entry key="namespace">{WORKSPACE}</entry>
        </connectionParameters>
    </dataStore>
    """
    response = requests.post(url, auth=(GEOSERVER_USER, GEOSERVER_PASS), headers=headers, data=data)
    if response.status_code == 201:
        print(f"Datastore '{store_name}' created successfully.")
        return True
    elif "already exists" in response.text:
        print(f"Datastore '{store_name}' already exists.")
        return True
    else:
        print(f"Error creating datastore '{store_name}': {response.text}")
        return False

def publish_layer(store_name, layer_name):
    """Publishes a layer from a datastore."""
    url = f"{GEOSERVER_URL}/workspaces/{WORKSPACE}/datastores/{store_name}/featuretypes"
    headers = {"Content-type": "text/xml"}
    data = f"<featureType><name>{layer_name}</name></featureType>"
    
    response = requests.post(url, auth=(GEOSERVER_USER, GEOSERVER_PASS), headers=headers, data=data)
    if response.status_code == 201:
        print(f"Layer '{layer_name}' published successfully.")
        return True
    elif "already exists" in response.text:
        print(f"Layer '{layer_name}' already exists.")
        return True
    else:
        print(f"Error publishing layer '{layer_name}': {response.text}")
        return False

def main():
    """Main function to set up Chad administrative regions."""
    
    # Create workspace
    if not create_workspace():
        return
    
    # Define the administrative region levels and their corresponding files
    admin_levels = [
        ("gadm41_TCD_0", "Country Level"),
        ("gadm41_TCD_1", "Province Level"),
        ("gadm41_TCD_2", "Department Level"),  
        ("gadm41_TCD_3", "Sub-Prefecture Level")
    ]
    
    shapefile_base_path = "/opt/geoserver_data/data/shapefiles/admin_regions"
    
    for file_name, description in admin_levels:
        shapefile_path = f"{shapefile_base_path}/{file_name}.shp"
        
        # Create datastore for this specific shapefile
        if create_shapefile_datastore(file_name, shapefile_path):
            # Publish the layer
            publish_layer(file_name, file_name)
    
    print("\nChad administrative regions setup complete!")
    print("Available layers:")
    for file_name, description in admin_levels:
        print(f"  - {WORKSPACE}:{file_name} ({description})")

if __name__ == "__main__":
    main()