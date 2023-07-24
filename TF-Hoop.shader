Shader "CocoaMilka/TF-Hoop"
{
    Properties
    {
        _Color ("Color", Color) = (1, 1, 1, 1)
        _MainTex ("Main Texture", 2D) = "white" {}
        _HoopLoc ("Hoop Transform", Vector) = (0, 0, 0, 0)
        _HoopRadius ("Hoop Radius", Float) = 0

        _StretchDist ("Stretchiness", Range(0.0, 5.0)) = 1.0
    }

    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vertexFunction
            #pragma fragment fragmentFunction
            #include "UnityCG.cginc"

            // Variables
            float4 _Color;
            sampler2D _MainTex;

            // Structs for passing data

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float4 position : SV_POSITION;
                float2 uv : TEXCOORD0;
            };



            // Functions

            v2f vertexFunction (appdata IN)
            {
                v2f OUT;

                // Converts from local object space to camera's clip space
                OUT.position = UnityObjectToClipPos(IN.vertex);
                OUT.uv = IN.uv;

                return OUT;
            }

            fixed4 fragmentFunction (v2f IN) : SV_TARGET
            {
                return tex2D(_MainTex, IN.uv);
                //return _Color;
            }


            ENDCG
        }
    }
}
