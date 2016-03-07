From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Mar 2016 10:54:24 +0100
Subject: [LTP] [PATCH] syscalls/profil01: disable this test for uClibc
In-Reply-To: <1457109655-6170-1-git-send-email-yuriy.kolerov@synopsys.com>
References: <1457109655-6170-1-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <20160307095424.GA3559@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/kernel/syscalls/profil/profil01.c b/testcases/kernel/syscalls/profil/profil01.c
> index 2fc47aa..c44daa7 100644
> --- a/testcases/kernel/syscalls/profil/profil01.c
> +++ b/testcases/kernel/syscalls/profil/profil01.c
> @@ -39,6 +39,8 @@
>  char *TCID = "profil01";
>  int TST_TOTAL = 1;
>  
> +#if !defined(__UCLIBC__)
> +
>  static volatile sig_atomic_t profil_done;
>  
>  static void alrm_handler(int sig)
> @@ -124,3 +126,11 @@ int main(int ac, char *av[])
>  
>  	tst_exit();
>  }
> +
> +#else
> +int main(void)
> +{
> +	tst_brkm(TCONF, NULL, "system doesn't have profiling support");
> +}
> +#endif

Adding #ifdefs for each platform/libc implementation like this does not
really scale.

What about handling it the same way we handle UCLINUX in the Makefiles?

Have a look at:

ltp/testcases/kernel/syscalls/Makefile
ltp/testcases/kernel/syscalls/writev/Makefile

-- 
Cyril Hrubis
chrubis@suse.cz
