varying vec2 v_vTexcoord;
varying vec4 v_vColour;

varying vec3 v_worldPosition;
varying vec3 v_worldNormal;

uniform vec3 u_LightDirection;
uniform vec3 u_ViewPosition;

uniform float u_SpecularStrength;
uniform float u_SpecularShininess;

void main() {
    vec4 starting_color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    vec3 ambient_color = vec3(0.1, 0.1, 0.1);
    vec3 light_color = vec3(0.8, 0.8, 0.8);
    vec3 light_dir = normalize(u_LightDirection);
    
    
    /*
    float specular_strength = 1.0;
    float specular_shininess = 32.0;
    */
    vec3 view_dir = normalize(u_ViewPosition - v_worldPosition);
    vec3 reflect_dir = reflect(light_dir, v_worldNormal);
    
    float specular_intensity = pow(max(0.0, dot(view_dir, reflect_dir)), u_SpecularShininess);
    vec3 specular_color = u_SpecularStrength * specular_intensity * light_color;
    
    
    
    float NdotL = max(0.0, -dot(v_worldNormal, light_dir));
    vec3 diffuse_color = NdotL * light_color;
    
    vec3 final_color = starting_color.rgb * (ambient_color + diffuse_color + specular_color);
    gl_FragColor = vec4(final_color, starting_color.a);
}