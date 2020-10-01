From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 30 Sep 2020 23:32:17 -0400
Subject: [LTP] [PATCH v4 4/4] ima_tpm.sh: Fix calculating PCR aggregate
In-Reply-To: <20200930160214.29358-5-pvorel@suse.cz>
References: <20200930160214.29358-1-pvorel@suse.cz>
 <20200930160214.29358-5-pvorel@suse.cz>
Message-ID: <b10815a3a0abade8ec8872757ab5ac2a4f7839f4.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, 2020-09-30 at 18:02 +0200, Petr Vorel wrote:

<snip>

> +get_pcr10_aggregate()
> +{
> +	local params pcr
> +	local msg="$ERRMSG_EVMCTL"
> +	local res=TCONF
> +
> +	if [ -z "$MISSING_EVMCTL" ]; then
> +		params="--ignore-violations"  <=== 

Violations should cause the measurement list verification to fail.

> +		msg=
> +		res=TFAIL
> +	elif check_ima_policy_cmdline "tcb"; then
> +		tst_res TCONF "using builtin IMA TCB policy $ERRMSG_EVMCTL"
> +		return
> +	fi
> +
> +	evmctl -v ima_measurement $params $BINARY_MEASUREMENTS > hash.txt 2>&1
> +	if [ $? -ne 0 -a -z "$MISSING_EVMCTL" ]; then
> +		tst_res TFAIL "evmctl failed $ERRMSG_EVMCTL"
> +		tst_res TINFO "hash file:"
> +		cat hash.txt >&2
> +		return
> +	fi
> +
> +	pcr=$(grep -E "^($ALGORITHM: )*PCRAgg.*:" hash.txt \

The IMA measurement list may contain records for other PCR 10.  The
output may contain other PCRs.  Using "PCRAgg.*10:" is safer.  
Probably need to use "grep -m 1 -E" as well.

thanks,

Mimi

> +		| awk '{print $NF}')
> +
> +	if [ -z "$pcr" ]; then
> +		tst_res $res "failed to find aggregate PCR-10 $msg"
> +		tst_res TINFO "hash file:"
> +		cat hash.txt >&2
> +		return
> +	fi
> +
> +	echo "$pcr"
> +}
> +




