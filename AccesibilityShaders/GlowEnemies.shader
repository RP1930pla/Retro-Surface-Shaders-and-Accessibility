Shader "Hidden/GlowEnemies"
{
    Properties
    {
        _MainTex("Texture", 2D) = "white" {}
        _Color("Main Color", Color) = (1,1,1,1)
        _OnlyColor("0 - 1, addition of color - just plain color", Float) = 0
        _Intensity("Intensity", Float) = 6
        _ID("ID of the Stencil Buffer", Integer) = 1
    }
        SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always

        Stencil
        {
            Ref [_ID]
            Comp Equal
        }

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag



            fixed4 _Color;
            float _Intensity;
            float _OnlyColor;

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


            fixed4 frag(v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex,i.uv);
                //fixed4 color = (1,0.2,0.4,1);
                return lerp(col + (_Color*_Intensity),(_Color*_Intensity),_OnlyColor);

            }
            ENDCG
        }
    }
}
