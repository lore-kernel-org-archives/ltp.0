From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 2 Feb 2016 18:14:58 +0100
Subject: [LTP] [PATCH V2 27/32] sysconf01: Use _SC_2_C_VERSION
 conditionally
In-Reply-To: <1452302060-103643-27-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
 <1452302060-103643-27-git-send-email-raj.khem@gmail.com>
Message-ID: <20160202171458.GQ19199@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/sysconf/sysconf01.c b/testcases/kernel/syscalls/sysconf/sysconf01.c
> index 8542e77..e806943 100644
> --- a/testcases/kernel/syscalls/sysconf/sysconf01.c
> +++ b/testcases/kernel/syscalls/sysconf/sysconf01.c
> @@ -102,7 +102,9 @@ int main(void)
>  	test_sysconf(_SC_ATEXIT_MAX);
>  	test_sysconf(_SC_2_C_BIND);
>  	test_sysconf(_SC_2_C_DEV);
> +#ifdef __GLIBC__

Why not #ifdef _SC_2_C_VERSION ?

That should work for any libc implementation...

>  	test_sysconf(_SC_2_C_VERSION);
> +#endif
>  	/* 21 - 25 */
>  	test_sysconf(_SC_2_CHAR_TERM);
>  	test_sysconf(_SC_2_FORT_DEV);

-- 
Cyril Hrubis
chrubis@suse.cz
