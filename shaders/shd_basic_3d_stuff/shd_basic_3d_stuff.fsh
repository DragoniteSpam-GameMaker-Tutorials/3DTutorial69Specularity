varying vec2 v_vTexcoord;
varying vec4 v_vColour;

varying vec3 v_worldPosition;
varying vec3 v_worldNormal;

uniform vec3 u_LightDirection;
uniform vec3 u_ViewPosition;

void main() {
    vec4 starting_color = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    vec3 ambient_color = vec3(0.1, 0.1, 0.1);
    vec3 light_color = vec3(0.8, 0.8, 0.8);
    vec3 light_dir = normalize(u_LightDirection);
    
    float NdotL = max(0.0, -dot(v_worldNormal, light_dir));
    vec3 diffuse_color = NdotL * light_color;
    
    vec3 final_color = starting_color.rgb * (ambient_color + diffuse_color);
    gl_FragColor = vec4(final_color, starting_color.a);
}