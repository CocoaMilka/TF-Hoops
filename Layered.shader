Shader "CocoaMilka/Layered"
{
    Properties
    {
        _MainColor ("Main Color", Color) = (1,1,1,1)
        _MainTex ("Texture", 2D) = "white" {}
        _CircleColor("Circle Color", Color) = (1, 0, 0)
        _Center("Center", Vector) = (0, 0, 0, 0)
        _CircleSize("Circle Size", Range(0, 100)) = 10
    }

    SubShader
    {
        Tags 
        {
            "Queue" = "Transparent" 
            "IgnoreProjector" = "True"
            "RenderType" = "Transparent"
        }
        LOD 200

        Cull Off
        Lighting Off
        ZWrite Off
        Fog { Mode Off }
        ColorMask RGB
        Blend SrcAlpha OneMinusSrcAlpha

        // Draw circle

        CGPROGRAM
        #pragma surface surfaceFunction Lambert
        #include "UnityCG.cginc"

        sampler2D _MainTex;
        fixed3 _MainColor;
        fixed3 _CircleColor;
        float _CircleSize;
        float3 _Center;

        struct Input
        {
            float2 uv_MainTex;
            float3 worldPos;
        };

        void surfaceFunction(Input IN, inout SurfaceOutput o)
        {
            half4 c = tex2D(_MainTex, IN.uv_MainTex);

            // Find distance of pixel from center coordinate variable
            float dist = distance(_Center, IN.worldPos);

            if (dist < _CircleSize)
            {
                o.Albedo = _CircleColor;
            }
            else
            {
                o.Albedo = (tex2D(_MainTex, IN.uv_MainTex) * _MainColor).rgb;
            }
            o.Alpha = c.a;
        }

        ENDCG



        
    }
    FallBack "Diffuse"
}
