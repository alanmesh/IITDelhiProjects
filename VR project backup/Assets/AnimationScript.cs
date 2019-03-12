using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimationScript : MonoBehaviour {

    // Use this for initialization
    Animator anim;
    void Start()
    {
        anim = GetComponentInChildren<Animator>();
        anim.SetBool("running", true);
        anim.ResetTrigger("TurnLeft");
        anim.ResetTrigger("TurnRight");
    }

    // Update is called once per frame
    void Update () {
		
	}
    public void TurnLeft()
    {
        anim.SetBool("running", false);
        anim.SetTrigger("TurnLeft");
        anim.SetBool("running", true);
    }
    public void TurnRight()
    {
        anim.SetBool("running", false);
        anim.SetTrigger("TurnRight");
        anim.SetBool("running", true);
    }
}
