using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ButtonTrigger : MonoBehaviour {

    [SerializeField]
    private Transform boxPrefab;
    [SerializeField]
    private Transform spawnPoint;

    // Use this for initialization
    void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}

    void OnTriggerEnter(Collider other)
    {
        if (other.tag == "Button")
        {
            Transform t = Instantiate(boxPrefab);

            t.position = spawnPoint.position;
        }
    }
}
