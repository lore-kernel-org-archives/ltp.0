From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Jun 2018 12:04:47 +0200
Subject: [LTP] [PATCH 1/3] lib: Add SAFE_CHROOT(path) macro
In-Reply-To: <20180620075917.21056-1-pvorel@suse.cz>
References: <20180620075917.21056-1-pvorel@suse.cz>
Message-ID: <20180620100447.GB21435@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  include/safe_macros_fn.h  |  3 +++
>  include/tst_safe_macros.h |  5 ++++-
>  lib/safe_macros.c         | 15 +++++++++++++++
>  3 files changed, 22 insertions(+), 1 deletion(-)
> 
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

Can we pretty please avoid adding the function prototypes with the
unused cleanup pointer?

The safe_macros_fn.h file exists only for a historical reasons, new safe
macros should be added to the tst_safe_macros.h file only, both macro
and function prototype should go there.

-- 
Cyril Hrubis
chrubis@suse.cz
