From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 7 Sep 2021 11:54:26 +0200
Subject: [LTP] [PATCH] openposix: make use of tst_process_state_wait3
In-Reply-To: <20210907025258.3294914-1-liwang@redhat.com>
References: <20210907025258.3294914-1-liwang@redhat.com>
Message-ID: <YTc20vtM2HbhTVTg@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> diff --git a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
> index 04ef0a2cc..554714695 100644
> --- a/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/clock_nanosleep/9-1.c
> @@ -17,6 +17,7 @@
>  #include <stdlib.h>
>  #include <errno.h>
>  #include "posixtest.h"
> +#include "proc.h"
>  
>  #define SLEEPSEC 30
>  
> @@ -88,7 +89,7 @@ int main(void)
>  		/* parent here */
>  		int i;
>  
> -		sleep(1);
> +		tst_process_state_wait3(pid, 'S', 1);

This test is actually the only one that looks at the remining time as
returned by clock_nanosleep() so it may make a sense to keep the
sleep(1) in this test so that the remaining time is smaller than the
sleep time by some reasonable margin. But I guess that the test will
work fine without it as well.

The rest is obviously fine.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz
