From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 3 Feb 2016 13:42:02 +0100
Subject: [LTP] [PATCH V2 08/32] Check if __GLIBC_PREREQ is defined
 before using it
In-Reply-To: <1452302060-103643-8-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-8-git-send-email-raj.khem@gmail.com>
Message-ID: <20160203124202.GA30788@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/accept4/accept4_01.c b/testcases/kernel/syscalls/accept4/accept4_01.c
> index 6072bfa..2b090cb 100644
> --- a/testcases/kernel/syscalls/accept4/accept4_01.c
> +++ b/testcases/kernel/syscalls/accept4/accept4_01.c
> @@ -64,6 +64,7 @@ static void cleanup(void)
>  	tst_rmdir();
>  }
>  
> +#if defined(__GLIBC__) && defined(__GLIBC_PREREQ)
>  #if !(__GLIBC_PREREQ(2, 10))
>  static int
>  accept4_01(int fd, struct sockaddr *sockaddr, socklen_t *addrlen, int flags)
> @@ -82,7 +83,6 @@ accept4_01(int fd, struct sockaddr *sockaddr, socklen_t *addrlen, int flags)
>  	}
>  	tst_resm(TINFO, "\n");
>  #endif
> -
>  #if USE_SOCKETCALL
>  	long args[6];
>  
> @@ -97,6 +97,7 @@ accept4_01(int fd, struct sockaddr *sockaddr, socklen_t *addrlen, int flags)
>  #endif
>  }
>  #endif
> +#endif
>  
>  static void
>  do_test(int lfd, struct sockaddr_in *conn_addr,
> @@ -119,9 +120,15 @@ do_test(int lfd, struct sockaddr_in *conn_addr,
>  		die("Connect Error");
>  
>  	addrlen = sizeof(struct sockaddr_in);
> +#if defined(__GLIBC__) && defined(__GLIBC_PREREQ)
>  #if !(__GLIBC_PREREQ(2, 10))
>  	acceptfd = accept4_01(lfd, (struct sockaddr *)&claddr, &addrlen,
>  			      closeonexec_flag | nonblock_flag);
> +
> +#else
> +	acceptfd = accept4(lfd, (struct sockaddr *)&claddr, &addrlen,
> +			   closeonexec_flag | nonblock_flag);
> +#endif
>  #else
>  	acceptfd = accept4(lfd, (struct sockaddr *)&claddr, &addrlen,
>  			   closeonexec_flag | nonblock_flag);

This should be ideally converted to configure check for accept4() rather
than adding more #ifdefs around.

> diff --git a/testcases/kernel/syscalls/getcpu/getcpu01.c b/testcases/kernel/syscalls/getcpu/getcpu01.c
> index c927512..6de6362 100644
> --- a/testcases/kernel/syscalls/getcpu/getcpu01.c
> +++ b/testcases/kernel/syscalls/getcpu/getcpu01.c

We allready have fallback definitions for the CPU_SET* macros in
testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity.h the
header should be moved to include/lapi/cpu_set.h and included in all
the testcases so that we can drop most of these GLIBC_PREREQ() instead
of adding more #ifdefs around.

-- 
Cyril Hrubis
chrubis@suse.cz
