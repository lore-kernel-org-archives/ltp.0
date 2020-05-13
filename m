From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 13 May 2020 11:20:28 +0200
Subject: [LTP] [PATCH v2 1/2] syscalls/pidfd_open01.c: Add check for
 close-on-exec flag
In-Reply-To: <5EBB5B3D.4020302@cn.fujitsu.com>
References: <20200513012626.1571-1-yangx.jy@cn.fujitsu.com>
 <5EBB5B3D.4020302@cn.fujitsu.com>
Message-ID: <20200513092028.GA4598@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Yang,

> For the patch set, I and Viresh have the following doubts so do you have any
> suggestion about them?
> 1) I keep TEST() in pidfd_open01/pidfd_open03 for now but I think it is
>    surplus because pidfd/fd and TERRNO are enough to check return value
>    and errno.
>    I wonder if it is necessary to keep TEST()?

yes, I've noticed your discussion at v1, sorry I wasn't able to follow.
https://patchwork.ozlabs.org/project/ltp/patch/20200430085742.1663-1-yangx.jy@cn.fujitsu.com/
Just to get context, We're talking about part of the changes between v1 and v2:

+++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open03.c
@@ -27,9 +27,11 @@ static void run(void)
                exit(EXIT_SUCCESS);
        }

-       fd = pidfd_open(pid, 0);
+       TEST(pidfd_open(pid, 0));
+
+       fd = TST_RET;
        if (fd == -1)
-               tst_brk(TFAIL | TERRNO, "pidfd_open() failed");
+               tst_brk(TFAIL | TTERRNO, "pidfd_open() failed");

        TST_CHECKPOINT_WAKE(0);

I haven't found Cyril's request to use TEST(). To be honest, not sure if it was
meant to make sure that errno needs to be reset before (which TEST()) does.
If not, using pidfd_open() directly would be ok for me.


> 2) tst_syscall() is enough to check the support of pidfd_open() and I
>    don't want to define check function as fsopen_supported_by_kernel()
>    does.
>    Do you think so?

> BTW:
> I don't like the implementation of fsopen_supported_by_kernel():
> a) syscall()/tst_syscall() is enough to check the support of
> pidfd_open(2) and 'tst_kvercmp(5, 2, 0)) < 0' will skip the check if
+1 for tst_syscall()

> a kernel on distribution is newer than v5.2 but drop the support of
> pidfd_open(2) on purpose.
"drop support of pidfd_open(2) on purpose": would anybody has a reason to do
that?

> b) tst_syscall() has checked ENOSYS error so we can simple
> fsopen_supported_by_kernel() by replacing syscall() with tst_syscalls().

Well, one of the benefits of fsopen_supported_by_kernel() was to reduce a bit of
duplicity. Even if the implementation is like TEST and SAFE_CLOSE(), it's
a fewer lines (+ function name as a self docs).

void fsopen_supported_by_kernel(void)
{
	TEST(tst_syscall(__NR_fsopen, NULL, 0));
	if (TST_RET != -1)
		SAFE_CLOSE(TST_RET);
}

For your change for pidfd_open03.c:

static void setup(void)
{
	int pidfd = -1;

	// Check if pidfd_open(2) is not supported
	pidfd = tst_syscall(__NR_pidfd_open, getpid(), 0);
	if (pidfd != -1)
		SAFE_CLOSE(pidfd);
}

 static struct tst_test test = {
-       .min_kver = "5.3",
+       .setup = setup,

How about to call the function pidfd_open_supported_by_kernel()?
Than you can remove the comment (which BTW should use C style /* */).
And IMHO you don't have to assign pidfd to -1.

Kind regards,
Petr
