From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Sep 2017 15:20:12 +0200
Subject: [LTP] [RFC PATCH 4/6] android: cve: Fix build of most of the
 tests
In-Reply-To: <20170902005926.15923-5-petr.vorel@gmail.com>
References: <20170902005926.15923-1-petr.vorel@gmail.com>
 <20170902005926.15923-5-petr.vorel@gmail.com>
Message-ID: <20170906132012.GG24177@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#if !defined(__ANDROID_API__) || __ANDROID_API__ >= 23

This looks ugly to me.

What is the exact problem here? Do the test fail to compile there? If so
we should really check for the missing feature and enable/disable the
test based on that rather than this hackery.

>  #include <pty.h>
>  #include <stdio.h>
>  #include <string.h>
> @@ -159,3 +160,11 @@ static struct tst_test test = {
>  	.cleanup = cleanup,
>  	.test_all = run,
>  };
> +#else /* Android API < 23 */
> +#define TST_NO_DEFAULT_MAIN
> +#include "tst_test.h"
> +int main(void)
> +{
> +	tst_brk(TCONF, "test does not run on Android API < 23");
> +}
> +#endif
> -- 
> 2.14.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
