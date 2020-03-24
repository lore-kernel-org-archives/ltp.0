From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Mar 2020 00:35:51 +0100
Subject: [LTP] [PATCH 1/3] accept4: Use tst_variant
In-Reply-To: <20200323224933.2613658-1-petr.vorel@gmail.com>
References: <20200323224933.2613658-1-petr.vorel@gmail.com>
Message-ID: <20200324233550.GA4521@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -#if !(__GLIBC_PREREQ(2, 10))
>  static int
>  accept4_01(int fd, struct sockaddr *sockaddr, socklen_t *addrlen, int flags)
>  {
> -#if USE_SOCKETCALL
>  	long args[6];
>  
>  	args[0] = fd;
> @@ -51,11 +51,7 @@ accept4_01(int fd, struct sockaddr *sockaddr, socklen_t *addrlen, int flags)
>  	args[3] = flags;
>  
>  	return tst_syscall(__NR_socketcall, SYS_ACCEPT4, args);
> -#else
> -	return tst_syscall(__NR_accept4, fd, sockaddr, addrlen, flags);
> -#endif
>  }
> -#endif

This is very minor, however the function should be renamed to something
as socketcall_accept4().

Acked otherwise.

-- 
Cyril Hrubis
chrubis@suse.cz
