using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class EyeLook : MonoBehaviour
{
    public GameObject location;
    Material _Shader;

    // Start is called before the first frame update
    void Start()
    {
        _Shader = GetComponent<Renderer>().material;
    }

    // Update is called once per frame
    void Update()
    {
        Vector3 pos = location.transform.position;
        _Shader.SetVector("_Center", pos);

        Debug.Log(string.Format("X: {0} Y: {1}", pos.x, pos.y));
    }
}
