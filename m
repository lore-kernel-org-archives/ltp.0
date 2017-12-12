From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 12 Dec 2017 09:48:08 -0500 (EST)
Subject: [LTP] [PATCH V3] ltp: Add a zero latency constraint for the
 timer tests library
In-Reply-To: <20170818122533.GD22319@rei.lan>
References: <20170817135029.GA31322@rei>
 <1502982026-4113-1-git-send-email-daniel.lezcano@linaro.org>
 <20170818122533.GD22319@rei.lan>
Message-ID: <1864131650.54048676.1513090088938.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I'm running into similar problem on "Dell Precision 5820 tower", with
Intel(R) Xeon(R) W-2133 CPU @ 3.60GHz, but I can't find any /proc /sys
knob that would help.

# uname -r
4.14.5

# cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
performance
performance
performance
performance
performance
performance
performance
performance
performance
performance
performance
performance

Any timer related tests are reliably failing on longer timeouts:
---
tst_test.c:934: INFO: Timeout per run is 0h 05m 00s
tst_timer_test.c:356: INFO: CLOCK_MONOTONIC resolution 1ns
tst_timer_test.c:368: INFO: prctl(PR_GET_TIMERSLACK) = 50us
tst_timer_test.c:275: INFO: poll() sleeping for 1000us 500 iterations, threshold 450.01us
tst_timer_test.c:318: INFO: min 1095us, max 1098us, median 1096us, trunc mean 1095.99us (discarded 25)
tst_timer_test.c:333: PASS: Measured times are within thresholds
tst_timer_test.c:275: INFO: poll() sleeping for 2000us 500 iterations, threshold 450.01us
tst_timer_test.c:318: INFO: min 2062us, max 2138us, median 2137us, trunc mean 2135.98us (discarded 25)
tst_timer_test.c:333: PASS: Measured times are within thresholds
tst_timer_test.c:275: INFO: poll() sleeping for 5000us 300 iterations, threshold 450.04us
tst_timer_test.c:318: INFO: min 5262us, max 5263us, median 5262us, trunc mean 5262.20us (discarded 15)
tst_timer_test.c:333: PASS: Measured times are within thresholds
tst_timer_test.c:275: INFO: poll() sleeping for 10000us 100 iterations, threshold 450.33us
tst_timer_test.c:318: INFO: min 10318us, max 10471us, median 10471us, trunc mean 10469.07us (discarded 5)
tst_timer_test.c:321: FAIL: poll() slept for too long

 Time: us | Frequency
--------------------------------------------------------------------------------
    10318 | +
    10327 | 
    10336 | 
    10345 | 
    10354 | 
    10363 | 
    10372 | 
    10381 | 
    10390 | 
    10399 | 
    10408 | 
    10417 | 
    10426 | 
    10435 | +
    10444 | 
    10453 | 
    10462 | 
    10471 | ********************************************************************
--------------------------------------------------------------------------------
      9us | 1 sample = 0.69388 '*', 1.38776 '+', 2.77551 '-', non-zero '.'

tst_timer_test.c:275: INFO: poll() sleeping for 25000us 50 iterations, threshold 451.29us
tst_timer_test.c:318: INFO: min 26096us, max 26097us, median 26096us, trunc mean 26096.00us (discarded 2)
tst_timer_test.c:321: FAIL: poll() slept for too long

 Time: us | Frequency
--------------------------------------------------------------------------------
    26096 | ********************************************************************
    26097 | *-
--------------------------------------------------------------------------------
      1us | 1 sample = 1.38776 '*', 2.77551 '+', 5.55102 '-', non-zero '.'

tst_timer_test.c:275: INFO: poll() sleeping for 100000us 10 iterations, threshold 537.00us
tst_timer_test.c:318: INFO: min 104273us, max 104274us, median 104274us, trunc mean 104273.67us (discarded 1)
tst_timer_test.c:321: FAIL: poll() slept for too long

 Time: us | Frequency
--------------------------------------------------------------------------------
   104273 | *****************************
   104274 | ********************************************************************
