using System.Collections;
using System.Collections.Generic;
using UnityEngine.Rendering;
using UnityEngine;

public class MultiplePasses : MonoBehaviour
{

    [SerializeField]
    private Shader _PostFX;

    [SerializeField]
    private Color[] Color = new Color[16];
    [SerializeField]
    public float Intensity = 2f;
    [SerializeField]
    public bool SimpleColor = false;

    Material[] material = new Material[16];
    

    private void Awake()
    {
        Init();
    }

    private void Update()
    {

        for(int i = 0; i < Color.Length; i++)
        {
            material[i].SetColor("_Color", Color[i]);
            material[i].SetFloat("_Intensity", Intensity);

            if (SimpleColor)
            {
                material[i].SetFloat("_OnlyColor", 1);
            }
            else
            {
                material[i].SetFloat("_OnlyColor", 0);
            }
        }

    }

    private void Init()
    {

        for (int i=0; i<Color.Length; i++)
        {
            var camera = GetComponent<Camera>();
            material[i] = new Material(_PostFX);
            material[i].SetInteger("_ID", i + 1);

            var commandBuffer = new CommandBuffer();
            commandBuffer.name = ("Remark Color" + i);

            int tempTextureIdentifier = Shader.PropertyToID("_MaskOBJ");
            commandBuffer.GetTemporaryRT(tempTextureIdentifier, -1, -1);
            commandBuffer.Blit(BuiltinRenderTextureType.CameraTarget, tempTextureIdentifier);

            commandBuffer.Blit(tempTextureIdentifier, BuiltinRenderTextureType.CameraTarget, material[i]);
            commandBuffer.ReleaseTemporaryRT(tempTextureIdentifier);
            camera.AddCommandBuffer(CameraEvent.BeforeImageEffectsOpaque, commandBuffer);

        }




    }




}
