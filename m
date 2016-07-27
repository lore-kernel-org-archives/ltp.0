From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 27 Jul 2016 18:24:31 +0200
Subject: [LTP] [PATCH V3 18/23] replace SIGCLD with SIGCHLD
In-Reply-To: <20160722042656.22346-18-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
 <20160722042656.22346-18-raj.khem@gmail.com>
Message-ID: <20160727162431.GA13160@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> -	#ifdef SIGCLD
> -		/* SIGCLD same as SIGCHLD */
> -		STRPAIR(SIGCHLD, "SIGCHLD/SIGCLD")
> +	#ifdef SIGCHLD
> +		/* SIGCHLD same as SIGCHLD */
> +		STRPAIR(SIGCHLD, "SIGCHLD/SIGCHLD")
>  	#else
>  		PAIR(SIGCHLD)
>  	#endif

I had to fix this part, since obviously it does not make sense anymore
and all of it needed to be replaced by just PAIR(SIGCHLD);

> --- a/testcases/kernel/ipc/ipc_stress/signals.h
> +++ b/testcases/kernel/ipc/ipc_stress/signals.h
> @@ -38,7 +38,7 @@ char * signames [] =
>   "SIGALRM", //         14      // Alarm clock (POSIX).
>   "SIGTERM", //         15      // Termination (ANSI).
>   "SIGSTKFLT", //       16      // Stack fault.
> - "SIGCLD/SIGCHLD", //  SIGCHLD // Same as SIGCHLD (System V).
> + "SIGCHLD/SIGCHLD", //  SIGCHLD // Same as SIGCHLD (System V).
>   //"SIGCHLD", //       17      // Child status has changed (POSIX).
>   "SIGCONT", //         18      // Continue (POSIX).
>   "SIGSTOP", //         19      // Stop, unblockable (POSIX).

And here as well.


And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
