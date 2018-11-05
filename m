From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Mon, 5 Nov 2018 15:51:18 +0800
Subject: [LTP] [PATCH] kernel/syscall/setrlimit05.c: use a legal bad
 address for mips
In-Reply-To: <1541403031-141386-1-git-send-email-hongzhi.song@windriver.com>
References: <1541403031-141386-1-git-send-email-hongzhi.song@windriver.com>
Message-ID: <5BDFF676.7020408@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2018/11/05 15:30, Hongzhi.Song wrote:
> This testcase fails on mips32. The process is killed by SIGBUS which
> doesn't return EFAULT as expect.
>
> This is because:
> ((void *)-1) is not a legal bad address which causes the process
> killed by SIGBUG on mips.
>
> 'tst_get_bad_addr()' returns an address that should work on mips
> and other arches.
>
> Signed-off-by: Hongzhi.Song<hongzhi.song@windriver.com>
> ---
>   testcases/kernel/syscalls/setrlimit/setrlimit05.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/setrlimit/setrlimit05.c b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
> index e716722..57b0b82 100644
> --- a/testcases/kernel/syscalls/setrlimit/setrlimit05.c
> +++ b/testcases/kernel/syscalls/setrlimit/setrlimit05.c
> @@ -31,9 +31,13 @@ static void verify_setrlimit(void)
>   	int status;
>   	pid_t pid;
>
> +    void *bad_addr;
> +
> +    bad_addr = tst_get_bad_addr(NULL);
> +
Hi Hongzhi,

Please use tab to do indention instead.
Other than that, it looks good to me.

Best Regards,
Xiao Yang
>   	pid = SAFE_FORK();
>   	if (!pid) {
> -		TEST(setrlimit(RLIMIT_NOFILE, (void *) -1));
> +		TEST(setrlimit(RLIMIT_NOFILE,(struct rlimit *)bad_addr));
>   		if (TST_RET != -1) {
>   			tst_res(TFAIL, "setrlimit()  succeeded unexpectedly");
>   			exit(0);



