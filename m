From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Fri, 5 Apr 2019 11:22:31 +0800
Subject: [LTP] [PATCH 1/1] Remove break after return
In-Reply-To: <20190328105006.17337-1-pvorel@suse.cz>
References: <20190328105006.17337-1-pvorel@suse.cz>
Message-ID: <5CA6C9F7.1060907@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2019/03/28 18:50, Petr Vorel wrote:
> Reported-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/syscalls/select/select_var.h       | 1 -
>  testcases/kernel/syscalls/sigpending/sigpending02.c | 3 ---
>  2 files changed, 4 deletions(-)
>
> diff --git a/testcases/kernel/syscalls/select/select_var.h b/testcases/kernel/syscalls/select/select_var.h
> index b19a1d1bf..29ebbc5ee 100644
> --- a/testcases/kernel/syscalls/select/select_var.h
> +++ b/testcases/kernel/syscalls/select/select_var.h
> @@ -20,7 +20,6 @@ static int do_select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *except
>  	switch (tst_variant) {
>  	case 0:
>  		return select(nfds, readfds, writefds, exceptfds, timeout);
> -	break;
>  	case 1: {
>  #ifdef __LP64__
>  		return tst_syscall(__NR_select, nfds, readfds, writefds, exceptfds, timeout);
> diff --git a/testcases/kernel/syscalls/sigpending/sigpending02.c b/testcases/kernel/syscalls/sigpending/sigpending02.c
> index ce0d2ff79..d75807d77 100644
> --- a/testcases/kernel/syscalls/sigpending/sigpending02.c
> +++ b/testcases/kernel/syscalls/sigpending/sigpending02.c
> @@ -37,13 +37,10 @@ static int tested_sigpending(sigset_t *sigset)
>  	switch (tst_variant) {
>  	case 0:
>  		return sigpending(sigset);
> -	break;
Hi Petr,

I have added libc sigpending() detection by the following patch:
http://lists.linux.it/pipermail/ltp/2019-April/011590.html

Perhaps, we should avoid potential compiler warnings by keeping the
break here.

Best Regards,
Xiao Yang
>  	case 1:
>  		return tst_syscall(__NR_sigpending, sigset);
> -	break;
>  	case 2:
>  		return tst_syscall(__NR_rt_sigpending, sigset, SIGSETSIZE);
> -	break;
>  	}
>  	return -1;
>  }



