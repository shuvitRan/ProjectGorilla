using UnityEngine;
using UnityEngine.UI;
using System;
using System.Collections;
using System.IO.Ports;
using System.Threading;

public class SerialTest : MonoBehaviour
{

    private SerialPort serialPort = null;
    private String portName = "/dev/tty.usbmodem145101"; //tty.usbmodem145101 // use the port name for your Arduino, such as /dev/tty.usbmodem1411  ,, COM15 for Mac or COM3 for PC 
    private int baudRate = 115200;  // match your rate from your serial in Arduino
    private int readTimeOut = 100;

    private string serialInput;

    bool programActive = true;
    Thread thread;


    public Vector3 preRotation;
    public Vector3 newRotation;
    public Transform thisobj;



    private void CheckPort()
    {
        int i = 0;
        string[] ports = SerialPort.GetPortNames();
        Debug.Log("The following serial ports were found:");
        foreach (string port in ports)
        {
            Debug.Log(i + ":" + port);
            i++;
        }

        //Console.ReadLine();
    }



    void Start()
    {
        //CheckPort();

        try
        {
            serialPort = new SerialPort();
            serialPort.PortName = portName;
            serialPort.BaudRate = baudRate;
            serialPort.ReadTimeout = readTimeOut;
            serialPort.Open();
        }
        catch (Exception e)
        {
            Debug.Log(e.Message);
        }
        thread = new Thread(new ThreadStart(ProcessData));  // serial events are now handled in a separate thread
        thread.Start();
    }

    void ProcessData()
    {
        Debug.Log("Thread: Start");
        while (programActive)
        {
            try
            {
                serialInput = serialPort.ReadLine();

            }
            catch (TimeoutException)
            {

            }
        }
        Debug.Log("Thread: Stop");
    }

    int number;
    bool startRead = false;

    void Update()
    {
        //serialInput = serialPort.ReadLine();

        if (serialInput != null)
        {
            Debug.Log(serialInput);

            if ( serialInput == "Send any character to begin DMP programming and demo: \r" && !startRead)
            {
                //Timeout(500);
                serialPort.Write("1");
                startRead = true;

            }

            String[] strEul = serialInput.Split(',');  // parses using semicolon ; into a string array called strEul. I originally was sending Euler angles for gyroscopes


            Debug.Log(strEul.Length);
            //Debug.Log(strEul[2]);
            //Debug.Log(typeof(strEul[1]));
            //if (strEul.Length > 1) // only uses the parsed data if every input expected has been received. In this case, three inputs consisting of a button (0 or 1) and two analog values between 0 and 1023
            //{
            //    if (int.Parse(strEul[0]) != 0) // if button not pressed
            //    {
            //        this.GetComponent<MeshRenderer>().enabled = true; //show the gameobject 

            //    }
            //    else
            //    {
            //        this.GetComponent<MeshRenderer>().enabled = false; // hide the gameobject

            //    }
            //    //this.transform.position = new Vector3(float.Parse(strEul[1]) / 100.0f, float.Parse(strEul[2]) / 100.0f, this.transform.position.z); // reposition gameobject based on the two analog values for X and Y of position
            //    //this.transform.rotation = new Vector3(float.Parse(strEul[1]) / 100.0f, float.Parse(strEul[2]) / 100.0f, this.transform.position.z); // reposition gameobject based on the two analog values for X and Y of position
            if (startRead == true && strEul.Length>2)
            {
                float x = Convert.ToSingle(strEul[1]);
                float y = Convert.ToSingle(strEul[0]);
                float z = Convert.ToSingle(strEul[2]);

                //preRotation = thisobj.eulerAngles;
                //thisobj.eulerAngles=new Vector3 (x > 0 ? x : x + 360, x > 0 ? y : y + 360, z > 0 ? z : z + 360);

                //differentX =
                //this.transform.rotation = Quaternion.Euler(x > 0 ? x : x + 360, y > 0 ? y : y + 360, z > 0 ? z : z + 360);
                this.transform.rotation = Quaternion.Euler(x > 0 ? x : x + 360, y > 0 ? y : y + 360, z > 0 ? z : z + 360);
            }
            //}
        }
    }

    public void OnDisable()  // attempts to closes serial port when the gameobject script is on goes away
    {
        programActive = false;
        if (serialPort != null && serialPort.IsOpen)
            serialPort.Close();
    }
}