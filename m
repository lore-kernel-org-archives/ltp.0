From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 12 Nov 2020 11:43:23 +0100
Subject: [LTP] [PATCH 1/4] syscalls/sync01: Remove it
In-Reply-To: <20201111182557.GA22242@pevik>
References: <5FA21AA9.9020208@cn.fujitsu.com> <20201106123604.GA30097@yuki.lan>
 <0bc685ce-1983-b900-787f-3d89e75ca48d@163.com>
 <20201106164742.GA6449@rei.lan>
 <f99d3484-f86d-dd8a-e64e-7d9d94533de4@163.com>
 <20201107165518.GB10159@pevik> <5FA8BE07.4040201@cn.fujitsu.com>
 <20201109124233.GA9991@yuki.lan>
 <260dd94635a3dead2e946b2c40096061aa18d25b.camel@suse.com>
 <20201111182557.GA22242@pevik>
Message-ID: <20201112104323.GE11365@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I see no downside in checking for this unexpected negative value,
> > except copy/pasting this test condition in every syscall testcase.
> 
> > I don't know the LTP codebase well enough yet, but what would you say
> > is a good way to have this somewhere in the library. A TEST_SYSCALL
> > macro, or something else, which fails if the return value is < -1?
> LGTM. I was thinking about adding it directly into TEST() and define _TEST()
> which would not do that and be used in that few cases which ret < -1 is valid,
> but that would be ugly.

Well it would have to be a set of macros at least since:

* There are different classes of functions by return values

* We have possitive and negative testcases

For example we would have to have two macros for functions that return
file descriptors, one for a cases where we expect the function to return
a valid file descriptor and one when we expect the function to fail.

So it would look like:

	TEST_FD(open("/foo/bar", O_RDONLY));

or:
	TEST_FAIL(open((void*)-1, O_RDONLY));


The TEST_FD() macro would fail the test if the return value is < 0

And the TEST_FAIL() will fail the test unless we the return value is set
to -1. Maybe we can even have a version with errno as well something as:

	TEST_FAIL_ERR(open((void*)-1, O_RDONLY), EFAULT);

-- 
Cyril Hrubis
chrubis@suse.cz
