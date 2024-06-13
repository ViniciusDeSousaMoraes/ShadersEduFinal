Shader "Custom/Madeira"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _WoodColor ("Wood Color", Color) = (1,1,1,1)
        _BumpMap ("Bump Map", 2D) = "bump" {}
        _SpecularMap ("Specular Map", 2D) = "white" {}
        _Shininess ("Shininess", Range(0.1, 1)) = 0.7
    }

    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        #pragma surface surf Lambert

        struct Input
        {
            float2 uv_MainTex;
            float2 uv_BumpMap;
            float2 uv_SpecularMap;
        };

        sampler2D _MainTex;
        sampler2D _BumpMap;
        sampler2D _SpecularMap;
        fixed4 _WoodColor;
        float _Shininess;

        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 texColor = tex2D(_MainTex, IN.uv_MainTex) * _WoodColor;
            o.Albedo = texColor.rgb;
            o.Alpha = texColor.a;

            o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));

            fixed4 specColor = tex2D(_SpecularMap, IN.uv_SpecularMap);
            o.Specular = specColor.rgb;
            o.Gloss = _Shininess;
        }
        ENDCG
    }

    FallBack "Diffuse"
}
﻿
