From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Oct 2020 14:13:43 +0200
Subject: [LTP] [PATCH V3 2/3] syscalls: select: Verify that data is
 available to read
In-Reply-To: <fb31dd18ad396ab602ba8957ee01a666f79ad9bb.1599558175.git.viresh.kumar@linaro.org>
References: <6fbfc6919c0000e7a7745afbc3c94baab02603fa.1599558175.git.viresh.kumar@linaro.org>
 <fb31dd18ad396ab602ba8957ee01a666f79ad9bb.1599558175.git.viresh.kumar@linaro.org>
Message-ID: <20201014121343.GD31816@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> select() returns a positive value on success if timeout hasn't happened,
> else returns 0. Check that and send some data to the write file
> descriptor for the same.
> 
> Acked-by: Li Wang <liwang@redhat.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  testcases/kernel/syscalls/select/select01.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/select/select01.c b/testcases/kernel/syscalls/select/select01.c
> index 1213aa931251..c6b30aa67dd7 100644
> --- a/testcases/kernel/syscalls/select/select01.c
> +++ b/testcases/kernel/syscalls/select/select01.c
> @@ -25,25 +25,32 @@ static struct select_info {
>  	int *nfds;
>  	fd_set *readfds;
>  	fd_set *writefds;
> +	int *writefd;
>  	char *desc;
>  } tests[] = {
> -	{&fd_reg, &readfds_reg, NULL, "with regular file"},
> -	{&fds_pipe[1], &readfds_pipe, &writefds_pipe, "with system pipe"},
> -	{&fd_npipe, &readfds_npipe, &writefds_npipe, "with named pipe (FIFO)"},
> +	{&fd_reg, &readfds_reg, NULL, NULL, "with regular file"},
> +	{&fds_pipe[1], &readfds_pipe, &writefds_pipe, &fds_pipe[1], "with system pipe"},
> +	{&fd_npipe, &readfds_npipe, &writefds_npipe, &fd_npipe, "with named pipe (FIFO)"},
>  };
>  
>  static void run(unsigned int n)
>  {
>  	struct select_info *tc = &tests[n];
>  	struct timeval timeout;
> +	char buf;
>  
>  	timeout.tv_sec = 0;
>  	timeout.tv_usec = 100000;
>  
> +	if (tc->writefd)
> +		SAFE_WRITE(0, *tc->writefd, &buf, sizeof(buf));

I'm not sure why we are writing data here. For both the pipe and fifo
the select() will return that we can write there, hence the return would
be non-zero regardless.

Also I would like to be more specific. E.g. expecting specific return
instead of just non-zero and also making sure the right bits are enabled
in the fd sets.

>  	TEST(do_select(*tc->nfds + 1, tc->readfds, tc->writefds, 0, &timeout));
>  
>  	if (TST_RET == -1)
>  		tst_res(TFAIL | TTERRNO, "select() failed %s", tc->desc);
> +	else if (!TST_RET)
> +		tst_res(TFAIL, "select() timed out %s", tc->desc);
>  	else
>  		tst_res(TPASS, "select() passed %s", tc->desc);
>  }
> -- 
> 2.25.0.rc1.19.g042ed3e048af
> 

-- 
Cyril Hrubis
chrubis@suse.cz
