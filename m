From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 2 Mar 2017 15:32:47 +0100
Subject: [LTP] [PATCH] doio/growfiles.c: show line number when test
	failed
In-Reply-To: <20170227065103.GA30910@localhost.localdomain>
References: <20170227065103.GA30910@localhost.localdomain>
Message-ID: <20170302143247.GC27525@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> The original code always shows "growfiles.c:132: Test failed". With this
> patch, it will show the right line number where exit() be called.
> ---
>  testcases/kernel/fs/doio/growfiles.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/fs/doio/growfiles.c b/testcases/kernel/fs/doio/growfiles.c
> index bbad230..6f25a54 100644
> --- a/testcases/kernel/fs/doio/growfiles.c
> +++ b/testcases/kernel/fs/doio/growfiles.c
> @@ -125,11 +125,11 @@ char *TCID = "growfiles";	/* Default test program identifier.    */
>  int TST_TOTAL = 1;		/* Total number of test cases. */
>  
>  /* To avoid extensive modifications to the code, use this bodge */
> -#define exit(x) myexit(x)
> -void myexit(int x)
> +#define exit(x) myexit(__FILE__, __LINE__, x)
> +void myexit(const char *file, const int lineno, int x)
>  {
>  	if (x)
> -		tst_resm(TFAIL, "Test failed");
> +		tst_resm_(file, lineno, TFAIL, "Test failed");
>  	else
>  		tst_resm(TPASS, "Test passed");
>  	tst_exit();

I would rather see the code cleaned up. Basically most of the exit(1)
calls are part of the option parsing code that should rather be
tst_brkm(TBROK, ...); Then there is a very few places that actually call
exit() that should either be tst_brkm(TBROK, ...) or tst_resm().

The worst part is that this define replaces exit() in the signal handler
as well which is not safe at all...

Or we can just get rid of the unfinished attempt to convert the testcase
to LTP test API. Or even try to sync with the version from xfstests that
has been cleaned up...

-- 
Cyril Hrubis
chrubis@suse.cz
