Shader "ImageFX/Desaturate"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Saturation("Saturation", Range(0.0,1.0)) = 1
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Stencil
        {
            Ref 1
            Comp Greater
        }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"



            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            sampler2D _MainTex;
            float _Saturation;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                
                float luma = dot(col, float3(0.2126729, 0.7151522, 0.0721750));
                fixed4 outcol = luma.xxxx + _Saturation.xxxx * (col - luma.xxxx);

                return outcol;
            }
            ENDCG
        }

       


    }
}
