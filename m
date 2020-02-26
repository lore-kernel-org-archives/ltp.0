From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 26 Feb 2020 09:27:02 +0800
Subject: [LTP] [PATCH] syscalls/pipe13: Add regression test for pipe to
 wake up all readers
In-Reply-To: <20200225102850.GA5077@rei.lan>
References: <1582537946-22098-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200224125802.GA30073@rei.lan>
 <0bfca454-8c44-6435-81fb-a243172ef96f@cn.fujitsu.com>
 <20200225102850.GA5077@rei.lan>
Message-ID: <c2a51c9c-2509-7099-23ff-015810048af3@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!

> Hi!
>>> We should just use waitpid with -1 as a pid here and WNOHANG twice,
>>> because if one of the children hangs it's not guaranteed in any way
>>> which one would that be.
>>>
>> On my environment, kernel wakes up the first read and the remaining read
>> doesn't be waked up. (I add three childs, 2,3 doesn't wake up)
> 
> But that behavior is not written down in any standard, that's just how
> the kernel internals are working at the moment, we should not assume it
> will work like this in the future.
Sound reasonable to me, I will follow your advise.
> 
> What I would do here would be:
> 
> 	int ret, cnt = 0, sleep_us = 1, fail = 0;
> 
> 	while (cnt < 2 && sleep_us < 100000) {
> 		ret = waitpid(-1, NULL, WNOHANG);
> 
> 		if (ret < 0)
> 			tst_brk(TBROK | TERRNO, "waitpid()");
> 
> 		if (ret > 0) {
> 			cnt++;
> 			for (i = 0; i < 2; i++) {
> 				if (pid[i] == ret)
> 					pid[i] = 0;
> 			}
> 			continue;
> 		}
> 
> 		usleep(sleep_time);
> 		sleep_time *= 2;
> 	}
> 
> 	for (i = 0; i < 2; i++) {
> 		if (pid[i]) {
> 			tst_res(TINFO, "pid %i still sleeps", pid[i]);
> 			fail = 1;
> 			SAFE_KILL(pid[i], SIGKILL);
> 			SAFE_WAIT(NULL);
> 		}
> 	}
> 
> 	if (fail)
> 		tst_res(TFAIL, "Closed pipe didn't wake everyone");
> 
> 
> 
> This has also advantage that we can easily run the test even for 100
> children as well as two if we change the upper bound of the for loops to
> a variable.
Yes. this way is more wise.

Best Regards
Yang Xu
> 


