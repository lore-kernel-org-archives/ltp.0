From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 29 Sep 2020 14:17:35 +0200
Subject: [LTP] [PATCH v2 3/4] ima_tpm.sh: Fix calculating boot aggregate
In-Reply-To: <20200925185034.24155-4-pvorel@suse.cz>
References: <20200925185034.24155-1-pvorel@suse.cz>
 <20200925185034.24155-4-pvorel@suse.cz>
Message-ID: <20200929121735.GA11889@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

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
I leaved this error during rebase:
if [ ! -f "$tpm_bios" ]; then

I'm still investigating corner case issue when
/sys/kernel/security/tpm0/binary_bios_measurements
is not presented (mostly when no TPM device, thus IMA "TPM-bypass" code being
used, but sometimes also for TPM 2.0 which does not export event log).

I'll send shortly v3.

Kind regards,
Petr

> +			tst_res TCONF "missing $tpm_bios, $ERRMSG_EVMCTL"
> +			return
> +		fi
> +		tst_check_cmds ima_boot_aggregate || return
> +		cmd="ima_boot_aggregate -f $tpm_bios"
> +	fi
> +	tst_res TINFO "using command: $cmd"
