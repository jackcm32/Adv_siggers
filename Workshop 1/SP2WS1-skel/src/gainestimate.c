#include "SP2WS1.h"


// input signal history
float insignal1[100], insignal2[100];


// function prototypes
void gainestimateLMS(float,float,float,float[2]);
void gainestimateRLS(float,float,float,float[2]);


void gainestimate(float in1, float in2, float out, float gain[2])
{
    // record input signal history for checking signal magnitude using plot facility
    for (int i = 99; i > 0; i--)
    {
        insignal1[i] = insignal1[i-1];
        insignal2[i] = insignal2[i-1];
    }
    insignal1[0] = in1;
    insignal2[0] = in2;


    // estimate gain
    gain[0] = 0;
    gain[1] = 1;
    //gainestimateLMS(in1, in2, out, gain);
    //gainestimateRLS(in1, in2, out, gain);
}

void gainestimateLMS(float in1, float in2, float out, float gain[2])
{
    // TODO: Implement gain estimation using LMS algorithm
}

void gainestimateRLS(float in1, float in2, float out, float gain[2])
{
	// TODO: Implement gain estimation using RLS algorithm
}
