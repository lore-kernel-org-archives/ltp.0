From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 25 Feb 2020 11:28:50 +0100
Subject: [LTP] [PATCH] syscalls/pipe13: Add regression test for pipe to
 wake up all readers
In-Reply-To: <0bfca454-8c44-6435-81fb-a243172ef96f@cn.fujitsu.com>
References: <1582537946-22098-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200224125802.GA30073@rei.lan>
 <0bfca454-8c44-6435-81fb-a243172ef96f@cn.fujitsu.com>
Message-ID: <20200225102850.GA5077@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > We should just use waitpid with -1 as a pid here and WNOHANG twice,
> > because if one of the children hangs it's not guaranteed in any way
> > which one would that be.
> > 
> On my environment, kernel wakes up the first read and the remaining read 
> doesn't be waked up. (I add three childs, 2,3 doesn't wake up)

But that behavior is not written down in any standard, that's just how
the kernel internals are working at the moment, we should not assume it
will work like this in the future.

What I would do here would be:

	int ret, cnt = 0, sleep_us = 1, fail = 0;

	while (cnt < 2 && sleep_us < 100000) {
		ret = waitpid(-1, NULL, WNOHANG);

		if (ret < 0)
			tst_brk(TBROK | TERRNO, "waitpid()");

		if (ret > 0) {
			cnt++;
			for (i = 0; i < 2; i++) {
				if (pid[i] == ret)
					pid[i] = 0;
			}
			continue;
		}

		usleep(sleep_time);
		sleep_time *= 2;
	}

	for (i = 0; i < 2; i++) {
		if (pid[i]) {
			tst_res(TINFO, "pid %i still sleeps", pid[i]);
			fail = 1;
			SAFE_KILL(pid[i], SIGKILL);
			SAFE_WAIT(NULL);
		}
	}

	if (fail)
		tst_res(TFAIL, "Closed pipe didn't wake everyone");



This has also advantage that we can easily run the test even for 100
children as well as two if we change the upper bound of the for loops to
a variable.

-- 
Cyril Hrubis
chrubis@suse.cz
