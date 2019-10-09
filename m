From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 9 Oct 2019 16:34:34 +0200
Subject: [LTP] [RFC PATCH v4 2/5] shell: Introduce TST_TIMEOUT variable,
 add checks
In-Reply-To: <20190930145916.20465-3-pvorel@suse.cz>
References: <20190930145916.20465-1-pvorel@suse.cz>
 <20190930145916.20465-3-pvorel@suse.cz>
Message-ID: <20191009143434.GE7561@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
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
> +	local err="LTP_TIMEOUT_MUL must be number >= 1!"
> +
> +	tst_is_num "$LTP_TIMEOUT_MUL" || tst_brk TCONF "$err ($LTP_TIMEOUT_MUL)"
> +
> +	if ! tst_is_int "$LTP_TIMEOUT_MUL"; then
> +		tst_test_cmds cut

I do not think that it's necessary to check for the presense of the cut
command.

> +		LTP_TIMEOUT_MUL=$(echo "$LTP_TIMEOUT_MUL" | cut -d. -f1)
> +		LTP_TIMEOUT_MUL=$((LTP_TIMEOUT_MUL+1))
> +		tst_res TINFO "ceiling LTP_TIMEOUT_MUL to $LTP_TIMEOUT_MUL"
> +	fi
> +	[ "$LTP_TIMEOUT_MUL" -ge 1 ] || tst_brk TCONF "$err ($LTP_TIMEOUT_MUL)"
> +
> +	if ! tst_is_int "$TST_TIMEOUT" || [ "$TST_TIMEOUT" -lt 1 ]; then
> +		tst_brk TBROK "TST_TIMEOUT must be int >= 1! ($TST_TIMEOUT)"
> +	fi
> +
> +	local sec
> +	if [ "$is_float" ]; then
> +		sec=`echo | awk '{printf("%d\n", '$TST_TIMEOUT' * '$LTP_TIMEOUT_MUL'+ 0.5)}'`
> +	else
> +		sec=$((TST_TIMEOUT * LTP_TIMEOUT_MUL))
> +	fi

Is this a leftover? Now that LTP_TIMEOUT_MUL has been converted to int
we can simply do what is done in the else branch.

>  	local h=$((sec / 3600))
>  	local m=$((sec / 60 % 60))
>  	local s=$((sec % 60))
> @@ -418,7 +446,7 @@ tst_run()
>  			NEEDS_CMDS|NEEDS_MODULE|MODPATH|DATAROOT);;
>  			NEEDS_DRIVERS|FS_TYPE|MNTPOINT|MNT_PARAMS);;
>  			IPV6|IPVER|TEST_DATA|TEST_DATA_IFS);;
> -			RETRY_FUNC|RETRY_FN_EXP_BACKOFF);;
> +			RETRY_FUNC|RETRY_FN_EXP_BACKOFF|TIMEOUT);;
>  			NET_MAX_PKT);;
>  			*) tst_res TWARN "Reserved variable TST_$_tst_i used!";;
>  			esac
> -- 
> 2.23.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz
