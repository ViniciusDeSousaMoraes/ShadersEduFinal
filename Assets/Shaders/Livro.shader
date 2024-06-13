Shader "Custom/Livro"
{
     Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _Color ("Color", Color) = (1,1,1,1)
        _SpecularMap ("Specular Map", 2D) = "white" {}
        _Shininess ("Shininess", Range(0.1, 1)) = 0.5
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
            float2 uv_SpecularMap;
        };

        sampler2D _MainTex;
        fixed4 _Color;
        sampler2D _SpecularMap;
        float _Shininess;

        void surf(Input IN, inout SurfaceOutput o)
        {
            fixed4 texColor = tex2D(_MainTex, IN.uv_MainTex) * _Color;
            o.Albedo = texColor.rgb;
            o.Alpha = texColor.a;

            fixed4 specColor = tex2D(_SpecularMap, IN.uv_SpecularMap);
            o.Specular = specColor.rgb;
            o.Gloss = _Shininess;
        }
        ENDCG
    }

    FallBack "Diffuse"
}