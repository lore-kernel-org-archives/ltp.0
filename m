From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 16 Mar 2020 12:31:16 +0800
Subject: [LTP] [PATCH] pthread_cond_init/s-c.c: Add the lose ifndef line
In-Reply-To: <1584327515-74727-1-git-send-email-zou_wei@huawei.com>
References: <1584327515-74727-1-git-send-email-zou_wei@huawei.com>
Message-ID: <8eec82a7-f9eb-1002-ee86-71b94a55bdf4@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zou

It was introduced by commit 310c9eb6e6("Remove explicit #define's for 
`_POSIX_C_SOURCE` and `_XOPEN_SOURCE`").

IMO, we can remove this WITHOUT_XOPEN macro directly because we have 
setted -D_POSIX_C_SOURCE=200809L -D_XOPEN_SOURCE=700 in 
ltp/testcases/open_posix_testsuite/CFLAGS.

Best Regards
Yang Xu
> pthread_cond_init/s-c.c testcase lose a #ifndef line, fix it
> 
> Reported-by: Zou Wei <zou_wei@huawei.com>
> Signed-off-by: Zou Wei <zou_wei@huawei.com>
> ---
>   testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c.c b/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c.c
> index 6a5c70a..8d18484 100644
> --- a/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c.c
> +++ b/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c.c
> @@ -80,6 +80,7 @@
>   /***********************************    Test case   *****************************************/
>   /********************************************************************************************/
> +#ifndef WITHOUT_XOPEN
>   typedef struct _teststruct {
>   	pthread_cond_t cnd[10 * SCALABILITY_FACTOR];
>   	pthread_condattr_t ca[4];
> --
> 2.6.2
> 
> 


