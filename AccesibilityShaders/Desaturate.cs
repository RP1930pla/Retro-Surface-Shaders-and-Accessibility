using System.Collections;
using System.Collections.Generic;
using UnityEngine.Rendering;
using UnityEngine;

public class Desaturate : MonoBehaviour
{

    [SerializeField]
    private Shader _Background;

    [Range(0.0f, 1.0f)]
    public float Saturation = 0.5f;


    private Material Mat;

    private void Awake()
    {
        InitBG();

        
    }



    private void Update()
    {
        Mat.SetFloat("_Saturation", Saturation);
    }



    private void InitBG()
    {
        var camera = GetComponent<Camera>();
        Mat = new Material(_Background);
        //Mat.SetFloat("_Saturation", 0.2f);

        var commandBuffer = new CommandBuffer();
        commandBuffer.name = "Desaturate BG";

        int tempTextureIdentifier = Shader.PropertyToID("_MaskBG");
        commandBuffer.GetTemporaryRT(tempTextureIdentifier, -1, -1);
        commandBuffer.Blit(BuiltinRenderTextureType.CameraTarget, tempTextureIdentifier);

        commandBuffer.Blit(tempTextureIdentifier, BuiltinRenderTextureType.CameraTarget, Mat);
        commandBuffer.ReleaseTemporaryRT(tempTextureIdentifier);
        camera.AddCommandBuffer(CameraEvent.BeforeImageEffectsOpaque, commandBuffer);
    }



}
