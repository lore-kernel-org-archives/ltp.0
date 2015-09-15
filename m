From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Sep 2015 10:37:29 +0200
Subject: [LTP] LTP and commit e1d7ba8735551ed7 ("time: Always make sure
 wall_to_monotonic isn't positive")
In-Reply-To: <20150914134603.GD7002@leverpostej>
References: <20150914134603.GD7002@leverpostej>
Message-ID: <20150915083729.GA3860@rei.nue.novell.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> While testing v4.3-rc1 with the LTP, we spotted failures in a couple of
> timekeeping tests, which seem to be a result of commit e1d7ba8735551ed7
> ("time: Always make sure wall_to_monotonic isn't positive").
> 
> In both cases this is because the new time would be before the boot
> time, so I guess these are covered by the caveat at the end of the
> commit message.
> 
> settimeofday01 [1] tries tries to settimeofday() with a timeval 100s and
> 100ns, while clock_gettime02 [2] tries to clock_settime to 1s and
> 100ns. Neither expect -EINVAL, and report failure with the new
> behaviour.
> 
> While I don't know that any "real" software is affected, I thought I
> should let you know.

Thanks for the report, we allready have patch for the first testcase on
the mailing list that initializes the the timeval value to current time
+ small amount. I will have a look at the second test as well.

> [1] https://github.com/linux-test-project/ltp/blob/20150903/testcases/kernel/syscalls/settimeofday/settimeofday01.c
> [2] https://github.com/linux-test-project/ltp/blob/20150903/testcases/kernel/timers/clock_settime/clock_settime02.c

-- 
Cyril Hrubis
chrubis@suse.cz
