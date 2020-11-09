From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 9 Nov 2020 13:42:33 +0100
Subject: [LTP] [PATCH 1/4] syscalls/sync01: Remove it
In-Reply-To: <5FA8BE07.4040201@cn.fujitsu.com>
References: <1603691317-22811-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <5FA21AA9.9020208@cn.fujitsu.com> <20201106123604.GA30097@yuki.lan>
 <0bc685ce-1983-b900-787f-3d89e75ca48d@163.com>
 <20201106164742.GA6449@rei.lan>
 <f99d3484-f86d-dd8a-e64e-7d9d94533de4@163.com>
 <20201107165518.GB10159@pevik> <5FA8BE07.4040201@cn.fujitsu.com>
Message-ID: <20201109124233.GA9991@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> 1) open(2) will return -1 if an error occur.
>      Is it necessary to check invalid return value(except -1) if an 
> error occur?

Well if there are values that are never supposed to be returned it makes
sense to catch these and return a TBROK or TFAIL.

If we are expecially testing a syscall() I would say that we should
check for all kinds of errors including the values that shall not be
returned e.g.:

	TEST(open(...));

	if (TST_RET == -1) {
		tst_ret(TFAIL | TTERRNO, "open() failed");
		return;
	}

	if (TST_RET < 0) {
		tst_ret(TFAIL | TTERRNO, "Invalid open() retval %ld", TST_RET);
		return;
	}

	...


If the syscall is part of the test preparation and there is no safe
macro I would say that it's enough to cover all invalid values in one
condition e.g.:

	fd = open(...);
	if (fd < 0)
		tst_brk(TBROK | TERRNO, "open() failed");


> 2) mmap(2) will return MAP_FAILED if an error occurs.
>      Is it necessary to check invalid value(except MAP_FAILED) if an 
> error occur?

Actually return value from mmap() is pointer, right? And the only value
that is not supposed to be returned is MAP_FAILED or do I miss
something?

> Martin's patches have added a check for invalid return value in many 
> safe macros but a lot of syscall tests(e.g. after doingTEST()) don't add 
> the check for now.
> I am not sure if we need to add the check for all syscall tests. :-)

I would say that at least for newly added test we should make sure that
there is no unexpected value returned.

> BTW: In my opinion, it is hardly to get invalid return value so the 
> check seems unnecessary and redundance.

Well it's not a common case but I've seen this to happen a few times,
once it was because a backported patch applied cleanly but the code was
incorrect and as a result syscall started to return really unexpected
values.

-- 
Cyril Hrubis
chrubis@suse.cz
