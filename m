From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 16 Mar 2021 18:15:47 +0800
Subject: [LTP] [PATCH] pidns13: Use getpid syscall directly instead of
 glibc wrapper
In-Reply-To: <1615888254-31940-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
References: <1615888254-31940-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
Message-ID: <60508553.4010108@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi All
I guess the following commit message is more clear.
"
From  glibc  version  2.3.4  up  to  and  including version 2.24, the glibc wrapper function for getpid() cached PIDs, 
with the goal of avoiding additional system calls when a process calls getpid()repeatedly.  Normally this caching was
invisible, but its correct operation relied on support in the wrapper functions for fork(2), vfork(2), and clone(2):
if an application bypassed the glibc wrappers for these system calls by using syscall(2), then a call to getpid()
in the child would return the wrong value (to be precise: it would return the PID of the parent process).  In addition,
there were cases where getpid() could return the wrong value even when invoking clone(2) via the glibc wrapper function. 
"(For a discussion of one such case, see BUGS in clone(2).)"

Because of the aforementioned problems, since glibc version 2.25, the PID cache is removed: calls to getpid() always invoke
the actual system call, rather than returning a cached value.
"
On old api, pidns13 doesn't fail because we use clone and getpid glibc wrapper, now we use clone3 syscall directly and use 
getpid glibc wrapper, so it fails on older glibc ie glibc-2.17.

> As clone(2) man-pages said "GNU C library versions 2.3.4 up to and including
> 2.24 contained a wrapper function for getpid(2) that performed caching of PIDs.
> This caching relied on support in the glibc wrapper for clone(), but limitations
> in the implementation meant that the cache was not up to date in some circumstances".
>
> Because of the stale-cache problem, as well as other problems noted in getpid(2), the
> PID caching feature was removed in glibc 2.25
>
> To get the truth, always use getpid syscall instead of getting value from cache.
> It fixes failure on centos7.
>
> Reported-by: Feiyu Zhu <zhufy.jy@cn.fujitsu.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> ---
>  testcases/kernel/containers/pidns/pidns13.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/containers/pidns/pidns13.c b/testcases/kernel/containers/pidns/pidns13.c
> index 12aee917b..c27ef51b4 100644
> --- a/testcases/kernel/containers/pidns/pidns13.c
> +++ b/testcases/kernel/containers/pidns/pidns13.c
> @@ -54,7 +54,7 @@ static void child_fn(unsigned int cinit_no)
>  	pid_t pid, ppid;
>  	int flags;
>  
> -	pid = getpid();
> +	pid = tst_syscall(__NR_getpid);
>  	ppid = getppid();
>  	if (pid != CHILD_PID || ppid != PARENT_PID)
>  		tst_brk(TBROK, "cinit%u: pidns not created.", cinit_no);



