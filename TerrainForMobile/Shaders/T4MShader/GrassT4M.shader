Shader "TerrainForMobile/GrassT4M" {
Properties {
	_Color ("Main Color", Color) = (1,1,1,1)
	_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
	_Cutoff ("Alpha cutoff", Range(0,1)) = 0.5
}
SubShader {
	Tags {"Queue"="AlphaTest" "IgnoreProjector"="True" "RenderType"="TransparentCutout"}
	LOD 100
	
	Pass {
		Lighting Off
		
		Alphatest Greater [_Cutoff]
		SetTexture [_MainTex] {
			constantColor [_Color]
			combine texture * constant
		} 
	}
}
}