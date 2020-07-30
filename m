From: Mimi Zohar <zohar@kernel.org>
Date: Thu, 30 Jul 2020 15:50:38 -0400
Subject: [LTP] [PATCH v5 2/4] IMA: Add policy related helpers
In-Reply-To: <20200727223041.13110-3-pvorel@suse.cz>
References: <20200727223041.13110-1-pvorel@suse.cz>
 <20200727223041.13110-3-pvorel@suse.cz>
Message-ID: <1596138638.25003.6.camel@kernel.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 2020-07-28 at 00:30 +0200, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>

Other than inverting the [ -f $IMA_POLICY ] tests.

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
> New in v5.
> 
>  .../security/integrity/ima/tests/ima_setup.sh | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
> 
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> index 975ce9cbb..c46f273ab 100644
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
> @@ -54,6 +54,45 @@ compute_digest()
>  	return 1
>  }
>  
> +check_policy_readable()
> +{
> +	if [ -f $IMA_POLICY ]; then
> +		tst_res TINFO "missing $IMA_POLICY (reboot or CONFIG_IMA_WRITE_POLICY=y required)"
> +		return 1
> +	fi
> +	cat $IMA_POLICY > /dev/null 2>/dev/null
> +}
> +
> +require_policy_readable()
> +{
> +	if [ -f $IMA_POLICY ]; then
> +		tst_brk TCONF "missing $IMA_POLICY (reboot or CONFIG_IMA_WRITE_POLICY=y required)"
> +	fi
> +	if ! check_policy_readable; then
> +		tst_brk TCONF "cannot read IMA policy (CONFIG_IMA_READ_POLICY=y required)"
> +	fi
> +}
> +
> +check_ima_policy_content()
> +{
> +	local pattern="$1"
> +	local grep_params="${2--q}"
> +
> +	check_policy_readable || return 1
> +	grep $grep_params "$pattern" $IMA_POLICY
> +}
> +
> +require_ima_policy_content()
> +{
> +	local pattern="$1"
> +	local grep_params="${2--q}"
> +
> +	require_policy_readable
> +	if ! grep $grep_params "$pattern" $IMA_POLICY; then
> +		tst_brk TCONF "IMA policy does not specify '$pattern'"
> +	fi
> +}
> +
>  require_ima_policy_cmdline()
>  {
>  	local policy="$1"

