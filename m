From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Mar 2018 17:32:41 +0100
Subject: [LTP] [RFC PATCH v2 1/4] security/ima: Rewrite tests into new
 API + fixes
In-Reply-To: <20180314155731.5943-2-pvorel@suse.cz>
References: <20180314155731.5943-1-pvorel@suse.cz>
 <20180314155731.5943-2-pvorel@suse.cz>
Message-ID: <20180314163241.2d5ekhz4mfsqgxjn@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> -# Function:     test02
> -# Description	- Verify ima calculated aggregate PCR values matches
> -#		  actual PCR value.
> -test02()
> +test2()
>  {
> +	tst_res TINFO "verify PCR values"

> -	# Would be nice to know where the PCRs are located.  Is this safe?
> -	PCRS_PATH=$(find /$SYSFS/devices/ | grep pcrs)
> +	# Would be nice to know where the PCRs are located. Is this safe?
> +	local pcrs_path="$(find $SYSFS/devices/ | grep pcrs)"
>  	if [ $? -eq 0 ]; then
> -		validate_pcr $PCRS_PATH
> +		validate_pcr $pcrs_path
>  		if [ $? -eq 0 ]; then
> -			tst_resm TPASS "aggregate PCR value matches real PCR value."
> +			tst_res TPASS "aggregate PCR value matches real PCR value"
>  		else
> -			tst_resm TFAIL "aggregate PCR value does not match real PCR value."
> +			tst_res TFAIL "aggregate PCR value does not match real PCR value"
>  		fi
>  	else
> -		tst_resm TFAIL "TPM not enabled, no PCR value to validate"
> +		tst_res TFAIL "TPM not enabled, no PCR value to validate"
Wrong, This must be TCONF:
		tst_res TCONF "TPM not enabled, no PCR value to validate"

>  	fi
>  }


Kind regards,
Petr
