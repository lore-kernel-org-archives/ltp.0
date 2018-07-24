From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 24 Jul 2018 11:35:37 +0200
Subject: [LTP] [PATCH v2 1/1] tst_test.sh: Add test cmd helper
	tst_test_cmds()
In-Reply-To: <20180423091706.24154-1-pvorel@suse.cz>
References: <20180423091706.24154-1-pvorel@suse.cz>
Message-ID: <20180724093537.GA19255@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + tst_cmd_available()
> 
> tst_test_cmds() is meant to be a check just for a particular test.
> Works like tst_check_cmds(), but instead of tst_brk() calls tst_res().

Hmm looking at this after a while I would expect the tst_test_cmds() to
exit the test while tst_check_cmds() to return a value, the question is
if this is worth of the work of renaming the current uses...

> tst_cmd_available() helper can handle cases when command shell builtin
> is not available (e.g. Busybox).
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi,
> 
> if you don't like using which or testing with 127 exit code in
> tst_cmd_available() (or if you don't like tst_cmd_available()), I
> can remove it.

This looks fine to me.

>  Locating kernel modules
>  +++++++++++++++++++++++
>  
> diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> index 8d49d34b6..b3e803e05 100644
> --- a/testcases/lib/tst_test.sh
> +++ b/testcases/lib/tst_test.sh
> @@ -201,12 +201,37 @@ tst_mkfs()
>  	ROD_SILENT mkfs.$fs_type $fs_opts $device
>  }
>  
> +tst_cmd_available()
> +{
> +	if type command > /dev/null 2>&1; then
> +		command -v $1 > /dev/null 2>&1 || return 1
> +	else
> +		which $1 > /dev/null 2>&1
> +		if [ $? -eq 0 ]; then
> +			return 0
> +		elif [ $? -eq 127 ]; then
> +			tst_brk TCONF "missing which command"
> +		else
> +			return 1
> +		fi
> +	fi
> +}
> +
>  tst_check_cmds()
>  {
>  	local cmd
>  	for cmd in $*; do

	BTW you can just write 'for cmd; do' here since the default
	array to loop over are the parameters passed to a function.

> -		if ! command -v $cmd > /dev/null 2>&1; then
> -			tst_brk TCONF "'$cmd' not found"
> +		tst_cmd_available $cmd || tst_brk TCONF "'$cmd' not found"
> +	done
> +}
> +
> +tst_test_cmds()
> +{
> +	local cmd
> +	for cmd in $*; do
> +		if ! tst_cmd_available $cmd; then
> +			tst_res TCONF "'$cmd' not found"
> +			return 1
>  		fi
>  	done

Can we add explicit return 0 here?

Other than that it's fine.

>  }
> -- 
> 2.16.3
> 

-- 
Cyril Hrubis
chrubis@suse.cz
