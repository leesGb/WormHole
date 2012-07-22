Shader "T4MShaders/ShaderModel2/MobileLM/T4M 3 Textures for MobileLightmap" {
Properties {
	_Splat0 ("Layer 1", 2D) = "white" {}
	_Splat1 ("Layer 2", 2D) = "white" {}
	_Splat2 ("Layer 3", 2D) = "white" {}
	_Control ("Control (RGBA)", 2D) = "white" {}
	_MainTex ("Never Used", 2D) = "white" {}
}
                
SubShader {
	Tags {
   "SplatCount" = "3"
   "RenderType" = "Opaque"
	}
	
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardBase" }
Program "vp" {
// Vertex combos: 8
//   opengl - ALU: 9 to 66
//   d3d9 - ALU: 9 to 66
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 9 [unity_Scale]
Matrix 5 [_Object2World]
Vector 10 [unity_SHAr]
Vector 11 [unity_SHAg]
Vector 12 [unity_SHAb]
Vector 13 [unity_SHBr]
Vector 14 [unity_SHBg]
Vector 15 [unity_SHBb]
Vector 16 [unity_SHC]
Vector 17 [_Control_ST]
Vector 18 [_Splat0_ST]
Vector 19 [_Splat1_ST]
Vector 20 [_Splat2_ST]
"!!ARBvp1.0
# 30 ALU
PARAM c[21] = { { 1 },
		state.matrix.mvp,
		program.local[5..20] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[9].w;
DP3 R3.w, R1, c[6];
DP3 R2.w, R1, c[7];
DP3 R0.x, R1, c[5];
MOV R0.y, R3.w;
MOV R0.z, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[12];
DP4 R2.y, R0, c[11];
DP4 R2.x, R0, c[10];
MUL R0.y, R3.w, R3.w;
DP4 R3.z, R1, c[15];
DP4 R3.y, R1, c[14];
DP4 R3.x, R1, c[13];
MAD R0.y, R0.x, R0.x, -R0;
MUL R1.xyz, R0.y, c[16];
ADD R2.xyz, R2, R3;
ADD result.texcoord[3].xyz, R2, R1;
MOV result.texcoord[2].z, R2.w;
MOV result.texcoord[2].y, R3.w;
MOV result.texcoord[2].x, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[20].xyxy, c[20];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[19], c[19].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 30 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Matrix 4 [_Object2World]
Vector 9 [unity_SHAr]
Vector 10 [unity_SHAg]
Vector 11 [unity_SHAb]
Vector 12 [unity_SHBr]
Vector 13 [unity_SHBg]
Vector 14 [unity_SHBb]
Vector 15 [unity_SHC]
Vector 16 [_Control_ST]
Vector 17 [_Splat0_ST]
Vector 18 [_Splat1_ST]
Vector 19 [_Splat2_ST]
"vs_2_0
; 30 ALU
def c20, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c8.w
dp3 r3.w, r1, c5
dp3 r2.w, r1, c6
dp3 r0.x, r1, c4
mov r0.y, r3.w
mov r0.z, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c20.x
dp4 r2.z, r0, c11
dp4 r2.y, r0, c10
dp4 r2.x, r0, c9
mul r0.y, r3.w, r3.w
dp4 r3.z, r1, c14
dp4 r3.y, r1, c13
dp4 r3.x, r1, c12
mad r0.y, r0.x, r0.x, -r0
mul r1.xyz, r0.y, c15
add r2.xyz, r2, r3
add oT3.xyz, r2, r1
mov oT2.z, r2.w
mov oT2.y, r3.w
mov oT2.x, r0
mad oT0.zw, v2.xyxy, c17.xyxy, c17
mad oT0.xy, v2, c16, c16.zwzw
mad oT1.zw, v2.xyxy, c19.xyxy, c19
mad oT1.xy, v2, c18, c18.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;


uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp mat4 _Object2World;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = gl_LightModel.ambient.xyz;
  tmpvar_4 = tmpvar_7;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Control, tmpvar_1).xyz;
  tmpvar_5 = (((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_6.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_6.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_6.z));
  lowp vec4 c_i0;
  c_i0.xyz = ((tmpvar_5 * _LightColor0.xyz) * (dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz) * 2.0));
  c_i0.w = 0.0;
  c = c_i0;
  c.xyz = (c_i0.xyz + (tmpvar_5 * xlv_TEXCOORD3));
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp mat4 _Object2World;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight;
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec3 tmpvar_8;
  mediump vec4 normal;
  normal = tmpvar_7;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAr, normal);
  x1.x = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAg, normal);
  x1.y = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAb, normal);
  x1.z = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBr, tmpvar_12);
  x2.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBg, tmpvar_12);
  x2.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBb, tmpvar_12);
  x2.z = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (unity_SHC.xyz * vC);
  x3 = tmpvar_17;
  tmpvar_8 = ((x1 + x2) + x3);
  shlight = tmpvar_8;
  tmpvar_4 = shlight;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Control, tmpvar_1).xyz;
  tmpvar_5 = (((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_6.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_6.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_6.z));
  lowp vec4 c_i0;
  c_i0.xyz = ((tmpvar_5 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_i0.w = 0.0;
  c = c_i0;
  c.xyz = (c_i0.xyz + (tmpvar_5 * xlv_TEXCOORD3));
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Matrix 4 [_Object2World]
Vector 9 [unity_SHAr]
Vector 10 [unity_SHAg]
Vector 11 [unity_SHAb]
Vector 12 [unity_SHBr]
Vector 13 [unity_SHBg]
Vector 14 [unity_SHBb]
Vector 15 [unity_SHC]
Vector 16 [_Control_ST]
Vector 17 [_Splat0_ST]
Vector 18 [_Splat1_ST]
Vector 19 [_Splat2_ST]
"agal_vs
c20 1.0 0.0 0.0 0.0
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaaiaaaappabaaaaaa mul r1.xyz, a1, c8.w
bcaaaaaaadaaaiacabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r3.w, r1.xyzz, c5
bcaaaaaaacaaaiacabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r2.w, r1.xyzz, c6
bcaaaaaaaaaaabacabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r0.x, r1.xyzz, c4
aaaaaaaaaaaaacacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.y, r3.w
aaaaaaaaaaaaaeacacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r0.z, r2.w
adaaaaaaabaaapacaaaaaakeacaaaaaaaaaaaacjacaaaaaa mul r1, r0.xyzz, r0.yzzx
aaaaaaaaaaaaaiacbeaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c20.x
bdaaaaaaacaaaeacaaaaaaoeacaaaaaaalaaaaoeabaaaaaa dp4 r2.z, r0, c11
bdaaaaaaacaaacacaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 r2.y, r0, c10
bdaaaaaaacaaabacaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 r2.x, r0, c9
adaaaaaaaaaaacacadaaaappacaaaaaaadaaaappacaaaaaa mul r0.y, r3.w, r3.w
bdaaaaaaadaaaeacabaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 r3.z, r1, c14
bdaaaaaaadaaacacabaaaaoeacaaaaaaanaaaaoeabaaaaaa dp4 r3.y, r1, c13
bdaaaaaaadaaabacabaaaaoeacaaaaaaamaaaaoeabaaaaaa dp4 r3.x, r1, c12
adaaaaaaaeaaacacaaaaaaaaacaaaaaaaaaaaaaaacaaaaaa mul r4.y, r0.x, r0.x
acaaaaaaaaaaacacaeaaaaffacaaaaaaaaaaaaffacaaaaaa sub r0.y, r4.y, r0.y
adaaaaaaabaaahacaaaaaaffacaaaaaaapaaaaoeabaaaaaa mul r1.xyz, r0.y, c15
abaaaaaaacaaahacacaaaakeacaaaaaaadaaaakeacaaaaaa add r2.xyz, r2.xyzz, r3.xyzz
abaaaaaaadaaahaeacaaaakeacaaaaaaabaaaakeacaaaaaa add v3.xyz, r2.xyzz, r1.xyzz
aaaaaaaaacaaaeaeacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v2.z, r2.w
aaaaaaaaacaaacaeadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v2.y, r3.w
aaaaaaaaacaaabaeaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v2.x, r0.x
adaaaaaaaeaaamacadaaaaeeaaaaaaaabbaaaaeeabaaaaaa mul r4.zw, a3.xyxy, c17.xyxy
abaaaaaaaaaaamaeaeaaaaopacaaaaaabbaaaaoeabaaaaaa add v0.zw, r4.wwzw, c17
adaaaaaaaeaaadacadaaaaoeaaaaaaaabaaaaaoeabaaaaaa mul r4.xy, a3, c16
abaaaaaaaaaaadaeaeaaaafeacaaaaaabaaaaaooabaaaaaa add v0.xy, r4.xyyy, c16.zwzw
adaaaaaaaeaaamacadaaaaeeaaaaaaaabdaaaaeeabaaaaaa mul r4.zw, a3.xyxy, c19.xyxy
abaaaaaaabaaamaeaeaaaaopacaaaaaabdaaaaoeabaaaaaa add v1.zw, r4.wwzw, c19
adaaaaaaaeaaadacadaaaaoeaaaaaaaabcaaaaoeabaaaaaa mul r4.xy, a3, c18
abaaaaaaabaaadaeaeaaaafeacaaaaaabcaaaaooabaaaaaa add v1.xy, r4.xyyy, c18.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [unity_LightmapST]
Vector 10 [_Control_ST]
Vector 11 [_Splat0_ST]
Vector 12 [_Splat1_ST]
Vector 13 [_Splat2_ST]
"!!ARBvp1.0
# 9 ALU
PARAM c[14] = { program.local[0],
		state.matrix.mvp,
		program.local[5..13] };
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[11].xyxy, c[11];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[12], c[12].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 9 instructions, 0 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
Vector 9 [_Control_ST]
Vector 10 [_Splat0_ST]
Vector 11 [_Splat1_ST]
Vector 12 [_Splat2_ST]
"vs_2_0
; 9 ALU
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
mad oT0.zw, v2.xyxy, c10.xyxy, c10
mad oT0.xy, v2, c9, c9.zwzw
mad oT1.zw, v2.xyxy, c12.xyxy, c12
mad oT1.xy, v2, c11, c11.zwzw
mad oT2.xy, v3, c8, c8.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;

uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Control, tmpvar_1).xyz;
  c = vec4(0.0, 0.0, 0.0, 0.0);
  c.xyz = ((((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_5.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_5.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_5.z)) * (2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz));
  c.w = 0.0;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;

uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Control, tmpvar_1).xyz;
  c = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  c.xyz = ((((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_5.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_5.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_5.z)) * ((8.0 * tmpvar_6.w) * tmpvar_6.xyz));
  c.w = 0.0;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
Vector 9 [_Control_ST]
Vector 10 [_Splat0_ST]
Vector 11 [_Splat1_ST]
Vector 12 [_Splat2_ST]
"agal_vs
[bc]
adaaaaaaaaaaamacadaaaaeeaaaaaaaaakaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c10.xyxy
abaaaaaaaaaaamaeaaaaaaopacaaaaaaakaaaaoeabaaaaaa add v0.zw, r0.wwzw, c10
adaaaaaaaaaaadacadaaaaoeaaaaaaaaajaaaaoeabaaaaaa mul r0.xy, a3, c9
abaaaaaaaaaaadaeaaaaaafeacaaaaaaajaaaaooabaaaaaa add v0.xy, r0.xyyy, c9.zwzw
adaaaaaaaaaaamacadaaaaeeaaaaaaaaamaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c12.xyxy
abaaaaaaabaaamaeaaaaaaopacaaaaaaamaaaaoeabaaaaaa add v1.zw, r0.wwzw, c12
adaaaaaaaaaaadacadaaaaoeaaaaaaaaalaaaaoeabaaaaaa mul r0.xy, a3, c11
abaaaaaaabaaadaeaaaaaafeacaaaaaaalaaaaooabaaaaaa add v1.xy, r0.xyyy, c11.zwzw
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaaiaaaaoeabaaaaaa mul r0.xy, a4, c8
abaaaaaaacaaadaeaaaaaafeacaaaaaaaiaaaaooabaaaaaa add v2.xy, r0.xyyy, c8.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaacaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [unity_LightmapST]
Vector 10 [_Control_ST]
Vector 11 [_Splat0_ST]
Vector 12 [_Splat1_ST]
Vector 13 [_Splat2_ST]
"!!ARBvp1.0
# 9 ALU
PARAM c[14] = { program.local[0],
		state.matrix.mvp,
		program.local[5..13] };
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[11].xyxy, c[11];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[10], c[10].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[12], c[12].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[9], c[9].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 9 instructions, 0 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
Vector 9 [_Control_ST]
Vector 10 [_Splat0_ST]
Vector 11 [_Splat1_ST]
Vector 12 [_Splat2_ST]
"vs_2_0
; 9 ALU
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
mad oT0.zw, v2.xyxy, c10.xyxy, c10
mad oT0.xy, v2, c9, c9.zwzw
mad oT1.zw, v2.xyxy, c12.xyxy, c12
mad oT1.xy, v2, c11, c11.zwzw
mad oT2.xy, v3, c8, c8.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;

uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Control, tmpvar_1).xyz;
  tmpvar_5 = (((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_6.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_6.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_6.z));
  c = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  mediump vec3 lm_i0;
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((8.0 * tmpvar_7.w) * tmpvar_7.xyz);
  lm_i0 = tmpvar_8;
  mediump vec3 tmpvar_9;
  tmpvar_9 = (tmpvar_5 * lm_i0);
  c.xyz = tmpvar_9;
  c.w = 0.0;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_LightmapST]
Vector 9 [_Control_ST]
Vector 10 [_Splat0_ST]
Vector 11 [_Splat1_ST]
Vector 12 [_Splat2_ST]
"agal_vs
[bc]
adaaaaaaaaaaamacadaaaaeeaaaaaaaaakaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c10.xyxy
abaaaaaaaaaaamaeaaaaaaopacaaaaaaakaaaaoeabaaaaaa add v0.zw, r0.wwzw, c10
adaaaaaaaaaaadacadaaaaoeaaaaaaaaajaaaaoeabaaaaaa mul r0.xy, a3, c9
abaaaaaaaaaaadaeaaaaaafeacaaaaaaajaaaaooabaaaaaa add v0.xy, r0.xyyy, c9.zwzw
adaaaaaaaaaaamacadaaaaeeaaaaaaaaamaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c12.xyxy
abaaaaaaabaaamaeaaaaaaopacaaaaaaamaaaaoeabaaaaaa add v1.zw, r0.wwzw, c12
adaaaaaaaaaaadacadaaaaoeaaaaaaaaalaaaaoeabaaaaaa mul r0.xy, a3, c11
abaaaaaaabaaadaeaaaaaafeacaaaaaaalaaaaooabaaaaaa add v1.xy, r0.xyyy, c11.zwzw
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaaiaaaaoeabaaaaaa mul r0.xy, a4, c8
abaaaaaaacaaadaeaaaaaafeacaaaaaaaiaaaaooabaaaaaa add v2.xy, r0.xyyy, c8.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaacaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [unity_Scale]
Matrix 5 [_Object2World]
Vector 11 [unity_SHAr]
Vector 12 [unity_SHAg]
Vector 13 [unity_SHAb]
Vector 14 [unity_SHBr]
Vector 15 [unity_SHBg]
Vector 16 [unity_SHBb]
Vector 17 [unity_SHC]
Vector 18 [_Control_ST]
Vector 19 [_Splat0_ST]
Vector 20 [_Splat1_ST]
Vector 21 [_Splat2_ST]
"!!ARBvp1.0
# 35 ALU
PARAM c[22] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R0.xyz, vertex.normal, c[10].w;
DP3 R3.w, R0, c[6];
DP3 R2.w, R0, c[7];
DP3 R1.w, R0, c[5];
MOV R1.x, R3.w;
MOV R1.y, R2.w;
MOV R1.z, c[0].x;
MUL R0, R1.wxyy, R1.xyyw;
DP4 R2.z, R1.wxyz, c[13];
DP4 R2.y, R1.wxyz, c[12];
DP4 R2.x, R1.wxyz, c[11];
DP4 R1.z, R0, c[16];
DP4 R1.y, R0, c[15];
DP4 R1.x, R0, c[14];
MUL R3.x, R3.w, R3.w;
MAD R0.x, R1.w, R1.w, -R3;
ADD R3.xyz, R2, R1;
MUL R2.xyz, R0.x, c[17];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[3].xyz, R3, R2;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MOV result.texcoord[2].z, R2.w;
MOV result.texcoord[2].y, R3.w;
MOV result.texcoord[2].x, R1.w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
END
# 35 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_Scale]
Matrix 4 [_Object2World]
Vector 11 [unity_SHAr]
Vector 12 [unity_SHAg]
Vector 13 [unity_SHAb]
Vector 14 [unity_SHBr]
Vector 15 [unity_SHBg]
Vector 16 [unity_SHBb]
Vector 17 [unity_SHC]
Vector 18 [_Control_ST]
Vector 19 [_Splat0_ST]
Vector 20 [_Splat1_ST]
Vector 21 [_Splat2_ST]
"vs_2_0
; 35 ALU
def c22, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1, c10.w
dp3 r3.w, r0, c5
dp3 r2.w, r0, c6
dp3 r1.w, r0, c4
mov r1.x, r3.w
mov r1.y, r2.w
mov r1.z, c22.x
mul r0, r1.wxyy, r1.xyyw
dp4 r2.z, r1.wxyz, c13
dp4 r2.y, r1.wxyz, c12
dp4 r2.x, r1.wxyz, c11
dp4 r1.z, r0, c16
dp4 r1.y, r0, c15
dp4 r1.x, r0, c14
mul r3.x, r3.w, r3.w
mad r0.x, r1.w, r1.w, -r3
add r3.xyz, r2, r1
mul r2.xyz, r0.x, c17
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c22.y
mul r1.y, r1, c8.x
add oT3.xyz, r3, r2
mad oT4.xy, r1.z, c9.zwzw, r1
mov oPos, r0
mov oT4.zw, r0
mov oT2.z, r2.w
mov oT2.y, r3.w
mov oT2.x, r1.w
mad oT0.zw, v2.xyxy, c19.xyxy, c19
mad oT0.xy, v2, c18, c18.zwzw
mad oT1.zw, v2.xyxy, c21.xyxy, c21
mad oT1.xy, v2, c20, c20.zwzw
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;
#define unity_LightColor0 _glesLightSource[0].diffuse
#define unity_LightColor1 _glesLightSource[1].diffuse
#define unity_LightColor2 _glesLightSource[2].diffuse
#define unity_LightColor3 _glesLightSource[3].diffuse
#define unity_LightPosition0 _glesLightSource[0].position
#define unity_LightPosition1 _glesLightSource[1].position
#define unity_LightPosition2 _glesLightSource[2].position
#define unity_LightPosition3 _glesLightSource[3].position
#define glstate_light0_spotDirection _glesLightSource[0].spotDirection
#define glstate_light1_spotDirection _glesLightSource[1].spotDirection
#define glstate_light2_spotDirection _glesLightSource[2].spotDirection
#define glstate_light3_spotDirection _glesLightSource[3].spotDirection
#define unity_LightAtten0 _glesLightSource[0].atten
#define unity_LightAtten1 _glesLightSource[1].atten
#define unity_LightAtten2 _glesLightSource[2].atten
#define unity_LightAtten3 _glesLightSource[3].atten
#define glstate_lightmodel_ambient _glesLightModel.ambient
#define gl_LightSource _glesLightSource
#define gl_LightSourceParameters _glesLightSourceParameters
struct _glesLightSourceParameters {
  vec4 diffuse;
  vec4 position;
  vec3 spotDirection;
  vec4 atten;
};
uniform _glesLightSourceParameters _glesLightSource[4];
#define gl_LightModel _glesLightModel
#define gl_LightModelParameters _glesLightModelParameters
struct _glesLightModelParameters {
  vec4 ambient;
};
uniform _glesLightModelParameters _glesLightModel;
#define gl_FrontMaterial _glesFrontMaterial
#define gl_BackMaterial _glesFrontMaterial
#define gl_MaterialParameters _glesMaterialParameters
struct _glesMaterialParameters {
  vec4 emission;
  vec4 ambient;
  vec4 diffuse;
  vec4 specular;
  float shininess;
};
uniform _glesMaterialParameters _glesFrontMaterial;

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;


uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 _Object2World;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (gl_ModelViewProjectionMatrix * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec3 tmpvar_8;
  tmpvar_8 = gl_LightModel.ambient.xyz;
  tmpvar_4 = tmpvar_8;
  highp vec4 o_i0;
  highp vec4 tmpvar_9;
  tmpvar_9 = (tmpvar_5 * 0.5);
  o_i0 = tmpvar_9;
  highp vec2 tmpvar_10;
  tmpvar_10.x = tmpvar_9.x;
  tmpvar_10.y = (tmpvar_9.y * _ProjectionParams.x);
  o_i0.xy = (tmpvar_10 + tmpvar_9.w);
  o_i0.zw = tmpvar_5.zw;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = o_i0;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Control, tmpvar_1).xyz;
  tmpvar_5 = (((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_6.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_6.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_6.z));
  lowp vec4 c_i0;
  c_i0.xyz = ((tmpvar_5 * _LightColor0.xyz) * ((dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x) * 2.0));
  c_i0.w = 0.0;
  c = c_i0;
  c.xyz = (c_i0.xyz + (tmpvar_5 * xlv_TEXCOORD3));
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 _Object2World;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight;
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (gl_ModelViewProjectionMatrix * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec3 tmpvar_9;
  mediump vec4 normal;
  normal = tmpvar_8;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAr, normal);
  x1.x = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAg, normal);
  x1.y = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (unity_SHAb, normal);
  x1.z = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBr, tmpvar_13);
  x2.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBg, tmpvar_13);
  x2.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHBb, tmpvar_13);
  x2.z = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (unity_SHC.xyz * vC);
  x3 = tmpvar_18;
  tmpvar_9 = ((x1 + x2) + x3);
  shlight = tmpvar_9;
  tmpvar_4 = shlight;
  highp vec4 o_i0;
  highp vec4 tmpvar_19;
  tmpvar_19 = (tmpvar_5 * 0.5);
  o_i0 = tmpvar_19;
  highp vec2 tmpvar_20;
  tmpvar_20.x = tmpvar_19.x;
  tmpvar_20.y = (tmpvar_19.y * _ProjectionParams.x);
  o_i0.xy = (tmpvar_20 + tmpvar_19.w);
  o_i0.zw = tmpvar_5.zw;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = o_i0;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Control, tmpvar_1).xyz;
  tmpvar_5 = (((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_6.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_6.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_6.z));
  lowp vec4 c_i0;
  c_i0.xyz = ((tmpvar_5 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x) * 2.0));
  c_i0.w = 0.0;
  c = c_i0;
  c.xyz = (c_i0.xyz + (tmpvar_5 * xlv_TEXCOORD3));
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [unity_NPOTScale]
Vector 10 [unity_Scale]
Matrix 4 [_Object2World]
Vector 11 [unity_SHAr]
Vector 12 [unity_SHAg]
Vector 13 [unity_SHAb]
Vector 14 [unity_SHBr]
Vector 15 [unity_SHBg]
Vector 16 [unity_SHBb]
Vector 17 [unity_SHC]
Vector 18 [_Control_ST]
Vector 19 [_Splat0_ST]
Vector 20 [_Splat1_ST]
Vector 21 [_Splat2_ST]
"agal_vs
c22 1.0 0.5 0.0 0.0
[bc]
adaaaaaaaaaaahacabaaaaoeaaaaaaaaakaaaappabaaaaaa mul r0.xyz, a1, c10.w
bcaaaaaaadaaaiacaaaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r3.w, r0.xyzz, c5
bcaaaaaaacaaaiacaaaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r2.w, r0.xyzz, c6
bcaaaaaaabaaaiacaaaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r1.w, r0.xyzz, c4
aaaaaaaaabaaabacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r3.w
aaaaaaaaabaaacacacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r1.y, r2.w
aaaaaaaaabaaaeacbgaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r1.z, c22.x
adaaaaaaaaaaapacabaaaafdacaaaaaaabaaaaneacaaaaaa mul r0, r1.wxyy, r1.xyyw
bdaaaaaaacaaaeacabaaaajdacaaaaaaanaaaaoeabaaaaaa dp4 r2.z, r1.wxyz, c13
bdaaaaaaacaaacacabaaaajdacaaaaaaamaaaaoeabaaaaaa dp4 r2.y, r1.wxyz, c12
bdaaaaaaacaaabacabaaaajdacaaaaaaalaaaaoeabaaaaaa dp4 r2.x, r1.wxyz, c11
bdaaaaaaabaaaeacaaaaaaoeacaaaaaabaaaaaoeabaaaaaa dp4 r1.z, r0, c16
bdaaaaaaabaaacacaaaaaaoeacaaaaaaapaaaaoeabaaaaaa dp4 r1.y, r0, c15
bdaaaaaaabaaabacaaaaaaoeacaaaaaaaoaaaaoeabaaaaaa dp4 r1.x, r0, c14
adaaaaaaadaaabacadaaaappacaaaaaaadaaaappacaaaaaa mul r3.x, r3.w, r3.w
adaaaaaaaeaaabacabaaaappacaaaaaaabaaaappacaaaaaa mul r4.x, r1.w, r1.w
acaaaaaaaaaaabacaeaaaaaaacaaaaaaadaaaaaaacaaaaaa sub r0.x, r4.x, r3.x
abaaaaaaacaaahacacaaaakeacaaaaaaabaaaakeacaaaaaa add r2.xyz, r2.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaaaaacaaaaaabbaaaaoeabaaaaaa mul r1.xyz, r0.x, c17
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r0.w, a0, c3
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.z, a0, c2
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r0.x, a0, c0
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r0.y, a0, c1
adaaaaaaadaaahacaaaaaapeacaaaaaabgaaaaffabaaaaaa mul r3.xyz, r0.xyww, c22.y
abaaaaaaadaaahaeacaaaakeacaaaaaaabaaaakeacaaaaaa add v3.xyz, r2.xyzz, r1.xyzz
adaaaaaaabaaacacadaaaaffacaaaaaaaiaaaaaaabaaaaaa mul r1.y, r3.y, c8.x
aaaaaaaaabaaabacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r3.x
abaaaaaaabaaadacabaaaafeacaaaaaaadaaaakkacaaaaaa add r1.xy, r1.xyyy, r3.z
adaaaaaaaeaaadaeabaaaafeacaaaaaaajaaaaoeabaaaaaa mul v4.xy, r1.xyyy, c9
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
aaaaaaaaaeaaamaeaaaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v4.zw, r0.wwzw
aaaaaaaaacaaaeaeacaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v2.z, r2.w
aaaaaaaaacaaacaeadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v2.y, r3.w
aaaaaaaaacaaabaeabaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v2.x, r1.w
adaaaaaaaeaaamacadaaaaeeaaaaaaaabdaaaaeeabaaaaaa mul r4.zw, a3.xyxy, c19.xyxy
abaaaaaaaaaaamaeaeaaaaopacaaaaaabdaaaaoeabaaaaaa add v0.zw, r4.wwzw, c19
adaaaaaaaeaaadacadaaaaoeaaaaaaaabcaaaaoeabaaaaaa mul r4.xy, a3, c18
abaaaaaaaaaaadaeaeaaaafeacaaaaaabcaaaaooabaaaaaa add v0.xy, r4.xyyy, c18.zwzw
adaaaaaaaeaaamacadaaaaeeaaaaaaaabfaaaaeeabaaaaaa mul r4.zw, a3.xyxy, c21.xyxy
abaaaaaaabaaamaeaeaaaaopacaaaaaabfaaaaoeabaaaaaa add v1.zw, r4.wwzw, c21
adaaaaaaaeaaadacadaaaaoeaaaaaaaabeaaaaoeabaaaaaa mul r4.xy, a3, c20
abaaaaaaabaaadaeaeaaaafeacaaaaaabeaaaaooabaaaaaa add v1.xy, r4.xyyy, c20.zwzw
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [_ProjectionParams]
Vector 10 [unity_LightmapST]
Vector 11 [_Control_ST]
Vector 12 [_Splat0_ST]
Vector 13 [_Splat1_ST]
Vector 14 [_Splat2_ST]
"!!ARBvp1.0
# 14 ALU
PARAM c[15] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[12].xyxy, c[12];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[13], c[13].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[10], c[10].zwzw;
END
# 14 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_LightmapST]
Vector 11 [_Control_ST]
Vector 12 [_Splat0_ST]
Vector 13 [_Splat1_ST]
Vector 14 [_Splat2_ST]
"vs_2_0
; 14 ALU
def c15, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c15.x
mul r1.y, r1, c8.x
mad oT3.xy, r1.z, c9.zwzw, r1
mov oPos, r0
mov oT3.zw, r0
mad oT0.zw, v2.xyxy, c12.xyxy, c12
mad oT0.xy, v2, c11, c11.zwzw
mad oT1.zw, v2.xyxy, c14.xyxy, c14
mad oT1.xy, v2, c13, c13.zwzw
mad oT2.xy, v3, c10, c10.zwzw
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;

uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_i0;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  o_i0 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_i0.xy = (tmpvar_5 + tmpvar_4.w);
  o_i0.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = o_i0;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Control, tmpvar_1).xyz;
  c = vec4(0.0, 0.0, 0.0, 0.0);
  c.xyz = ((((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_5.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_5.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_5.z)) * min ((2.0 * texture2D (unity_Lightmap, xlv_TEXCOORD2).xyz), vec3((texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3).x * 2.0))));
  c.w = 0.0;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;

uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_i0;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  o_i0 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_i0.xy = (tmpvar_5 + tmpvar_4.w);
  o_i0.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = o_i0;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Control, tmpvar_1).xyz;
  lowp vec4 tmpvar_6;
  tmpvar_6 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3);
  c = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  lowp vec3 tmpvar_8;
  tmpvar_8 = ((8.0 * tmpvar_7.w) * tmpvar_7.xyz);
  c.xyz = ((((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_5.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_5.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_5.z)) * max (min (tmpvar_8, ((tmpvar_6.x * 2.0) * tmpvar_7.xyz)), (tmpvar_8 * tmpvar_6.x)));
  c.w = 0.0;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [unity_NPOTScale]
Vector 10 [unity_LightmapST]
Vector 11 [_Control_ST]
Vector 12 [_Splat0_ST]
Vector 13 [_Splat1_ST]
Vector 14 [_Splat2_ST]
"agal_vs
c15 0.5 0.0 0.0 0.0
[bc]
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r0.w, a0, c3
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.z, a0, c2
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r0.x, a0, c0
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r0.y, a0, c1
adaaaaaaabaaahacaaaaaapeacaaaaaaapaaaaaaabaaaaaa mul r1.xyz, r0.xyww, c15.x
adaaaaaaabaaacacabaaaaffacaaaaaaaiaaaaaaabaaaaaa mul r1.y, r1.y, c8.x
abaaaaaaabaaadacabaaaafeacaaaaaaabaaaakkacaaaaaa add r1.xy, r1.xyyy, r1.z
adaaaaaaadaaadaeabaaaafeacaaaaaaajaaaaoeabaaaaaa mul v3.xy, r1.xyyy, c9
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
aaaaaaaaadaaamaeaaaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v3.zw, r0.wwzw
adaaaaaaaaaaamacadaaaaeeaaaaaaaaamaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c12.xyxy
abaaaaaaaaaaamaeaaaaaaopacaaaaaaamaaaaoeabaaaaaa add v0.zw, r0.wwzw, c12
adaaaaaaaaaaadacadaaaaoeaaaaaaaaalaaaaoeabaaaaaa mul r0.xy, a3, c11
abaaaaaaaaaaadaeaaaaaafeacaaaaaaalaaaaooabaaaaaa add v0.xy, r0.xyyy, c11.zwzw
adaaaaaaaaaaamacadaaaaeeaaaaaaaaaoaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c14.xyxy
abaaaaaaabaaamaeaaaaaaopacaaaaaaaoaaaaoeabaaaaaa add v1.zw, r0.wwzw, c14
adaaaaaaaaaaadacadaaaaoeaaaaaaaaanaaaaoeabaaaaaa mul r0.xy, a3, c13
abaaaaaaabaaadaeaaaaaafeacaaaaaaanaaaaooabaaaaaa add v1.xy, r0.xyyy, c13.zwzw
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaakaaaaoeabaaaaaa mul r0.xy, a4, c10
abaaaaaaacaaadaeaaaaaafeacaaaaaaakaaaaooabaaaaaa add v2.xy, r0.xyyy, c10.zwzw
aaaaaaaaacaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 9 [_ProjectionParams]
Vector 10 [unity_LightmapST]
Vector 11 [_Control_ST]
Vector 12 [_Splat0_ST]
Vector 13 [_Splat1_ST]
Vector 14 [_Splat2_ST]
"!!ARBvp1.0
# 14 ALU
PARAM c[15] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[9].x;
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[12].xyxy, c[12];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[13], c[13].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[10], c[10].zwzw;
END
# 14 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_LightmapST]
Vector 11 [_Control_ST]
Vector 12 [_Splat0_ST]
Vector 13 [_Splat1_ST]
Vector 14 [_Splat2_ST]
"vs_2_0
; 14 ALU
def c15, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v2
dcl_texcoord1 v3
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c15.x
mul r1.y, r1, c8.x
mad oT3.xy, r1.z, c9.zwzw, r1
mov oPos, r0
mov oT3.zw, r0
mad oT0.zw, v2.xyxy, c12.xyxy, c12
mad oT0.xy, v2, c11, c11.zwzw
mad oT1.zw, v2.xyxy, c14.xyxy, c14
mad oT1.xy, v2, c13, c13.zwzw
mad oT2.xy, v3, c10, c10.zwzw
"
}


SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;

uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_i0;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  o_i0 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_i0.xy = (tmpvar_5 + tmpvar_4.w);
  o_i0.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD3 = o_i0;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD3;
varying highp vec2 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _ShadowMapTexture;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Control, tmpvar_1).xyz;
  tmpvar_5 = (((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_6.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_6.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_6.z));
  lowp vec4 tmpvar_7;
  tmpvar_7 = texture2DProj (_ShadowMapTexture, xlv_TEXCOORD3);
  c = vec4(0.0, 0.0, 0.0, 0.0);
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2D (unity_Lightmap, xlv_TEXCOORD2);
  mediump vec3 lm_i0;
  lowp vec3 tmpvar_9;
  tmpvar_9 = ((8.0 * tmpvar_8.w) * tmpvar_8.xyz);
  lm_i0 = tmpvar_9;
  mediump vec4 tmpvar_10;
  tmpvar_10.w = 0.0;
  tmpvar_10.xyz = lm_i0;
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_5 * max (min (tmpvar_10.xyz, ((tmpvar_7.x * 2.0) * tmpvar_8.xyz)), (lm_i0 * tmpvar_7.x)));
  c.xyz = tmpvar_11;
  c.w = 0.0;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [unity_NPOTScale]
Vector 10 [unity_LightmapST]
Vector 11 [_Control_ST]
Vector 12 [_Splat0_ST]
Vector 13 [_Splat1_ST]
Vector 14 [_Splat2_ST]
"agal_vs
c15 0.5 0.0 0.0 0.0
[bc]
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r0.w, a0, c3
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.z, a0, c2
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r0.x, a0, c0
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r0.y, a0, c1
adaaaaaaabaaahacaaaaaapeacaaaaaaapaaaaaaabaaaaaa mul r1.xyz, r0.xyww, c15.x
adaaaaaaabaaacacabaaaaffacaaaaaaaiaaaaaaabaaaaaa mul r1.y, r1.y, c8.x
abaaaaaaabaaadacabaaaafeacaaaaaaabaaaakkacaaaaaa add r1.xy, r1.xyyy, r1.z
adaaaaaaadaaadaeabaaaafeacaaaaaaajaaaaoeabaaaaaa mul v3.xy, r1.xyyy, c9
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
aaaaaaaaadaaamaeaaaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v3.zw, r0.wwzw
adaaaaaaaaaaamacadaaaaeeaaaaaaaaamaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c12.xyxy
abaaaaaaaaaaamaeaaaaaaopacaaaaaaamaaaaoeabaaaaaa add v0.zw, r0.wwzw, c12
adaaaaaaaaaaadacadaaaaoeaaaaaaaaalaaaaoeabaaaaaa mul r0.xy, a3, c11
abaaaaaaaaaaadaeaaaaaafeacaaaaaaalaaaaooabaaaaaa add v0.xy, r0.xyyy, c11.zwzw
adaaaaaaaaaaamacadaaaaeeaaaaaaaaaoaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c14.xyxy
abaaaaaaabaaamaeaaaaaaopacaaaaaaaoaaaaoeabaaaaaa add v1.zw, r0.wwzw, c14
adaaaaaaaaaaadacadaaaaoeaaaaaaaaanaaaaoeabaaaaaa mul r0.xy, a3, c13
abaaaaaaabaaadaeaaaaaafeacaaaaaaanaaaaooabaaaaaa add v1.xy, r0.xyyy, c13.zwzw
adaaaaaaaaaaadacaeaaaaoeaaaaaaaaakaaaaoeabaaaaaa mul r0.xy, a4, c10
abaaaaaaacaaadaeaaaaaafeacaaaaaaakaaaaooabaaaaaa add v2.xy, r0.xyyy, c10.zwzw
aaaaaaaaacaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.zw, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 9 [unity_Scale]
Matrix 5 [_Object2World]
Vector 10 [unity_4LightPosX0]
Vector 11 [unity_4LightPosY0]
Vector 12 [unity_4LightPosZ0]
Vector 13 [unity_4LightAtten0]
Vector 14 [unity_LightColor0]
Vector 15 [unity_LightColor1]
Vector 16 [unity_LightColor2]
Vector 17 [unity_LightColor3]
Vector 18 [unity_SHAr]
Vector 19 [unity_SHAg]
Vector 20 [unity_SHAb]
Vector 21 [unity_SHBr]
Vector 22 [unity_SHBg]
Vector 23 [unity_SHBb]
Vector 24 [unity_SHC]
Vector 25 [_Control_ST]
Vector 26 [_Splat0_ST]
Vector 27 [_Splat1_ST]
Vector 28 [_Splat2_ST]
"!!ARBvp1.0
# 60 ALU
PARAM c[29] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..28] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[9].w;
DP3 R4.x, R3, c[5];
DP3 R3.w, R3, c[6];
DP3 R3.x, R3, c[7];
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[11];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[10];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MOV R4.w, c[0].x;
MAD R2, R4.x, R0, R2;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[12];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[13];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
DP4 R2.z, R4, c[20];
DP4 R2.y, R4, c[19];
DP4 R2.x, R4, c[18];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[15];
MAD R1.xyz, R0.x, c[14], R1;
MAD R0.xyz, R0.z, c[16], R1;
MAD R1.xyz, R0.w, c[17], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R4.w, R0, c[23];
DP4 R4.z, R0, c[22];
DP4 R4.y, R0, c[21];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[24];
ADD R2.xyz, R2, R4.yzww;
ADD R0.xyz, R2, R0;
ADD result.texcoord[3].xyz, R0, R1;
MOV result.texcoord[2].z, R3.x;
MOV result.texcoord[2].y, R3.w;
MOV result.texcoord[2].x, R4;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[26].xyxy, c[26];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[25], c[25].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[28].xyxy, c[28];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[27], c[27].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 60 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Matrix 4 [_Object2World]
Vector 9 [unity_4LightPosX0]
Vector 10 [unity_4LightPosY0]
Vector 11 [unity_4LightPosZ0]
Vector 12 [unity_4LightAtten0]
Vector 13 [unity_LightColor0]
Vector 14 [unity_LightColor1]
Vector 15 [unity_LightColor2]
Vector 16 [unity_LightColor3]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Vector 24 [_Control_ST]
Vector 25 [_Splat0_ST]
Vector 26 [_Splat1_ST]
Vector 27 [_Splat2_ST]
"vs_2_0
; 60 ALU
def c28, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r3.xyz, v1, c8.w
dp3 r4.x, r3, c4
dp3 r3.w, r3, c5
dp3 r3.x, r3, c6
dp4 r0.x, v0, c5
add r1, -r0.x, c10
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c9
mul r1, r1, r1
mov r4.z, r3.x
mov r4.w, c28.x
mad r2, r4.x, r0, r2
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c11
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c12
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c28.x
dp4 r2.z, r4, c19
dp4 r2.y, r4, c18
dp4 r2.x, r4, c17
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c28.y
mul r0, r0, r1
mul r1.xyz, r0.y, c14
mad r1.xyz, r0.x, c13, r1
mad r0.xyz, r0.z, c15, r1
mad r1.xyz, r0.w, c16, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r4.w, r0, c22
dp4 r4.z, r0, c21
dp4 r4.y, r0, c20
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c23
add r2.xyz, r2, r4.yzww
add r0.xyz, r2, r0
add oT3.xyz, r0, r1
mov oT2.z, r3.x
mov oT2.y, r3.w
mov oT2.x, r4
mad oT0.zw, v2.xyxy, c25.xyxy, c25
mad oT0.xy, v2, c24, c24.zwzw
mad oT1.zw, v2.xyxy, c27.xyxy, c27
mad oT1.xy, v2, c26, c26.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}


SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightAtten0;

uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp mat4 _Object2World;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight;
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_6;
  highp vec4 tmpvar_7;
  tmpvar_7.w = 1.0;
  tmpvar_7.xyz = tmpvar_6;
  mediump vec3 tmpvar_8;
  mediump vec4 normal;
  normal = tmpvar_7;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_9;
  tmpvar_9 = dot (unity_SHAr, normal);
  x1.x = tmpvar_9;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAg, normal);
  x1.y = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAb, normal);
  x1.z = tmpvar_11;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_13;
  tmpvar_13 = dot (unity_SHBr, tmpvar_12);
  x2.x = tmpvar_13;
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBg, tmpvar_12);
  x2.y = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBb, tmpvar_12);
  x2.z = tmpvar_15;
  mediump float tmpvar_16;
  tmpvar_16 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_16;
  highp vec3 tmpvar_17;
  tmpvar_17 = (unity_SHC.xyz * vC);
  x3 = tmpvar_17;
  tmpvar_8 = ((x1 + x2) + x3);
  shlight = tmpvar_8;
  tmpvar_4 = shlight;
  highp vec3 tmpvar_18;
  tmpvar_18 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_19;
  tmpvar_19 = (unity_4LightPosX0 - tmpvar_18.x);
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosY0 - tmpvar_18.y);
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosZ0 - tmpvar_18.z);
  highp vec4 tmpvar_22;
  tmpvar_22 = (((tmpvar_19 * tmpvar_19) + (tmpvar_20 * tmpvar_20)) + (tmpvar_21 * tmpvar_21));
  highp vec4 tmpvar_23;
  tmpvar_23 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_19 * tmpvar_6.x) + (tmpvar_20 * tmpvar_6.y)) + (tmpvar_21 * tmpvar_6.z)) * inversesqrt (tmpvar_22))) * (1.0/((1.0 + (tmpvar_22 * unity_4LightAtten0)))));
  highp vec3 tmpvar_24;
  tmpvar_24 = (tmpvar_4 + ((((unity_LightColor[0].xyz * tmpvar_23.x) + (unity_LightColor[1].xyz * tmpvar_23.y)) + (unity_LightColor[2].xyz * tmpvar_23.z)) + (unity_LightColor[3].xyz * tmpvar_23.w)));
  tmpvar_4 = tmpvar_24;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Control, tmpvar_1).xyz;
  tmpvar_5 = (((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_6.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_6.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_6.z));
  lowp vec4 c_i0;
  c_i0.xyz = ((tmpvar_5 * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)) * 2.0));
  c_i0.w = 0.0;
  c = c_i0;
  c.xyz = (c_i0.xyz + (tmpvar_5 * xlv_TEXCOORD3));
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Matrix 4 [_Object2World]
Vector 9 [unity_4LightPosX0]
Vector 10 [unity_4LightPosY0]
Vector 11 [unity_4LightPosZ0]
Vector 12 [unity_4LightAtten0]
Vector 13 [unity_LightColor0]
Vector 14 [unity_LightColor1]
Vector 15 [unity_LightColor2]
Vector 16 [unity_LightColor3]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Vector 24 [_Control_ST]
Vector 25 [_Splat0_ST]
Vector 26 [_Splat1_ST]
Vector 27 [_Splat2_ST]
"agal_vs
c28 1.0 0.0 0.0 0.0
[bc]
adaaaaaaadaaahacabaaaaoeaaaaaaaaaiaaaappabaaaaaa mul r3.xyz, a1, c8.w
bcaaaaaaaeaaabacadaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r4.x, r3.xyzz, c4
bcaaaaaaadaaaiacadaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r3.w, r3.xyzz, c5
bcaaaaaaadaaabacadaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r3.x, r3.xyzz, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.x, a0, c5
bfaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.x, r0.x
abaaaaaaabaaapacabaaaaaaacaaaaaaakaaaaoeabaaaaaa add r1, r1.x, c10
adaaaaaaacaaapacadaaaappacaaaaaaabaaaaoeacaaaaaa mul r2, r3.w, r1
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bfaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r0.x, r0.x
abaaaaaaaaaaapacaaaaaaaaacaaaaaaajaaaaoeabaaaaaa add r0, r0.x, c9
adaaaaaaabaaapacabaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r1, r1, r1
aaaaaaaaaeaaaeacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r4.z, r3.x
aaaaaaaaaeaaaiacbmaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r4.w, c28.x
adaaaaaaafaaapacaeaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r5, r4.x, r0
abaaaaaaacaaapacafaaaaoeacaaaaaaacaaaaoeacaaaaaa add r2, r5, r2
bdaaaaaaaeaaacacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r4.y, a0, c6
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
bfaaaaaaaaaaacacaeaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r4.y
abaaaaaaaaaaapacaaaaaaffacaaaaaaalaaaaoeabaaaaaa add r0, r0.y, c11
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
adaaaaaaaaaaapacadaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r0, r3.x, r0
abaaaaaaaaaaapacaaaaaaoeacaaaaaaacaaaaoeacaaaaaa add r0, r0, r2
adaaaaaaacaaapacabaaaaoeacaaaaaaamaaaaoeabaaaaaa mul r2, r1, c12
aaaaaaaaaeaaacacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r4.y, r3.w
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
akaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rsq r1.y, r1.y
akaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r1.w, r1.w
akaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rsq r1.z, r1.z
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
abaaaaaaabaaapacacaaaaoeacaaaaaabmaaaaaaabaaaaaa add r1, r2, c28.x
bdaaaaaaacaaaeacaeaaaaoeacaaaaaabdaaaaoeabaaaaaa dp4 r2.z, r4, c19
bdaaaaaaacaaacacaeaaaaoeacaaaaaabcaaaaoeabaaaaaa dp4 r2.y, r4, c18
bdaaaaaaacaaabacaeaaaaoeacaaaaaabbaaaaoeabaaaaaa dp4 r2.x, r4, c17
afaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, r1.x
afaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rcp r1.y, r1.y
afaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rcp r1.w, r1.w
afaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r1.z
ahaaaaaaaaaaapacaaaaaaoeacaaaaaabmaaaaffabaaaaaa max r0, r0, c28.y
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
adaaaaaaabaaahacaaaaaaffacaaaaaaaoaaaaoeabaaaaaa mul r1.xyz, r0.y, c14
adaaaaaaafaaahacaaaaaaaaacaaaaaaanaaaaoeabaaaaaa mul r5.xyz, r0.x, c13
abaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakkacaaaaaaapaaaaoeabaaaaaa mul r0.xyz, r0.z, c15
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaappacaaaaaabaaaaaoeabaaaaaa mul r1.xyz, r0.w, c16
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
adaaaaaaaaaaapacaeaaaakeacaaaaaaaeaaaacjacaaaaaa mul r0, r4.xyzz, r4.yzzx
adaaaaaaabaaaiacadaaaappacaaaaaaadaaaappacaaaaaa mul r1.w, r3.w, r3.w
bdaaaaaaaeaaaiacaaaaaaoeacaaaaaabgaaaaoeabaaaaaa dp4 r4.w, r0, c22
bdaaaaaaaeaaaeacaaaaaaoeacaaaaaabfaaaaoeabaaaaaa dp4 r4.z, r0, c21
bdaaaaaaaeaaacacaaaaaaoeacaaaaaabeaaaaoeabaaaaaa dp4 r4.y, r0, c20
adaaaaaaafaaaiacaeaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r5.w, r4.x, r4.x
acaaaaaaabaaaiacafaaaappacaaaaaaabaaaappacaaaaaa sub r1.w, r5.w, r1.w
adaaaaaaaaaaahacabaaaappacaaaaaabhaaaaoeabaaaaaa mul r0.xyz, r1.w, c23
abaaaaaaacaaahacacaaaakeacaaaaaaaeaaaapjacaaaaaa add r2.xyz, r2.xyzz, r4.yzww
abaaaaaaaaaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r2.xyzz, r0.xyzz
abaaaaaaadaaahaeaaaaaakeacaaaaaaabaaaakeacaaaaaa add v3.xyz, r0.xyzz, r1.xyzz
aaaaaaaaacaaaeaeadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v2.z, r3.x
aaaaaaaaacaaacaeadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v2.y, r3.w
aaaaaaaaacaaabaeaeaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v2.x, r4.x
adaaaaaaafaaamacadaaaaeeaaaaaaaabjaaaaeeabaaaaaa mul r5.zw, a3.xyxy, c25.xyxy
abaaaaaaaaaaamaeafaaaaopacaaaaaabjaaaaoeabaaaaaa add v0.zw, r5.wwzw, c25
adaaaaaaafaaadacadaaaaoeaaaaaaaabiaaaaoeabaaaaaa mul r5.xy, a3, c24
abaaaaaaaaaaadaeafaaaafeacaaaaaabiaaaaooabaaaaaa add v0.xy, r5.xyyy, c24.zwzw
adaaaaaaafaaamacadaaaaeeaaaaaaaablaaaaeeabaaaaaa mul r5.zw, a3.xyxy, c27.xyxy
abaaaaaaabaaamaeafaaaaopacaaaaaablaaaaoeabaaaaaa add v1.zw, r5.wwzw, c27
adaaaaaaafaaadacadaaaaoeaaaaaaaabkaaaaoeabaaaaaa mul r5.xy, a3, c26
abaaaaaaabaaadaeafaaaafeacaaaaaabkaaaaooabaaaaaa add v1.xy, r5.xyyy, c26.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [unity_Scale]
Matrix 5 [_Object2World]
Vector 11 [unity_4LightPosX0]
Vector 12 [unity_4LightPosY0]
Vector 13 [unity_4LightPosZ0]
Vector 14 [unity_4LightAtten0]
Vector 15 [unity_LightColor0]
Vector 16 [unity_LightColor1]
Vector 17 [unity_LightColor2]
Vector 18 [unity_LightColor3]
Vector 19 [unity_SHAr]
Vector 20 [unity_SHAg]
Vector 21 [unity_SHAb]
Vector 22 [unity_SHBr]
Vector 23 [unity_SHBg]
Vector 24 [unity_SHBb]
Vector 25 [unity_SHC]
Vector 26 [_Control_ST]
Vector 27 [_Splat0_ST]
Vector 28 [_Splat1_ST]
Vector 29 [_Splat2_ST]
"!!ARBvp1.0
# 66 ALU
PARAM c[30] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..29] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[10].w;
DP3 R4.x, R3, c[5];
DP3 R3.w, R3, c[6];
DP3 R3.x, R3, c[7];
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[12];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[11];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MOV R4.w, c[0].x;
MAD R2, R4.x, R0, R2;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[13];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[14];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
DP4 R2.z, R4, c[21];
DP4 R2.y, R4, c[20];
DP4 R2.x, R4, c[19];
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[16];
MAD R1.xyz, R0.x, c[15], R1;
MAD R0.xyz, R0.z, c[17], R1;
MAD R1.xyz, R0.w, c[18], R0;
MUL R0, R4.xyzz, R4.yzzx;
MUL R1.w, R3, R3;
DP4 R4.w, R0, c[24];
DP4 R4.z, R0, c[23];
DP4 R4.y, R0, c[22];
MAD R1.w, R4.x, R4.x, -R1;
MUL R0.xyz, R1.w, c[25];
ADD R2.xyz, R2, R4.yzww;
ADD R4.yzw, R2.xxyz, R0.xxyz;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R2.xyz, R0.xyww, c[0].z;
ADD result.texcoord[3].xyz, R4.yzww, R1;
MOV R1.x, R2;
MUL R1.y, R2, c[9].x;
ADD result.texcoord[4].xy, R1, R2.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MOV result.texcoord[2].z, R3.x;
MOV result.texcoord[2].y, R3.w;
MOV result.texcoord[2].x, R4;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[27].xyxy, c[27];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[26], c[26].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[29].xyxy, c[29];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[28], c[28].zwzw;
END
# 66 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_Scale]
Matrix 4 [_Object2World]
Vector 11 [unity_4LightPosX0]
Vector 12 [unity_4LightPosY0]
Vector 13 [unity_4LightPosZ0]
Vector 14 [unity_4LightAtten0]
Vector 15 [unity_LightColor0]
Vector 16 [unity_LightColor1]
Vector 17 [unity_LightColor2]
Vector 18 [unity_LightColor3]
Vector 19 [unity_SHAr]
Vector 20 [unity_SHAg]
Vector 21 [unity_SHAb]
Vector 22 [unity_SHBr]
Vector 23 [unity_SHBg]
Vector 24 [unity_SHBb]
Vector 25 [unity_SHC]
Vector 26 [_Control_ST]
Vector 27 [_Splat0_ST]
Vector 28 [_Splat1_ST]
Vector 29 [_Splat2_ST]
"vs_2_0
; 66 ALU
def c30, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r3.xyz, v1, c10.w
dp3 r4.x, r3, c4
dp3 r3.w, r3, c5
dp3 r3.x, r3, c6
dp4 r0.x, v0, c5
add r1, -r0.x, c12
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c11
mul r1, r1, r1
mov r4.z, r3.x
mov r4.w, c30.x
mad r2, r4.x, r0, r2
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c13
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c14
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c30.x
dp4 r2.z, r4, c21
dp4 r2.y, r4, c20
dp4 r2.x, r4, c19
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c30.y
mul r0, r0, r1
mul r1.xyz, r0.y, c16
mad r1.xyz, r0.x, c15, r1
mad r0.xyz, r0.z, c17, r1
mad r1.xyz, r0.w, c18, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r4.w, r0, c24
dp4 r4.z, r0, c23
dp4 r4.y, r0, c22
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c25
add r2.xyz, r2, r4.yzww
add r4.yzw, r2.xxyz, r0.xxyz
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r2.xyz, r0.xyww, c30.z
add oT3.xyz, r4.yzww, r1
mov r1.x, r2
mul r1.y, r2, c8.x
mad oT4.xy, r2.z, c9.zwzw, r1
mov oPos, r0
mov oT4.zw, r0
mov oT2.z, r3.x
mov oT2.y, r3.w
mov oT2.x, r4
mad oT0.zw, v2.xyxy, c27.xyxy, c27
mad oT0.xy, v2, c26, c26.zwzw
mad oT1.zw, v2.xyxy, c29.xyxy, c29
mad oT1.xy, v2, c28, c28.zwzw
"
}


SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;
uniform highp vec4 unity_LightColor[4];
uniform highp vec4 unity_4LightPosZ0;
uniform highp vec4 unity_4LightPosY0;
uniform highp vec4 unity_4LightPosX0;
uniform highp vec4 unity_4LightAtten0;

uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 _Object2World;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec3 shlight;
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  lowp vec3 tmpvar_4;
  highp vec4 tmpvar_5;
  tmpvar_5 = (gl_ModelViewProjectionMatrix * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  mat3 tmpvar_6;
  tmpvar_6[0] = _Object2World[0].xyz;
  tmpvar_6[1] = _Object2World[1].xyz;
  tmpvar_6[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_7;
  tmpvar_7 = (tmpvar_6 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_7;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = tmpvar_7;
  mediump vec3 tmpvar_9;
  mediump vec4 normal;
  normal = tmpvar_8;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAr, normal);
  x1.x = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAg, normal);
  x1.y = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (unity_SHAb, normal);
  x1.z = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBr, tmpvar_13);
  x2.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBg, tmpvar_13);
  x2.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHBb, tmpvar_13);
  x2.z = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (unity_SHC.xyz * vC);
  x3 = tmpvar_18;
  tmpvar_9 = ((x1 + x2) + x3);
  shlight = tmpvar_9;
  tmpvar_4 = shlight;
  highp vec3 tmpvar_19;
  tmpvar_19 = (_Object2World * _glesVertex).xyz;
  highp vec4 tmpvar_20;
  tmpvar_20 = (unity_4LightPosX0 - tmpvar_19.x);
  highp vec4 tmpvar_21;
  tmpvar_21 = (unity_4LightPosY0 - tmpvar_19.y);
  highp vec4 tmpvar_22;
  tmpvar_22 = (unity_4LightPosZ0 - tmpvar_19.z);
  highp vec4 tmpvar_23;
  tmpvar_23 = (((tmpvar_20 * tmpvar_20) + (tmpvar_21 * tmpvar_21)) + (tmpvar_22 * tmpvar_22));
  highp vec4 tmpvar_24;
  tmpvar_24 = (max (vec4(0.0, 0.0, 0.0, 0.0), ((((tmpvar_20 * tmpvar_7.x) + (tmpvar_21 * tmpvar_7.y)) + (tmpvar_22 * tmpvar_7.z)) * inversesqrt (tmpvar_23))) * (1.0/((1.0 + (tmpvar_23 * unity_4LightAtten0)))));
  highp vec3 tmpvar_25;
  tmpvar_25 = (tmpvar_4 + ((((unity_LightColor[0].xyz * tmpvar_24.x) + (unity_LightColor[1].xyz * tmpvar_24.y)) + (unity_LightColor[2].xyz * tmpvar_24.z)) + (unity_LightColor[3].xyz * tmpvar_24.w)));
  tmpvar_4 = tmpvar_25;
  highp vec4 o_i0;
  highp vec4 tmpvar_26;
  tmpvar_26 = (tmpvar_5 * 0.5);
  o_i0 = tmpvar_26;
  highp vec2 tmpvar_27;
  tmpvar_27.x = tmpvar_26.x;
  tmpvar_27.y = (tmpvar_26.y * _ProjectionParams.x);
  o_i0.xy = (tmpvar_27 + tmpvar_26.w);
  o_i0.zw = tmpvar_5.zw;
  gl_Position = tmpvar_5;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = o_i0;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying lowp vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform lowp vec4 _WorldSpaceLightPos0;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _ShadowMapTexture;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  lowp vec3 tmpvar_6;
  tmpvar_6 = texture2D (_Control, tmpvar_1).xyz;
  tmpvar_5 = (((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_6.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_6.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_6.z));
  lowp vec4 c_i0;
  c_i0.xyz = ((tmpvar_5 * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, _WorldSpaceLightPos0.xyz)) * texture2DProj (_ShadowMapTexture, xlv_TEXCOORD4).x) * 2.0));
  c_i0.w = 0.0;
  c = c_i0;
  c.xyz = (c_i0.xyz + (tmpvar_5 * xlv_TEXCOORD3));
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [unity_NPOTScale]
Vector 10 [unity_Scale]
Matrix 4 [_Object2World]
Vector 11 [unity_4LightPosX0]
Vector 12 [unity_4LightPosY0]
Vector 13 [unity_4LightPosZ0]
Vector 14 [unity_4LightAtten0]
Vector 15 [unity_LightColor0]
Vector 16 [unity_LightColor1]
Vector 17 [unity_LightColor2]
Vector 18 [unity_LightColor3]
Vector 19 [unity_SHAr]
Vector 20 [unity_SHAg]
Vector 21 [unity_SHAb]
Vector 22 [unity_SHBr]
Vector 23 [unity_SHBg]
Vector 24 [unity_SHBb]
Vector 25 [unity_SHC]
Vector 26 [_Control_ST]
Vector 27 [_Splat0_ST]
Vector 28 [_Splat1_ST]
Vector 29 [_Splat2_ST]
"agal_vs
c30 1.0 0.0 0.5 0.0
[bc]
adaaaaaaadaaahacabaaaaoeaaaaaaaaakaaaappabaaaaaa mul r3.xyz, a1, c10.w
bcaaaaaaaeaaabacadaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 r4.x, r3.xyzz, c4
bcaaaaaaadaaaiacadaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 r3.w, r3.xyzz, c5
bcaaaaaaadaaabacadaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 r3.x, r3.xyzz, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.x, a0, c5
bfaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r1.x, r0.x
abaaaaaaabaaapacabaaaaaaacaaaaaaamaaaaoeabaaaaaa add r1, r1.x, c12
adaaaaaaacaaapacadaaaappacaaaaaaabaaaaoeacaaaaaa mul r2, r3.w, r1
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bfaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa neg r0.x, r0.x
abaaaaaaaaaaapacaaaaaaaaacaaaaaaalaaaaoeabaaaaaa add r0, r0.x, c11
adaaaaaaabaaapacabaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r1, r1, r1
aaaaaaaaaeaaaeacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r4.z, r3.x
aaaaaaaaaeaaaiacboaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r4.w, c30.x
adaaaaaaafaaapacaeaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r5, r4.x, r0
abaaaaaaacaaapacafaaaaoeacaaaaaaacaaaaoeacaaaaaa add r2, r5, r2
bdaaaaaaaeaaacacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r4.y, a0, c6
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
bfaaaaaaaaaaacacaeaaaaffacaaaaaaaaaaaaaaaaaaaaaa neg r0.y, r4.y
abaaaaaaaaaaapacaaaaaaffacaaaaaaanaaaaoeabaaaaaa add r0, r0.y, c13
adaaaaaaafaaapacaaaaaaoeacaaaaaaaaaaaaoeacaaaaaa mul r5, r0, r0
abaaaaaaabaaapacafaaaaoeacaaaaaaabaaaaoeacaaaaaa add r1, r5, r1
adaaaaaaaaaaapacadaaaaaaacaaaaaaaaaaaaoeacaaaaaa mul r0, r3.x, r0
abaaaaaaaaaaapacaaaaaaoeacaaaaaaacaaaaoeacaaaaaa add r0, r0, r2
adaaaaaaacaaapacabaaaaoeacaaaaaaaoaaaaoeabaaaaaa mul r2, r1, c14
aaaaaaaaaeaaacacadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov r4.y, r3.w
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
akaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rsq r1.y, r1.y
akaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rsq r1.w, r1.w
akaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rsq r1.z, r1.z
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
abaaaaaaabaaapacacaaaaoeacaaaaaaboaaaaaaabaaaaaa add r1, r2, c30.x
bdaaaaaaacaaaeacaeaaaaoeacaaaaaabfaaaaoeabaaaaaa dp4 r2.z, r4, c21
bdaaaaaaacaaacacaeaaaaoeacaaaaaabeaaaaoeabaaaaaa dp4 r2.y, r4, c20
bdaaaaaaacaaabacaeaaaaoeacaaaaaabdaaaaoeabaaaaaa dp4 r2.x, r4, c19
afaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, r1.x
afaaaaaaabaaacacabaaaaffacaaaaaaaaaaaaaaaaaaaaaa rcp r1.y, r1.y
afaaaaaaabaaaiacabaaaappacaaaaaaaaaaaaaaaaaaaaaa rcp r1.w, r1.w
afaaaaaaabaaaeacabaaaakkacaaaaaaaaaaaaaaaaaaaaaa rcp r1.z, r1.z
ahaaaaaaaaaaapacaaaaaaoeacaaaaaaboaaaaffabaaaaaa max r0, r0, c30.y
adaaaaaaaaaaapacaaaaaaoeacaaaaaaabaaaaoeacaaaaaa mul r0, r0, r1
adaaaaaaabaaahacaaaaaaffacaaaaaabaaaaaoeabaaaaaa mul r1.xyz, r0.y, c16
adaaaaaaafaaahacaaaaaaaaacaaaaaaapaaaaoeabaaaaaa mul r5.xyz, r0.x, c15
abaaaaaaabaaahacafaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r5.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakkacaaaaaabbaaaaoeabaaaaaa mul r0.xyz, r0.z, c17
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacaaaaaappacaaaaaabcaaaaoeabaaaaaa mul r1.xyz, r0.w, c18
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
adaaaaaaaaaaapacaeaaaakeacaaaaaaaeaaaacjacaaaaaa mul r0, r4.xyzz, r4.yzzx
adaaaaaaabaaaiacadaaaappacaaaaaaadaaaappacaaaaaa mul r1.w, r3.w, r3.w
bdaaaaaaaeaaaiacaaaaaaoeacaaaaaabiaaaaoeabaaaaaa dp4 r4.w, r0, c24
bdaaaaaaaeaaaeacaaaaaaoeacaaaaaabhaaaaoeabaaaaaa dp4 r4.z, r0, c23
bdaaaaaaaeaaacacaaaaaaoeacaaaaaabgaaaaoeabaaaaaa dp4 r4.y, r0, c22
adaaaaaaafaaaiacaeaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r5.w, r4.x, r4.x
acaaaaaaabaaaiacafaaaappacaaaaaaabaaaappacaaaaaa sub r1.w, r5.w, r1.w
adaaaaaaaaaaahacabaaaappacaaaaaabjaaaaoeabaaaaaa mul r0.xyz, r1.w, c25
abaaaaaaacaaahacacaaaakeacaaaaaaaeaaaapjacaaaaaa add r2.xyz, r2.xyzz, r4.yzww
abaaaaaaacaaahacacaaaakeacaaaaaaaaaaaakeacaaaaaa add r2.xyz, r2.xyzz, r0.xyzz
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 r0.w, a0, c3
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 r0.z, a0, c2
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 r0.x, a0, c0
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 r0.y, a0, c1
adaaaaaaaeaaaoacaaaaaandacaaaaaaboaaaakkabaaaaaa mul r4.yzw, r0.wxyw, c30.z
abaaaaaaadaaahaeacaaaakeacaaaaaaabaaaakeacaaaaaa add v3.xyz, r2.xyzz, r1.xyzz
adaaaaaaabaaacacaeaaaakkacaaaaaaaiaaaaaaabaaaaaa mul r1.y, r4.z, c8.x
aaaaaaaaabaaabacaeaaaaffacaaaaaaaaaaaaaaaaaaaaaa mov r1.x, r4.y
abaaaaaaabaaadacabaaaafeacaaaaaaaeaaaappacaaaaaa add r1.xy, r1.xyyy, r4.w
adaaaaaaaeaaadaeabaaaafeacaaaaaaajaaaaoeabaaaaaa mul v4.xy, r1.xyyy, c9
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
aaaaaaaaaeaaamaeaaaaaaopacaaaaaaaaaaaaaaaaaaaaaa mov v4.zw, r0.wwzw
aaaaaaaaacaaaeaeadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v2.z, r3.x
aaaaaaaaacaaacaeadaaaappacaaaaaaaaaaaaaaaaaaaaaa mov v2.y, r3.w
aaaaaaaaacaaabaeaeaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov v2.x, r4.x
adaaaaaaafaaamacadaaaaeeaaaaaaaablaaaaeeabaaaaaa mul r5.zw, a3.xyxy, c27.xyxy
abaaaaaaaaaaamaeafaaaaopacaaaaaablaaaaoeabaaaaaa add v0.zw, r5.wwzw, c27
adaaaaaaafaaadacadaaaaoeaaaaaaaabkaaaaoeabaaaaaa mul r5.xy, a3, c26
abaaaaaaaaaaadaeafaaaafeacaaaaaabkaaaaooabaaaaaa add v0.xy, r5.xyyy, c26.zwzw
adaaaaaaafaaamacadaaaaeeaaaaaaaabnaaaaeeabaaaaaa mul r5.zw, a3.xyxy, c29.xyxy
abaaaaaaabaaamaeafaaaaopacaaaaaabnaaaaoeabaaaaaa add v1.zw, r5.wwzw, c29
adaaaaaaafaaadacadaaaaoeaaaaaaaabmaaaaoeabaaaaaa mul r5.xy, a3, c28
abaaaaaaabaaadaeafaaaafeacaaaaaabmaaaaooabaaaaaa add v1.xy, r5.xyyy, c28.zwzw
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

}
Program "fp" {
// Fragment combos: 6
//   opengl - ALU: 12 to 18, TEX: 4 to 6
//   d3d9 - ALU: 12 to 18, TEX: 4 to 6
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 14 ALU, 4 TEX
PARAM c[3] = { program.local[0..1],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R0.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R2.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R3.xyz, R1.y, R3;
MAD R2.xyz, R1.x, R2, R3;
MAD R1.xyz, R0, R1.z, R2;
MUL R0.xyz, R1, fragment.texcoord[3];
DP3 R0.w, fragment.texcoord[2], c[0];
MUL R1.xyz, R1, c[1];
MAX R0.w, R0, c[2].x;
MUL R1.xyz, R0.w, R1;
MAD result.color.xyz, R1, c[2].y, R0;
MOV result.color.w, c[2].x;
END
# 14 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
"ps_2_0
; 16 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c2, 0.00000000, 2.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xyz
dcl t3.xyz
texld r2, t0, s0
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.xy, r0
mov r0.y, t0.w
mov r0.x, t0.z
texld r3, r1, s3
texld r1, r0, s1
texld r0, t1, s2
mul_pp r0.xyz, r2.y, r0
mad_pp r0.xyz, r2.x, r1, r0
mad_pp r1.xyz, r3, r2.z, r0
mul_pp r2.xyz, r1, c1
dp3_pp r0.x, t2, c0
max_pp r0.x, r0, c2
mul_pp r0.xyz, r0.x, r2
mul_pp r1.xyz, r1, t3
mov_pp r0.w, c2.x
mad_pp r0.xyz, r0, c2.y, r1
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
"agal_ps
c2 0.0 2.0 0.0 0.0
[bc]
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r2, v0, s0 <2d wrap linear point>
aaaaaaaaaaaaacacabaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v1.w
aaaaaaaaaaaaabacabaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v1.z
aaaaaaaaabaaadacaaaaaafeacaaaaaaaaaaaaaaaaaaaaaa mov r1.xy, r0.xyyy
aaaaaaaaaaaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v0.w
aaaaaaaaaaaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v0.z
ciaaaaaaadaaapacabaaaafeacaaaaaaadaaaaaaafaababb tex r3, r1.xyyy, s3 <2d wrap linear point>
ciaaaaaaabaaapacaaaaaafeacaaaaaaabaaaaaaafaababb tex r1, r0.xyyy, s1 <2d wrap linear point>
ciaaaaaaaaaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r0, v1, s2 <2d wrap linear point>
adaaaaaaaaaaahacacaaaaffacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r2.y, r0.xyzz
adaaaaaaaeaaahacacaaaaaaacaaaaaaabaaaakeacaaaaaa mul r4.xyz, r2.x, r1.xyzz
abaaaaaaaaaaahacaeaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r4.xyzz, r0.xyzz
adaaaaaaabaaahacadaaaakeacaaaaaaacaaaakkacaaaaaa mul r1.xyz, r3.xyzz, r2.z
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaabaaaaoeabaaaaaa mul r2.xyz, r1.xyzz, c1
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaaaaaaaoeabaaaaaa dp3 r0.x, v2, c0
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa max r0.x, r0.x, c2
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r0.xyz, r0.x, r2.xyzz
adaaaaaaabaaahacabaaaakeacaaaaaaadaaaaoeaeaaaaaa mul r1.xyz, r1.xyzz, v3
aaaaaaaaaaaaaiacacaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c2.x
adaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c2.y
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 5 TEX
PARAM c[1] = { { 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[2], texture[4], 2D;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R4.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R3.xyz, R2.y, R3;
MAD R1.xyz, R2.x, R1, R3;
MAD R1.xyz, R4, R2.z, R1;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[0].y;
MOV result.color.w, c[0].x;
END
# 12 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [unity_Lightmap] 2D
"ps_2_0
; 12 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c0, 8.00000000, 0.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xy
texld r3, t0, s0
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.y, t0.w
mov r1.x, t0.z
texld r4, r0, s3
texld r2, r1, s1
texld r0, t2, s4
texld r1, t1, s2
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r3.y, r1
mad_pp r1.xyz, r3.x, r2, r1
mad_pp r1.xyz, r4, r3.z, r1
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c0.x
mov_pp r0.w, c0.y
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_OFF" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [unity_Lightmap] 2D
"agal_ps
c0 8.0 0.0 0.0 0.0
[bc]
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
aaaaaaaaaaaaacacabaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v1.w
aaaaaaaaaaaaabacabaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v1.z
aaaaaaaaabaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r1.y, v0.w
aaaaaaaaabaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r1.x, v0.z
ciaaaaaaaeaaapacaaaaaafeacaaaaaaadaaaaaaafaababb tex r4, r0.xyyy, s3 <2d wrap linear point>
ciaaaaaaacaaapacabaaaafeacaaaaaaabaaaaaaafaababb tex r2, r1.xyyy, s1 <2d wrap linear point>
ciaaaaaaaaaaapacacaaaaoeaeaaaaaaaeaaaaaaafaababb tex r0, v2, s4 <2d wrap linear point>
ciaaaaaaabaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r1, v1, s2 <2d wrap linear point>
adaaaaaaaaaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r0.w, r0.xyzz
adaaaaaaabaaahacadaaaaffacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r3.y, r1.xyzz
adaaaaaaacaaahacadaaaaaaacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r3.x, r2.xyzz
abaaaaaaabaaahacacaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r2.xyzz, r1.xyzz
adaaaaaaacaaahacaeaaaakeacaaaaaaadaaaakkacaaaaaa mul r2.xyz, r4.xyzz, r3.z
abaaaaaaabaaahacacaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r2.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaabaaaaaa mul r0.xyz, r0.xyzz, c0.x
aaaaaaaaaaaaaiacaaaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c0.y
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 12 ALU, 5 TEX
PARAM c[1] = { { 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0, fragment.texcoord[2], texture[4], 2D;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R4.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R3.xyz, R2.y, R3;
MAD R1.xyz, R2.x, R1, R3;
MAD R1.xyz, R4, R2.z, R1;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, R1;
MUL result.color.xyz, R0, c[0].y;
MOV result.color.w, c[0].x;
END
# 12 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [unity_Lightmap] 2D
"ps_2_0
; 12 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c0, 8.00000000, 0.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xy
texld r3, t0, s0
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.y, t0.w
mov r1.x, t0.z
texld r4, r0, s3
texld r2, r1, s1
texld r0, t2, s4
texld r1, t1, s2
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r3.y, r1
mad_pp r1.xyz, r3.x, r2, r1
mad_pp r1.xyz, r4, r3.z, r1
mul_pp r0.xyz, r0, r1
mul_pp r0.xyz, r0, c0.x
mov_pp r0.w, c0.y
mov_pp oC0, r0
"
}


SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_OFF" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [unity_Lightmap] 2D
"agal_ps
c0 8.0 0.0 0.0 0.0
[bc]
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
aaaaaaaaaaaaacacabaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v1.w
aaaaaaaaaaaaabacabaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v1.z
aaaaaaaaabaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r1.y, v0.w
aaaaaaaaabaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r1.x, v0.z
ciaaaaaaaeaaapacaaaaaafeacaaaaaaadaaaaaaafaababb tex r4, r0.xyyy, s3 <2d wrap linear point>
ciaaaaaaacaaapacabaaaafeacaaaaaaabaaaaaaafaababb tex r2, r1.xyyy, s1 <2d wrap linear point>
ciaaaaaaaaaaapacacaaaaoeaeaaaaaaaeaaaaaaafaababb tex r0, v2, s4 <2d wrap linear point>
ciaaaaaaabaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r1, v1, s2 <2d wrap linear point>
adaaaaaaaaaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r0.w, r0.xyzz
adaaaaaaabaaahacadaaaaffacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r3.y, r1.xyzz
adaaaaaaacaaahacadaaaaaaacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r3.x, r2.xyzz
abaaaaaaabaaahacacaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r2.xyzz, r1.xyzz
adaaaaaaacaaahacaeaaaakeacaaaaaaadaaaakkacaaaaaa mul r2.xyz, r4.xyzz, r3.z
abaaaaaaabaaahacacaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r2.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaabaaaaaa mul r0.xyz, r0.xyzz, c0.x
aaaaaaaaaaaaaiacaaaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c0.y
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 5 TEX
PARAM c[3] = { program.local[0..1],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R0.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R2.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TXP R4.x, fragment.texcoord[4], texture[4], 2D;
MUL R3.xyz, R1.y, R3;
MAD R2.xyz, R1.x, R2, R3;
MAD R0.xyz, R0, R1.z, R2;
MUL R1.xyz, R0, fragment.texcoord[3];
DP3 R0.w, fragment.texcoord[2], c[0];
MAX R0.w, R0, c[2].x;
MUL R0.xyz, R0, c[1];
MUL R0.w, R0, R4.x;
MUL R0.xyz, R0.w, R0;
MAD result.color.xyz, R0, c[2].y, R1;
MOV result.color.w, c[2].x;
END
# 16 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_2_0
; 16 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c2, 0.00000000, 2.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xyz
dcl t3.xyz
dcl t4
texldp r4, t4, s4
texld r2, t0, s0
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.y, t1.w
mov r1.x, t1.z
texld r3, r1, s3
texld r1, r0, s1
texld r0, t1, s2
mul_pp r0.xyz, r2.y, r0
mad_pp r0.xyz, r2.x, r1, r0
mad_pp r1.xyz, r3, r2.z, r0
mul_pp r2.xyz, r1, c1
dp3_pp r0.x, t2, c0
max_pp r0.x, r0, c2
mul_pp r0.x, r0, r4
mul_pp r0.xyz, r0.x, r2
mul_pp r1.xyz, r1, t3
mov_pp r0.w, c2.x
mad_pp r0.xyz, r0, c2.y, r1
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
Vector 0 [_WorldSpaceLightPos0]
Vector 1 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"agal_ps
c2 0.0 2.0 0.0 0.0
[bc]
aeaaaaaaaaaaapacaeaaaaoeaeaaaaaaaeaaaappaeaaaaaa div r0, v4, v4.w
ciaaaaaaaeaaapacaaaaaafeacaaaaaaaeaaaaaaafaababb tex r4, r0.xyyy, s4 <2d wrap linear point>
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r2, v0, s0 <2d wrap linear point>
aaaaaaaaaaaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v0.w
aaaaaaaaaaaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v0.z
aaaaaaaaabaaacacabaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r1.y, v1.w
aaaaaaaaabaaabacabaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r1.x, v1.z
ciaaaaaaadaaapacabaaaafeacaaaaaaadaaaaaaafaababb tex r3, r1.xyyy, s3 <2d wrap linear point>
ciaaaaaaabaaapacaaaaaafeacaaaaaaabaaaaaaafaababb tex r1, r0.xyyy, s1 <2d wrap linear point>
ciaaaaaaaaaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r0, v1, s2 <2d wrap linear point>
adaaaaaaaaaaahacacaaaaffacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r2.y, r0.xyzz
adaaaaaaaeaaaoacacaaaaaaacaaaaaaabaaaakeacaaaaaa mul r4.yzw, r2.x, r1.xyzz
abaaaaaaaaaaahacaeaaaapjacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r4.yzww, r0.xyzz
adaaaaaaabaaahacadaaaakeacaaaaaaacaaaakkacaaaaaa mul r1.xyz, r3.xyzz, r2.z
abaaaaaaabaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa add r1.xyz, r1.xyzz, r0.xyzz
adaaaaaaacaaahacabaaaakeacaaaaaaabaaaaoeabaaaaaa mul r2.xyz, r1.xyzz, c1
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaaaaaaaoeabaaaaaa dp3 r0.x, v2, c0
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaaoeabaaaaaa max r0.x, r0.x, c2
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaaaaacaaaaaa mul r0.x, r0.x, r4.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r0.xyz, r0.x, r2.xyzz
adaaaaaaabaaahacabaaaakeacaaaaaaadaaaaoeaeaaaaaa mul r1.xyz, r1.xyzz, v3
aaaaaaaaaaaaaiacacaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c2.x
adaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c2.y
abaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa add r0.xyz, r0.xyzz, r1.xyzz
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_ShadowMapTexture] 2D
SetTexture 5 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 18 ALU, 6 TEX
PARAM c[1] = { { 0, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R0, fragment.texcoord[2], texture[5], 2D;
TXP R5.x, fragment.texcoord[3], texture[4], 2D;
TEX R4.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R3.xyz, R2.y, R3;
MAD R1.xyz, R2.x, R1, R3;
MUL R3.xyz, R0.w, R0;
MUL R3.xyz, R3, c[0].y;
MUL R0.xyz, R0, R5.x;
MUL R0.xyz, R0, c[0].z;
MUL R2.xyw, R3.xyzz, R5.x;
MIN R0.xyz, R3, R0;
MAX R0.xyz, R0, R2.xyww;
MAD R1.xyz, R4, R2.z, R1;
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[0].x;
END
# 18 instructions, 6 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_ShadowMapTexture] 2D
SetTexture 5 [unity_Lightmap] 2D
"ps_2_0
; 18 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c0, 8.00000000, 2.00000000, 0.00000000, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3
texld r5, t0, s0
texld r3, t1, s2
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.xy, r0
mov r0.y, t0.w
mov r0.x, t0.z
texld r2, r1, s3
texld r4, r0, s1
texldp r1, t3, s4
texld r0, t2, s5
mul_pp r6.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1.x
mul_pp r6.xyz, r6, c0.x
mul_pp r0.xyz, r0, c0.y
mul_pp r1.xyz, r6, r1.x
min_pp r0.xyz, r6, r0
max_pp r0.xyz, r0, r1
mul_pp r1.xyz, r5.y, r3
mad_pp r1.xyz, r5.x, r4, r1
mad_pp r1.xyz, r2, r5.z, r1
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c0.z
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "SHADOWS_SCREEN" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_ShadowMapTexture] 2D
SetTexture 5 [unity_Lightmap] 2D
"agal_ps
c0 8.0 2.0 0.0 0.0
[bc]
ciaaaaaaafaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r5, v0, s0 <2d wrap linear point>
ciaaaaaaadaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r3, v1, s2 <2d wrap linear point>
aaaaaaaaaaaaacacabaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v1.w
aaaaaaaaaaaaabacabaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v1.z
aaaaaaaaabaaadacaaaaaafeacaaaaaaaaaaaaaaaaaaaaaa mov r1.xy, r0.xyyy
aaaaaaaaaaaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v0.w
aaaaaaaaaaaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v0.z
ciaaaaaaacaaapacabaaaafeacaaaaaaadaaaaaaafaababb tex r2, r1.xyyy, s3 <2d wrap linear point>
ciaaaaaaaeaaapacaaaaaafeacaaaaaaabaaaaaaafaababb tex r4, r0.xyyy, s1 <2d wrap linear point>
aeaaaaaaagaaapacadaaaaoeaeaaaaaaadaaaappaeaaaaaa div r6, v3, v3.w
ciaaaaaaabaaapacagaaaafeacaaaaaaaeaaaaaaafaababb tex r1, r6.xyyy, s4 <2d wrap linear point>
ciaaaaaaaaaaapacacaaaaoeaeaaaaaaafaaaaaaafaababb tex r0, v2, s5 <2d wrap linear point>
adaaaaaaagaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r6.xyz, r0.w, r0.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaaaacaaaaaa mul r0.xyz, r0.xyzz, r1.x
adaaaaaaagaaahacagaaaakeacaaaaaaaaaaaaaaabaaaaaa mul r6.xyz, r6.xyzz, c0.x
adaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c0.y
adaaaaaaabaaahacagaaaakeacaaaaaaabaaaaaaacaaaaaa mul r1.xyz, r6.xyzz, r1.x
agaaaaaaaaaaahacagaaaakeacaaaaaaaaaaaakeacaaaaaa min r0.xyz, r6.xyzz, r0.xyzz
ahaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa max r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacafaaaaffacaaaaaaadaaaakeacaaaaaa mul r1.xyz, r5.y, r3.xyzz
adaaaaaaadaaahacafaaaaaaacaaaaaaaeaaaakeacaaaaaa mul r3.xyz, r5.x, r4.xyzz
abaaaaaaabaaahacadaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r3.xyzz, r1.xyzz
adaaaaaaacaaahacacaaaakeacaaaaaaafaaaakkacaaaaaa mul r2.xyz, r2.xyzz, r5.z
abaaaaaaabaaahacacaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r2.xyzz, r1.xyzz
adaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r1.xyzz, r0.xyzz
aaaaaaaaaaaaaiacaaaaaakkabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c0.z
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_ShadowMapTexture] 2D
SetTexture 5 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 18 ALU, 6 TEX
PARAM c[1] = { { 0, 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R0, fragment.texcoord[2], texture[5], 2D;
TXP R5.x, fragment.texcoord[3], texture[4], 2D;
TEX R4.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R3.xyz, R2.y, R3;
MAD R1.xyz, R2.x, R1, R3;
MUL R3.xyz, R0.w, R0;
MUL R3.xyz, R3, c[0].y;
MUL R0.xyz, R0, R5.x;
MUL R0.xyz, R0, c[0].z;
MUL R2.xyw, R3.xyzz, R5.x;
MIN R0.xyz, R3, R0;
MAX R0.xyz, R0, R2.xyww;
MAD R1.xyz, R4, R2.z, R1;
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[0].x;
END
# 18 instructions, 6 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_ShadowMapTexture] 2D
SetTexture 5 [unity_Lightmap] 2D
"ps_2_0
; 18 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c0, 8.00000000, 2.00000000, 0.00000000, 0
dcl t0
dcl t1
dcl t2.xy
dcl t3
texld r5, t0, s0
texld r3, t1, s2
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.xy, r0
mov r0.y, t0.w
mov r0.x, t0.z
texld r2, r1, s3
texld r4, r0, s1
texldp r1, t3, s4
texld r0, t2, s5
mul_pp r6.xyz, r0.w, r0
mul_pp r0.xyz, r0, r1.x
mul_pp r6.xyz, r6, c0.x
mul_pp r0.xyz, r0, c0.y
mul_pp r1.xyz, r6, r1.x
min_pp r0.xyz, r6, r0
max_pp r0.xyz, r0, r1
mul_pp r1.xyz, r5.y, r3
mad_pp r1.xyz, r5.x, r4, r1
mad_pp r1.xyz, r2, r5.z, r1
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c0.z
mov_pp oC0, r0
"
}

SubProgram "gles " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "SHADOWS_SCREEN" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_ShadowMapTexture] 2D
SetTexture 5 [unity_Lightmap] 2D
"agal_ps
c0 8.0 2.0 0.0 0.0
[bc]
ciaaaaaaafaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r5, v0, s0 <2d wrap linear point>
ciaaaaaaadaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r3, v1, s2 <2d wrap linear point>
aaaaaaaaaaaaacacabaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v1.w
aaaaaaaaaaaaabacabaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v1.z
aaaaaaaaabaaadacaaaaaafeacaaaaaaaaaaaaaaaaaaaaaa mov r1.xy, r0.xyyy
aaaaaaaaaaaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v0.w
aaaaaaaaaaaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v0.z
ciaaaaaaacaaapacabaaaafeacaaaaaaadaaaaaaafaababb tex r2, r1.xyyy, s3 <2d wrap linear point>
ciaaaaaaaeaaapacaaaaaafeacaaaaaaabaaaaaaafaababb tex r4, r0.xyyy, s1 <2d wrap linear point>
aeaaaaaaagaaapacadaaaaoeaeaaaaaaadaaaappaeaaaaaa div r6, v3, v3.w
ciaaaaaaabaaapacagaaaafeacaaaaaaaeaaaaaaafaababb tex r1, r6.xyyy, s4 <2d wrap linear point>
ciaaaaaaaaaaapacacaaaaoeaeaaaaaaafaaaaaaafaababb tex r0, v2, s5 <2d wrap linear point>
adaaaaaaagaaahacaaaaaappacaaaaaaaaaaaakeacaaaaaa mul r6.xyz, r0.w, r0.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaaaacaaaaaa mul r0.xyz, r0.xyzz, r1.x
adaaaaaaagaaahacagaaaakeacaaaaaaaaaaaaaaabaaaaaa mul r6.xyz, r6.xyzz, c0.x
adaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c0.y
adaaaaaaabaaahacagaaaakeacaaaaaaabaaaaaaacaaaaaa mul r1.xyz, r6.xyzz, r1.x
agaaaaaaaaaaahacagaaaakeacaaaaaaaaaaaakeacaaaaaa min r0.xyz, r6.xyzz, r0.xyzz
ahaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaakeacaaaaaa max r0.xyz, r0.xyzz, r1.xyzz
adaaaaaaabaaahacafaaaaffacaaaaaaadaaaakeacaaaaaa mul r1.xyz, r5.y, r3.xyzz
adaaaaaaadaaahacafaaaaaaacaaaaaaaeaaaakeacaaaaaa mul r3.xyz, r5.x, r4.xyzz
abaaaaaaabaaahacadaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r3.xyzz, r1.xyzz
adaaaaaaacaaahacacaaaakeacaaaaaaafaaaakkacaaaaaa mul r2.xyz, r2.xyzz, r5.z
abaaaaaaabaaahacacaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r2.xyzz, r1.xyzz
adaaaaaaaaaaahacabaaaakeacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r1.xyzz, r0.xyzz
aaaaaaaaaaaaaiacaaaaaakkabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c0.z
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

}
	}
	Pass {
		Name "FORWARD"
		Tags { "LightMode" = "ForwardAdd" }
		ZWrite Off Blend One One Fog { Color (0,0,0,0) }
Program "vp" {
// Vertex combos: 5
//   opengl - ALU: 13 to 21
//   d3d9 - ALU: 13 to 21
SubProgram "opengl " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 15 [_Control_ST]
Vector 16 [_Splat0_ST]
Vector 17 [_Splat1_ST]
Vector 18 [_Splat2_ST]
"!!ARBvp1.0
# 20 ALU
PARAM c[19] = { program.local[0],
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[13].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
ADD result.texcoord[3].xyz, -R0, c[14];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[17], c[17].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 20 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 14 [_Control_ST]
Vector 15 [_Splat0_ST]
Vector 16 [_Splat1_ST]
Vector 17 [_Splat2_ST]
"vs_2_0
; 20 ALU
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c12.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT4.z, r0, c10
dp4 oT4.y, r0, c9
dp4 oT4.x, r0, c8
dp3 oT2.z, r1, c6
dp3 oT2.y, r1, c5
dp3 oT2.x, r1, c4
add oT3.xyz, -r0, c13
mad oT0.zw, v2.xyxy, c15.xyxy, c15
mad oT0.xy, v2, c14, c14.zwzw
mad oT1.zw, v2.xyxy, c17.xyxy, c17
mad oT1.xy, v2, c16, c16.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}


SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_4 = tmpvar_7;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Control, tmpvar_1).xyz;
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize (xlv_TEXCOORD3);
  lightDir = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = vec2(dot (xlv_TEXCOORD4, xlv_TEXCOORD4));
  lowp vec4 c_i0;
  c_i0.xyz = (((((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_5.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_5.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_5.z)) * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, lightDir)) * texture2D (_LightTexture0, tmpvar_7).w) * 2.0));
  c_i0.w = 0.0;
  c = c_i0;
  c.w = 0.0;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "POINT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 14 [_Control_ST]
Vector 15 [_Splat0_ST]
Vector 16 [_Splat1_ST]
Vector 17 [_Splat2_ST]
"agal_vs
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaamaaaappabaaaaaa mul r1.xyz, a1, c12.w
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaeaaaeaeaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v4.z, r0, c10
bdaaaaaaaeaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v4.y, r0, c9
bdaaaaaaaeaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v4.x, r0, c8
bcaaaaaaacaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v2.z, r1.xyzz, c6
bcaaaaaaacaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v2.y, r1.xyzz, c5
bcaaaaaaacaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v2.x, r1.xyzz, c4
bfaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r0.xyzz
abaaaaaaadaaahaeaaaaaakeacaaaaaaanaaaaoeabaaaaaa add v3.xyz, r0.xyzz, c13
adaaaaaaaaaaamacadaaaaeeaaaaaaaaapaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c15.xyxy
abaaaaaaaaaaamaeaaaaaaopacaaaaaaapaaaaoeabaaaaaa add v0.zw, r0.wwzw, c15
adaaaaaaaaaaadacadaaaaoeaaaaaaaaaoaaaaoeabaaaaaa mul r0.xy, a3, c14
abaaaaaaaaaaadaeaaaaaafeacaaaaaaaoaaaaooabaaaaaa add v0.xy, r0.xyyy, c14.zwzw
adaaaaaaaaaaamacadaaaaeeaaaaaaaabbaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c17.xyxy
abaaaaaaabaaamaeaaaaaaopacaaaaaabbaaaaoeabaaaaaa add v1.zw, r0.wwzw, c17
adaaaaaaaaaaadacadaaaaoeaaaaaaaabaaaaaoeabaaaaaa mul r0.xy, a3, c16
abaaaaaaabaaadaeaaaaaafeacaaaaaabaaaaaooabaaaaaa add v1.xy, r0.xyyy, c16.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 9 [unity_Scale]
Vector 10 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Vector 11 [_Control_ST]
Vector 12 [_Splat0_ST]
Vector 13 [_Splat1_ST]
Vector 14 [_Splat2_ST]
"!!ARBvp1.0
# 13 ALU
PARAM c[15] = { program.local[0],
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
MUL R0.xyz, vertex.normal, c[9].w;
DP3 result.texcoord[2].z, R0, c[7];
DP3 result.texcoord[2].y, R0, c[6];
DP3 result.texcoord[2].x, R0, c[5];
MOV result.texcoord[3].xyz, c[10];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[12].xyxy, c[12];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[11], c[11].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[13], c[13].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 13 instructions, 1 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 10 [_Control_ST]
Vector 11 [_Splat0_ST]
Vector 12 [_Splat1_ST]
Vector 13 [_Splat2_ST]
"vs_2_0
; 13 ALU
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r0.xyz, v1, c8.w
dp3 oT2.z, r0, c6
dp3 oT2.y, r0, c5
dp3 oT2.x, r0, c4
mov oT3.xyz, c9
mad oT0.zw, v2.xyxy, c11.xyxy, c11
mad oT0.xy, v2, c10, c10.zwzw
mad oT1.zw, v2.xyxy, c13.xyxy, c13
mad oT1.xy, v2, c12, c12.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp mat4 _Object2World;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  tmpvar_4 = tmpvar_7;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
}



#endif
#ifdef FRAGMENT

varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Control, tmpvar_1).xyz;
  lightDir = xlv_TEXCOORD3;
  lowp vec4 c_i0;
  c_i0.xyz = (((((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_5.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_5.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_5.z)) * _LightColor0.xyz) * (max (0.0, dot (xlv_TEXCOORD2, lightDir)) * 2.0));
  c_i0.w = 0.0;
  c = c_i0;
  c.w = 0.0;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Vector 10 [_Control_ST]
Vector 11 [_Splat0_ST]
Vector 12 [_Splat1_ST]
Vector 13 [_Splat2_ST]
"agal_vs
[bc]
adaaaaaaaaaaahacabaaaaoeaaaaaaaaaiaaaappabaaaaaa mul r0.xyz, a1, c8.w
bcaaaaaaacaaaeaeaaaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v2.z, r0.xyzz, c6
bcaaaaaaacaaacaeaaaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v2.y, r0.xyzz, c5
bcaaaaaaacaaabaeaaaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v2.x, r0.xyzz, c4
aaaaaaaaadaaahaeajaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.xyz, c9
adaaaaaaaaaaamacadaaaaeeaaaaaaaaalaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c11.xyxy
abaaaaaaaaaaamaeaaaaaaopacaaaaaaalaaaaoeabaaaaaa add v0.zw, r0.wwzw, c11
adaaaaaaaaaaadacadaaaaoeaaaaaaaaakaaaaoeabaaaaaa mul r0.xy, a3, c10
abaaaaaaaaaaadaeaaaaaafeacaaaaaaakaaaaooabaaaaaa add v0.xy, r0.xyyy, c10.zwzw
adaaaaaaaaaaamacadaaaaeeaaaaaaaaanaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c13.xyxy
abaaaaaaabaaamaeaaaaaaopacaaaaaaanaaaaoeabaaaaaa add v1.zw, r0.wwzw, c13
adaaaaaaaaaaadacadaaaaoeaaaaaaaaamaaaaoeabaaaaaa mul r0.xy, a3, c12
abaaaaaaabaaadaeaaaaaafeacaaaaaaamaaaaooabaaaaaa add v1.xy, r0.xyyy, c12.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 15 [_Control_ST]
Vector 16 [_Splat0_ST]
Vector 17 [_Splat1_ST]
Vector 18 [_Splat2_ST]
"!!ARBvp1.0
# 21 ALU
PARAM c[19] = { program.local[0],
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[13].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[4].w, R0, c[12];
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
ADD result.texcoord[3].xyz, -R0, c[14];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[17], c[17].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 21 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 14 [_Control_ST]
Vector 15 [_Splat0_ST]
Vector 16 [_Splat1_ST]
Vector 17 [_Splat2_ST]
"vs_2_0
; 21 ALU
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c12.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT4.w, r0, c11
dp4 oT4.z, r0, c10
dp4 oT4.y, r0, c9
dp4 oT4.x, r0, c8
dp3 oT2.z, r1, c6
dp3 oT2.y, r1, c5
dp3 oT2.x, r1, c4
add oT3.xyz, -r0, c13
mad oT0.zw, v2.xyxy, c15.xyxy, c15
mad oT0.xy, v2, c14, c14.zwzw
mad oT1.zw, v2.xyxy, c17.xyxy, c17
mad oT1.xy, v2, c16, c16.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_4 = tmpvar_7;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex));
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _LightTextureB0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Control, tmpvar_1).xyz;
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize (xlv_TEXCOORD3);
  lightDir = tmpvar_6;
  highp vec3 LightCoord_i0;
  LightCoord_i0 = xlv_TEXCOORD4.xyz;
  highp vec2 tmpvar_7;
  tmpvar_7 = vec2(dot (LightCoord_i0, LightCoord_i0));
  lowp float atten;
  atten = ((float((xlv_TEXCOORD4.z > 0.0)) * texture2D (_LightTexture0, ((xlv_TEXCOORD4.xy / xlv_TEXCOORD4.w) + 0.5)).w) * texture2D (_LightTextureB0, tmpvar_7).w);
  lowp vec4 c_i0;
  c_i0.xyz = (((((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_5.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_5.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_5.z)) * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, lightDir)) * atten) * 2.0));
  c_i0.w = 0.0;
  c = c_i0;
  c.w = 0.0;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "SPOT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 14 [_Control_ST]
