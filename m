From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Dec 2015 14:47:34 +0100
Subject: [LTP] [PATCH v2] commands/which: Added new testcase to test
	which(1).
In-Reply-To: <1449220333-14268-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
References: <566145CE.8070004@cn.fujitsu.com>
 <1449220333-14268-1-git-send-email-fenggw-fnst@cn.fujitsu.com>
Message-ID: <20151215134733.GC26217@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +		grep -q "$1" temp
> +		if [ $? -ne 0 ]; then
> +			if [ "$which_op" = "--skip-alias" ] && \
> +				[ "$1" = "pname='pname -i'" ]; then
> +				shift
> +				continue
> +			fi

                              Hmm why don't we remove the
			      "pname='pname -i'" from the parameters?

			      If we silently ignore the failure it's the
			      same as if we haven't checked it in the
			      first place...

Also it would be good to be a bit more verbose here. I.e. do:

echo "'$1' not found in:
cat temp
echo

> +			return 1
> +		fi
> +		shift
> +	done
> +}
> +
> +which_test()
> +{
> +	local which_op=$1
> +	local prog_name=$2
> +
> +	local which_cmd="which $which_op $prog_name"
> +
> +	if [ "$which_op" = "--read-alias" ] || [ "$which_op" = "-i" ] || \
> +		[ "$which_op" = "--skip-alias" ]; then
> +		which_cmd="alias | $which_cmd"
> +	fi
> +
> +	eval ${which_cmd} >temp 2>&1
> +	if [ $? -ne 0 ]; then
> +		grep -q -E "unknown option|invalid option|Usage" temp
> +		if [ $? -eq 0 ]; then
> +			tst_resm TCONF "'${which_cmd}' not supported."
> +			return
> +		fi
> +
> +		tst_resm TFAIL "'${which_cmd}' failed."
> +		cat temp
> +		return
> +	fi
> +
> +	if [ -n "$prog_name" ]; then

I would rather do 'if [ $# -gt 2 ]; then' but that is very minor.

> +		shift 2
> +		which_verify "$which_op" "$@"
> +		if [ $? -ne 0 ]; then
> +			tst_resm TFAIL "'${which_cmd}' failed, not expected."
> +			return
> +		fi
> +	fi
> +
> +	tst_resm TPASS "'${which_cmd}' passed."
> +}

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz
