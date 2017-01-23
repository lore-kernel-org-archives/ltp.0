From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 23 Jan 2017 14:02:17 +0100
Subject: [LTP] [PATCH v2 1/3] lib/tst_safe_sysv_ipc.c : Add
	tst_safe_sysv_ipc.c
In-Reply-To: <1485167476-18151-1-git-send-email-yangx.jy@cn.fujitsu.com>
References: <20170119143903.GC9193@rei.lan>
 <1485167476-18151-1-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <20170123130039.GA24526@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/include/tst_test.h b/include/tst_test.h
> index acb4b93..c68d880 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -34,6 +34,7 @@
>  #include "tst_kvercmp.h"
>  #include "tst_clone.h"
>  #include "tst_kernel.h"
> +#include "tst_safe_sysv_ipc.h"

I've removed this include from the tst_test.h since the tst_test.h
header is polluted enough already and these safe macros would be used
only by a very small number of tests anyway.

> +int safe_msgget(const char *file, const int lineno, key_t key, int msgflg)
> +{
> +	int rval;
> +
> +	rval = msgget(key, msgflg);
> +	if (rval == -1) {
> +		tst_brk(TBROK | TERRNO, "%s:%d: msgget() failed",
> +			file, lineno);

And I've also changed these tst_brk() messages to print the parameters
passed to the msg*() functions as well in order to provide as much
information as possible.

> +	}
> +
> +	return rval;
> +}

And pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
