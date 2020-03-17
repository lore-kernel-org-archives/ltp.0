From: Zouwei (Samuel) <zou_wei@huawei.com>
Date: Tue, 17 Mar 2020 07:34:05 +0000
Subject: [LTP] =?gb2312?b?tPC4tDogIFtQQVRDSF0gcHRocmVhZF9jb25kX2luaXQv?=
 =?gb2312?b?cy1jLmM6IEFkZCB0aGUgbG9zZSBpZm5kZWYgbGluZQ==?=
In-Reply-To: <5E7078E9.9080809@cn.fujitsu.com>
References: <1584327515-74727-1-git-send-email-zou_wei@huawei.com>
 <5E7078E9.9080809@cn.fujitsu.com>
Message-ID: <C3CD0DF8AD11A84CB25A1426DE537C61E5910B5D@dggeml524-mbx.china.huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu

Thanks for merge the patch.

I sent another 2 patches, one is to enable the open_posix_testsuite in the makefile, and the other one is to fix the open_posix compilation issue.

Best Regards
Zou Wei
-----????-----
???: Xiao Yang [mailto:yangx.jy@cn.fujitsu.com] 
????: 2020?3?17? 15:15
???: Zouwei (Samuel) <zou_wei@huawei.com>
??: ltp@lists.linux.it
??: Re: [LTP] [PATCH] pthread_cond_init/s-c.c: Add the lose ifndef line

Hi Zou,

Pushed.

BTW:
1) we also need to update open_posix_testsuite so that it can compile these stress tests by default.
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
> diff --git 
> a/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c.
> c 
> b/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c.
> c
> index 6a5c70a..8d18484 100644
> --- 
> a/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/s-c.
> c
> +++ b/testcases/open_posix_testsuite/stress/threads/pthread_cond_init/
> +++ s-c.c
> @@ -80,6 +80,7 @@
>   /***********************************    Test case   *****************************************/
>   
> /*********************************************************************
> ***********************/
> +#ifndef WITHOUT_XOPEN
>   typedef struct _teststruct {
>   	pthread_cond_t cnd[10 * SCALABILITY_FACTOR];
>   	pthread_condattr_t ca[4];
> --
> 2.6.2
>
>



