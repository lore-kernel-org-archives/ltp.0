From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Jun 2016 10:56:08 +0200
Subject: [LTP] [lkp] [signal]  98ea270c46: ltp.float_exp_log.fail
In-Reply-To: <20160628030304.GJ19084@yexl-desktop>
References: <20160628030304.GJ19084@yexl-desktop>
Message-ID: <20160628085608.GA31668@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> <<<test_start>>>
> tag=float_bessel stime=1466890256
> cmdline="cd $LTPROOT/testcases/bin; float_bessel -v"
> contacts=""
> analysis=exit
> <<<test_output>>>
> float_bessel    1  TPASS  :  Test passed
> float_bessel    0  TINFO  :  float_bessel: will run for 500 loops; using . as a data directory
> float_bessel    0  TINFO  :  float_bessel: will run 5 functions, 20 threads per function
> float_bessel    0  TINFO  :  signal handler 140339933017856 started
> float_bessel    0  TINFO  :  Signal handler starts waiting...
> float_bessel    0  TINFO  :  Signal handler caught signal 0
> float_bessel    1  TFAIL  :  main.c:41: Test failed

Looking at the test it creates a separate thread to handle signals which
sleeps in sigwait() which is implemented in glibc via the sigtimedwait
syscall with NULL timeout.

Looking at the patch the ktime_t timeout is initialized to 0 instead of
MAX_SCHEDULE_TIMEOUT now so I guess that the call with NULL timeout does
poll instead of sleeping in kernel waiting for signals to arrive. That
should be fixed.

-- 
Cyril Hrubis
