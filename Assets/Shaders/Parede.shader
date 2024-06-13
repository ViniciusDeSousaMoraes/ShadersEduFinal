Shader "Custom/Parede"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _NormalMap ("Normal Map", 2D) = "bump" {}
        _SpecularMap ("Specular Map", 2D) = "white" {}
        _Shininess ("Shininess", Range(0.1, 1)) = 0.5
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
            float2 uv_SpecularMap;
        };

        sampler2D _MainTex;
        sampler2D _NormalMap;
        sampler2D _SpecularMap;
        float _Shininess;

        void surf(Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 texColor = tex2D(_MainTex, IN.uv_MainTex);
            o.Albedo = texColor.rgb;
            o.Alpha = texColor.a;

            o.Normal = UnpackNormal(tex2D(_NormalMap, IN.uv_NormalMap));

            fixed4 specColor = tex2D(_SpecularMap, IN.uv_SpecularMap);
            o.Smoothness = _Shininess;
        }
        ENDCG
    }

    FallBack "Diffuse"
}
