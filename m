From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Feb 2018 21:24:36 +0100
Subject: [LTP] LTP: perf_event_open02 failed intermittently
In-Reply-To: <CA+G9fYubpRaR_Q04o_9Nh=HTxHWEqHaifQF5Cg+HU_G83cTdEw@mail.gmail.com>
References: <CA+G9fYubpRaR_Q04o_9Nh=HTxHWEqHaifQF5Cg+HU_G83cTdEw@mail.gmail.com>
Message-ID: <20180207202436.GA19939@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> perf_event_open02 is an intermittent failures on linux-mainline on
> Juno, x15 and x86_64 and this failure is not specific to any kernel
> version. We have seen this failures on 4.14, 4.9 and 4.4 kernel.
> 
> History of test,
> https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-syscalls-tests/perf_event_open02
> 
> Test log on x86_64
> ------------------
> perf_event_open02    0  TINFO  :  overall task clock: 30671523
> perf_event_open02    0  TINFO  :  hw sum: 2709582012, task clock sum: 276075072
> perf_event_open02    0  TINFO  :  ratio: 9.001023
> perf_event_open02    1  TFAIL  :  perf_event_open02.c:333: test failed
> (ratio was greater than )
> 
> LAVA job id:
> https://lkft.validation.linaro.org/scheduler/job/111546#L11603
> 
> Test log on Juno
> ----------------
> perf_event_open02    0  TINFO  :  overall task clock: 189268240
> perf_event_open02    0  TINFO  :  hw sum: 573229827, task clock sum: 407820520
> perf_event_open02    0  TINFO  :  ratio: 2.154722
> perf_event_open02    1  TFAIL  :  perf_event_open02.c:333: test failed
> (ratio was greater than )
> 
> LTP full log on arm64 Juno,
> 
> https://lkft.validation.linaro.org/scheduler/job/112567#L11871
> 
> Please refer open bug on bugzilla,
> https://bugs.linaro.org/show_bug.cgi?id=3382
> 
> Have you seen this intermittent failure before ?

I've seen it to fail on x86_64 as well, it's more likely to happen under
heavy CPU load, which hints to preemption which may introduce roundring
errors. We do have SUSE internal bug open for the testcase as well, and
given that the bug was ignored for more than year by our kernel devs we
may as well disable the testcase from the default run.

And also for me running the test realtime priority seem to fix the
problem.

-- 
Cyril Hrubis
chrubis@suse.cz
