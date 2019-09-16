From: Clemens Famulla-Conrad <cfamullaconrad@suse.de>
Date: Mon, 16 Sep 2019 12:26:35 +0200
Subject: [LTP] [PATCH v2 2/3] shell: Introduce TST_TIMEOUT variable
In-Reply-To: <20190913125823.17314-3-pvorel@suse.cz>
References: <20190913125823.17314-1-pvorel@suse.cz>
 <20190913125823.17314-3-pvorel@suse.cz>
Message-ID: <1568629595.3028.13.camel@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,
only some small comments below.

On Fri, 2019-09-13 at 14:58 +0200, Petr Vorel wrote:
> <snip>
> -2.3.2 Library variables
> -^^^^^^^^^^^^^^^^^^^^^^^
> +2.3.2 Library environment variables for shell
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>  
>  Similarily to the C library various checks and preparations can be
> requested
>  simply by setting right '$TST_NEEDS_FOO'.
> @@ -2047,6 +2058,14 @@ simply by setting right '$TST_NEEDS_FOO'.
>                         the test (see below).
>  | 'TST_NEEDS_MODULE' | Test module name needed for the test (see
> below).
>  | 'TST_NEEDS_DRIVERS'| Checks kernel drivers support for the test.
> +| 'TST_TIMEOUT'      | Maximum timeout set for the test in sec. Must
> be float

      ^
I think TST_TIMEOUT isn't evaluated in c at all. There we have `(struct
tst_test*)->timeout` which is `int`,

> +                       >= 1 for C, int >=1 for shell. Default value
> is 300 sec,
> +                       timeout can be disabled by setting it to -1.
> +                       Variable should be set in tests, not by user.
> +| 'LTP_TIMEOUT_MUL'  | Multiply timeout, must be number >= 1 (> 1 is
> useful for
> +                       slow machines to avoid unexpected timeout).
> +                       Variable is also used in C tests,
> +                       it should be set by user, not in tests.
>  |===================================================================
> ==========
>  
>  NOTE: Network tests (see testcases/network/README.md) use additional
> variables
> diff --git
> a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> index 5b19cc292..ad8605e16 100755
> --- a/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> +++ b/testcases/kernel/controllers/memcg/stress/memcg_stress_test.sh
> @@ -17,7 +17,7 @@ TST_NEEDS_CMDS="mount umount cat kill mkdir rmdir
> grep awk cut"
>  
>  # Each test case runs for 900 secs when everything fine
>  # therefore the default 5 mins timeout is not enough.
> -LTP_TIMEOUT_MUL=7
> +TST_TIMEOUT=2100
>  
>  . cgroup_lib.sh
>  
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index ca63745fd..b206fc0bb 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -379,9 +379,41 @@ _tst_rescmp()
>  
>  _tst_setup_timer()
>  {
> +	TST_TIMEOUT=${TST_TIMEOUT:-300}
>  	LTP_TIMEOUT_MUL=${LTP_TIMEOUT_MUL:-1}
>  
> -	local sec=$((300 * LTP_TIMEOUT_MUL))
> +	if [ "$TST_TIMEOUT" = -1 ]; then
> +		tst_res TINFO "Timeout per run is disabled"
> +		return
> +	fi
> +
> +	local err is_float
> +	if tst_is_num "$LTP_TIMEOUT_MUL"; then
> +		if tst_is_int "$LTP_TIMEOUT_MUL"; then
> +			[ "$LTP_TIMEOUT_MUL" -ge 1 ] || err=1
> +		else
> +			tst_test_cmds awk
> +			echo | awk '{if ('"$LTP_TIMEOUT_MUL"' < 1)
> {exit 1}}' || err=1
> +			is_float=1
> +		fi
> +	else
> +		err=1
> +	fi
> +	if [ "$err" ]; then
> +		tst_brk TCONF "LTP_TIMEOUT_MUL must be number >= 1!
> ($LTP_TIMEOUT_MUL)"
> +	fi
> +
> +	if ! tst_is_int "$TST_TIMEOUT" || [ "$TST_TIMEOUT" -lt 1 ];
> then
> +		tst_brk TBROK "TST_TIMEOUT must be int >= 1!
> ($TST_TIMEOUT)"
> +	fi
> +
> +	local sec
> +	if [ "$is_float" ]; then
> +		sec=`echo |awk '{printf("%d\n", '$TST_TIMEOUT' * 

                          ^
                          nit, space after |

> '$LTP_TIMEOUT_MUL')}'`

                   ^
                   + 0.5
In C implementation we round up. Maybe we should do the same in shell.

> +	else
> +		sec=$((TST_TIMEOUT * LTP_TIMEOUT_MUL))
> +	fi
> +
>  	local h=$((sec / 3600))
>  	local m=$((sec / 60 % 60))
>  	local s=$((sec % 60))
> @@ -418,7 +450,7 @@ tst_run()
>  			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
>  			NEEDS_DRIVERS|FS_TYPE|MNTPOINT|MNT_PARAMS);;
>  			IPV6|IPVER|TEST_DATA|TEST_DATA_IFS);;
> -			RETRY_FUNC|RETRY_FN_EXP_BACKOFF);;
> +			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
>  			NET_MAX_PKT);;
>  			*) tst_res TWARN "Reserved variable
> TST_$_tst_i used!";;
>  			esac
