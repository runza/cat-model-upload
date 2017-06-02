precision highp float;
varying vec3 v_normal;
uniform vec4 u_ambient;
uniform vec4 u_diffuse;
uniform vec4 u_emission;
uniform vec4 u_specular;
uniform float u_shininess;
varying vec3 v_light0Direction;
varying vec3 v_position;
uniform float u_light0ConstantAttenuation;
uniform float u_light0LinearAttenuation;
uniform float u_light0QuadraticAttenuation;
uniform vec3 u_light0Color;
uniform mat4 u_light0InverseTransform;
uniform float u_light0FallOffExponent;
uniform float u_light0FallOffAngle;
varying vec3 v_light1Direction;
uniform float u_light1ConstantAttenuation;
uniform float u_light1LinearAttenuation;
uniform float u_light1QuadraticAttenuation;
uniform vec3 u_light1Color;
uniform mat4 u_light1InverseTransform;
uniform float u_light1FallOffExponent;
uniform float u_light1FallOffAngle;
varying vec3 v_light2Direction;
uniform float u_light2ConstantAttenuation;
uniform float u_light2LinearAttenuation;
uniform float u_light2QuadraticAttenuation;
uniform vec3 u_light2Color;
varying vec3 v_light3Direction;
uniform vec3 u_light3Color;
varying vec3 v_light4Direction;
uniform float u_light4ConstantAttenuation;
uniform float u_light4LinearAttenuation;
uniform float u_light4QuadraticAttenuation;
uniform vec3 u_light4Color;
uniform mat4 u_light4InverseTransform;
uniform float u_light4FallOffExponent;
uniform float u_light4FallOffAngle;
void main(void) {
vec3 normal = normalize(v_normal);
vec4 color = vec4(0., 0., 0., 0.);
vec4 diffuse = vec4(0., 0., 0., 1.);
vec3 diffuseLight = vec3(0., 0., 0.);
vec4 emission;
vec4 ambient;
vec4 specular;
ambient = u_ambient;
diffuse = u_diffuse;
emission = u_emission;
specular = u_specular;
vec3 specularLight = vec3(0., 0., 0.);
{
float specularIntensity = 0.;
float attenuation = 1.0;
float range = length(v_light0Direction);
attenuation = 1.0 / ( u_light0ConstantAttenuation + (u_light0LinearAttenuation * range) + (u_light0QuadraticAttenuation * range * range) ) ;
vec3 l = normalize(v_light0Direction);
vec4 spotPosition = u_light0InverseTransform * vec4(v_position, 1.);
float cosAngle = dot(vec3(0.0,0.0,-1.0), normalize(spotPosition.xyz));
if (cosAngle > cos(radians(u_light0FallOffAngle * 0.5)))
{
attenuation *= max(0.0, pow(cosAngle, u_light0FallOffExponent));
vec3 viewDir = -normalize(v_position);
float phongTerm = max(0.0, dot(reflect(-l,normal), viewDir));
specularIntensity = max(0., pow(phongTerm , u_shininess)) * attenuation;
specularLight += u_light0Color * specularIntensity;
diffuseLight += u_light0Color * max(dot(normal,l), 0.) * attenuation;
}
}
{
float specularIntensity = 0.;
float attenuation = 1.0;
float range = length(v_light1Direction);
attenuation = 1.0 / ( u_light1ConstantAttenuation + (u_light1LinearAttenuation * range) + (u_light1QuadraticAttenuation * range * range) ) ;
vec3 l = normalize(v_light1Direction);
vec4 spotPosition = u_light1InverseTransform * vec4(v_position, 1.);
float cosAngle = dot(vec3(0.0,0.0,-1.0), normalize(spotPosition.xyz));
if (cosAngle > cos(radians(u_light1FallOffAngle * 0.5)))
{
attenuation *= max(0.0, pow(cosAngle, u_light1FallOffExponent));
vec3 viewDir = -normalize(v_position);
float phongTerm = max(0.0, dot(reflect(-l,normal), viewDir));
specularIntensity = max(0., pow(phongTerm , u_shininess)) * attenuation;
specularLight += u_light1Color * specularIntensity;
diffuseLight += u_light1Color * max(dot(normal,l), 0.) * attenuation;
}
}
{
float specularIntensity = 0.;
float attenuation = 1.0;
float range = length(v_light2Direction);
attenuation = 1.0 / ( u_light2ConstantAttenuation + (u_light2LinearAttenuation * range) + (u_light2QuadraticAttenuation * range * range) ) ;
vec3 l = normalize(v_light2Direction);
vec3 viewDir = -normalize(v_position);
float phongTerm = max(0.0, dot(reflect(-l,normal), viewDir));
specularIntensity = max(0., pow(phongTerm , u_shininess)) * attenuation;
specularLight += u_light2Color * specularIntensity;
diffuseLight += u_light2Color * max(dot(normal,l), 0.) * attenuation;
}
{
float specularIntensity = 0.;
float attenuation = 1.0;
vec3 l = normalize(v_light3Direction);
vec3 viewDir = -normalize(v_position);
float phongTerm = max(0.0, dot(reflect(-l,normal), viewDir));
specularIntensity = max(0., pow(phongTerm , u_shininess)) * attenuation;
specularLight += u_light3Color * specularIntensity;
diffuseLight += u_light3Color * max(dot(normal,l), 0.) * attenuation;
}
{
float specularIntensity = 0.;
float attenuation = 1.0;
float range = length(v_light4Direction);
attenuation = 1.0 / ( u_light4ConstantAttenuation + (u_light4LinearAttenuation * range) + (u_light4QuadraticAttenuation * range * range) ) ;
vec3 l = normalize(v_light4Direction);
vec4 spotPosition = u_light4InverseTransform * vec4(v_position, 1.);
float cosAngle = dot(vec3(0.0,0.0,-1.0), normalize(spotPosition.xyz));
if (cosAngle > cos(radians(u_light4FallOffAngle * 0.5)))
{
attenuation *= max(0.0, pow(cosAngle, u_light4FallOffExponent));
vec3 viewDir = -normalize(v_position);
float phongTerm = max(0.0, dot(reflect(-l,normal), viewDir));
specularIntensity = max(0., pow(phongTerm , u_shininess)) * attenuation;
specularLight += u_light4Color * specularIntensity;
diffuseLight += u_light4Color * max(dot(normal,l), 0.) * attenuation;
}
}
specular.xyz *= specularLight;
color.xyz += specular.xyz;
diffuse.xyz *= diffuseLight;
color.xyz += diffuse.xyz;
color.xyz += emission.xyz;
color = vec4(color.rgb * diffuse.a, diffuse.a);
gl_FragColor = color;
}
