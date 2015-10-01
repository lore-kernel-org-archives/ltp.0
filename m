From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 1 Oct 2015 13:29:41 +0200
Subject: [LTP] [PATCH] syscalls/mallopt: Does not work correctly?
In-Reply-To: <330BE2030BD7834286495D8B7FCF1FB71C99B4FB@mbx01.itr.canon-is.co.jp>
References: <330BE2030BD7834286495D8B7FCF1FB71C99B4FB@mbx01.itr.canon-is.co.jp>
Message-ID: <20151001112940.GF8256@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Therefore, I suggest to adding following functions.
> 1. Checking mallopt() return values.
> 2. Setting tests value is 0 and 80*sizeof(size_t)/4. 

Sounds good, comments to the patch itself below.

> --- a/testcases/kernel/syscalls/mallopt/mallopt01.c 2015-09-08 18:37:03.000000000 +0900
> +++ b/testcases/kernel/syscalls/mallopt/mallopt01.c 2015-09-10 16:20:44.471493667 +0900
> @@ -51,6 +51,7 @@
>  
>  #define FAILED 0
>  #define PASSED 1
> +#define MAX_FAST_SIZE (80 * sizeof(size_t) / 4)
>  
>  int local_flag = PASSED;
>  
> @@ -71,7 +72,8 @@ int main(int argc, char *argv[])
>  
>   tst_tmpdir();
>  
> - buf = SAFE_MALLOC(NULL, 20480);
> + if ((buf = SAFE_MALLOC(NULL, 20480)) == NULL)
> +  tst_brkm(TBROK, NULL, "malloc failed");

The purpose of SAFE_MALLOC() is to allocate the buffer, or exit the
test. It will never return NULL.

>   /*
>    * Check space usage.
> @@ -86,16 +88,41 @@ int main(int argc, char *argv[])
>    printinfo();
>    tst_resm(TFAIL, "mallinfo failed: smblks != 0");
>   }

We use tabs for indentation. It looks like even the context of the patch
set uses spaces instead. One possibility is that your email client
converted tabs to spaces. Please figure out how to send it correcty, as
it is the patch will not apply.

> + if (info.uordblks >= 20480 && info.smblks == 0)
> +  tst_resm(TPASS, "mallinfo() succeeded");
>   free(buf);
>
>   /*
>    * Test mallopt's M_MXFAST and M_NLBLKS cmds.
>    */
> - mallopt(M_MXFAST, 2048);
> - mallopt(M_NLBLKS, 50);
> - buf = SAFE_MALLOC(NULL, 1024);
> + if (mallopt(M_MXFAST, MAX_FAST_SIZE) == 0)
> +  tst_resm(TFAIL, "mallopt(M_MXFAST, %d) failed", MAX_FAST_SIZE);
> + else
> +  tst_resm(TPASS, "mallopt(M_MXFAST, %d) succeeded", MAX_FAST_SIZE);
> +
> + if (mallopt(M_NLBLKS, 50) == 0)
> +  tst_resm(TFAIL, "mallopt(M_NLBLKS, 50) failed");
> + else
> +  tst_resm(TPASS, "mallopt(M_NLBLKS, 50) succeeded");
> +
> + if ((buf = SAFE_MALLOC(NULL, 1024)) == NULL)
> +  tst_resm(TFAIL, "malloc(1024) failed");
> + else {
> +  tst_resm(TPASS, "malloc(1024) succeeded");
> +  free(buf);
> + }

Here as well, the SAFE_MALLOC() will never fail, just use plain old
malloc() here instead.

> - free(buf);
> + if (mallopt(M_MXFAST, 0) == 0)
> +  tst_resm(TFAIL, "mallopt(M_MXFAST, 0) failed");
> + else
> +  tst_resm(TPASS, "mallopt(M_MXFAST, 0) succeeded");
> +
> + if ((buf = SAFE_MALLOC(NULL, 1024)) == NULL)
> +  tst_resm(TFAIL, "malloc(1024) failed");
> + else {
> +  tst_resm(TPASS, "malloc(1024) succeeded");
> +  free(buf);
> + }

And here as well.

Other than that you should also update the TST_TOTAL to match the number
of PASS/FAIL messages

-- 
Cyril Hrubis
chrubis@suse.cz
