From: Radoslav Kolev <radoslav.kolev@suse.com>
Date: Mon, 09 Nov 2020 20:15:55 +0200
Subject: [LTP] [PATCH 1/4] syscalls/sync01: Remove it
In-Reply-To: <20201109124233.GA9991@yuki.lan>
References: <1603691317-22811-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <5FA21AA9.9020208@cn.fujitsu.com> <20201106123604.GA30097@yuki.lan>
 <0bc685ce-1983-b900-787f-3d89e75ca48d@163.com>
 <20201106164742.GA6449@rei.lan>
 <f99d3484-f86d-dd8a-e64e-7d9d94533de4@163.com>
 <20201107165518.GB10159@pevik> <5FA8BE07.4040201@cn.fujitsu.com>
 <20201109124233.GA9991@yuki.lan>
Message-ID: <260dd94635a3dead2e946b2c40096061aa18d25b.camel@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 2020-11-09 at 13:42 +0100, Cyril Hrubis wrote:
> Hi!
> > 1) open(2) will return -1 if an error occur.
> >      Is it necessary to check invalid return value(except -1) if
> > an 
> > error occur?
> 
> Well if there are values that are never supposed to be returned it
> makes
> sense to catch these and return a TBROK or TFAIL.
> 
> If we are expecially testing a syscall() I would say that we should
> check for all kinds of errors including the values that shall not be
> returned e.g.:
> 
> 	TEST(open(...));
> 
> 	if (TST_RET == -1) {
> 		tst_ret(TFAIL | TTERRNO, "open() failed");
> 		return;
> 	}
> 
> 	if (TST_RET < 0) {
> 		tst_ret(TFAIL | TTERRNO, "Invalid open() retval %ld",
> TST_RET);
> 		return;
> 	}
> 
> 	...

I see no downside in checking for this unexpected negative value,
except copy/pasting this test condition in every syscall testcase.

I don't know the LTP codebase well enough yet, but what would you say
is a good way to have this somewhere in the library. A TEST_SYSCALL
macro, or something else, which fails if the return value is < -1?

