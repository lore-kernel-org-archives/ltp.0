From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 25 Aug 2016 13:15:17 +0200
Subject: [LTP] [PATCH V2 03/11] Add TST_TRACE
In-Reply-To: <1472041679-29759-4-git-send-email-stanislav.kholmanskikh@oracle.com>
References: <1472041679-29759-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <1472041679-29759-4-git-send-email-stanislav.kholmanskikh@oracle.com>
Message-ID: <20160825111517.GC10490@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +'TST_TRACE' can make the analysis of such situations easier. It's a macro which
> +inserts a call to 'tst_res(TINFO, ...)' in case its argument is not zero.
                                                         ^
						"evaluates to non-zero"

						would be more clear in
						this case

> +In this call to 'tst_res(TINFO, ...)' the file and line will be expanded using
> +the actual location of 'TST_TRACE'.
> +
> +[source,c]
> +-------------------------------------------------------------------------------
> +#include "tst_test.h"
> +
> +if (TST_TRACE(do_action())) {
> +	...
> +}
> +-------------------------------------------------------------------------------

Maybe we should also include example test output here. Otherise the
description looks good to me.

>  2.3.1 Basic shell test structure
>  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 3e2ff5b..eb3f751 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -59,6 +59,10 @@ pid_t safe_fork(const char *filename, unsigned int lineno);
>  #define SAFE_FORK() \
>  	safe_fork(__FILE__, __LINE__)
>  
> +#define TST_TRACE(expr)							\
> +	({int ret = expr;						\
> +		ret != 0 ? tst_res(TINFO, #expr " failed"), ret : ret; })
> +

I would format this to something as:

#define TST_TRACE(expr)	                                            \
	({int ret = expr;                                           \
	  ret != 0 ? tst_res(TINFO, #expr " failed"), ret : ret; }) \

But that is very minor.

-- 
Cyril Hrubis
chrubis@suse.cz
