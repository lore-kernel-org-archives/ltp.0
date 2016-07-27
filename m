From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jul 2016 12:14:33 +0200
Subject: [LTP] [PATCH V3 08/23] rt_sigaction/rt_sigprocmark: Replace
 SA_NOMASK with SA_NODEFER
In-Reply-To: <20160722042656.22346-8-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-8-raj.khem@gmail.com>
Message-ID: <20160727101433.GA10903@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> --- a/testcases/misc/crash/crash01.c
> +++ b/testcases/misc/crash/crash01.c
> @@ -49,7 +49,7 @@ stress test at the same time you run other tests, like a multi-user
>  benchmark.
>  
>  */
> -
> +#define _GNU_SOURCE
>  #include <stdio.h>
>  #include <stdlib.h>
>  #include <string.h>
> @@ -409,7 +409,7 @@ void my_signal(int sig, void (*func) ())
>  
>  	act.sa_handler = func;
>  	memset(&act.sa_mask, 0x00, sizeof(sigset_t));
> -	act.sa_flags = SA_NOMASK | SA_RESTART;
> +	act.sa_flags = SA_NODEFER | SA_RESTART;
>  	sigaction(sig, &act, 0);
>  }
>  
> diff --git a/testcases/misc/crash/crash02.c b/testcases/misc/crash/crash02.c
> index 00fee34..1aba3b9 100644
> --- a/testcases/misc/crash/crash02.c
> +++ b/testcases/misc/crash/crash02.c
> @@ -49,7 +49,6 @@ TODO:
>  	* Does a syscall is supposed to send SIGSEGV?
>  */
>  
> -#define _GNU_SOURCE
>  #include <sys/syscall.h>
>  #include <stdio.h>
>  #include <stdlib.h>
> @@ -358,7 +357,7 @@ void my_signal(int sig, void (*func) ())
>  
>  	act.sa_handler = func;
>  	memset(&act.sa_mask, 0x00, sizeof(sigset_t));
> -	act.sa_flags = SA_NOMASK | SA_RESTART;
> +	act.sa_flags = SA_NODEFER | SA_RESTART;
>  	sigaction(sig, &act, 0);
>  }

What is the reason to add #define _GNU_SOURCE to crash01 and to remove
it from crash02? That looks like unintended change to me.

The rest is obviously OK.

-- 
Cyril Hrubis
chrubis@suse.cz
