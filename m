From: Joerg Vehlow <lkml@jv-coder.de>
Date: Tue, 2 Feb 2021 09:19:12 +0100
Subject: [LTP] [RFC PATCH 1/1] tst_test.sh: Run cleanup also on timeout
In-Reply-To: <20210202074753.31516-1-pvorel@suse.cz>
References: <20210202074753.31516-1-pvorel@suse.cz>
Message-ID: <47060cdf-58a3-2568-3508-31436b9c6e12@jv-coder.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

On 2/2/2021 8:47 AM, Petr Vorel wrote:
> Also timeout requires to run a test cleanup (e.g. zram01.sh).
> Thus send first SIGINT, but keep also SIGKILL for safety reasons
> (after 5 sec to give cleanup function some time.
+1
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 69f007d89..35ad6d2d7 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -21,7 +21,7 @@ export TST_LIB_LOADED=1
>   . tst_security.sh
>   
>   # default trap function
> -trap "tst_brk TBROK 'test interrupted'" INT
> +trap "tst_brk TBROK 'test interrupted or timeout'" INT
should be "timed out" for consistency
>   
>   _tst_do_exit()
>   {
> @@ -459,7 +459,7 @@ _tst_setup_timer()
>   
>   	tst_res TINFO "timeout per run is ${h}h ${m}m ${s}s"
>   
> -	sleep $sec && tst_res TBROK "test killed, timeout! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && kill -9 -$pid &
> +	sleep $sec && tst_res TBROK "test killed, timeout! If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1" && { kill -2 -$pid; sleep 5; kill -9 -$pid; } &
Can we move the timeout handling to a separate function? This is getting 
a tiny bit unreadable...
Can this work?:
_tst_handle_timeout()
{
 ??? tst_res TBROK ...
 ??? kill ....
}
...
sleep $sec && _tst_handle_timeout &

J?rg
