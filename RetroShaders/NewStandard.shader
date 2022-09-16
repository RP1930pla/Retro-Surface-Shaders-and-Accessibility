// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "NewStandard"
{
	Properties
	{
		_Albedo("Albedo", 2D) = "white" {}
		_MetallicSmoothness("Metallic Smoothness", 2D) = "white" {}
		_Metallic("Metallic", Range( 0 , 1)) = 0
		_Smoothness("Smoothness", Range( 0 , 1)) = 0
		[Normal]_Normal("Normal", 2D) = "bump" {}
		_Occlusion("Occlusion", 2D) = "white" {}
		_Emission("Emission", 2D) = "white" {}
		[HDR]_EmissionColor("Emission Color", Color) = (0,0,0,0)
		_ID("_ID", Int) = 0
		[Toggle(_AFFINETEXTUREMAPPING_ON)] _AffineTextureMapping("Affine Texture Mapping", Float) = 0
		[Toggle(_NOFPU_ON)] _NoFPU("No FPU", Float) = 0
		_HorizontalResolution("Horizontal Resolution", Int) = 320
		_VerticalResolution("Vertical Resolution", Int) = 240
		[HideInInspector] _texcoord4( "", 2D ) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		Stencil
		{
			Ref [_ID]
			Comp Always
			Pass Replace
		}
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#include "UnityCG.cginc"
		#pragma target 4.6
		#pragma multi_compile_local __ _NOFPU_ON
		#pragma multi_compile __ _AFFINETEXTUREMAPPING_ON
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv4_texcoord4;
			float2 vertexToFrag4_g19;
			float3 worldPos;
			float2 uv_texcoord;
			float2 vertexToFrag4_g18;
			float2 vertexToFrag4_g16;
			float2 vertexToFrag4_g15;
			float2 vertexToFrag4_g17;
		};

		uniform int _ID;
		uniform int _HorizontalResolution;
		uniform int _VerticalResolution;
		uniform sampler2D _Normal;
		uniform float4 _Normal_ST;
		uniform sampler2D _Albedo;
		uniform float4 _Albedo_ST;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float4 _EmissionColor;
		uniform sampler2D _MetallicSmoothness;
		uniform float4 _MetallicSmoothness_ST;
		uniform float _Metallic;
		uniform float _Smoothness;
		uniform sampler2D _Occlusion;
		uniform float4 _Occlusion_ST;


		float4x4 Inverse4x4(float4x4 input)
		{
			#define minor(a,b,c) determinant(float3x3(input.a, input.b, input.c))
			float4x4 cofactors = float4x4(
			minor( _22_23_24, _32_33_34, _42_43_44 ),
			-minor( _21_23_24, _31_33_34, _41_43_44 ),
			minor( _21_22_24, _31_32_34, _41_42_44 ),
			-minor( _21_22_23, _31_32_33, _41_42_43 ),
		
			-minor( _12_13_14, _32_33_34, _42_43_44 ),
			minor( _11_13_14, _31_33_34, _41_43_44 ),
			-minor( _11_12_14, _31_32_34, _41_42_44 ),
			minor( _11_12_13, _31_32_33, _41_42_43 ),
		
			minor( _12_13_14, _22_23_24, _42_43_44 ),
			-minor( _11_13_14, _21_23_24, _41_43_44 ),
			minor( _11_12_14, _21_22_24, _41_42_44 ),
			-minor( _11_12_13, _21_22_23, _41_42_43 ),
		
			-minor( _12_13_14, _22_23_24, _32_33_34 ),
			minor( _11_13_14, _21_23_24, _31_33_34 ),
			-minor( _11_12_14, _21_22_24, _31_32_34 ),
			minor( _11_12_13, _21_22_23, _31_32_33 ));
			#undef minor
			return transpose( cofactors ) / determinant( input );
		}


		float MyCustomExpression66_g20( float vertexin, int Pixels )
		{
			float result;
			result = floor(Pixels * vertexin) / Pixels;
			return result;
		}


		float MyCustomExpression65_g20( float vertexin, int Pixels )
		{
			float result;
			result = floor(Pixels * vertexin) / Pixels;
			return result;
		}


		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float4x4 invertVal79_g20 = Inverse4x4( UNITY_MATRIX_MVP );
			float4 unityObjectToClipPos49_g20 = UnityObjectToClipPos( ase_vertex3Pos );
			float4 SnapToPixel54_g20 = unityObjectToClipPos49_g20;
			float4 vertex55_g20 = SnapToPixel54_g20;
			float4 break57_g20 = vertex55_g20;
			float3 appendResult58_g20 = (float3(break57_g20.x , break57_g20.y , break57_g20.z));
			float4 appendResult62_g20 = (float4(( appendResult58_g20 / SnapToPixel54_g20.w ) , break57_g20.w));
			float4 break63_g20 = appendResult62_g20;
			float vertexin66_g20 = break63_g20.x;
			int Pixels66_g20 = ( _HorizontalResolution / 2 );
			float localMyCustomExpression66_g20 = MyCustomExpression66_g20( vertexin66_g20 , Pixels66_g20 );
			float vertexin65_g20 = break63_g20.y;
			int Pixels65_g20 = ( _VerticalResolution / 2 );
			float localMyCustomExpression65_g20 = MyCustomExpression65_g20( vertexin65_g20 , Pixels65_g20 );
			float3 appendResult69_g20 = (float3(localMyCustomExpression66_g20 , localMyCustomExpression65_g20 , break63_g20.z));
			float4 appendResult73_g20 = (float4(( appendResult69_g20 * SnapToPixel54_g20.w ) , break63_g20.w));
			#ifdef _NOFPU_ON
				float4 staticSwitch94 = mul( invertVal79_g20, appendResult73_g20 );
			#else
				float4 staticSwitch94 = float4( ase_vertex3Pos , 0.0 );
			#endif
			v.vertex.xyz = staticSwitch94.xyz;
			v.vertex.w = 1;
			float2 uv_Normal = v.texcoord.xy * _Normal_ST.xy + _Normal_ST.zw;
			float4 unityObjectToClipPos2_g19 = UnityObjectToClipPos( ase_vertex3Pos );
			o.vertexToFrag4_g19 = ( uv_Normal * unityObjectToClipPos2_g19.w );
			float2 uv_Albedo = v.texcoord.xy * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 unityObjectToClipPos2_g18 = UnityObjectToClipPos( ase_vertex3Pos );
			o.vertexToFrag4_g18 = ( uv_Albedo * unityObjectToClipPos2_g18.w );
			float2 uv_Emission = v.texcoord.xy * _Emission_ST.xy + _Emission_ST.zw;
			float4 unityObjectToClipPos2_g16 = UnityObjectToClipPos( ase_vertex3Pos );
			o.vertexToFrag4_g16 = ( uv_Emission * unityObjectToClipPos2_g16.w );
			float2 uv_MetallicSmoothness = v.texcoord.xy * _MetallicSmoothness_ST.xy + _MetallicSmoothness_ST.zw;
			float4 unityObjectToClipPos2_g15 = UnityObjectToClipPos( ase_vertex3Pos );
			o.vertexToFrag4_g15 = ( uv_MetallicSmoothness * unityObjectToClipPos2_g15.w );
			float2 uv_Occlusion = v.texcoord.xy * _Occlusion_ST.xy + _Occlusion_ST.zw;
			float4 unityObjectToClipPos2_g17 = UnityObjectToClipPos( ase_vertex3Pos );
			o.vertexToFrag4_g17 = ( uv_Occlusion * unityObjectToClipPos2_g17.w );
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv4_Normal = i.uv4_texcoord4 * _Normal_ST.xy + _Normal_ST.zw;
			float3 ase_vertex3Pos = mul( unity_WorldToObject, float4( i.worldPos , 1 ) );
			float4 unityObjectToClipPos5_g19 = UnityObjectToClipPos( ase_vertex3Pos );
			#ifdef _AFFINETEXTUREMAPPING_ON
				float2 staticSwitch99 = ( i.vertexToFrag4_g19 / unityObjectToClipPos5_g19.w );
			#else
				float2 staticSwitch99 = uv4_Normal;
			#endif
			float3 Normal106 = UnpackNormal( tex2D( _Normal, staticSwitch99 ) );
			o.Normal = Normal106;
			float2 uv_Albedo = i.uv_texcoord * _Albedo_ST.xy + _Albedo_ST.zw;
			float4 unityObjectToClipPos5_g18 = UnityObjectToClipPos( ase_vertex3Pos );
			#ifdef _AFFINETEXTUREMAPPING_ON
				float2 staticSwitch57 = ( i.vertexToFrag4_g18 / unityObjectToClipPos5_g18.w );
			#else
				float2 staticSwitch57 = uv_Albedo;
			#endif
			float4 Albedo95 = tex2D( _Albedo, staticSwitch57 );
			o.Albedo = Albedo95.rgb;
			float2 uv4_Emission = i.uv4_texcoord4 * _Emission_ST.xy + _Emission_ST.zw;
			float4 unityObjectToClipPos5_g16 = UnityObjectToClipPos( ase_vertex3Pos );
			#ifdef _AFFINETEXTUREMAPPING_ON
				float2 staticSwitch111 = ( i.vertexToFrag4_g16 / unityObjectToClipPos5_g16.w );
			#else
				float2 staticSwitch111 = uv4_Emission;
			#endif
			float4 Emission115 = ( tex2D( _Emission, staticSwitch111 ) * _EmissionColor );
			o.Emission = Emission115.rgb;
			float2 uv4_MetallicSmoothness = i.uv4_texcoord4 * _MetallicSmoothness_ST.xy + _MetallicSmoothness_ST.zw;
			float4 unityObjectToClipPos5_g15 = UnityObjectToClipPos( ase_vertex3Pos );
			#ifdef _AFFINETEXTUREMAPPING_ON
				float2 staticSwitch120 = ( i.vertexToFrag4_g15 / unityObjectToClipPos5_g15.w );
			#else
				float2 staticSwitch120 = uv4_MetallicSmoothness;
			#endif
			float4 tex2DNode121 = tex2D( _MetallicSmoothness, staticSwitch120 );
			float Metallic129 = ( tex2DNode121.r * _Metallic );
			o.Metallic = Metallic129;
			float Smoothness130 = ( tex2DNode121.a * _Smoothness );
			o.Smoothness = Smoothness130;
			float2 uv4_Occlusion = i.uv4_texcoord4 * _Occlusion_ST.xy + _Occlusion_ST.zw;
			float4 unityObjectToClipPos5_g17 = UnityObjectToClipPos( ase_vertex3Pos );
			#ifdef _AFFINETEXTUREMAPPING_ON
				float2 staticSwitch135 = ( i.vertexToFrag4_g17 / unityObjectToClipPos5_g17.w );
			#else
				float2 staticSwitch135 = uv4_Occlusion;
			#endif
			float4 Oclussion138 = tex2D( _Occlusion, staticSwitch135 );
			o.Occlusion = Oclussion138.r;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=18935
1920;0;1920;1019;2016.289;387.5671;1.534274;True;False
Node;AmplifyShaderEditor.TexturePropertyNode;117;-3454.842,987.5032;Inherit;True;Property;_MetallicSmoothness;Metallic Smoothness;1;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;119;-2955.486,992.8434;Inherit;False;AffineTM;-1;;15;1253b9ff3f307ed47846b90f0972e7f5;0;1;9;SAMPLER2D;0;False;2;SAMPLER2D;10;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;118;-2981.475,1119.058;Inherit;False;3;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StaticSwitch;120;-2661.421,1100.607;Inherit;False;Property;_AffineTextureMapping;Affine Texture Mapping;9;0;Create;True;0;0;0;False;0;False;1;0;0;True;;Toggle;2;Key0;Key1;Reference;57;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;121;-2312.362,995.3282;Inherit;True;Property;_TextureSample3;Texture Sample 3;9;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;108;-3427.777,145.1745;Inherit;True;Property;_Emission;Emission;6;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.TexturePropertyNode;47;-3437.923,-789.5674;Inherit;True;Property;_Albedo;Albedo;0;0;Create;True;0;0;0;False;0;False;None;750b1bd7ba8bd28489650de6d0a95cc5;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.WireNode;125;-2033.975,1257.514;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.TexturePropertyNode;101;-3454.566,-389.1792;Inherit;True;Property;_Normal;Normal;4;1;[Normal];Create;True;0;0;0;True;0;False;None;None;False;bump;LockedToTexture2D;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;110;-2873.778,149.4037;Inherit;False;AffineTM;-1;;16;1253b9ff3f307ed47846b90f0972e7f5;0;1;9;SAMPLER2D;0;False;2;SAMPLER2D;10;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;109;-2899.767,275.6184;Inherit;False;3;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TexturePropertyNode;137;-3423.188,2203.739;Inherit;True;Property;_Occlusion;Occlusion;5;0;Create;True;0;0;0;False;0;False;None;None;False;white;Auto;Texture2D;-1;0;2;SAMPLER2D;0;SAMPLERSTATE;1
Node;AmplifyShaderEditor.FunctionNode;134;-3030.952,2350.336;Inherit;False;AffineTM;-1;;17;1253b9ff3f307ed47846b90f0972e7f5;0;1;9;SAMPLER2D;0;False;2;SAMPLER2D;10;FLOAT2;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;133;-3056.941,2476.551;Inherit;False;3;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;98;-2884.948,-266.7325;Inherit;False;3;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TextureCoordinatesNode;58;-3174.4,-668.823;Inherit;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;104;-3083.407,-785.9377;Inherit;False;AffineTM;-1;;18;1253b9ff3f307ed47846b90f0972e7f5;0;1;9;SAMPLER2D;0;False;2;SAMPLER2D;10;FLOAT2;0
Node;AmplifyShaderEditor.WireNode;126;-2007.975,1293.514;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.FunctionNode;105;-2793.956,-383.8473;Inherit;False;AffineTM;-1;;19;1253b9ff3f307ed47846b90f0972e7f5;0;1;9;SAMPLER2D;0;False;2;SAMPLER2D;10;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;111;-2579.713,257.1671;Inherit;False;Property;_AffineTextureMapping;Affine Texture Mapping;9;0;Create;True;0;0;0;False;0;False;1;0;0;True;;Toggle;2;Key0;Key1;Reference;57;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;112;-2230.654,151.8886;Inherit;True;Property;_TextureSample2;Texture Sample 2;9;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.WireNode;127;-1954.975,1305.514;Inherit;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;57;-2883.538,-663.2827;Inherit;False;Property;_AffineTextureMapping;Affine Texture Mapping;9;0;Create;True;0;0;0;False;0;False;1;0;0;True;_affine_tex;Toggle;2;Key0;Key1;Create;False;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.ColorNode;114;-2211.103,371.7734;Inherit;False;Property;_EmissionColor;Emission Color;7;1;[HDR];Create;True;0;0;0;False;0;False;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;128;-2010.645,1401.229;Inherit;False;Property;_Smoothness;Smoothness;3;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;135;-2736.887,2458.099;Inherit;False;Property;_AffineTextureMapping1;Affine Texture Mapping;9;0;Create;True;0;0;0;False;0;False;1;0;0;True;;Toggle;2;Key0;Key1;Reference;57;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.StaticSwitch;99;-2577.894,-277.3839;Inherit;False;Property;_AffineTextureMapping;Affine Texture Mapping;9;0;Create;True;0;0;0;False;0;False;1;0;0;True;;Toggle;2;Key0;Key1;Reference;57;True;True;All;9;1;FLOAT2;0,0;False;0;FLOAT2;0,0;False;2;FLOAT2;0,0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT2;0,0;False;6;FLOAT2;0,0;False;7;FLOAT2;0,0;False;8;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.IntNode;87;-1106.445,719.3546;Inherit;False;Property;_VerticalResolution;Vertical Resolution;12;0;Create;True;0;0;0;False;0;False;240;240;False;0;1;INT;0
Node;AmplifyShaderEditor.RangedFloatNode;123;-1967.975,1090.514;Inherit;False;Property;_Metallic;Metallic;2;0;Create;True;0;0;0;False;0;False;0;0;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;85;-1142.445,599.3546;Inherit;False;Property;_HorizontalResolution;Horizontal Resolution;11;0;Create;True;0;0;0;False;0;False;320;320;False;0;1;INT;0
Node;AmplifyShaderEditor.SamplerNode;136;-2387.828,2352.821;Inherit;True;Property;_TextureSample5;Texture Sample 2;9;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;100;-2258.396,-385.9604;Inherit;True;Property;_TextureSample1;Texture Sample 1;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;True;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;124;-1648.402,1276.892;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;84;-816.4446,604.3546;Inherit;False;2;0;INT;0;False;1;INT;2;False;1;INT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;113;-1739.103,155.7734;Inherit;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;122;-1636.975,1024.514;Inherit;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleDivideOpNode;90;-839.4446,715.3546;Inherit;False;2;0;INT;0;False;1;INT;2;False;1;INT;0
Node;AmplifyShaderEditor.SamplerNode;50;-2547.848,-788.0509;Inherit;True;Property;_TextureSample0;Texture Sample 0;1;0;Create;True;0;0;0;False;0;False;-1;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;8;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;6;FLOAT;0;False;7;SAMPLERSTATE;;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RegisterLocalVarNode;130;-1439.865,1273.012;Inherit;False;Smoothness;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;138;-1934.737,2357.027;Inherit;False;Oclussion;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;129;-1442.623,1017.953;Inherit;False;Metallic;-1;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;95;-2158.779,-786.6695;Inherit;False;Albedo;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;106;-1823.017,-384.8355;Inherit;False;Normal;-1;True;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.PosVertexDataNode;93;-569.6793,758.1081;Inherit;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FunctionNode;88;-594.1214,602.401;Inherit;False;NoFPU;-1;;20;85d694b10abf39c488fd8fa5d47212dd;0;2;81;INT;160;False;82;INT;120;False;1;FLOAT4;0
Node;AmplifyShaderEditor.RegisterLocalVarNode;115;-1518.103,150.7734;Inherit;False;Emission;-1;True;1;0;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;139;-183.7279,83.70685;Inherit;False;138;Oclussion;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;116;-185.0199,-172.3181;Inherit;False;115;Emission;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.GetLocalVarNode;132;-195.1589,-1.932922;Inherit;False;130;Smoothness;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;131;-187.1589,-82.93292;Inherit;False;129;Metallic;1;0;OBJECT;;False;1;FLOAT;0
Node;AmplifyShaderEditor.GetLocalVarNode;107;-200.9654,-385.3942;Inherit;False;106;Normal;1;0;OBJECT;;False;1;FLOAT3;0
Node;AmplifyShaderEditor.GetLocalVarNode;96;-202.6782,-461.8839;Inherit;False;95;Albedo;1;0;OBJECT;;False;1;COLOR;0
Node;AmplifyShaderEditor.IntNode;61;-506.0851,-761.1105;Inherit;False;Property;_ID;_ID;8;0;Create;True;0;0;0;True;0;False;0;0;False;0;1;INT;0
Node;AmplifyShaderEditor.StaticSwitch;94;-264.1794,626.8082;Inherit;False;Property;_NoFPU;No FPU;10;0;Create;True;0;0;0;False;0;False;1;0;0;True;;Toggle;2;Key0;Key1;Create;True;True;All;9;1;FLOAT4;0,0,0,0;False;0;FLOAT4;0,0,0,0;False;2;FLOAT4;0,0,0,0;False;3;FLOAT4;0,0,0,0;False;4;FLOAT4;0,0,0,0;False;5;FLOAT4;0,0,0,0;False;6;FLOAT4;0,0,0,0;False;7;FLOAT4;0,0,0,0;False;8;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;14;174.0837,-217.0332;Float;False;True;-1;6;ASEMaterialInspector;0;0;Standard;NewStandard;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;18;all;True;True;True;True;0;False;-1;True;0;True;61;255;False;-1;255;False;-1;7;False;-1;3;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;0;5.4;1;25.6;False;0;True;0;0;False;-1;0;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;True;Absolute;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;False;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;119;9;117;0
WireConnection;118;2;117;0
WireConnection;120;1;118;0
WireConnection;120;0;119;0
WireConnection;121;0;119;10
WireConnection;121;1;120;0
WireConnection;125;0;121;4
WireConnection;110;9;108;0
WireConnection;109;2;108;0
WireConnection;134;9;137;0
WireConnection;133;2;137;0
WireConnection;98;2;101;0
WireConnection;58;2;47;0
WireConnection;104;9;47;0
WireConnection;126;0;125;0
WireConnection;105;9;101;0
WireConnection;111;1;109;0
WireConnection;111;0;110;0
WireConnection;112;0;110;10
WireConnection;112;1;111;0
WireConnection;127;0;126;0
WireConnection;57;1;58;0
WireConnection;57;0;104;0
WireConnection;135;1;133;0
WireConnection;135;0;134;0
WireConnection;99;1;98;0
WireConnection;99;0;105;0
WireConnection;136;0;134;10
WireConnection;136;1;135;0
WireConnection;100;0;105;10
WireConnection;100;1;99;0
WireConnection;124;0;127;0
WireConnection;124;1;128;0
WireConnection;84;0;85;0
WireConnection;113;0;112;0
WireConnection;113;1;114;0
WireConnection;122;0;121;1
WireConnection;122;1;123;0
WireConnection;90;0;87;0
WireConnection;50;0;104;10
WireConnection;50;1;57;0
WireConnection;130;0;124;0
WireConnection;138;0;136;0
WireConnection;129;0;122;0
WireConnection;95;0;50;0
WireConnection;106;0;100;0
WireConnection;88;81;84;0
WireConnection;88;82;90;0
WireConnection;115;0;113;0
WireConnection;94;1;93;0
WireConnection;94;0;88;0
WireConnection;14;0;96;0
WireConnection;14;1;107;0
WireConnection;14;2;116;0
WireConnection;14;3;131;0
WireConnection;14;4;132;0
WireConnection;14;5;139;0
WireConnection;14;11;94;0
ASEEND*/
//CHKSM=834F3AEBE84FC8B92409984689B828223119BD35