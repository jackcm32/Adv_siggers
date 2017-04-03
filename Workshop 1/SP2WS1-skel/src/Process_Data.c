#include "SP2WS1.h"
#include "math.h"
#include "string.h"
#include "stdlib.h"

#define alpha            1.0

#define SWITCH_PERIOD    10
#define HIST_LENGTH      1000
#define HIST_DOWNSAMPLE  480    // SAMPLE_RATE * SWITCH_PERIOD / HIST_LENGTH

float x = 0.1, y = 0.9;              // true parameters
float theta[2] = { 0.0, 0.0 };       // parameter estimates

// gain estimate history of just past period for plotting
float theta1_history[HIST_LENGTH] = { 0.0 };
float theta2_history[HIST_LENGTH] = { 0.0 };

void Process_Data(void)
{
    // local static variables for remembering gain estimate history
    static int h = 0;
    static float theta1_history_current[HIST_LENGTH] = { 0.0 };
    static float theta2_history_current[HIST_LENGTH] = { 0.0 };
    
    // change gain every 10 seconds
    static int mode = 0;
    static int i = 0;
    i++;
    if (i > SWITCH_PERIOD * SAMPLE_RATE)
    {
        if (mode == 1)
        {
            mode = 0;
            x = 0.1;
            y = 0.9;
        }
        else
        {
            mode = 1;
            x = 0.9;
            y = 0.1;
        }
        i = 0;

        // copy past period history to the global variable for plotting
        memcpy(theta1_history, theta1_history_current, sizeof(float) * HIST_LENGTH);
        memcpy(theta2_history, theta2_history_current, sizeof(float) * HIST_LENGTH);

        // reset history for new period
        memset(theta1_history_current, 0, sizeof(float) * HIST_LENGTH);
        memset(theta2_history_current, 0, sizeof(float) * HIST_LENGTH);
        h = 0;
    }
    led(2, mode == 0);
    led(3, mode == 1);


    // convert integers to float
    float tl0in, tl1in, tr0in, tr1in;
    tl0in = (float)iChannel0LeftIn;
    tl1in = (float)iChannel1LeftIn;
    tr0in = (float)iChannel0RightIn;
    tr1in = (float)iChannel1RightIn;

    // model signals
    float cleftout, crightout;
    cleftout  = y * tl0in + x * tl1in;
    crightout = y * tr0in + x * tr1in;
    

    // estimate gains based on left channel
    gainestimate(tl0in, tl1in, cleftout, theta);


    // remember estimate history
    if ((i % HIST_DOWNSAMPLE) == 0)
    {
        theta1_history_current[h] = theta[0];
        theta2_history_current[h] = theta[1];
        h++;
    }
    

    // generate output signals
    iChannel0LeftOut  = (int)((1.0 - fabs(y - theta[0])) * tl0in + alpha * fabs(x - theta[1]) * tl1in);
    iChannel0RightOut = (int)((1.0 - fabs(y - theta[0])) * tr0in + alpha * fabs(x - theta[1]) * tr1in);
    
    
    // set running indicator led
    static int cycle_time = 0;
    static int toggle_time = 0;

    cycle_time = (cycle_time + 1) % SAMPLE_RATE;
    if (cycle_time == 0)
    {
        toggle_time = !toggle_time;
    }
    led(0, toggle_time == 0);
    led(1, toggle_time == 1);
}
