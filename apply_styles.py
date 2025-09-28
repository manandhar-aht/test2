#!/usr/bin/env python3
import requests
import os
import time

# GeoServer connection details
GEOSERVER_URL = "http://geoserver:8080/geoserver/rest"
GEOSERVER_USER = "admin"
GEOSERVER_PASS = "geoserver"
WORKSPACE = "sahel"

def upload_style(style_name, sld_file_path):
    """Upload SLD style to GeoServer."""
    print(f"Uploading style: {style_name}")
    
    # Read the SLD file
    with open(sld_file_path, 'r') as f:
        sld_content = f.read()
    
    # First create the style
    url = f"{GEOSERVER_URL}/styles"
    headers = {"Content-type": "text/xml"}
    data = f"<style><name>{style_name}</name><filename>{style_name}.sld</filename></style>"
    
    response = requests.post(url, auth=(GEOSERVER_USER, GEOSERVER_PASS), headers=headers, data=data)
    if response.status_code == 201:
        print(f"Style '{style_name}' created successfully.")
    elif "already exists" in response.text:
        print(f"Style '{style_name}' already exists. Updating...")
    else:
        print(f"Error creating style '{style_name}': {response.text}")
        return False
    
    # Upload the SLD content
    url = f"{GEOSERVER_URL}/styles/{style_name}"
    headers = {"Content-type": "application/vnd.ogc.sld+xml"}
    
    response = requests.put(url, auth=(GEOSERVER_USER, GEOSERVER_PASS), headers=headers, data=sld_content)
    if response.status_code == 200:
        print(f"SLD content uploaded for style '{style_name}'.")
        return True
    else:
        print(f"Error uploading SLD for style '{style_name}': {response.text}")
        return False

def apply_style_to_layer(workspace, layer_name, style_name):
    """Apply a style to a specific layer."""
    print(f"Applying style '{style_name}' to layer '{workspace}:{layer_name}'")
    
    url = f"{GEOSERVER_URL}/layers/{workspace}:{layer_name}"
    headers = {"Content-type": "text/xml"}
    data = f"""<layer>
        <defaultStyle>
            <name>{style_name}</name>
        </defaultStyle>
    </layer>"""
    
    response = requests.put(url, auth=(GEOSERVER_USER, GEOSERVER_PASS), headers=headers, data=data)
    if response.status_code == 200:
        print(f"Style '{style_name}' applied to layer '{workspace}:{layer_name}' successfully.")
        return True
    else:
        print(f"Error applying style to layer '{workspace}:{layer_name}': {response.text}")
        return False

def main():
    """Main function to upload styles and apply them to layers."""
    print("Setting up custom styles for water infrastructure...")
    
    # Wait a moment for GeoServer to be ready
    time.sleep(2)
    
    # Define styles and their corresponding SLD files
    styles = [
        ("wells_style", "/styles/wells_style.sld"),
        ("boreholes_style", "/styles/boreholes_style.sld"),
        ("ponds_style", "/styles/ponds_style.sld")
    ]
    
    # Upload each style
    for style_name, sld_path in styles:
        if not upload_style(style_name, sld_path):
            print(f"Failed to upload style {style_name}, skipping...")
            continue
        
        # Wait a moment between uploads
        time.sleep(1)
    
    # Apply styles to corresponding layers
    layer_style_mapping = [
        ("wells", "wells_style"),
        ("boreholes", "boreholes_style"), 
        ("ponds", "ponds_style")
    ]
    
    for layer_name, style_name in layer_style_mapping:
        apply_style_to_layer(WORKSPACE, layer_name, style_name)
        time.sleep(1)
    
    print("\n✅ Style setup complete!")
    print("\nLayer styling:")
    print("  🔵 Wells - Blue circles")
    print("  🔴 Boreholes - Red squares")
    print("  🔶 Ponds - Teal triangles")
    print("\nAll layers now have custom styling with labels!")

if __name__ == "__main__":
    main()