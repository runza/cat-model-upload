precision highp float;
attribute vec3 a_position;
attribute vec3 a_normal;
varying vec3 v_normal;
uniform mat3 u_normalMatrix;
uniform mat4 u_modelViewMatrix;
uniform mat4 u_projectionMatrix;
varying vec3 v_light0Direction;
varying vec3 v_position;
uniform mat4 u_light0Transform;
varying vec3 v_light1Direction;
uniform mat4 u_light1Transform;
varying vec3 v_light2Direction;
uniform mat4 u_light2Transform;
varying vec3 v_light3Direction;
uniform mat4 u_light3Transform;
varying vec3 v_light4Direction;
uniform mat4 u_light4Transform;
void main(void) {
vec4 pos = u_modelViewMatrix * vec4(a_position,1.0);
v_normal = u_normalMatrix * a_normal;
v_position = pos.xyz;
v_light0Direction = u_light0Transform[3].xyz - pos.xyz;
v_light1Direction = u_light1Transform[3].xyz - pos.xyz;
v_light2Direction = u_light2Transform[3].xyz - pos.xyz;
v_light3Direction = mat3(u_light3Transform) * vec3(0.,0.,1.);
v_light4Direction = u_light4Transform[3].xyz - pos.xyz;
gl_Position = u_projectionMatrix * pos;
}