--------------------------------------------------------------------------------
      1us | 1 sample = 9.71429 '*', 19.42857 '+', 38.85714 '-', non-zero '.'

tst_timer_test.c:275: INFO: poll() sleeping for 1000000us 2 iterations, threshold 4400.00us
tst_timer_test.c:318: INFO: min 1007717us, max 1011050us, median 1007717us, trunc mean 1007717.00us (discarded 1)
tst_timer_test.c:321: FAIL: poll() slept for too long

 Time: us | Frequency
--------------------------------------------------------------------------------
  1007717 | ********************************************************************
  1007893 | 
  1008069 | 
  1008245 | 
  1008421 | 
  1008597 | 
  1008773 | 
  1008949 | 
  1009125 | 
  1009301 | 
  1009477 | 
  1009653 | 
  1009829 | 
  1010005 | 
  1010181 | 
  1010357 | 
  1010533 | 
  1010709 | 
  1010885 | ********************************************************************
--------------------------------------------------------------------------------
    176us | 1 sample = 68.00000 '*', 136.00000 '+', 272.00000 '-', non-zero '.'
---

SCHED_OTHER or SCHED_FIFO -> FAIL
intel_idle.max_cstate=0 processor.max_cstate=1 -> FAIL
echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo -> FAIL
idle=halt -> FAIL
idle=poll -> FAIL

Only thing I found to help is to keep CPU slightly busy with
  taskset -c 1 sh -c "while [ True ]; do usleep 100; done"

After that it started to PASS:

# taskset -c 1 ./poll02
tst_test.c:934: INFO: Timeout per run is 0h 05m 00s
tst_timer_test.c:356: INFO: CLOCK_MONOTONIC resolution 1ns
tst_timer_test.c:368: INFO: prctl(PR_GET_TIMERSLACK) = 50us
tst_timer_test.c:275: INFO: poll() sleeping for 1000us 500 iterations, threshold 450.01us
tst_timer_test.c:318: INFO: min 1004us, max 1325us, median 1072us, trunc mean 1149.29us (discarded 25)
tst_timer_test.c:333: PASS: Measured times are within thresholds
tst_timer_test.c:275: INFO: poll() sleeping for 2000us 500 iterations, threshold 450.01us
tst_timer_test.c:318: INFO: min 2007us, max 2326us, median 2075us, trunc mean 2158.64us (discarded 25)
tst_timer_test.c:333: PASS: Measured times are within thresholds
tst_timer_test.c:275: INFO: poll() sleeping for 5000us 300 iterations, threshold 450.04us
tst_timer_test.c:318: INFO: min 5006us, max 5345us, median 5074us, trunc mean 5146.84us (discarded 15)
tst_timer_test.c:333: PASS: Measured times are within thresholds
tst_timer_test.c:275: INFO: poll() sleeping for 10000us 100 iterations, threshold 450.33us
tst_timer_test.c:318: INFO: min 10004us, max 10364us, median 10075us, trunc mean 10128.61us (discarded 5)
tst_timer_test.c:333: PASS: Measured times are within thresholds
tst_timer_test.c:275: INFO: poll() sleeping for 25000us 50 iterations, threshold 451.29us
tst_timer_test.c:318: INFO: min 25006us, max 25359us, median 25072us, trunc mean 25137.48us (discarded 2)
tst_timer_test.c:333: PASS: Measured times are within thresholds
tst_timer_test.c:275: INFO: poll() sleeping for 100000us 10 iterations, threshold 537.00us
tst_timer_test.c:318: INFO: min 100010us, max 100372us, median 100125us, trunc mean 100167.78us (discarded 1)
tst_timer_test.c:333: PASS: Measured times are within thresholds
tst_timer_test.c:275: INFO: poll() sleeping for 1000000us 2 iterations, threshold 4400.00us
tst_timer_test.c:318: INFO: min 1000843us, max 1000920us, median 1000843us, trunc mean 1000843.00us (discarded 1)
tst_timer_test.c:333: PASS: Measured times are within thresholds

Summary:
passed   7
failed   0
skipped  0
warnings 0

Any ideas?

Regards,
Jan
