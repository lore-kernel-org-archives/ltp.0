From: Mimi Zohar <zohar@linux.ibm.com>
Date: Tue, 29 Sep 2020 17:39:06 -0400
Subject: [LTP] [PATCH v3 2/4] IMA: Rewrite ima_boot_aggregate.c to new
 API
In-Reply-To: <20200929165021.11731-3-pvorel@suse.cz>
References: <20200929165021.11731-1-pvorel@suse.cz>
 <20200929165021.11731-3-pvorel@suse.cz>
Message-ID: <4c0ec7617f2686ffdd4565a05beddd34ebf0b6aa.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 2020-09-29 at 18:50 +0200, Petr Vorel wrote:
> The main reason was to see TCONF messages, which are printed into stderr
> in new API (but to stdout in legacy API) and thus visible as the output
> is redirected into the variable.
> 
> Changing boot_aggregate: to sha1: to be compatible with evmctl
> ima_boot_aggregate.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---

<snip>

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> index c69f891f1..dc958eb5c 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> @@ -33,7 +33,7 @@ test1()
>  			tst_res TFAIL "bios boot aggregate is not 0"
>  		fi
>  	else
> -		boot_aggregate=$(ima_boot_aggregate $tpm_bios | grep "boot_aggregate:" | cut -d':' -f2)
> +		boot_aggregate=$(ima_boot_aggregate -f $tpm_bios | grep "sha1:" | cut -d':' -f2)
>  		if [ "$boot_hash" = "$boot_aggregate" ]; then
>  			tst_res TPASS "bios aggregate matches IMA boot aggregate"
>  		else

The original "ima" template is just the hash digest, without the
algorithm.

Mimi

