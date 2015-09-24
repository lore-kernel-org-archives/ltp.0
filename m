From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 24 Sep 2015 16:51:43 +0200
Subject: [LTP] LTP and commit e1d7ba8735551ed7 ("time: Always make sure
 wall_to_monotonic isn't positive")
In-Reply-To: <20150915083729.GA3860@rei.nue.novell.com>
References: <20150914134603.GD7002@leverpostej>
 <20150915083729.GA3860@rei.nue.novell.com>
Message-ID: <20150924145143.GB32030@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Thanks for the report, we allready have patch for the first testcase on
> the mailing list that initializes the the timeval value to current time
> + small amount. I will have a look at the second test as well.
> 
> > [1] https://github.com/linux-test-project/ltp/blob/20150903/testcases/kernel/syscalls/settimeofday/settimeofday01.c
> > [2] https://github.com/linux-test-project/ltp/blob/20150903/testcases/kernel/timers/clock_settime/clock_settime02.c

Both should be fixed in latest git.

-- 
Cyril Hrubis
chrubis@suse.cz
