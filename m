From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 19 Jan 2018 17:19:01 +0100
Subject: [LTP] [RFC PATCH 1/2] lib: Add SAFE_CHROOT(path) macro
In-Reply-To: <20180118131134.11945-2-pvorel@suse.cz>
References: <20180118131134.11945-1-pvorel@suse.cz>
 <20180118131134.11945-2-pvorel@suse.cz>
Message-ID: <20180119161901.GC7954@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
> index 3df952811..9b11801a4 100644
> --- a/include/safe_macros_fn.h
> +++ b/include/safe_macros_fn.h
> @@ -30,6 +30,9 @@ char* safe_basename(const char *file, const int lineno,
>  int safe_chdir(const char *file, const int lineno,
>                 void (*cleanup_fn)(void), const char *path);
>  
> +int safe_chroot(const char *file, const int lineno,
> +               void (*cleanup_fn)(void), const char *path);

Can we please add the safe macro only for the newlib? I.e. function
prototype into the tst_safe_macros.h and implementation into
tst_safe_macros.c?

-- 
Cyril Hrubis
chrubis@suse.cz
