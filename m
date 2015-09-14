From: Mark Rutland <mark.rutland@arm.com>
Date: Mon, 14 Sep 2015 14:46:05 +0100
Subject: [LTP] LTP and commit e1d7ba8735551ed7 ("time: Always make sure
 wall_to_monotonic isn't positive")
Message-ID: <20150914134603.GD7002@leverpostej>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

While testing v4.3-rc1 with the LTP, we spotted failures in a couple of
timekeeping tests, which seem to be a result of commit e1d7ba8735551ed7
("time: Always make sure wall_to_monotonic isn't positive").

In both cases this is because the new time would be before the boot
time, so I guess these are covered by the caveat at the end of the
commit message.

settimeofday01 [1] tries tries to settimeofday() with a timeval 100s and
100ns, while clock_gettime02 [2] tries to clock_settime to 1s and
100ns. Neither expect -EINVAL, and report failure with the new
behaviour.

While I don't know that any "real" software is affected, I thought I
should let you know.

Thanks,
Mark.

[1] https://github.com/linux-test-project/ltp/blob/20150903/testcases/kernel/syscalls/settimeofday/settimeofday01.c
[2] https://github.com/linux-test-project/ltp/blob/20150903/testcases/kernel/timers/clock_settime/clock_settime02.c
