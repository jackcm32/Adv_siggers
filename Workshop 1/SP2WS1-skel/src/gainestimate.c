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
//    gainestimateLMS(in1, in2, out, gain);
     gainestimateRLS(in1, in2, out, gain);
}

void gainestimateLMS(float in1, float in2, float out, float gain[2])
{
    // TODO: Implement gain estimation using LMS algorithm
    static float theta_hat1 = 0, theta_hat2 = 1.0;

    float mu = 1E-20;

    float err = out - (in1 * theta_hat1 + in2 * theta_hat2);

    theta_hat1 = theta_hat1 + (mu * in1) * err;
    theta_hat2 = theta_hat2 + (mu * in2) * err;

    gain[0] = theta_hat1;
    gain[1] = theta_hat2;

}

void gainestimateRLS(float in1, float in2, float out, float gain[2])
{
    // TODO: Implement gain estimation using RLS algorithm
    static float theta_hat1 = 0, theta_hat2 = 1.0, p11 = 1E-25, p12 = 0, p21 = 0, p22 = 1E-25;  // p11 = p22 = 1 for identity

    float lambda = 0.9999;

    float err = out - (in1 * theta_hat1 + in2 * theta_hat2);


    float p11_in1 = p11 * in1;
    float p11_in2 = p11 * in2;
    float p12_in1 = p12 * in1;
    float p12_in2 = p12 * in2;
    float p21_in1 = p21 * in1;
    float p21_in2 = p21 * in2;
    float p22_in1 = p22 * in1;
    float p22_in2 = p22 * in2;

    float inv_lambda = 1.0 / lambda;

    float denom = (lambda + in1 * (p11_in1 + p21_in2) + in2 * (p12_in1 + p22_in2));

    float p11_new = inv_lambda * (p11 - (p11_in1 * (p11_in1 + p12_in2) + p21_in2 * (p11_in1 + p12_in2)) / denom);
    float p12_new = inv_lambda * (p12 - (p12_in1 * (p11_in1 + p12_in2) + p22_in2 * (p11_in1 + p12_in2)) / denom);
    float p21_new = inv_lambda * (p21 - (p11_in1 * (p21_in1 + p22_in2) + p21_in2 * (p21_in1 + p22_in2)) / denom);
    float p22_new = inv_lambda * (p22 - (p12_in1 * (p21_in1 + p22_in2) + p22_in2 * (p21_in1 + p22_in2)) / denom);


    p11 = p11_new;
    p12 = p12_new;
    p21 = p21_new;
    p22 = p22_new;

    theta_hat1 = theta_hat1 + ((p11 * in1) + (p12 * in2)) * err;
    theta_hat2 = theta_hat2 + ((p21 * in1) + (p22 * in2)) * err;

    gain[0] = theta_hat1;
    gain[1] = theta_hat2;
    // then save p values for next round

}
