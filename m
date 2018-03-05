From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 5 Mar 2018 09:03:34 +0100
Subject: [LTP] [PATCH 2/3] syscalls/pipe*: Fix compiler warnings
In-Reply-To: <1519977744-1595-2-git-send-email-huangjh.jy@cn.fujitsu.com>
References: <1519977744-1595-1-git-send-email-huangjh.jy@cn.fujitsu.com>
 <1519977744-1595-2-git-send-email-huangjh.jy@cn.fujitsu.com>
Message-ID: <20180305080334.amcwf4ghvb7cxv7c@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jinhui,

> Signed-off-by: Jinhui Huang <huangjh.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/syscalls/pipe/pipe04.c | 2 +-
>  testcases/kernel/syscalls/pipe/pipe05.c | 4 ++--
>  testcases/kernel/syscalls/pipe/pipe07.c | 2 +-
>  testcases/kernel/syscalls/pipe/pipe08.c | 2 ++
>  testcases/kernel/syscalls/pipe/pipe11.c | 6 +++---
>  5 files changed, 9 insertions(+), 7 deletions(-)

> diff --git a/testcases/kernel/syscalls/pipe/pipe04.c b/testcases/kernel/syscalls/pipe/pipe04.c
> index b3d255b..a3c56e3 100644
> --- a/testcases/kernel/syscalls/pipe/pipe04.c
> +++ b/testcases/kernel/syscalls/pipe/pipe04.c
> @@ -235,7 +235,7 @@ void c2func(void)
>  			tst_resm(TBROK | TERRNO, "[child 2] pipe write failed");
>  }

> -void alarmfunc(int sig)
> +void alarmfunc(int sig LTP_ATTRIBUTE_UNUSED)
>  {
>  	/* for some reason tst_brkm doesn't seem to work in a signal handler */
>  	tst_brkm(TFAIL, cleanup, "one or more children did't die in 60 second "
> diff --git a/testcases/kernel/syscalls/pipe/pipe05.c b/testcases/kernel/syscalls/pipe/pipe05.c
> index fe5ec37..4105988 100644
> --- a/testcases/kernel/syscalls/pipe/pipe05.c
> +++ b/testcases/kernel/syscalls/pipe/pipe05.c
> @@ -59,7 +59,7 @@ void sig11_handler(int sig);

>  int main(int ac, char **av)
>  {
> -	int lc;
> +	volatile int lc;
Why volatile?

>  	struct sigaction sa, osa;

>  	tst_parse_opts(ac, av, NULL, NULL);
> @@ -120,7 +120,7 @@ void setup(void)
>  /******************************************************************
>   * sig11_handler() - our segfault recover hack
>   ******************************************************************/
> -void sig11_handler(int sig)
> +void sig11_handler(int sig LTP_ATTRIBUTE_UNUSED)
>  {
>  	longjmp(sig11_recover, 1);
>  }
> diff --git a/testcases/kernel/syscalls/pipe/pipe07.c b/testcases/kernel/syscalls/pipe/pipe07.c
> index b09df71..55bb9f4 100644
> --- a/testcases/kernel/syscalls/pipe/pipe07.c
> +++ b/testcases/kernel/syscalls/pipe/pipe07.c
> @@ -129,7 +129,7 @@ static void record_open_fds(void)
>  		if (fd == dir_fd)
>  			continue;

> -		if (rec_fds_max >= ARRAY_SIZE(rec_fds)) {
> +		if (rec_fds_max >= (int)ARRAY_SIZE(rec_fds)) {
>  			tst_brkm(TBROK, cleanup,
>  			         "Too much file descriptors open");
>  		}
> diff --git a/testcases/kernel/syscalls/pipe/pipe08.c b/testcases/kernel/syscalls/pipe/pipe08.c
> index cdb2a4d..9f8d9cc 100644
> --- a/testcases/kernel/syscalls/pipe/pipe08.c
> +++ b/testcases/kernel/syscalls/pipe/pipe08.c
> @@ -98,6 +98,8 @@ int main(int ac, char **av)
>  		 * sent
>  		 */
>  		written = write(pipefd[1], wrbuf, length);
> +		if (written > 0)
> +			tst_brkm(TBROK, cleanup, "write succeeded expectedly");
Did you mean "unexpectedly"?

>  	}
>  	cleanup();
>  	tst_exit();
> diff --git a/testcases/kernel/syscalls/pipe/pipe11.c b/testcases/kernel/syscalls/pipe/pipe11.c
> index e11c556..e3b2741 100644
> --- a/testcases/kernel/syscalls/pipe/pipe11.c
> +++ b/testcases/kernel/syscalls/pipe/pipe11.c
> @@ -198,7 +198,8 @@ void do_child_uclinux(void)
>   */
>  void setup(void)
>  {
> -	int i, j;
> +	int i;
> +	unsigned int j;

>  	tst_sig(FORK, DEF_HANDLER, cleanup);

> @@ -230,9 +231,8 @@ void setup(void)
>  	j = 0;
>  	for (i = 0; i < szcharbuf;) {
>  		wrbuf[i++] = rawchars[j++];
> -		if (j >= sizeof(rawchars)) {
> +		if (j >= sizeof(rawchars))
>  			j = 0;
> -		}
>  	}
>  }

Otherwise LGTM, thanks!


Kind regards,
Petr
