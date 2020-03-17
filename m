From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Tue, 17 Mar 2020 15:14:49 +0800
Subject: [LTP] [PATCH] pthread_cond_init/s-c.c: Add the lose ifndef line
In-Reply-To: <1584327515-74727-1-git-send-email-zou_wei@huawei.com>
References: <1584327515-74727-1-git-send-email-zou_wei@huawei.com>
Message-ID: <5E7078E9.9080809@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zou,

Pushed.

BTW:
1) we also need to update open_posix_testsuite so that it can compile 
these stress tests by default.
2) Your patch seems to be broken so I recreate and apply it.

Thanks,
Xiao Yang
On 2020/3/16 10:58, Zou Wei wrote:
> pthread_cond_init/s-c.c testcase lose a #ifndef line, fix it
>
> Reported-by: Zou Wei<zou_wei@huawei.com>
> Signed-off-by: Zou Wei<zou_wei@huawei.com>
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



