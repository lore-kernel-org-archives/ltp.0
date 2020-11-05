From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 5 Nov 2020 18:56:41 +0800
Subject: [LTP] [PATCH] sycalls: select03: Make nfds use the correct value
In-Reply-To: <1604572726-11596-1-git-send-email-zhufy.jy@cn.fujitsu.com>
References: <1604572726-11596-1-git-send-email-zhufy.jy@cn.fujitsu.com>
Message-ID: <5FA3DA69.2020305@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Feiyu
> When running select03 with runltp in /opt/ltp, this case failed as below:
> select03.c:52: TFAIL: Invalid readfds: select() passed unexpectedly with 0
> select03.c:52: TFAIL: Invalid writefds: select() passed unexpectedly with 0
> select03.c:52: TFAIL: Invalid exceptfds: select() passed unexpectedly with 0
>
> When running select03 with runltp, nfds should be 8 or 9 instead of 6.
>
> Reviewed-by: Yang Xu<xuyang2018.jy@cn.fujitsu.com>
> Signed-off-by: Feiyu Zhu<zhufy.jy@cn.fujitsu.com>
> ---
>   testcases/kernel/syscalls/select/select03.c | 19 ++++++++++++-------
>   1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/select/select03.c b/testcases/kernel/syscalls/select/select03.c
> index ca1b7a5..34264d1 100644
> --- a/testcases/kernel/syscalls/select/select03.c
> +++ b/testcases/kernel/syscalls/select/select03.c
> @@ -30,19 +30,24 @@ static struct tcases {
>   	int exp_errno;
>   } tests[] = {
>   	{ "Negative nfds", -1,&preadfds_reg,&pwritefds_reg,&nullfds,&valid_to, EINVAL },
> -	{ "Invalid readfds", 6,&pfds_closed,&pwritefds_reg,&nullfds,&valid_to, EBADF },
> -	{ "Invalid writefds", 6,&preadfds_reg,&pfds_closed,&nullfds,&valid_to, EBADF },
> -	{ "Invalid exceptfds", 6,&preadfds_reg,&pwritefds_reg,&pfds_closed,&valid_to, EBADF },
> -	{ "Faulty readfds", 6,&faulty_fds,&pwritefds_reg,&nullfds,&valid_to, EFAULT },
> -	{ "Faulty writefds", 6,&preadfds_reg,&faulty_fds,&nullfds,&valid_to, EFAULT },
> -	{ "Faulty exceptfds", 6,&preadfds_reg,&pwritefds_reg,&faulty_fds,&valid_to, EFAULT },
> -	{ "Faulty timeout", 6,&preadfds_reg,&pwritefds_reg,&nullfds,&invalid_to, EFAULT },
> +	{ "Invalid readfds", 1,&pfds_closed,&pwritefds_reg,&nullfds,&valid_to, EBADF },
> +	{ "Invalid writefds", 0,&preadfds_reg,&pfds_closed,&nullfds,&valid_to, EBADF },
> +	{ "Invalid exceptfds", 1,&preadfds_reg,&pwritefds_reg,&pfds_closed,&valid_to, EBADF },
> +	{ "Faulty readfds", 1,&faulty_fds,&pwritefds_reg,&nullfds,&valid_to, EFAULT },
> +	{ "Faulty writefds", 0,&preadfds_reg,&faulty_fds,&nullfds,&valid_to, EFAULT },
> +	{ "Faulty exceptfds", 1,&preadfds_reg,&pwritefds_reg,&faulty_fds,&valid_to, EFAULT },
> +	{ "Faulty timeout", 1,&preadfds_reg,&pwritefds_reg,&nullfds,&invalid_to, EFAULT },
>   };
>
>   static void run(unsigned int n)
>   {
>   	struct tcases *tc =&tests[n];
>
> +	if (tc->nfds == 0)
> +		tc->nfds = fd[0]+1;
> +	else if (tc->nfds == 1)
> +		tc->nfds = fd[1]+1;
I guess we should only use fd[1] + 1 because fd[1] is always greater 
than fds[0]. As man-page said" nfds is the highest-numbered file 
descriptor in any of the three sets, plus 1."

So the code maybe as below
diff --git a/testcases/kernel/syscalls/select/select03.c 
b/testcases/kernel/syscalls/select/select03.c
index ca1b7a504..099b622de 100644
--- a/testcases/kernel/syscalls/select/select03.c
+++ b/testcases/kernel/syscalls/select/select03.c
@@ -29,21 +29,21 @@ static struct tcases {
         struct timeval **timeout;
         int exp_errno;
  } tests[] = {
-       { "Negative nfds", -1, &preadfds_reg, &pwritefds_reg, &nullfds, 
&valid_to, EINVAL },
-       { "Invalid readfds", 6, &pfds_closed, &pwritefds_reg, &nullfds, 
&valid_to, EBADF },
-       { "Invalid writefds", 6, &preadfds_reg, &pfds_closed, &nullfds, 
&valid_to, EBADF },
-       { "Invalid exceptfds", 6, &preadfds_reg, &pwritefds_reg, 
&pfds_closed, &valid_to, EBADF },
-       { "Faulty readfds", 6, &faulty_fds, &pwritefds_reg, &nullfds, 
&valid_to, EFAULT },
-       { "Faulty writefds", 6, &preadfds_reg, &faulty_fds, &nullfds, 
&valid_to, EFAULT },
-       { "Faulty exceptfds", 6, &preadfds_reg, &pwritefds_reg, 
&faulty_fds, &valid_to, EFAULT },
-       { "Faulty timeout", 6, &preadfds_reg, &pwritefds_reg, &nullfds, 
&invalid_to, EFAULT },
+       { "Negative nfds", 0, &preadfds_reg, &pwritefds_reg, &nullfds, 
&valid_to, EINVAL },
+       { "Invalid readfds", 1, &pfds_closed, &pwritefds_reg, &nullfds, 
&valid_to, EBADF },
+       { "Invalid writefds", 1, &preadfds_reg, &pfds_closed, &nullfds, 
&valid_to, EBADF },
+       { "Invalid exceptfds", 1, &preadfds_reg, &pwritefds_reg, 
&pfds_closed, &valid_to, EBADF },
+       { "Faulty readfds", 1, &faulty_fds, &pwritefds_reg, &nullfds, 
&valid_to, EFAULT },
+       { "Faulty writefds", 1, &preadfds_reg, &faulty_fds, &nullfds, 
&valid_to, EFAULT },
+       { "Faulty exceptfds", 1, &preadfds_reg, &pwritefds_reg, 
&faulty_fds, &valid_to, EFAULT },
+       { "Faulty timeout", 1, &preadfds_reg, &pwritefds_reg, &nullfds, 
&invalid_to, EFAULT },
  };

  static void run(unsigned int n)
  {
         struct tcases *tc = &tests[n];

-       TEST(do_select_faulty_to(tc->nfds, *tc->readfds, *tc->writefds,
+       TEST(do_select_faulty_to(tc->nfds ? fd[1] + 1 : -1, 
*tc->readfds, *tc->writefds,
                                  *tc->exceptfds, *tc->timeout,
                                  tc->timeout == &invalid_to));


Best Regrads
Yang Xu
> +
>   	TEST(do_select_faulty_to(tc->nfds, *tc->readfds, *tc->writefds,
>   				 *tc->exceptfds, *tc->timeout,
>   				 tc->timeout ==&invalid_to));