Vector 15 [_Splat0_ST]
Vector 16 [_Splat1_ST]
Vector 17 [_Splat2_ST]
"agal_vs
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaamaaaappabaaaaaa mul r1.xyz, a1, c12.w
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaeaaaiaeaaaaaaoeacaaaaaaalaaaaoeabaaaaaa dp4 v4.w, r0, c11
bdaaaaaaaeaaaeaeaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v4.z, r0, c10
bdaaaaaaaeaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v4.y, r0, c9
bdaaaaaaaeaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v4.x, r0, c8
bcaaaaaaacaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v2.z, r1.xyzz, c6
bcaaaaaaacaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v2.y, r1.xyzz, c5
bcaaaaaaacaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v2.x, r1.xyzz, c4
bfaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r0.xyzz
abaaaaaaadaaahaeaaaaaakeacaaaaaaanaaaaoeabaaaaaa add v3.xyz, r0.xyzz, c13
adaaaaaaaaaaamacadaaaaeeaaaaaaaaapaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c15.xyxy
abaaaaaaaaaaamaeaaaaaaopacaaaaaaapaaaaoeabaaaaaa add v0.zw, r0.wwzw, c15
adaaaaaaaaaaadacadaaaaoeaaaaaaaaaoaaaaoeabaaaaaa mul r0.xy, a3, c14
abaaaaaaaaaaadaeaaaaaafeacaaaaaaaoaaaaooabaaaaaa add v0.xy, r0.xyyy, c14.zwzw
adaaaaaaaaaaamacadaaaaeeaaaaaaaabbaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c17.xyxy
abaaaaaaabaaamaeaaaaaaopacaaaaaabbaaaaoeabaaaaaa add v1.zw, r0.wwzw, c17
adaaaaaaaaaaadacadaaaaoeaaaaaaaabaaaaaoeabaaaaaa mul r0.xy, a3, c16
abaaaaaaabaaadaeaaaaaafeacaaaaaabaaaaaooabaaaaaa add v1.xy, r0.xyyy, c16.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 15 [_Control_ST]
Vector 16 [_Splat0_ST]
Vector 17 [_Splat1_ST]
Vector 18 [_Splat2_ST]
"!!ARBvp1.0
# 20 ALU
PARAM c[19] = { program.local[0],
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[13].w;
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP4 result.texcoord[4].z, R0, c[11];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
ADD result.texcoord[3].xyz, -R0, c[14];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[17], c[17].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 20 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 14 [_Control_ST]
Vector 15 [_Splat0_ST]
Vector 16 [_Splat1_ST]
Vector 17 [_Splat2_ST]
"vs_2_0
; 20 ALU
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c12.w
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp4 oT4.z, r0, c10
dp4 oT4.y, r0, c9
dp4 oT4.x, r0, c8
dp3 oT2.z, r1, c6
dp3 oT2.y, r1, c5
dp3 oT2.x, r1, c4
add oT3.xyz, -r0, c13
mad oT0.zw, v2.xyxy, c15.xyxy, c15
mad oT0.xy, v2, c14, c14.zwzw
mad oT1.zw, v2.xyxy, c17.xyxy, c17
mad oT1.xy, v2, c16, c16.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}



SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = (_WorldSpaceLightPos0.xyz - (_Object2World * _glesVertex).xyz);
  tmpvar_4 = tmpvar_7;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xyz;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _LightTextureB0;
uniform samplerCube _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Control, tmpvar_1).xyz;
  mediump vec3 tmpvar_6;
  tmpvar_6 = normalize (xlv_TEXCOORD3);
  lightDir = tmpvar_6;
  highp vec2 tmpvar_7;
  tmpvar_7 = vec2(dot (xlv_TEXCOORD4, xlv_TEXCOORD4));
  lowp vec4 c_i0;
  c_i0.xyz = (((((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_5.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_5.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_5.z)) * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, lightDir)) * (texture2D (_LightTextureB0, tmpvar_7).w * textureCube (_LightTexture0, xlv_TEXCOORD4).w)) * 2.0));
  c_i0.w = 0.0;
  c = c_i0;
  c.w = 0.0;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 14 [_Control_ST]
Vector 15 [_Splat0_ST]
Vector 16 [_Splat1_ST]
Vector 17 [_Splat2_ST]
"agal_vs
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaamaaaappabaaaaaa mul r1.xyz, a1, c12.w
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaeaaaeaeaaaaaaoeacaaaaaaakaaaaoeabaaaaaa dp4 v4.z, r0, c10
bdaaaaaaaeaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v4.y, r0, c9
bdaaaaaaaeaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v4.x, r0, c8
bcaaaaaaacaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v2.z, r1.xyzz, c6
bcaaaaaaacaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v2.y, r1.xyzz, c5
bcaaaaaaacaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v2.x, r1.xyzz, c4
bfaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaaaaaaaaaaa neg r0.xyz, r0.xyzz
abaaaaaaadaaahaeaaaaaakeacaaaaaaanaaaaoeabaaaaaa add v3.xyz, r0.xyzz, c13
adaaaaaaaaaaamacadaaaaeeaaaaaaaaapaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c15.xyxy
abaaaaaaaaaaamaeaaaaaaopacaaaaaaapaaaaoeabaaaaaa add v0.zw, r0.wwzw, c15
adaaaaaaaaaaadacadaaaaoeaaaaaaaaaoaaaaoeabaaaaaa mul r0.xy, a3, c14
abaaaaaaaaaaadaeaaaaaafeacaaaaaaaoaaaaooabaaaaaa add v0.xy, r0.xyyy, c14.zwzw
adaaaaaaaaaaamacadaaaaeeaaaaaaaabbaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c17.xyxy
abaaaaaaabaaamaeaaaaaaopacaaaaaabbaaaaoeabaaaaaa add v1.zw, r0.wwzw, c17
adaaaaaaaaaaadacadaaaaoeaaaaaaaabaaaaaoeabaaaaaa mul r0.xy, a3, c16
abaaaaaaabaaadaeaaaaaafeacaaaaaabaaaaaooabaaaaaa add v1.xy, r0.xyyy, c16.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.w, c0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceLightPos0]
Matrix 5 [_Object2World]
Matrix 9 [_LightMatrix0]
Vector 15 [_Control_ST]
Vector 16 [_Splat0_ST]
Vector 17 [_Splat1_ST]
Vector 18 [_Splat2_ST]
"!!ARBvp1.0
# 19 ALU
PARAM c[19] = { program.local[0],
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
MUL R1.xyz, vertex.normal, c[13].w;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 result.texcoord[4].y, R0, c[10];
DP4 result.texcoord[4].x, R0, c[9];
DP3 result.texcoord[2].z, R1, c[7];
DP3 result.texcoord[2].y, R1, c[6];
DP3 result.texcoord[2].x, R1, c[5];
MOV result.texcoord[3].xyz, c[14];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[16].xyxy, c[16];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[15], c[15].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[17], c[17].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 19 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 14 [_Control_ST]
Vector 15 [_Splat0_ST]
Vector 16 [_Splat1_ST]
Vector 17 [_Splat2_ST]
"vs_2_0
; 19 ALU
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c12.w
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 oT4.y, r0, c9
dp4 oT4.x, r0, c8
dp3 oT2.z, r1, c6
dp3 oT2.y, r1, c5
dp3 oT2.x, r1, c4
mov oT3.xyz, c13
mad oT0.zw, v2.xyxy, c15.xyxy, c15
mad oT0.xy, v2, c14, c14.zwzw
mad oT1.zw, v2.xyxy, c17.xyxy, c17
mad oT1.xy, v2, c16, c16.zwzw
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}


SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform lowp vec4 _WorldSpaceLightPos0;
uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp mat4 _Object2World;
uniform highp mat4 _LightMatrix0;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  lowp vec3 tmpvar_3;
  mediump vec3 tmpvar_4;
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  mat3 tmpvar_5;
  tmpvar_5[0] = _Object2World[0].xyz;
  tmpvar_5[1] = _Object2World[1].xyz;
  tmpvar_5[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_6;
  tmpvar_6 = (tmpvar_5 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_3 = tmpvar_6;
  highp vec3 tmpvar_7;
  tmpvar_7 = _WorldSpaceLightPos0.xyz;
  tmpvar_4 = tmpvar_7;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = tmpvar_3;
  xlv_TEXCOORD3 = tmpvar_4;
  xlv_TEXCOORD4 = (_LightMatrix0 * (_Object2World * _glesVertex)).xy;
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD4;
varying mediump vec3 xlv_TEXCOORD3;
varying lowp vec3 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _LightTexture0;
uniform lowp vec4 _LightColor0;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 c;
  lowp vec3 lightDir;
  highp vec2 tmpvar_1;
  tmpvar_1 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_5;
  tmpvar_5 = texture2D (_Control, tmpvar_1).xyz;
  lightDir = xlv_TEXCOORD3;
  lowp vec4 c_i0;
  c_i0.xyz = (((((texture2D (_Splat0, tmpvar_2).xyz * tmpvar_5.x) + (texture2D (_Splat1, tmpvar_3).xyz * tmpvar_5.y)) + (texture2D (_Splat2, tmpvar_4).xyz * tmpvar_5.z)) * _LightColor0.xyz) * ((max (0.0, dot (xlv_TEXCOORD2, lightDir)) * texture2D (_LightTexture0, xlv_TEXCOORD4).w) * 2.0));
  c_i0.w = 0.0;
  c = c_i0;
  c.w = 0.0;
  gl_FragData[0] = c;
}



#endif"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceLightPos0]
Matrix 4 [_Object2World]
Matrix 8 [_LightMatrix0]
Vector 14 [_Control_ST]
Vector 15 [_Splat0_ST]
Vector 16 [_Splat1_ST]
Vector 17 [_Splat2_ST]
"agal_vs
[bc]
adaaaaaaabaaahacabaaaaoeaaaaaaaaamaaaappabaaaaaa mul r1.xyz, a1, c12.w
bdaaaaaaaaaaaiacaaaaaaoeaaaaaaaaahaaaaoeabaaaaaa dp4 r0.w, a0, c7
bdaaaaaaaaaaaeacaaaaaaoeaaaaaaaaagaaaaoeabaaaaaa dp4 r0.z, a0, c6
bdaaaaaaaaaaabacaaaaaaoeaaaaaaaaaeaaaaoeabaaaaaa dp4 r0.x, a0, c4
bdaaaaaaaaaaacacaaaaaaoeaaaaaaaaafaaaaoeabaaaaaa dp4 r0.y, a0, c5
bdaaaaaaaeaaacaeaaaaaaoeacaaaaaaajaaaaoeabaaaaaa dp4 v4.y, r0, c9
bdaaaaaaaeaaabaeaaaaaaoeacaaaaaaaiaaaaoeabaaaaaa dp4 v4.x, r0, c8
bcaaaaaaacaaaeaeabaaaakeacaaaaaaagaaaaoeabaaaaaa dp3 v2.z, r1.xyzz, c6
bcaaaaaaacaaacaeabaaaakeacaaaaaaafaaaaoeabaaaaaa dp3 v2.y, r1.xyzz, c5
bcaaaaaaacaaabaeabaaaakeacaaaaaaaeaaaaoeabaaaaaa dp3 v2.x, r1.xyzz, c4
aaaaaaaaadaaahaeanaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.xyz, c13
adaaaaaaaaaaamacadaaaaeeaaaaaaaaapaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c15.xyxy
abaaaaaaaaaaamaeaaaaaaopacaaaaaaapaaaaoeabaaaaaa add v0.zw, r0.wwzw, c15
adaaaaaaaaaaadacadaaaaoeaaaaaaaaaoaaaaoeabaaaaaa mul r0.xy, a3, c14
abaaaaaaaaaaadaeaaaaaafeacaaaaaaaoaaaaooabaaaaaa add v0.xy, r0.xyyy, c14.zwzw
adaaaaaaaaaaamacadaaaaeeaaaaaaaabbaaaaeeabaaaaaa mul r0.zw, a3.xyxy, c17.xyxy
abaaaaaaabaaamaeaaaaaaopacaaaaaabbaaaaoeabaaaaaa add v1.zw, r0.wwzw, c17
adaaaaaaaaaaadacadaaaaoeaaaaaaaabaaaaaoeabaaaaaa mul r0.xy, a3, c16
abaaaaaaabaaadaeaaaaaafeacaaaaaabaaaaaooabaaaaaa add v1.xy, r0.xyyy, c16.zwzw
bdaaaaaaaaaaaiadaaaaaaoeaaaaaaaaadaaaaoeabaaaaaa dp4 o0.w, a0, c3
bdaaaaaaaaaaaeadaaaaaaoeaaaaaaaaacaaaaoeabaaaaaa dp4 o0.z, a0, c2
bdaaaaaaaaaaacadaaaaaaoeaaaaaaaaabaaaaoeabaaaaaa dp4 o0.y, a0, c1
bdaaaaaaaaaaabadaaaaaaoeaaaaaaaaaaaaaaoeabaaaaaa dp4 o0.x, a0, c0
aaaaaaaaacaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v2.w, c0
aaaaaaaaadaaaiaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v3.w, c0
aaaaaaaaaeaaamaeaaaaaaoeabaaaaaaaaaaaaaaaaaaaaaa mov v4.zw, c0
"
}

}
Program "fp" {
// Fragment combos: 5
//   opengl - ALU: 14 to 25, TEX: 4 to 6
//   d3d9 - ALU: 15 to 26, TEX: 4 to 6
SubProgram "opengl " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 19 ALU, 5 TEX
PARAM c[2] = { program.local[0],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R3.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R0.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R2.xyz, R1.y, R2;
MAD R0.xyz, R1.x, R0, R2;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
DP3 R1.w, fragment.texcoord[3], fragment.texcoord[3];
RSQ R1.y, R1.w;
MUL R2.xyz, R1.y, fragment.texcoord[3];
MAD R0.xyz, R3, R1.z, R0;
DP3 R1.x, fragment.texcoord[2], R2;
MUL R0.xyz, R0, c[0];
MAX R1.x, R1, c[1];
MOV result.color.w, c[1].x;
TEX R0.w, R0.w, texture[4], 2D;
MUL R0.w, R1.x, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[1].y;
END
# 19 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightTexture0] 2D
"ps_2_0
; 20 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c1, 0.00000000, 2.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
texld r3, t0, s0
dp3 r0.x, t4, t4
mov r2.xy, r0.x
mov r1.y, t0.w
mov r1.x, t0.z
mov r0.y, t1.w
mov r0.x, t1.z
texld r4, r2, s4
texld r2, r1, s1
texld r0, r0, s3
texld r1, t1, s2
mul_pp r1.xyz, r3.y, r1
mad_pp r2.xyz, r3.x, r2, r1
dp3_pp r1.x, t3, t3
rsq_pp r1.x, r1.x
mad_pp r0.xyz, r0, r3.z, r2
mul_pp r1.xyz, r1.x, t3
dp3_pp r1.x, t2, r1
mul_pp r0.xyz, r0, c0
max_pp r1.x, r1, c1
mul_pp r1.x, r1, r4
mul_pp r0.xyz, r1.x, r0
mul_pp r0.xyz, r0, c1.y
mov_pp r0.w, c1.x
mov_pp oC0, r0
"
}


SubProgram "glesdesktop " {
Keywords { "POINT" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "POINT" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightTexture0] 2D
"agal_ps
c1 0.0 2.0 0.0 0.0
[bc]
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
bcaaaaaaaaaaabacaeaaaaoeaeaaaaaaaeaaaaoeaeaaaaaa dp3 r0.x, v4, v4
aaaaaaaaacaaadacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r2.xy, r0.x
aaaaaaaaabaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r1.y, v0.w
aaaaaaaaabaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r1.x, v0.z
aaaaaaaaaaaaacacabaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v1.w
aaaaaaaaaaaaabacabaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v1.z
ciaaaaaaaeaaapacacaaaafeacaaaaaaaeaaaaaaafaababb tex r4, r2.xyyy, s4 <2d wrap linear point>
ciaaaaaaacaaapacabaaaafeacaaaaaaabaaaaaaafaababb tex r2, r1.xyyy, s1 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaafeacaaaaaaadaaaaaaafaababb tex r0, r0.xyyy, s3 <2d wrap linear point>
ciaaaaaaabaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r1, v1, s2 <2d wrap linear point>
adaaaaaaabaaahacadaaaaffacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r3.y, r1.xyzz
adaaaaaaacaaahacadaaaaaaacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r3.x, r2.xyzz
abaaaaaaacaaahacacaaaakeacaaaaaaabaaaakeacaaaaaa add r2.xyz, r2.xyzz, r1.xyzz
bcaaaaaaabaaabacadaaaaoeaeaaaaaaadaaaaoeaeaaaaaa dp3 r1.x, v3, v3
akaaaaaaabaaabacabaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r1.x
adaaaaaaaaaaahacaaaaaakeacaaaaaaadaaaakkacaaaaaa mul r0.xyz, r0.xyzz, r3.z
abaaaaaaaaaaahacaaaaaakeacaaaaaaacaaaakeacaaaaaa add r0.xyz, r0.xyzz, r2.xyzz
adaaaaaaabaaahacabaaaaaaacaaaaaaadaaaaoeaeaaaaaa mul r1.xyz, r1.x, v3
bcaaaaaaabaaabacacaaaaoeaeaaaaaaabaaaakeacaaaaaa dp3 r1.x, v2, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r0.xyz, r0.xyzz, c0
ahaaaaaaabaaabacabaaaaaaacaaaaaaabaaaaoeabaaaaaa max r1.x, r1.x, c1
adaaaaaaabaaabacabaaaaaaacaaaaaaaeaaaappacaaaaaa mul r1.x, r1.x, r4.w
adaaaaaaaaaaahacabaaaaaaacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r1.x, r0.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c1.y
aaaaaaaaaaaaaiacabaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c1.x
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 14 ALU, 4 TEX
PARAM c[2] = { program.local[0],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R3.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R0.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R2.xyz, R1.y, R2;
MAD R0.xyz, R1.x, R0, R2;
MOV R2.xyz, fragment.texcoord[3];
MAD R0.xyz, R3, R1.z, R0;
DP3 R0.w, fragment.texcoord[2], R2;
MUL R0.xyz, R0, c[0];
MAX R0.w, R0, c[1].x;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[1].y;
MOV result.color.w, c[1].x;
END
# 14 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
"ps_2_0
; 15 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c1, 0.00000000, 2.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xyz
dcl t3.xyz
texld r3, t0, s0
mov r1.y, t0.w
mov r1.x, t0.z
mov r0.y, t1.w
mov r0.x, t1.z
texld r2, r1, s1
texld r0, r0, s3
texld r1, t1, s2
mul_pp r1.xyz, r3.y, r1
mad_pp r2.xyz, r3.x, r2, r1
mad_pp r2.xyz, r0, r3.z, r2
mov_pp r1.xyz, t3
dp3_pp r0.x, t2, r1
mul_pp r1.xyz, r2, c0
max_pp r0.x, r0, c1
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c1.y
mov_pp r0.w, c1.x
mov_pp oC0, r0
"
}


SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
"agal_ps
c1 0.0 2.0 0.0 0.0
[bc]
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
aaaaaaaaabaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r1.y, v0.w
aaaaaaaaabaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r1.x, v0.z
aaaaaaaaaaaaacacabaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v1.w
aaaaaaaaaaaaabacabaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v1.z
ciaaaaaaacaaapacabaaaafeacaaaaaaabaaaaaaafaababb tex r2, r1.xyyy, s1 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaafeacaaaaaaadaaaaaaafaababb tex r0, r0.xyyy, s3 <2d wrap linear point>
ciaaaaaaabaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r1, v1, s2 <2d wrap linear point>
adaaaaaaabaaahacadaaaaffacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r3.y, r1.xyzz
adaaaaaaacaaahacadaaaaaaacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r3.x, r2.xyzz
abaaaaaaacaaahacacaaaakeacaaaaaaabaaaakeacaaaaaa add r2.xyz, r2.xyzz, r1.xyzz
adaaaaaaadaaahacaaaaaakeacaaaaaaadaaaakkacaaaaaa mul r3.xyz, r0.xyzz, r3.z
abaaaaaaacaaahacadaaaakeacaaaaaaacaaaakeacaaaaaa add r2.xyz, r3.xyzz, r2.xyzz
aaaaaaaaabaaahacadaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r1.xyz, v3
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaabaaaakeacaaaaaa dp3 r0.x, v2, r1.xyzz
adaaaaaaabaaahacacaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r2.xyzz, c0
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaaoeabaaaaaa max r0.x, r0.x, c1
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.x, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c1.y
aaaaaaaaaaaaaiacabaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c1.x
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "opengl " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightTexture0] 2D
SetTexture 5 [_LightTextureB0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 25 ALU, 6 TEX
PARAM c[2] = { program.local[0],
		{ 0, 0.5, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R3.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
MUL R2.xyz, R1.y, R2;
RCP R0.x, fragment.texcoord[4].w;
MAD R4.xy, fragment.texcoord[4], R0.x, c[1].y;
DP3 R1.w, fragment.texcoord[4], fragment.texcoord[4];
DP3 R1.y, fragment.texcoord[3], fragment.texcoord[3];
MOV result.color.w, c[1].x;
TEX R0.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R0.w, R4, texture[4], 2D;
TEX R1.w, R1.w, texture[5], 2D;
MAD R0.xyz, R1.x, R0, R2;
RSQ R2.x, R1.y;
MAD R1.xyz, R3, R1.z, R0;
MUL R0.xyz, R2.x, fragment.texcoord[3];
DP3 R0.x, fragment.texcoord[2], R0;
SLT R0.y, c[1].x, fragment.texcoord[4].z;
MUL R0.y, R0, R0.w;
MUL R0.y, R0, R1.w;
MAX R0.x, R0, c[1];
MUL R1.xyz, R1, c[0];
MUL R0.x, R0, R0.y;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[1].z;
END
# 25 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightTexture0] 2D
SetTexture 5 [_LightTextureB0] 2D
"ps_2_0
; 26 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c1, 0.50000000, 0.00000000, 1.00000000, 2.00000000
dcl t0
dcl t1
dcl t2.xyz
dcl t3.xyz
dcl t4
dp3 r3.x, t4, t4
mov r3.xy, r3.x
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.y, t1.w
mov r1.x, t1.z
mov r2.xy, r1
rcp r1.x, t4.w
mad r1.xy, t4, r1.x, c1.x
texld r4, r3, s5
texld r5, r1, s4
texld r3, r2, s3
texld r1, r0, s1
texld r0, t1, s2
texld r2, t0, s0
mul_pp r0.xyz, r2.y, r0
mad_pp r0.xyz, r2.x, r1, r0
mad_pp r0.xyz, r3, r2.z, r0
mul_pp r2.xyz, r0, c0
dp3_pp r0.x, t3, t3
rsq_pp r1.x, r0.x
mul_pp r1.xyz, r1.x, t3
dp3_pp r1.x, t2, r1
cmp r0.x, -t4.z, c1.y, c1.z
mul_pp r0.x, r0, r5.w
mul_pp r0.x, r0, r4
max_pp r1.x, r1, c1.y
mul_pp r0.x, r1, r0
mul_pp r0.xyz, r0.x, r2
mul_pp r0.xyz, r0, c1.w
mov_pp r0.w, c1.y
mov_pp oC0, r0
"
}


SubProgram "glesdesktop " {
Keywords { "SPOT" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "SPOT" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightTexture0] 2D
SetTexture 5 [_LightTextureB0] 2D
"agal_ps
c1 0.5 0.0 1.0 2.0
[bc]
bcaaaaaaadaaabacaeaaaaoeaeaaaaaaaeaaaaoeaeaaaaaa dp3 r3.x, v4, v4
aaaaaaaaadaaadacadaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r3.xy, r3.x
aaaaaaaaaaaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v0.w
aaaaaaaaaaaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v0.z
aaaaaaaaabaaacacabaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r1.y, v1.w
aaaaaaaaabaaabacabaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r1.x, v1.z
aaaaaaaaacaaadacabaaaafeacaaaaaaaaaaaaaaaaaaaaaa mov r2.xy, r1.xyyy
afaaaaaaabaaabacaeaaaappaeaaaaaaaaaaaaaaaaaaaaaa rcp r1.x, v4.w
adaaaaaaabaaadacaeaaaaoeaeaaaaaaabaaaaaaacaaaaaa mul r1.xy, v4, r1.x
abaaaaaaabaaadacabaaaafeacaaaaaaabaaaaaaabaaaaaa add r1.xy, r1.xyyy, c1.x
ciaaaaaaaeaaapacadaaaafeacaaaaaaafaaaaaaafaababb tex r4, r3.xyyy, s5 <2d wrap linear point>
ciaaaaaaafaaapacabaaaafeacaaaaaaaeaaaaaaafaababb tex r5, r1.xyyy, s4 <2d wrap linear point>
ciaaaaaaadaaapacacaaaafeacaaaaaaadaaaaaaafaababb tex r3, r2.xyyy, s3 <2d wrap linear point>
ciaaaaaaabaaapacaaaaaafeacaaaaaaabaaaaaaafaababb tex r1, r0.xyyy, s1 <2d wrap linear point>
ciaaaaaaaaaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r0, v1, s2 <2d wrap linear point>
ciaaaaaaacaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r2, v0, s0 <2d wrap linear point>
adaaaaaaaaaaahacacaaaaffacaaaaaaaaaaaakeacaaaaaa mul r0.xyz, r2.y, r0.xyzz
adaaaaaaaeaaahacacaaaaaaacaaaaaaabaaaakeacaaaaaa mul r4.xyz, r2.x, r1.xyzz
abaaaaaaaaaaahacaeaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r4.xyzz, r0.xyzz
adaaaaaaadaaahacadaaaakeacaaaaaaacaaaakkacaaaaaa mul r3.xyz, r3.xyzz, r2.z
abaaaaaaaaaaahacadaaaakeacaaaaaaaaaaaakeacaaaaaa add r0.xyz, r3.xyzz, r0.xyzz
adaaaaaaacaaahacaaaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r2.xyz, r0.xyzz, c0
bcaaaaaaaaaaabacadaaaaoeaeaaaaaaadaaaaoeaeaaaaaa dp3 r0.x, v3, v3
akaaaaaaabaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r1.x, r0.x
adaaaaaaabaaahacabaaaaaaacaaaaaaadaaaaoeaeaaaaaa mul r1.xyz, r1.x, v3
bcaaaaaaabaaabacacaaaaoeaeaaaaaaabaaaakeacaaaaaa dp3 r1.x, v2, r1.xyzz
bfaaaaaaabaaaiacaeaaaakkaeaaaaaaaaaaaaaaaaaaaaaa neg r1.w, v4.z
ckaaaaaaaaaaabacabaaaappacaaaaaaabaaaaffabaaaaaa slt r0.x, r1.w, c1.y
adaaaaaaaaaaabacaaaaaaaaacaaaaaaafaaaappacaaaaaa mul r0.x, r0.x, r5.w
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaappacaaaaaa mul r0.x, r0.x, r4.w
ahaaaaaaabaaabacabaaaaaaacaaaaaaabaaaaffabaaaaaa max r1.x, r1.x, c1.y
adaaaaaaaaaaabacabaaaaaaacaaaaaaaaaaaaaaacaaaaaa mul r0.x, r1.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaacaaaakeacaaaaaa mul r0.xyz, r0.x, r2.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaappabaaaaaa mul r0.xyz, r0.xyzz, c1.w
aaaaaaaaaaaaaiacabaaaaffabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c1.y
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "opengl " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 21 ALU, 6 TEX
PARAM c[2] = { program.local[0],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R3.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R0.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R1.w, fragment.texcoord[4], texture[5], CUBE;
MUL R2.xyz, R1.y, R2;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
MAD R0.xyz, R1.x, R0, R2;
DP3 R1.y, fragment.texcoord[3], fragment.texcoord[3];
RSQ R2.x, R1.y;
MAD R1.xyz, R3, R1.z, R0;
MUL R0.xyz, R2.x, fragment.texcoord[3];
DP3 R0.x, fragment.texcoord[2], R0;
MUL R1.xyz, R1, c[0];
MAX R0.x, R0, c[1];
MOV result.color.w, c[1].x;
TEX R0.w, R0.w, texture[4], 2D;
MUL R0.y, R0.w, R1.w;
MUL R0.x, R0, R0.y;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[1].y;
END
# 21 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"ps_2_0
; 22 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_cube s5
def c1, 0.00000000, 2.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xyz
dcl t3.xyz
dcl t4.xyz
texld r4, t4, s5
texld r3, t0, s0
dp3 r2.x, t4, t4
mov r2.xy, r2.x
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.xy, r0
mov r0.y, t1.w
mov r0.x, t1.z
texld r5, r2, s4
texld r2, r1, s1
texld r0, r0, s3
texld r1, t1, s2
mul_pp r1.xyz, r3.y, r1
mad_pp r1.xyz, r3.x, r2, r1
mad_pp r1.xyz, r0, r3.z, r1
dp3_pp r0.x, t3, t3
rsq_pp r0.x, r0.x
mul_pp r0.xyz, r0.x, t3
dp3_pp r0.x, t2, r0
mul_pp r1.xyz, r1, c0
mul r2.x, r5, r4.w
max_pp r0.x, r0, c1
mul_pp r0.x, r0, r2
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c1.y
mov_pp r0.w, c1.x
mov_pp oC0, r0
"
}


SubProgram "glesdesktop " {
Keywords { "POINT_COOKIE" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "POINT_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightTextureB0] 2D
SetTexture 5 [_LightTexture0] CUBE
"agal_ps
c1 0.0 2.0 0.0 0.0
[bc]
ciaaaaaaaeaaapacaeaaaaoeaeaaaaaaafaaaaaaafbababb tex r4, v4, s5 <cube wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
bcaaaaaaacaaabacaeaaaaoeaeaaaaaaaeaaaaoeaeaaaaaa dp3 r2.x, v4, v4
aaaaaaaaacaaadacacaaaaaaacaaaaaaaaaaaaaaaaaaaaaa mov r2.xy, r2.x
aaaaaaaaaaaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v0.w
aaaaaaaaaaaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v0.z
aaaaaaaaabaaadacaaaaaafeacaaaaaaaaaaaaaaaaaaaaaa mov r1.xy, r0.xyyy
aaaaaaaaaaaaacacabaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v1.w
aaaaaaaaaaaaabacabaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v1.z
ciaaaaaaafaaapacacaaaafeacaaaaaaaeaaaaaaafaababb tex r5, r2.xyyy, s4 <2d wrap linear point>
ciaaaaaaacaaapacabaaaafeacaaaaaaabaaaaaaafaababb tex r2, r1.xyyy, s1 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaafeacaaaaaaadaaaaaaafaababb tex r0, r0.xyyy, s3 <2d wrap linear point>
ciaaaaaaabaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r1, v1, s2 <2d wrap linear point>
adaaaaaaabaaahacadaaaaffacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r3.y, r1.xyzz
adaaaaaaaeaaahacadaaaaaaacaaaaaaacaaaakeacaaaaaa mul r4.xyz, r3.x, r2.xyzz
abaaaaaaabaaahacaeaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r4.xyzz, r1.xyzz
adaaaaaaadaaahacaaaaaakeacaaaaaaadaaaakkacaaaaaa mul r3.xyz, r0.xyzz, r3.z
abaaaaaaabaaahacadaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r3.xyzz, r1.xyzz
bcaaaaaaaaaaabacadaaaaoeaeaaaaaaadaaaaoeaeaaaaaa dp3 r0.x, v3, v3
akaaaaaaaaaaabacaaaaaaaaacaaaaaaaaaaaaaaaaaaaaaa rsq r0.x, r0.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaadaaaaoeaeaaaaaa mul r0.xyz, r0.x, v3
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v2, r0.xyzz
adaaaaaaabaaahacabaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r1.xyzz, c0
adaaaaaaacaaabacafaaaappacaaaaaaaeaaaappacaaaaaa mul r2.x, r5.w, r4.w
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaaoeabaaaaaa max r0.x, r0.x, c1
adaaaaaaaaaaabacaaaaaaaaacaaaaaaacaaaaaaacaaaaaa mul r0.x, r0.x, r2.x
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.x, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c1.y
aaaaaaaaaaaaaiacabaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c1.x
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightTexture0] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 5 TEX
PARAM c[2] = { program.local[0],
		{ 0, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R3.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R0.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
TEX R0.w, fragment.texcoord[4], texture[4], 2D;
MUL R2.xyz, R1.y, R2;
MAD R0.xyz, R1.x, R0, R2;
MOV R2.xyz, fragment.texcoord[3];
MAD R0.xyz, R3, R1.z, R0;
DP3 R1.x, fragment.texcoord[2], R2;
MAX R1.x, R1, c[1];
MUL R0.xyz, R0, c[0];
MUL R0.w, R1.x, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[1].y;
MOV result.color.w, c[1].x;
END
# 16 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightTexture0] 2D
"ps_2_0
; 17 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c1, 0.00000000, 2.00000000, 0, 0
dcl t0
dcl t1
dcl t2.xyz
dcl t3.xyz
dcl t4.xy
texld r4, t4, s4
texld r3, t0, s0
mov r0.y, t0.w
mov r0.x, t0.z
mov r1.xy, r0
mov r0.y, t1.w
mov r0.x, t1.z
texld r2, r1, s1
texld r0, r0, s3
texld r1, t1, s2
mul_pp r1.xyz, r3.y, r1
mad_pp r1.xyz, r3.x, r2, r1
mad_pp r1.xyz, r0, r3.z, r1
mov_pp r0.xyz, t3
dp3_pp r0.x, t2, r0
max_pp r0.x, r0, c1
mul_pp r1.xyz, r1, c0
mul_pp r0.x, r0, r4.w
mul_pp r0.xyz, r0.x, r1
mul_pp r0.xyz, r0, c1.y
mov_pp r0.w, c1.x
mov_pp oC0, r0
"
}


SubProgram "glesdesktop " {
Keywords { "DIRECTIONAL_COOKIE" }
"!!GLES"
}

SubProgram "flash " {
Keywords { "DIRECTIONAL_COOKIE" }
Vector 0 [_LightColor0]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightTexture0] 2D
"agal_ps
c1 0.0 2.0 0.0 0.0
[bc]
ciaaaaaaaeaaapacaeaaaaoeaeaaaaaaaeaaaaaaafaababb tex r4, v4, s4 <2d wrap linear point>
ciaaaaaaadaaapacaaaaaaoeaeaaaaaaaaaaaaaaafaababb tex r3, v0, s0 <2d wrap linear point>
aaaaaaaaaaaaacacaaaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v0.w
aaaaaaaaaaaaabacaaaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v0.z
aaaaaaaaabaaadacaaaaaafeacaaaaaaaaaaaaaaaaaaaaaa mov r1.xy, r0.xyyy
aaaaaaaaaaaaacacabaaaappaeaaaaaaaaaaaaaaaaaaaaaa mov r0.y, v1.w
aaaaaaaaaaaaabacabaaaakkaeaaaaaaaaaaaaaaaaaaaaaa mov r0.x, v1.z
ciaaaaaaacaaapacabaaaafeacaaaaaaabaaaaaaafaababb tex r2, r1.xyyy, s1 <2d wrap linear point>
ciaaaaaaaaaaapacaaaaaafeacaaaaaaadaaaaaaafaababb tex r0, r0.xyyy, s3 <2d wrap linear point>
ciaaaaaaabaaapacabaaaaoeaeaaaaaaacaaaaaaafaababb tex r1, v1, s2 <2d wrap linear point>
adaaaaaaabaaahacadaaaaffacaaaaaaabaaaakeacaaaaaa mul r1.xyz, r3.y, r1.xyzz
adaaaaaaacaaahacadaaaaaaacaaaaaaacaaaakeacaaaaaa mul r2.xyz, r3.x, r2.xyzz
abaaaaaaabaaahacacaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r2.xyzz, r1.xyzz
adaaaaaaacaaahacaaaaaakeacaaaaaaadaaaakkacaaaaaa mul r2.xyz, r0.xyzz, r3.z
abaaaaaaabaaahacacaaaakeacaaaaaaabaaaakeacaaaaaa add r1.xyz, r2.xyzz, r1.xyzz
aaaaaaaaaaaaahacadaaaaoeaeaaaaaaaaaaaaaaaaaaaaaa mov r0.xyz, v3
bcaaaaaaaaaaabacacaaaaoeaeaaaaaaaaaaaakeacaaaaaa dp3 r0.x, v2, r0.xyzz
ahaaaaaaaaaaabacaaaaaaaaacaaaaaaabaaaaoeabaaaaaa max r0.x, r0.x, c1
adaaaaaaabaaahacabaaaakeacaaaaaaaaaaaaoeabaaaaaa mul r1.xyz, r1.xyzz, c0
adaaaaaaaaaaabacaaaaaaaaacaaaaaaaeaaaappacaaaaaa mul r0.x, r0.x, r4.w
adaaaaaaaaaaahacaaaaaaaaacaaaaaaabaaaakeacaaaaaa mul r0.xyz, r0.x, r1.xyzz
adaaaaaaaaaaahacaaaaaakeacaaaaaaabaaaaffabaaaaaa mul r0.xyz, r0.xyzz, c1.y
aaaaaaaaaaaaaiacabaaaaaaabaaaaaaaaaaaaaaaaaaaaaa mov r0.w, c1.x
aaaaaaaaaaaaapadaaaaaaoeacaaaaaaaaaaaaaaaaaaaaaa mov o0, r0
"
}

}
	}
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassBase" }
		Fog {Mode Off}
Program "vp" {
// Vertex combos: 1
//   opengl - ALU: 8 to 8
//   d3d9 - ALU: 8 to 8
SubProgram "opengl " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Vector 9 [unity_Scale]
Matrix 5 [_Object2World]
"!!ARBvp1.0
# 8 ALU
PARAM c[10] = { program.local[0],
		state.matrix.mvp,
		program.local[5..9] };
TEMP R0;
MUL R0.xyz, vertex.normal, c[9].w;
DP3 result.texcoord[0].z, R0, c[7];
DP3 result.texcoord[0].y, R0, c[6];
DP3 result.texcoord[0].x, R0, c[5];
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 8 instructions, 1 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
Bind "vertex" Vertex
Bind "normal" Normal
Matrix 0 [glstate_matrix_mvp]
Vector 8 [unity_Scale]
Matrix 4 [_Object2World]
"vs_2_0
; 8 ALU
dcl_position0 v0
dcl_normal0 v1
mul r0.xyz, v1, c8.w
dp3 oT0.z, r0, c6
dp3 oT0.y, r0, c5
dp3 oT0.x, r0, c4
dp4 oPos.w, v0, c3
dp4 oPos.z, v0, c2
dp4 oPos.y, v0, c1
dp4 oPos.x, v0, c0
"
}

SubProgram "glesdesktop " {
Keywords { }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying lowp vec3 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;

uniform highp mat4 _Object2World;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  lowp vec3 tmpvar_1;
  mat3 tmpvar_2;
  tmpvar_2[0] = _Object2World[0].xyz;
  tmpvar_2[1] = _Object2World[1].xyz;
  tmpvar_2[2] = _Object2World[2].xyz;
  highp vec3 tmpvar_3;
  tmpvar_3 = (tmpvar_2 * (normalize (_glesNormal) * unity_Scale.w));
  tmpvar_1 = tmpvar_3;
  gl_Position = (gl_ModelViewProjectionMatrix * _glesVertex);
  xlv_TEXCOORD0 = tmpvar_1;
}



#endif
#ifdef FRAGMENT

varying lowp vec3 xlv_TEXCOORD0;
void main ()
{
  lowp vec4 res;
  res.xyz = ((xlv_TEXCOORD0 * 0.5) + 0.5);
  res.w = 0.0;
  gl_FragData[0] = res;
}



#endif"
}

}
Program "fp" {
// Fragment combos: 1
//   opengl - ALU: 2 to 2, TEX: 0 to 0
//   d3d9 - ALU: 3 to 3
SubProgram "opengl " {
Keywords { }
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 2 ALU, 0 TEX
PARAM c[1] = { { 0, 0.5 } };
MAD result.color.xyz, fragment.texcoord[0], c[0].y, c[0].y;
MOV result.color.w, c[0].x;
END
# 2 instructions, 0 R-regs
"
}

SubProgram "d3d9 " {
Keywords { }
"ps_2_0
; 3 ALU
def c0, 0.50000000, 0.00000000, 0, 0
dcl t0.xyz
mad_pp r0.xyz, t0, c0.x, c0.x
mov_pp r0.w, c0.y
mov_pp oC0, r0
"
}


SubProgram "glesdesktop " {
Keywords { }
"!!GLES"
}

}
	}
	Pass {
		Name "PREPASS"
		Tags { "LightMode" = "PrePassFinal" }
		ZWrite Off
Program "vp" {
// Vertex combos: 6
//   opengl - ALU: 14 to 31
//   d3d9 - ALU: 14 to 31
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [unity_Scale]
Matrix 5 [_Object2World]
Vector 11 [unity_SHAr]
Vector 12 [unity_SHAg]
Vector 13 [unity_SHAb]
Vector 14 [unity_SHBr]
Vector 15 [unity_SHBg]
Vector 16 [unity_SHBb]
Vector 17 [unity_SHC]
Vector 18 [_Control_ST]
Vector 19 [_Splat0_ST]
Vector 20 [_Splat1_ST]
Vector 21 [_Splat2_ST]
"!!ARBvp1.0
# 31 ALU
PARAM c[22] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[10].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[13];
DP4 R2.y, R0, c[12];
DP4 R2.x, R0, c[11];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[16];
DP4 R3.y, R1, c[15];
DP4 R3.x, R1, c[14];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MAD R0.x, R0, R0, -R0.y;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[17];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[9].x;
ADD result.texcoord[3].xyz, R3, R2;
ADD result.texcoord[2].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[2].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
END
# 31 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_Scale]
Matrix 4 [_Object2World]
Vector 11 [unity_SHAr]
Vector 12 [unity_SHAg]
Vector 13 [unity_SHAb]
Vector 14 [unity_SHBr]
Vector 15 [unity_SHBg]
Vector 16 [unity_SHBb]
Vector 17 [unity_SHC]
Vector 18 [_Control_ST]
Vector 19 [_Splat0_ST]
Vector 20 [_Splat1_ST]
Vector 21 [_Splat2_ST]
"vs_2_0
; 31 ALU
def c22, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c10.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c22.y
dp4 r2.z, r0, c13
dp4 r2.y, r0, c12
dp4 r2.x, r0, c11
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c16
dp4 r3.y, r1, c15
dp4 r3.x, r1, c14
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
mad r0.x, r0, r0, -r0.y
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c17
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r0.xyz, r1.xyww, c22.x
mul r0.y, r0, c8.x
add oT3.xyz, r3, r2
mad oT2.xy, r0.z, c9.zwzw, r0
mov oPos, r1
mov oT2.zw, r1
mad oT0.zw, v2.xyxy, c19.xyxy, c19
mad oT0.xy, v2, c18, c18.zwzw
mad oT1.zw, v2.xyxy, c21.xyxy, c21
mad oT1.xy, v2, c20, c20.zwzw
"
}


SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 _Object2World;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewProjectionMatrix * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_i0;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * 0.5);
  o_i0 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_i0.xy = (tmpvar_6 + tmpvar_5.w);
  o_i0.zw = tmpvar_4.zw;
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_7 * (normalize (_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_9;
  mediump vec4 normal;
  normal = tmpvar_8;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAr, normal);
  x1.x = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAg, normal);
  x1.y = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (unity_SHAb, normal);
  x1.z = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBr, tmpvar_13);
  x2.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBg, tmpvar_13);
  x2.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHBb, tmpvar_13);
  x2.z = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (unity_SHC.xyz * vC);
  x3 = tmpvar_18;
  tmpvar_9 = ((x1 + x2) + x3);
  tmpvar_3 = tmpvar_9;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_i0;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _LightBuffer;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c;
  mediump vec4 light;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_5;
  tmpvar_5 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Control, tmpvar_2).xyz;
  tmpvar_6 = (((texture2D (_Splat0, tmpvar_3).xyz * tmpvar_7.x) + (texture2D (_Splat1, tmpvar_4).xyz * tmpvar_7.y)) + (texture2D (_Splat2, tmpvar_5).xyz * tmpvar_7.z));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = -(log2 (max (light, vec4(0.001, 0.001, 0.001, 0.001))));
  light = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + xlv_TEXCOORD3);
  light.xyz = tmpvar_10;
  lowp vec4 c_i0;
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_6 * light.xyz);
  c_i0.xyz = tmpvar_11;
  c_i0.w = 0.0;
  c = c_i0;
  tmpvar_1 = c;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_ProjectionParams]
