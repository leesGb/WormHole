Shader "TerrainForMobile/2TexturesDiffuseSimple" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_Layer1 ("Layer1 (RGB)", 2D) = "white" {}
	_Layer2 ("Layer2 (RGB)", 2D) = "white" {}
	_MainTex ("Mask (RGB)", 2D) = "white" {}
}
SubShader {
		Tags {
		"SplatCount" = "2"
		"Queue" = "Geometry-100"
		"RenderType" = "Opaque"
	}
CGPROGRAM
#pragma surface surf Lambert exclude_path:prepass   halfasview novertexlights



struct Input {
	float2 uv_Layer1: TEXCOORD0;
	float2 uv_Layer2 : TEXCOORD1;
	float2 uv_MainTex : TEXCOORD3;
};sampler2D _MainTex;
sampler2D _Layer1, _Layer2;
fixed3 _Color;


void surf (Input IN, inout SurfaceOutput o) {
	
	fixed2 Mask = tex2D (_MainTex, IN.uv_MainTex);
	fixed3 lay;
	lay  = Mask.r * tex2D (_Layer1, IN.uv_Layer1).rgb;
	lay += Mask.g * tex2D (_Layer2, IN.uv_Layer2).rgb;
	o.Albedo = lay* _Color.rgb;
	o.Alpha = 0.0;
}
ENDCG
}

}
