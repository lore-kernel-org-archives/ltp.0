From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Aug 2017 15:23:30 +0200
Subject: [LTP] [PATCH v3 1/3] lib: add helper SAFE_FANOTIFY_INIT
In-Reply-To: <1502719311-18774-2-git-send-email-xzhou@redhat.com>
References: <20170811084138.GA3341@rei.lan>
 <1502719311-18774-1-git-send-email-xzhou@redhat.com>
 <1502719311-18774-2-git-send-email-xzhou@redhat.com>
Message-ID: <20170815132330.GB30800@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/lib/tst_safe_macros.c b/lib/tst_safe_macros.c
> index e7f5095..47f87a7 100644
> --- a/lib/tst_safe_macros.c
> +++ b/lib/tst_safe_macros.c
> @@ -17,6 +17,7 @@
>  
>  #define _GNU_SOURCE
>  #include <unistd.h>
> +#include <errno.h>
>  #define TST_NO_DEFAULT_MAIN
>  #include "tst_test.h"
>  #include "tst_safe_macros.h"
> @@ -47,3 +48,25 @@ pid_t safe_getpgid(const char *file, const int lineno, pid_t pid)
>  
>  	return pgid;
>  }
> +
> +int safe_fanotify_init(const char *file, const int lineno,
> +	unsigned int flags, unsigned int event_f_flags)
> +{
> +	int rval;
> +
> +	rval = fanotify_init(flags, event_f_flags);
> +
> +	if (rval == -1) {
> +
> +		if (errno == ENOSYS) {
> +			tst_brk(TCONF,
> +				"fanotify is not configured in this kernel.");
> +		} else {
> +			tst_brk(TBROK | TERRNO,
> +				"%s:%d: fanotify_init() failed",
> +				file, lineno);
> +		}

There is no need for the else branch here, the tst_brk() will exit the
test execution.

> +	}
> +
> +	return rval;
> +}
> -- 
> 1.8.3.1
> 

-- 
Cyril Hrubis
chrubis@suse.cz
