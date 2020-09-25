From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 25 Sep 2020 20:30:02 +0200
Subject: [LTP] [PATCH 3/4] ima_tpm.sh: Fix calculating boot aggregate
In-Reply-To: <20200925174439.9534-4-pvorel@suse.cz>
References: <20200925174439.9534-1-pvorel@suse.cz>
 <20200925174439.9534-4-pvorel@suse.cz>
Message-ID: <20200925183002.GA14078@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

...
>  test1()
>  {
>  	tst_res TINFO "verify boot aggregate"

> -	local zero="0000000000000000000000000000000000000000"
>  	local tpm_bios="$SECURITYFS/tpm0/binary_bios_measurements"
> -	local ima_measurements="$ASCII_MEASUREMENTS"
> -	local boot_aggregate boot_hash line
> +	local cmd="evmctl ima_boot_aggregate"
> +	local boot_aggregate cmd zero

> -	# IMA boot aggregate
> -	read line < $ima_measurements
> -	boot_hash=$(echo $line | awk '{print $(NF-1)}' | cut -d':' -f2)
> +	if [ "$MISSING_EVMCTL" = 1 ]; then
> +		if [ -f "$tpm_bios" ]; then
> +			tst_res TCONF "missing $tpm_bios, $ERRMSG_EVMCTL"
> +			return
> +		fi
> +		cmd="ima_boot_aggregate"
This is supposed to be:
		cmd="ima_boot_aggregate -f $tpm_bios"

+ there are other needed fixes => v2 needed.

Kind regards,
Petr
