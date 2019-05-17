From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 17 May 2019 08:51:16 +0200
Subject: [LTP] [PATCH] ima: skip verifying TPM 2.0 PCR values
In-Reply-To: <1558041162.3971.2.camel@linux.ibm.com>
References: <1558041162.3971.2.camel@linux.ibm.com>
Message-ID: <20190517065116.GA8170@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Mimi,

> TPM 1.2 exported the PCRs.  Reading the TPM 2.0 PCRs requires a
> userspace application.  For now, skip this test.

> Signed-off-by: Mimi Zohar <zohar@linux.ibm.com>
Acked-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/kernel/security/integrity/ima/tests/ima_tpm.sh | 8 ++++++++
>  1 file changed, 8 insertions(+)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> index 0ffc3c02247d..ebe4b4c360e4 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_tpm.sh
> @@ -88,6 +88,14 @@ test2()
>  	tst_res TINFO "verify PCR values"
>  	tst_check_cmds evmctl

> +	local tpm_description="/sys/class/tpm/tpm0/device/description"
> +	if [ -f "$tpm_description" ]; then
> +		if grep -q "^\TPM 2.0" $tpm_description; then
I guess the backslash in "^\TPM 2.0" is a typo.
If yes, no need to repost, I'll fix it when applying your patch.
+ I'd prefer join 2 ifs into single one, but that's just matter of preference,
not important.

> +			tst_res TCONF "TPM 2.0 enabled, but not supported"
> +			return 0
> +		fi
> +	fi
> +
>  	tst_res TINFO "evmctl version: $(evmctl --version)"

>  	local pcrs_path="/sys/class/tpm/tpm0/device/pcrs"

Thanks for your fix.

Kind regards,
Petr