Matrix 9 [_Object2World]
Vector 14 [unity_LightmapST]
Vector 15 [unity_ShadowFadeCenterAndType]
Vector 16 [_Control_ST]
Vector 17 [_Splat0_ST]
Vector 18 [_Splat1_ST]
Vector 19 [_Splat2_ST]
"!!ARBvp1.0
# 23 ALU
PARAM c[20] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..19] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[15].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[15];
MOV result.texcoord[2].zw, R0;
MUL result.texcoord[4].xyz, R1, c[15].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[14], c[14].zwzw;
MUL result.texcoord[4].w, -R0.x, R0.y;
END
# 23 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Matrix 8 [_Object2World]
Vector 14 [unity_LightmapST]
Vector 15 [unity_ShadowFadeCenterAndType]
Vector 16 [_Control_ST]
Vector 17 [_Splat0_ST]
Vector 18 [_Splat1_ST]
Vector 19 [_Splat2_ST]
"vs_2_0
; 23 ALU
def c20, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c20.x
mul r1.y, r1, c12.x
mad oT2.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov r0.x, c15.w
add r0.y, c20, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c15
mov oT2.zw, r0
mul oT4.xyz, r1, c15.w
mad oT0.zw, v1.xyxy, c17.xyxy, c17
mad oT0.xy, v1, c16, c16.zwzw
mad oT1.zw, v1.xyxy, c19.xyxy, c19
mad oT1.xy, v1, c18, c18.zwzw
mad oT3.xy, v2, c14, c14.zwzw
mul oT4.w, -r0.x, r0.y
"
}

SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;
#define gl_ModelViewMatrix glstate_matrix_modelview0
uniform mat4 glstate_matrix_modelview0;

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 unity_LightmapST;


uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 _Object2World;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewProjectionMatrix * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_i0;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * 0.5);
  o_i0 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_i0.xy = (tmpvar_6 + tmpvar_5.w);
  o_i0.zw = tmpvar_4.zw;
  tmpvar_3.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_3.w = (-((gl_ModelViewMatrix * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_i0;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD4 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _LightBuffer;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c;
  mediump vec3 lmIndirect;
  mediump vec3 lmFull;
  mediump vec4 light;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_5;
  tmpvar_5 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Control, tmpvar_2).xyz;
  tmpvar_6 = (((texture2D (_Splat0, tmpvar_3).xyz * tmpvar_7.x) + (texture2D (_Splat1, tmpvar_4).xyz * tmpvar_7.y)) + (texture2D (_Splat2, tmpvar_5).xyz * tmpvar_7.z));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = -(log2 (max (light, vec4(0.001, 0.001, 0.001, 0.001))));
  light = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (unity_Lightmap, xlv_TEXCOORD3);
  lowp vec3 tmpvar_11;
  tmpvar_11 = ((8.0 * tmpvar_10.w) * tmpvar_10.xyz);
  lmFull = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (unity_LightmapInd, xlv_TEXCOORD3);
  lowp vec3 tmpvar_13;
  tmpvar_13 = ((8.0 * tmpvar_12.w) * tmpvar_12.xyz);
  lmIndirect = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = vec3(clamp (((length (xlv_TEXCOORD4) * unity_LightmapFade.z) + unity_LightmapFade.w), 0.0, 1.0));
  light.xyz = (tmpvar_9.xyz + mix (lmIndirect, lmFull, tmpvar_14));
  lowp vec4 c_i0;
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_6 * light.xyz);
  c_i0.xyz = tmpvar_15;
  c_i0.w = 0.0;
  c = c_i0;
  tmpvar_1 = c;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 5 [_ProjectionParams]
Vector 6 [unity_LightmapST]
Vector 7 [_Control_ST]
Vector 8 [_Splat0_ST]
Vector 9 [_Splat1_ST]
Vector 10 [_Splat2_ST]
"!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..10] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[5].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[8].xyxy, c[8];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[7], c[7].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[10].xyxy, c[10];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[9], c[9].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
Vector 6 [unity_LightmapST]
Vector 7 [_Control_ST]
Vector 8 [_Splat0_ST]
Vector 9 [_Splat1_ST]
Vector 10 [_Splat2_ST]
"vs_2_0
; 14 ALU
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c4.x
mad oT2.xy, r1.z, c5.zwzw, r1
mov oPos, r0
mov oT2.zw, r0
mad oT0.zw, v1.xyxy, c8.xyxy, c8
mad oT0.xy, v1, c7, c7.zwzw
mad oT1.zw, v1.xyxy, c10.xyxy, c10
mad oT1.xy, v1, c9, c9.zwzw
mad oT3.xy, v2, c6, c6.zwzw
"
}


SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;

uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_i0;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  o_i0 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_i0.xy = (tmpvar_5 + tmpvar_4.w);
  o_i0.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_i0;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _LightBuffer;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c;
  mediump vec4 light;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_5;
  tmpvar_5 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Control, tmpvar_2).xyz;
  tmpvar_6 = (((texture2D (_Splat0, tmpvar_3).xyz * tmpvar_7.x) + (texture2D (_Splat1, tmpvar_4).xyz * tmpvar_7.y)) + (texture2D (_Splat2, tmpvar_5).xyz * tmpvar_7.z));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3);
  mediump vec3 lm_i0;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((8.0 * tmpvar_9.w) * tmpvar_9.xyz);
  lm_i0 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = lm_i0;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (-(log2 (max (light, vec4(0.001, 0.001, 0.001, 0.001)))) + tmpvar_11);
  light = tmpvar_12;
  lowp vec4 c_i0;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_6 * tmpvar_12.xyz);
  c_i0.xyz = tmpvar_13;
  c_i0.w = 0.0;
  c = c_i0;
  tmpvar_1 = c;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Vector 9 [_ProjectionParams]
Vector 10 [unity_Scale]
Matrix 5 [_Object2World]
Vector 11 [unity_SHAr]
Vector 12 [unity_SHAg]
Vector 13 [unity_SHAb]
Vector 14 [unity_SHBr]
Vector 15 [unity_SHBg]
Vector 16 [unity_SHBb]
Vector 17 [unity_SHC]
Vector 18 [_Control_ST]
Vector 19 [_Splat0_ST]
Vector 20 [_Splat1_ST]
Vector 21 [_Splat2_ST]
"!!ARBvp1.0
# 31 ALU
PARAM c[22] = { { 0.5, 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[10].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].y;
DP4 R2.z, R0, c[13];
DP4 R2.y, R0, c[12];
DP4 R2.x, R0, c[11];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[16];
DP4 R3.y, R1, c[15];
DP4 R3.x, R1, c[14];
DP4 R1.w, vertex.position, c[4];
DP4 R1.z, vertex.position, c[3];
MAD R0.x, R0, R0, -R0.y;
ADD R3.xyz, R2, R3;
MUL R2.xyz, R0.x, c[17];
DP4 R1.x, vertex.position, c[1];
DP4 R1.y, vertex.position, c[2];
MUL R0.xyz, R1.xyww, c[0].x;
MUL R0.y, R0, c[9].x;
ADD result.texcoord[3].xyz, R3, R2;
ADD result.texcoord[2].xy, R0, R0.z;
MOV result.position, R1;
MOV result.texcoord[2].zw, R1;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[20], c[20].zwzw;
END
# 31 instructions, 4 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Matrix 0 [glstate_matrix_mvp]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_Scale]
Matrix 4 [_Object2World]
Vector 11 [unity_SHAr]
Vector 12 [unity_SHAg]
Vector 13 [unity_SHAb]
Vector 14 [unity_SHBr]
Vector 15 [unity_SHBg]
Vector 16 [unity_SHBb]
Vector 17 [unity_SHC]
Vector 18 [_Control_ST]
Vector 19 [_Splat0_ST]
Vector 20 [_Splat1_ST]
Vector 21 [_Splat2_ST]
"vs_2_0
; 31 ALU
def c22, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_normal0 v1
dcl_texcoord0 v2
mul r1.xyz, v1, c10.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c22.y
dp4 r2.z, r0, c13
dp4 r2.y, r0, c12
dp4 r2.x, r0, c11
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c16
dp4 r3.y, r1, c15
dp4 r3.x, r1, c14
dp4 r1.w, v0, c3
dp4 r1.z, v0, c2
mad r0.x, r0, r0, -r0.y
add r3.xyz, r2, r3
mul r2.xyz, r0.x, c17
dp4 r1.x, v0, c0
dp4 r1.y, v0, c1
mul r0.xyz, r1.xyww, c22.x
mul r0.y, r0, c8.x
add oT3.xyz, r3, r2
mad oT2.xy, r0.z, c9.zwzw, r0
mov oPos, r1
mov oT2.zw, r1
mad oT0.zw, v2.xyxy, c19.xyxy, c19
mad oT0.xy, v2, c18, c18.zwzw
mad oT1.zw, v2.xyxy, c21.xyxy, c21
mad oT1.xy, v2, c20, c20.zwzw
"
}


SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_Scale;
uniform highp vec4 unity_SHC;
uniform highp vec4 unity_SHBr;
uniform highp vec4 unity_SHBg;
uniform highp vec4 unity_SHBb;
uniform highp vec4 unity_SHAr;
uniform highp vec4 unity_SHAg;
uniform highp vec4 unity_SHAb;

uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 _Object2World;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord0;
attribute vec3 _glesNormal;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec3 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewProjectionMatrix * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_i0;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * 0.5);
  o_i0 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_i0.xy = (tmpvar_6 + tmpvar_5.w);
  o_i0.zw = tmpvar_4.zw;
  mat3 tmpvar_7;
  tmpvar_7[0] = _Object2World[0].xyz;
  tmpvar_7[1] = _Object2World[1].xyz;
  tmpvar_7[2] = _Object2World[2].xyz;
  highp vec4 tmpvar_8;
  tmpvar_8.w = 1.0;
  tmpvar_8.xyz = (tmpvar_7 * (normalize (_glesNormal) * unity_Scale.w));
  mediump vec3 tmpvar_9;
  mediump vec4 normal;
  normal = tmpvar_8;
  mediump vec3 x3;
  highp float vC;
  mediump vec3 x2;
  mediump vec3 x1;
  highp float tmpvar_10;
  tmpvar_10 = dot (unity_SHAr, normal);
  x1.x = tmpvar_10;
  highp float tmpvar_11;
  tmpvar_11 = dot (unity_SHAg, normal);
  x1.y = tmpvar_11;
  highp float tmpvar_12;
  tmpvar_12 = dot (unity_SHAb, normal);
  x1.z = tmpvar_12;
  mediump vec4 tmpvar_13;
  tmpvar_13 = (normal.xyzz * normal.yzzx);
  highp float tmpvar_14;
  tmpvar_14 = dot (unity_SHBr, tmpvar_13);
  x2.x = tmpvar_14;
  highp float tmpvar_15;
  tmpvar_15 = dot (unity_SHBg, tmpvar_13);
  x2.y = tmpvar_15;
  highp float tmpvar_16;
  tmpvar_16 = dot (unity_SHBb, tmpvar_13);
  x2.z = tmpvar_16;
  mediump float tmpvar_17;
  tmpvar_17 = ((normal.x * normal.x) - (normal.y * normal.y));
  vC = tmpvar_17;
  highp vec3 tmpvar_18;
  tmpvar_18 = (unity_SHC.xyz * vC);
  x3 = tmpvar_18;
  tmpvar_9 = ((x1 + x2) + x3);
  tmpvar_3 = tmpvar_9;
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_i0;
  xlv_TEXCOORD3 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

varying highp vec3 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _LightBuffer;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c;
  mediump vec4 light;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_5;
  tmpvar_5 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Control, tmpvar_2).xyz;
  tmpvar_6 = (((texture2D (_Splat0, tmpvar_3).xyz * tmpvar_7.x) + (texture2D (_Splat1, tmpvar_4).xyz * tmpvar_7.y)) + (texture2D (_Splat2, tmpvar_5).xyz * tmpvar_7.z));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = max (light, vec4(0.001, 0.001, 0.001, 0.001));
  light = tmpvar_9;
  highp vec3 tmpvar_10;
  tmpvar_10 = (tmpvar_9.xyz + xlv_TEXCOORD3);
  light.xyz = tmpvar_10;
  lowp vec4 c_i0;
  mediump vec3 tmpvar_11;
  tmpvar_11 = (tmpvar_6 * light.xyz);
  c_i0.xyz = tmpvar_11;
  c_i0.w = 0.0;
  c = c_i0;
  tmpvar_1 = c;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 13 [_ProjectionParams]
Matrix 9 [_Object2World]
Vector 14 [unity_LightmapST]
Vector 15 [unity_ShadowFadeCenterAndType]
Vector 16 [_Control_ST]
Vector 17 [_Splat0_ST]
Vector 18 [_Splat1_ST]
Vector 19 [_Splat2_ST]
"!!ARBvp1.0
# 23 ALU
PARAM c[20] = { { 0.5, 1 },
		state.matrix.modelview[0],
		state.matrix.mvp,
		program.local[9..19] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[13].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV R0.x, c[0].y;
ADD R0.y, R0.x, -c[15].w;
DP4 R0.x, vertex.position, c[3];
DP4 R1.z, vertex.position, c[11];
DP4 R1.x, vertex.position, c[9];
DP4 R1.y, vertex.position, c[10];
ADD R1.xyz, R1, -c[15];
MOV result.texcoord[2].zw, R0;
MUL result.texcoord[4].xyz, R1, c[15].w;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[17].xyxy, c[17];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[16], c[16].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[14], c[14].zwzw;
MUL result.texcoord[4].w, -R0.x, R0.y;
END
# 23 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_modelview0]
Matrix 4 [glstate_matrix_mvp]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Matrix 8 [_Object2World]
Vector 14 [unity_LightmapST]
Vector 15 [unity_ShadowFadeCenterAndType]
Vector 16 [_Control_ST]
Vector 17 [_Splat0_ST]
Vector 18 [_Splat1_ST]
Vector 19 [_Splat2_ST]
"vs_2_0
; 23 ALU
def c20, 0.50000000, 1.00000000, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
mul r1.xyz, r0.xyww, c20.x
mul r1.y, r1, c12.x
mad oT2.xy, r1.z, c13.zwzw, r1
mov oPos, r0
mov r0.x, c15.w
add r0.y, c20, -r0.x
dp4 r0.x, v0, c2
dp4 r1.z, v0, c10
dp4 r1.x, v0, c8
dp4 r1.y, v0, c9
add r1.xyz, r1, -c15
mov oT2.zw, r0
mul oT4.xyz, r1, c15.w
mad oT0.zw, v1.xyxy, c17.xyxy, c17
mad oT0.xy, v1, c16, c16.zwzw
mad oT1.zw, v1.xyxy, c19.xyxy, c19
mad oT1.xy, v1, c18, c18.zwzw
mad oT3.xy, v2, c14, c14.zwzw
mul oT4.w, -r0.x, r0.y
"
}



SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;
#define gl_ModelViewMatrix glstate_matrix_modelview0
uniform mat4 glstate_matrix_modelview0;

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_ShadowFadeCenterAndType;
uniform highp vec4 unity_LightmapST;


uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _ProjectionParams;
uniform highp mat4 _Object2World;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  highp vec4 tmpvar_4;
  tmpvar_4 = (gl_ModelViewProjectionMatrix * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_i0;
  highp vec4 tmpvar_5;
  tmpvar_5 = (tmpvar_4 * 0.5);
  o_i0 = tmpvar_5;
  highp vec2 tmpvar_6;
  tmpvar_6.x = tmpvar_5.x;
  tmpvar_6.y = (tmpvar_5.y * _ProjectionParams.x);
  o_i0.xy = (tmpvar_6 + tmpvar_5.w);
  o_i0.zw = tmpvar_4.zw;
  tmpvar_3.xyz = (((_Object2World * _glesVertex).xyz - unity_ShadowFadeCenterAndType.xyz) * unity_ShadowFadeCenterAndType.w);
  tmpvar_3.w = (-((gl_ModelViewMatrix * _glesVertex).z) * (1.0 - unity_ShadowFadeCenterAndType.w));
  gl_Position = tmpvar_4;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_i0;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
  xlv_TEXCOORD4 = tmpvar_3;
}



#endif
#ifdef FRAGMENT

varying highp vec4 xlv_TEXCOORD4;
varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_LightmapInd;
uniform highp vec4 unity_LightmapFade;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _LightBuffer;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c;
  mediump vec3 lmIndirect;
  mediump vec3 lmFull;
  mediump vec4 light;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_5;
  tmpvar_5 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Control, tmpvar_2).xyz;
  tmpvar_6 = (((texture2D (_Splat0, tmpvar_3).xyz * tmpvar_7.x) + (texture2D (_Splat1, tmpvar_4).xyz * tmpvar_7.y)) + (texture2D (_Splat2, tmpvar_5).xyz * tmpvar_7.z));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light = tmpvar_8;
  mediump vec4 tmpvar_9;
  tmpvar_9 = max (light, vec4(0.001, 0.001, 0.001, 0.001));
  light = tmpvar_9;
  lowp vec4 tmpvar_10;
  tmpvar_10 = texture2D (unity_Lightmap, xlv_TEXCOORD3);
  lowp vec3 tmpvar_11;
  tmpvar_11 = ((8.0 * tmpvar_10.w) * tmpvar_10.xyz);
  lmFull = tmpvar_11;
  lowp vec4 tmpvar_12;
  tmpvar_12 = texture2D (unity_LightmapInd, xlv_TEXCOORD3);
  lowp vec3 tmpvar_13;
  tmpvar_13 = ((8.0 * tmpvar_12.w) * tmpvar_12.xyz);
  lmIndirect = tmpvar_13;
  highp vec3 tmpvar_14;
  tmpvar_14 = vec3(clamp (((length (xlv_TEXCOORD4) * unity_LightmapFade.z) + unity_LightmapFade.w), 0.0, 1.0));
  light.xyz = (tmpvar_9.xyz + mix (lmIndirect, lmFull, tmpvar_14));
  lowp vec4 c_i0;
  mediump vec3 tmpvar_15;
  tmpvar_15 = (tmpvar_6 * light.xyz);
  c_i0.xyz = tmpvar_15;
  c_i0.w = 0.0;
  c = c_i0;
  tmpvar_1 = c;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Vector 5 [_ProjectionParams]
Vector 6 [unity_LightmapST]
Vector 7 [_Control_ST]
Vector 8 [_Splat0_ST]
Vector 9 [_Splat1_ST]
Vector 10 [_Splat2_ST]
"!!ARBvp1.0
# 14 ALU
PARAM c[11] = { { 0.5 },
		state.matrix.mvp,
		program.local[5..10] };
TEMP R0;
TEMP R1;
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].x;
MUL R1.y, R1, c[5].x;
ADD result.texcoord[2].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[2].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[8].xyxy, c[8];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[7], c[7].zwzw;
MAD result.texcoord[1].zw, vertex.texcoord[0].xyxy, c[10].xyxy, c[10];
MAD result.texcoord[1].xy, vertex.texcoord[0], c[9], c[9].zwzw;
MAD result.texcoord[3].xy, vertex.texcoord[1], c[6], c[6].zwzw;
END
# 14 instructions, 2 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
Bind "vertex" Vertex
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Matrix 0 [glstate_matrix_mvp]
Vector 4 [_ProjectionParams]
Vector 5 [_ScreenParams]
Vector 6 [unity_LightmapST]
Vector 7 [_Control_ST]
Vector 8 [_Splat0_ST]
Vector 9 [_Splat1_ST]
Vector 10 [_Splat2_ST]
"vs_2_0
; 14 ALU
def c11, 0.50000000, 0, 0, 0
dcl_position0 v0
dcl_texcoord0 v1
dcl_texcoord1 v2
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c11.x
mul r1.y, r1, c4.x
mad oT2.xy, r1.z, c5.zwzw, r1
mov oPos, r0
mov oT2.zw, r0
mad oT0.zw, v1.xyxy, c8.xyxy, c8
mad oT0.xy, v1, c7, c7.zwzw
mad oT1.zw, v1.xyxy, c10.xyxy, c10
mad oT1.xy, v1, c9, c9.zwzw
mad oT3.xy, v2, c6, c6.zwzw
"
}


SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES
#define SHADER_API_GLES 1
#define tex2D texture2D


#ifdef VERTEX
#define gl_ModelViewProjectionMatrix glstate_matrix_mvp
uniform mat4 glstate_matrix_mvp;

varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform highp vec4 unity_LightmapST;

uniform highp vec4 _Splat2_ST;
uniform highp vec4 _Splat1_ST;
uniform highp vec4 _Splat0_ST;
uniform highp vec4 _ProjectionParams;
uniform highp vec4 _Control_ST;
attribute vec4 _glesMultiTexCoord1;
attribute vec4 _glesMultiTexCoord0;
attribute vec4 _glesVertex;
void main ()
{
  highp vec4 tmpvar_1;
  highp vec4 tmpvar_2;
  highp vec4 tmpvar_3;
  tmpvar_3 = (gl_ModelViewProjectionMatrix * _glesVertex);
  tmpvar_1.xy = ((_glesMultiTexCoord0.xy * _Control_ST.xy) + _Control_ST.zw);
  tmpvar_1.zw = ((_glesMultiTexCoord0.xy * _Splat0_ST.xy) + _Splat0_ST.zw);
  tmpvar_2.xy = ((_glesMultiTexCoord0.xy * _Splat1_ST.xy) + _Splat1_ST.zw);
  tmpvar_2.zw = ((_glesMultiTexCoord0.xy * _Splat2_ST.xy) + _Splat2_ST.zw);
  highp vec4 o_i0;
  highp vec4 tmpvar_4;
  tmpvar_4 = (tmpvar_3 * 0.5);
  o_i0 = tmpvar_4;
  highp vec2 tmpvar_5;
  tmpvar_5.x = tmpvar_4.x;
  tmpvar_5.y = (tmpvar_4.y * _ProjectionParams.x);
  o_i0.xy = (tmpvar_5 + tmpvar_4.w);
  o_i0.zw = tmpvar_3.zw;
  gl_Position = tmpvar_3;
  xlv_TEXCOORD0 = tmpvar_1;
  xlv_TEXCOORD1 = tmpvar_2;
  xlv_TEXCOORD2 = o_i0;
  xlv_TEXCOORD3 = ((_glesMultiTexCoord1.xy * unity_LightmapST.xy) + unity_LightmapST.zw);
}



#endif
#ifdef FRAGMENT

varying highp vec2 xlv_TEXCOORD3;
varying highp vec4 xlv_TEXCOORD2;
varying highp vec4 xlv_TEXCOORD1;
varying highp vec4 xlv_TEXCOORD0;
uniform sampler2D unity_Lightmap;
uniform sampler2D _Splat2;
uniform sampler2D _Splat1;
uniform sampler2D _Splat0;
uniform sampler2D _LightBuffer;
uniform sampler2D _Control;
void main ()
{
  lowp vec4 tmpvar_1;
  mediump vec4 c;
  mediump vec4 light;
  highp vec2 tmpvar_2;
  tmpvar_2 = xlv_TEXCOORD0.xy;
  highp vec2 tmpvar_3;
  tmpvar_3 = xlv_TEXCOORD0.zw;
  highp vec2 tmpvar_4;
  tmpvar_4 = xlv_TEXCOORD1.xy;
  highp vec2 tmpvar_5;
  tmpvar_5 = xlv_TEXCOORD1.zw;
  lowp vec3 tmpvar_6;
  lowp vec3 tmpvar_7;
  tmpvar_7 = texture2D (_Control, tmpvar_2).xyz;
  tmpvar_6 = (((texture2D (_Splat0, tmpvar_3).xyz * tmpvar_7.x) + (texture2D (_Splat1, tmpvar_4).xyz * tmpvar_7.y)) + (texture2D (_Splat2, tmpvar_5).xyz * tmpvar_7.z));
  lowp vec4 tmpvar_8;
  tmpvar_8 = texture2DProj (_LightBuffer, xlv_TEXCOORD2);
  light = tmpvar_8;
  lowp vec4 tmpvar_9;
  tmpvar_9 = texture2D (unity_Lightmap, xlv_TEXCOORD3);
  mediump vec3 lm_i0;
  lowp vec3 tmpvar_10;
  tmpvar_10 = ((8.0 * tmpvar_9.w) * tmpvar_9.xyz);
  lm_i0 = tmpvar_10;
  mediump vec4 tmpvar_11;
  tmpvar_11.w = 0.0;
  tmpvar_11.xyz = lm_i0;
  mediump vec4 tmpvar_12;
  tmpvar_12 = (max (light, vec4(0.001, 0.001, 0.001, 0.001)) + tmpvar_11);
  light = tmpvar_12;
  lowp vec4 c_i0;
  mediump vec3 tmpvar_13;
  tmpvar_13 = (tmpvar_6 * tmpvar_12.xyz);
  c_i0.xyz = tmpvar_13;
  c_i0.w = 0.0;
  c = c_i0;
  tmpvar_1 = c;
  gl_FragData[0] = tmpvar_1;
}



#endif"
}

}
Program "fp" {
// Fragment combos: 6
//   opengl - ALU: 11 to 25, TEX: 5 to 7
//   d3d9 - ALU: 12 to 24, TEX: 5 to 7
SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightBuffer] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 14 ALU, 5 TEX
PARAM c[1] = { { 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TXP R4.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R3.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R0.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R2.xyz, R1.y, R2;
MAD R0.xyz, R1.x, R0, R2;
LG2 R2.x, R4.x;
LG2 R2.z, R4.z;
LG2 R2.y, R4.y;
ADD R2.xyz, -R2, fragment.texcoord[3];
MAD R0.xyz, R3, R1.z, R0;
MUL result.color.xyz, R0, R2;
MOV result.color.w, c[0].x;
END
# 14 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightBuffer] 2D
"ps_2_0
; 15 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c0, 0.00000000, 0, 0, 0
dcl t0
dcl t1
dcl t2
dcl t3.xyz
texld r2, t1, s2
texld r4, t0, s0
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.xy, r0
mov r0.y, t0.w
mov r0.x, t0.z
mul_pp r2.xyz, r4.y, r2
texld r3, r0, s1
texldp r0, t2, s4
texld r1, r1, s3
mad_pp r2.xyz, r4.x, r3, r2
log_pp r0.x, r0.x
log_pp r0.z, r0.z
log_pp r0.y, r0.y
add_pp r0.xyz, -r0, t3
mad_pp r1.xyz, r1, r4.z, r2
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c0.x
mov_pp oC0, r0
"
}


SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [unity_LightmapFade]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightBuffer] 2D
SetTexture 5 [unity_Lightmap] 2D
SetTexture 6 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 25 ALU, 7 TEX
PARAM c[2] = { program.local[0],
		{ 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R0, fragment.texcoord[3], texture[6], 2D;
TEX R1, fragment.texcoord[3], texture[5], 2D;
TXP R6.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R3.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R5.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R2.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[1].y;
MUL R4.xyz, R3.y, R4;
DP4 R1.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R0.w, R1.w;
RCP R0.w, R0.w;
MAD R1.xyz, R1, c[1].y, -R0;
MAD_SAT R0.w, R0, c[0].z, c[0];
MAD R0.xyz, R0.w, R1, R0;
LG2 R1.x, R6.x;
LG2 R1.y, R6.y;
LG2 R1.z, R6.z;
ADD R0.xyz, -R1, R0;
MAD R2.xyz, R3.x, R2, R4;
MAD R1.xyz, R5, R3.z, R2;
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[1].x;
END
# 25 instructions, 7 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
Vector 0 [unity_LightmapFade]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightBuffer] 2D
SetTexture 5 [unity_Lightmap] 2D
SetTexture 6 [unity_LightmapInd] 2D
"ps_2_0
; 24 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c1, 8.00000000, 0.00000000, 0, 0
dcl t0
dcl t1
dcl t2
dcl t3.xy
dcl t4
texld r5, t0, s0
texld r3, t1, s2
texld r6, t3, s6
mul_pp r6.xyz, r6.w, r6
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.xy, r0
mov r0.y, t0.w
mov r0.x, t0.z
mul_pp r6.xyz, r6, c1.x
texld r2, r1, s3
texld r4, r0, s1
texldp r1, t2, s4
texld r0, t3, s5
mul_pp r7.xyz, r0.w, r0
dp4 r0.x, t4, t4
rsq r0.x, r0.x
rcp r0.x, r0.x
log_pp r1.x, r1.x
log_pp r1.y, r1.y
log_pp r1.z, r1.z
mad_pp r7.xyz, r7, c1.x, -r6
mad_sat r0.x, r0, c0.z, c0.w
mad_pp r0.xyz, r0.x, r7, r6
add_pp r0.xyz, -r1, r0
mul_pp r1.xyz, r5.y, r3
mad_pp r1.xyz, r5.x, r4, r1
mad_pp r1.xyz, r2, r5.z, r1
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c1.y
mov_pp oC0, r0
"
}


SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightBuffer] 2D
SetTexture 5 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 16 ALU, 6 TEX
PARAM c[1] = { { 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0, fragment.texcoord[3], texture[5], 2D;
TXP R5.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R4.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R3.xyz, R2.y, R3;
MAD R1.xyz, R2.x, R1, R3;
MUL R0.xyz, R0.w, R0;
LG2 R3.x, R5.x;
LG2 R3.z, R5.z;
LG2 R3.y, R5.y;
MAD R0.xyz, R0, c[0].y, -R3;
MAD R1.xyz, R4, R2.z, R1;
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[0].x;
END
# 16 instructions, 6 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightBuffer] 2D
SetTexture 5 [unity_Lightmap] 2D
"ps_2_0
; 15 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c0, 8.00000000, 0.00000000, 0, 0
dcl t0
dcl t1
dcl t2
dcl t3.xy
texldp r4, t2, s4
texld r3, t0, s0
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.y, t0.w
mov r1.x, t0.z
texld r5, r0, s3
texld r2, r1, s1
texld r0, t3, s5
texld r1, t1, s2
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r3.y, r1
mad_pp r1.xyz, r3.x, r2, r1
log_pp r2.x, r4.x
log_pp r2.z, r4.z
log_pp r2.y, r4.y
mad_pp r0.xyz, r0, c0.x, -r2
mad_pp r1.xyz, r5, r3.z, r1
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c0.y
mov_pp oC0, r0
"
}


SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_OFF" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightBuffer] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 11 ALU, 5 TEX
PARAM c[1] = { { 0 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R1.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R2.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R3.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TXP R4.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R0.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R2.xyz, R1.y, R2;
MAD R0.xyz, R1.x, R0, R2;
ADD R2.xyz, R4, fragment.texcoord[3];
MAD R0.xyz, R3, R1.z, R0;
MUL result.color.xyz, R0, R2;
MOV result.color.w, c[0].x;
END
# 11 instructions, 5 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightBuffer] 2D
"ps_2_0
; 12 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c0, 0.00000000, 0, 0, 0
dcl t0
dcl t1
dcl t2
dcl t3.xyz
texld r2, t1, s2
texld r4, t0, s0
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.xy, r0
mov r0.y, t0.w
mov r0.x, t0.z
mul_pp r2.xyz, r4.y, r2
texld r3, r0, s1
texldp r0, t2, s4
texld r1, r1, s3
mad_pp r2.xyz, r4.x, r3, r2
add_pp r0.xyz, r0, t3
mad_pp r1.xyz, r1, r4.z, r2
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c0.x
mov_pp oC0, r0
"
}


SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_OFF" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [unity_LightmapFade]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightBuffer] 2D
SetTexture 5 [unity_Lightmap] 2D
SetTexture 6 [unity_LightmapInd] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 22 ALU, 7 TEX
PARAM c[2] = { program.local[0],
		{ 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEMP R6;
TEX R0, fragment.texcoord[3], texture[6], 2D;
TEX R1, fragment.texcoord[3], texture[5], 2D;
TEX R3.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R4.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R5.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TXP R6.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R2.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R0.xyz, R0.w, R0;
DP4 R0.w, fragment.texcoord[4], fragment.texcoord[4];
RSQ R0.w, R0.w;
RCP R0.w, R0.w;
MUL R0.xyz, R0, c[1].y;
MUL R1.xyz, R1.w, R1;
MAD R1.xyz, R1, c[1].y, -R0;
MAD_SAT R0.w, R0, c[0].z, c[0];
MAD R0.xyz, R0.w, R1, R0;
MUL R4.xyz, R3.y, R4;
MAD R1.xyz, R3.x, R2, R4;
ADD R0.xyz, R6, R0;
MAD R1.xyz, R5, R3.z, R1;
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[1].x;
END
# 22 instructions, 7 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
Vector 0 [unity_LightmapFade]
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightBuffer] 2D
SetTexture 5 [unity_Lightmap] 2D
SetTexture 6 [unity_LightmapInd] 2D
"ps_2_0
; 21 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
dcl_2d s6
def c1, 8.00000000, 0.00000000, 0, 0
dcl t0
dcl t1
dcl t2
dcl t3.xy
dcl t4
texldp r5, t2, s4
texld r2, t1, s2
texld r3, t0, s0
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.xy, r0
mov r0.y, t0.w
mov r0.x, t0.z
mul_pp r2.xyz, r3.y, r2
texld r6, r1, s3
texld r4, r0, s1
texld r1, t3, s6
texld r0, t3, s5
mul_pp r1.xyz, r1.w, r1
mad_pp r2.xyz, r3.x, r4, r2
mul_pp r4.xyz, r0.w, r0
mul_pp r1.xyz, r1, c1.x
dp4 r0.x, t4, t4
rsq r0.x, r0.x
rcp r0.x, r0.x
mad_pp r4.xyz, r4, c1.x, -r1
mad_sat r0.x, r0, c0.z, c0.w
mad_pp r0.xyz, r0.x, r4, r1
add_pp r0.xyz, r5, r0
mad_pp r1.xyz, r6, r3.z, r2
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c1.y
mov_pp oC0, r0
"
}



SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_OFF" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

SubProgram "opengl " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightBuffer] 2D
SetTexture 5 [unity_Lightmap] 2D
"!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 13 ALU, 6 TEX
PARAM c[1] = { { 0, 8 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0, fragment.texcoord[3], texture[5], 2D;
TEX R2.xyz, fragment.texcoord[0], texture[0], 2D;
TEX R3.xyz, fragment.texcoord[1], texture[2], 2D;
TEX R4.xyz, fragment.texcoord[1].zwzw, texture[3], 2D;
TXP R5.xyz, fragment.texcoord[2], texture[4], 2D;
TEX R1.xyz, fragment.texcoord[0].zwzw, texture[1], 2D;
MUL R3.xyz, R2.y, R3;
MAD R1.xyz, R2.x, R1, R3;
MUL R0.xyz, R0.w, R0;
MAD R0.xyz, R0, c[0].y, R5;
MAD R1.xyz, R4, R2.z, R1;
MUL result.color.xyz, R1, R0;
MOV result.color.w, c[0].x;
END
# 13 instructions, 6 R-regs
"
}

SubProgram "d3d9 " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
SetTexture 0 [_Control] 2D
SetTexture 1 [_Splat0] 2D
SetTexture 2 [_Splat1] 2D
SetTexture 3 [_Splat2] 2D
SetTexture 4 [_LightBuffer] 2D
SetTexture 5 [unity_Lightmap] 2D
"ps_2_0
; 12 ALU, 6 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
dcl_2d s5
def c0, 8.00000000, 0.00000000, 0, 0
dcl t0
dcl t1
dcl t2
dcl t3.xy
texldp r4, t2, s4
texld r3, t0, s0
mov r0.y, t1.w
mov r0.x, t1.z
mov r1.y, t0.w
mov r1.x, t0.z
texld r5, r0, s3
texld r2, r1, s1
texld r0, t3, s5
texld r1, t1, s2
mul_pp r0.xyz, r0.w, r0
mul_pp r1.xyz, r3.y, r1
mad_pp r1.xyz, r3.x, r2, r1
mad_pp r0.xyz, r0, c0.x, r4
mad_pp r1.xyz, r5, r3.z, r1
mul_pp r0.xyz, r1, r0
mov_pp r0.w, c0.y
mov_pp oC0, r0
"
}


SubProgram "glesdesktop " {
Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_ON" "HDR_LIGHT_PREPASS_ON" }
"!!GLES"
}

}
	}

#LINE 36
 
}
}