From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 13 May 2020 10:28:13 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/pidfd_open01.c: Add check for
 close-on-exec flag
In-Reply-To: <20200513012626.1571-1-yangx.jy@cn.fujitsu.com>
References: <20200513012626.1571-1-yangx.jy@cn.fujitsu.com>
Message-ID: <5EBB5B3D.4020302@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril, Petr

For the patch set, I and Viresh have the following doubts so do you have 
any suggestion about them?
1) I keep TEST() in pidfd_open01/pidfd_open03 for now but I think it is
    surplus because pidfd/fd and TERRNO are enough to check return value
    and errno.
    I wonder if it is necessary to keep TEST()?
2) tst_syscall() is enough to check the support of pidfd_open() and I
    don't want to define check function as fsopen_supported_by_kernel()
    does.
    Do you think so?

BTW:
I don't like the implementation of fsopen_supported_by_kernel():
a) syscall()/tst_syscall() is enough to check the support of
pidfd_open(2) and 'tst_kvercmp(5, 2, 0)) < 0' will skip the check if
a kernel on distribution is newer than v5.2 but drop the support of
pidfd_open(2) on purpose.
b) tst_syscall() has checked ENOSYS error so we can simple
fsopen_supported_by_kernel() by replacing syscall() with tst_syscalls().

Best Regards,
Xiao Yang
On 2020/5/13 9:26, Xiao Yang wrote:
> pidfd_open(2) will set close-on-exec flag on the file descriptor as it
> manpage states, so check close-on-exec flag by fcntl(2).
>
> BTW:
> I tried to pass (long) TST_RET to fcntl() but triggered the following
> compiler warning, so pass (int) pidfd instead.
> ------------------------------------------------------
> In file included from pidfd_open01.c:9:
> pidfd_open01.c: In function ?run?:
> ../../../../include/tst_test.h:76:41: warning: format ?%i? expects argument of type ?int?, but argument 5 has type ?long int? [-Wformat=]
>     76 |   tst_brk_(__FILE__, __LINE__, (ttype), (arg_fmt), ##__VA_ARGS__);\
>        |                                         ^~~~~~~~~
> ../../../../include/tst_safe_macros.h:224:5: note: in expansion of macro ?tst_brk?
>    224 |     tst_brk(TBROK | TERRNO,                          \
>        |     ^~~~~~~
> pidfd_open01.c:20:9: note: in expansion of macro ?SAFE_FCNTL?
>     20 |  flag = SAFE_FCNTL(TST_RET, F_GETFD);
> ------------------------------------------------------
>
> Signed-off-by: Xiao Yang<yangx.jy@cn.fujitsu.com>
> Reviewed-by: Viresh Kumar<viresh.kumar@linaro.org>
> ---
>   testcases/kernel/syscalls/pidfd_open/pidfd_open01.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
> index 93bb86687..ba1580bc7 100644
> --- a/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
> +++ b/testcases/kernel/syscalls/pidfd_open/pidfd_open01.c
> @@ -11,13 +11,20 @@
>
>   static void run(void)
>   {
> -	TEST(pidfd_open(getpid(), 0));
> +	int pidfd, flag;
> +
> +	TEST(pidfd = pidfd_open(getpid(), 0));
>
>   	if (TST_RET == -1)
>   		tst_brk(TFAIL | TTERRNO, "pidfd_open(getpid(), 0) failed");
>
> +	flag = SAFE_FCNTL(pidfd, F_GETFD);
> +
>   	SAFE_CLOSE(TST_RET);
>
> +	if (!(flag&  FD_CLOEXEC))
> +		tst_brk(TFAIL, "pidfd_open(getpid(), 0) didn't set close-on-exec flag");
> +
>   	tst_res(TPASS, "pidfd_open(getpid(), 0) passed");
>   }
>



