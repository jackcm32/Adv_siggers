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
    gainestimateLMS(in1, in2, out, gain);
    // gainestimateRLS(in1, in2, out, gain);
}

void gainestimateLMS(float in1, float in2, float out, float gain[2])
{
    // TODO: Implement gain estimation using LMS algorithm
    static float theta_hat1 = 0, theta_hat2 = 1.0;

    float mu = 1E-18;

    float err = out - (in1 * theta_hat1 + in2 * theta_hat2);

    theta_hat1 = theta_hat1 + (mu * in1) * err;
    theta_hat2 = theta_hat2 + (mu * in2) * err;

    gain[0] = theta_hat1;
    gain[1] = theta_hat2;

}

void gainestimateRLS(float in1, float in2, float out, float gain[2])
{
    // TODO: Implement gain estimation using RLS algorithm
}
