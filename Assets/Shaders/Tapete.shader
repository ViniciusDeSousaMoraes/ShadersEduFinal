Shader "Custom/Tapete"
{
     Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _Shininess ("Shininess", Range(0.1, 1)) = 0.5
        _Roughness ("Roughness", Range(0, 1)) = 0.5
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Standard

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_NormalMap;
        };

        sampler2D _MainTex;
        fixed4 _Color;
        sampler2D _NormalMap;
        float _Shininess;
        float _Roughness;

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 texColor = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = texColor.rgb;
            o.Alpha = texColor.a;

            o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));

            o.Smoothness = _Roughness;
           
        }
        ENDCG
    }

    FallBack "Diffuse"
}