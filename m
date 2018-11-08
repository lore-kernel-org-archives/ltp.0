From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 8 Nov 2018 12:53:03 -0500 (EST)
Subject: [LTP] [PATCH 2/2] lib/tst_test.c: Restrict that tst_brk() only
 works with TBROK/TCONF
In-Reply-To: <1541681733-18845-2-git-send-email-yangx.jy@cn.fujitsu.com>
References: <1541681733-18845-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1541681733-18845-2-git-send-email-yangx.jy@cn.fujitsu.com>
Message-ID: <60497535.71361444.1541699583188.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


----- Original Message -----
> 1) Add tst_check_ttype() to check if TPASS/TFAIL/TWARN/TINFO is
>    passed into tst_brk() and convert it to TBROK forcely.
> 2) Only update test result in library process and main test process
>    because the exit status of child can be passed into main test
>    process by check_child_status().
> 3) Increase the number of skipped when calling tst_brk(TCONF).
> 4) Increase the number of warnings when calling tst_brk(TBROK) in
>    test cleanup(), other than that print "Test broken!" when calling
>    tst_brk(TBROK).
> 
> Fix: #408
> 
> Signed-off-by: Xiao Yang <yangx.jy@cn.fujitsu.com>
> ---
>  lib/tst_test.c | 28 ++++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 661fbbf..c8d8eff 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -55,6 +55,7 @@ struct results {
>  	int skipped;
>  	int failed;
>  	int warnings;
> +	int broken;

Hi,

I don't follow what benefit this provides. It generates message "Test broken",
but we already know that test is broken by message in tst_vbrk_() / tst_cvres().

Regards,
Jan

>  	unsigned int timeout;
>  };
>  
> @@ -159,6 +160,18 @@ void tst_reinit(void)
>  	SAFE_CLOSE(fd);
>  }
>  
> +static int tst_check_ttype(int ttype)
> +{
> +	if (TTYPE_RESULT(ttype) != TCONF && TTYPE_RESULT(ttype) != TBROK) {
> +		tst_res(TINFO, "tst_brk(): invalid type %s, use TBROK forcely",
> +			tst_strttype(ttype));
> +		ttype &= ~TTYPE_MASK;
> +		ttype |= TBROK;
> +	}
> +
> +	return ttype;
> +}
> +
>  static void update_results(int ttype)
>  {
>  	if (!results)
> @@ -177,6 +190,9 @@ static void update_results(int ttype)
>  	case TFAIL:
>  		tst_atomic_inc(&results->failed);
>  	break;
> +	case TBROK:
> +		tst_atomic_inc(&results->broken);
> +	break;
>  	}
>  }
>  
> @@ -305,11 +321,15 @@ void tst_vbrk_(const char *file, const int lineno, int
> ttype,
>  	 * specified but CLONE_THREAD is not. Use direct syscall to avoid
>  	 * cleanup running in the child.
>  	 */
> -	if (syscall(SYS_getpid) == main_pid)
> +	if (syscall(SYS_getpid) == main_pid) {
> +		update_results(ttype);
>  		do_test_cleanup();
> +	}
>  
> -	if (getpid() == lib_pid)
> +	if (getpid() == lib_pid) {
> +		update_results(ttype);
>  		do_exit(TTYPE_RESULT(ttype));
> +	}
>  
>  	exit(TTYPE_RESULT(ttype));
>  }
> @@ -330,6 +350,7 @@ void tst_brk_(const char *file, const int lineno, int
> ttype,
>  	va_list va;
>  
>  	va_start(va, fmt);
> +	ttype = tst_check_ttype(ttype);
>  	tst_brk_handler(file, lineno, ttype, fmt, va);
>  	va_end(va);
>  }
> @@ -605,6 +626,9 @@ static void do_exit(int ret)
>  			ret |= TWARN;
>  	}
>  
> +	if (results->broken)
> +		printf("Test broken!\n");
> +
>  	do_cleanup();
>  
>  	exit(ret);
> --
> 1.8.3.1
> 
> 
> 
> 
