Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X6zpv-0006H3-5c
	for ltp-list@lists.sourceforge.net; Tue, 15 Jul 2014 10:19:51 +0000
Date: Tue, 15 Jul 2014 12:19:21 +0200
From: chrubis@suse.cz
Message-ID: <20140715101921.GC27102@rei>
References: <1404985422-6546-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<1404985422-6546-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1404985422-6546-2-git-send-email-wangxg.fnst@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 2/2] lib/tst_res.c: make tst_brkm() and tst_resm()
 output more informative message
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> If testcase calls tst_brkm(...) to terminate test, usually we need
> to serch the message outputted by tst_brkm() to locate it in test
> program, it is inefficient, especially we have multiple same messages,
> so here we choose to make tst_brkm output extra information about
> source files and line number. Also make similar change to tst_resm().
> 
> E.g.:
> We execute getxattr01 before this patch:
> [root@localhost getxattr]# ./getxattr01
> getxattr01    1  TCONF  :  No xattr support in fs or mount without user_xattr option
> getxattr01    2  TCONF  :  Remaining cases not appropriate for configuration
> 
> After this patch:
> [root@localhost getxattr]# ./getxattr01
> getxattr01    1  TCONF  :  getxattr01.c:158: No xattr support in fs or mount without user_xattr option
> getxattr01    2  TCONF  :  Remaining cases not appropriate for configuration
> 
> Signed-off-by: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
> ---
>  lib/tst_res.c | 121 ++++++++++++++++++++++++++++------------------------------
>  1 file changed, 58 insertions(+), 63 deletions(-)
> 
> diff --git a/lib/tst_res.c b/lib/tst_res.c
> index 0383c98..d27fdd0 100644
> --- a/lib/tst_res.c
> +++ b/lib/tst_res.c
> @@ -36,12 +36,12 @@
>   *    OS Testing - Silicon Graphics, Inc.
>   *
>   *    FUNCTION NAME     :
> - *      tst_res() -       Print result message (include file contents)
> - *      tst_resm() -      Print result message
> - *      tst_resm_hexd() - Print result message (add buffer contents in hex)
> - *      tst_brk() -       Print result message (include file contents)
> + *      tst_res_() -       Print result message (include file contents)
> + *      tst_resm_() -      Print result message
> + *      tst_resm_hexd_() - Print result message (add buffer contents in hex)
> + *      tst_brk_() -       Print result message (include file contents)
>   *                        and break remaining test cases
> - *      tst_brkm() -      Print result message and break remaining test
> + *      tst_brkm_() -      Print result message and break remaining test
>   *                        cases
>   *      tst_flush() -     Print any messages pending in the output stream
>   *      tst_exit() -      Exit test with a meaningful exit value.
> @@ -49,35 +49,6 @@
>   *
>   *    FUNCTION TITLE    : Standard automated test result reporting mechanism
>   *
> - *    SYNOPSIS:
> - *      #include "test.h"
> - *
> - *      void tst_res(ttype, fname, tmesg [,arg]...)
> - *      int  ttype;
> - *      char *fname;
> - *      char *tmesg;
> - *
> - *      void tst_resm(ttype, tmesg [,arg]...)
> - *      int  ttype;
> - *      char *tmesg;
> - *
> - *      void tst_brk(ttype, fname, cleanup, tmesg, [,argv]...)
> - *      int  ttype;
> - *      char *fname;
> - *      void (*cleanup)();
> - *      char *tmesg;
> - *
> - *      void tst_brkm(ttype, cleanup, tmesg [,arg]...)
> - *      int  ttype;
> - *      void (*cleanup)();
> - *      char *tmesg;
> - *
> - *      void tst_flush()
> - *
> - *      void tst_exit()
> - *
> - *      int  tst_environ()
> - *
>   *    AUTHOR            : Kent Rogers (from Dave Fenner's original)
>   *
>   *    CO-PILOT          : Rich Logan
> @@ -224,25 +195,29 @@ const char *strttype(int ttype)
>  #include "signame.h"
>  
>  /*
> - * tst_res() - Main result reporting function.  Handle test information
> + * tst_res_() - Main result reporting function.  Handle test information
>   *             appropriately depending on output display mode.  Call
>   *             tst_condense() or tst_print() to actually print results.
> - *             All result functions (tst_resm(), tst_brk(), etc.)
> + *             All result functions (tst_resm_(), tst_brk_(), etc.)
>   *             eventually get here to print the results.
>   */
> -void tst_res(int ttype, const char *fname, const char *arg_fmt, ...)
> +void tst_res_(const char *file, const int lineno, int ttype,
> +	const char *fname, const char *arg_fmt, ...)
>  {
>  	pthread_mutex_lock(&tmutex);
>  
>  	char tmesg[USERMESG];
> +	int len = 0;
>  	int ttype_result = TTYPE_RESULT(ttype);
>  
>  #if DEBUG
> -	printf("IN tst_res; tst_count = %d\n", tst_count);
> +	printf("IN tst_res_; tst_count = %d\n", tst_count);
>  	fflush(stdout);
>  #endif
>  
> -	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
> +	if (file && (ttype_result != TPASS && ttype_result != TINFO))
> +		len = sprintf(tmesg, "%s:%d: ", file, lineno);
> +	EXPAND_VAR_ARGS(tmesg + len, arg_fmt, USERMESG);
>  
>  	/*
>  	 * Save the test result type by ORing ttype into the current exit
> @@ -599,23 +574,27 @@ int tst_environ(void)
>  static int tst_brk_entered = 0;
>  
>  /*
> - * tst_brk() - Fail or break current test case, and break the remaining
> + * tst_brk_() - Fail or break current test case, and break the remaining
>   *             tests cases.
>   */
> -void tst_brk(int ttype, const char *fname, void (*func) (void), const char *arg_fmt, ...)
> +void tst_brk_(const char *file, const int lineno, int ttype, const char *fname,
> +	void (*func)(void), const char *arg_fmt, ...)
>  {
>  	pthread_mutex_lock(&tmutex);
>  
>  	char tmesg[USERMESG];
> +	int len = 0;
>  	int ttype_result = TTYPE_RESULT(ttype);
>  
>  #if DEBUG
> -	printf("IN tst_brk\n");
> +	printf("IN tst_brk_\n");
>  	fflush(stdout);
>  	fflush(stdout);
>  #endif
>  
> -	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
> +	if (file)
> +		len = sprintf(tmesg, "%s:%d: ", file, lineno);
> +	EXPAND_VAR_ARGS(tmesg + len, arg_fmt, USERMESG);
                                               ^
					       technically this should
					       be (USERMESG - len)

Moreover why do we add the file and line to the buffer here when we can
pass it to the tst_res_ below and keep only one copy of the code?

>  	/*
>  	 * Only FAIL, BROK, CONF, and RETR are supported by tst_brk().
> @@ -629,14 +608,16 @@ void tst_brk(int ttype, const char *fname, void (*func) (void), const char *arg_
>  		ttype = (ttype & ~ttype_result) | TBROK;
>  	}
>  
> -	tst_res(ttype, fname, "%s", tmesg);
> +	tst_res_(NULL, 0, ttype, fname, "%s", tmesg);
>  	if (tst_brk_entered == 0) {
> -		if (ttype_result == TCONF)
> -			tst_res(ttype, NULL,
> +		if (ttype_result == TCONF) {
> +			tst_res_(NULL, 0, ttype, NULL,
>  				"Remaining cases not appropriate for "
>  				"configuration");
> -		else if (ttype_result == TBROK)
> -			tst_res(TBROK, NULL, "Remaining cases broken");
> +		} else if (ttype_result == TBROK) {
> +			tst_res_(NULL, 0, TBROK, NULL,
> +				 "Remaining cases broken");
> +		}
>  	}
>  
>  	/*
> @@ -655,10 +636,13 @@ void tst_brk(int ttype, const char *fname, void (*func) (void), const char *arg_
>  }
>  
>  /*
> - * tst_resm() - Interface to tst_res(), with no filename.
> + * tst_resm_() - Interface to tst_res(), with no filename.
>   */
> -void tst_resm(int ttype, const char *arg_fmt, ...)
> +void tst_resm_(const char *file, const int lineno, int ttype,
> +	const char *arg_fmt, ...)
>  {
> +	int len = 0;
> +	int ttype_result = TTYPE_RESULT(ttype);
>  	char tmesg[USERMESG];
>  
>  #if DEBUG
> @@ -667,27 +651,35 @@ void tst_resm(int ttype, const char *arg_fmt, ...)
>  	fflush(stdout);
>  #endif
>  
> -	EXPAND_VAR_ARGS(tmesg, arg_fmt, USERMESG);
> +	if (ttype_result != TPASS && ttype_result != TINFO)
> +		len = sprintf(tmesg, "%s:%d: ", file, lineno);
> +	EXPAND_VAR_ARGS(tmesg + len, arg_fmt, USERMESG);
> +

Same here, why can't we just pass the file and line to the tst_res_
instead?

And the same for the rest of the code.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
