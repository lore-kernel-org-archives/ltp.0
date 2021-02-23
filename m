From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 23 Feb 2021 10:24:06 +0100
Subject: [LTP] [PATCH] IMA: Check for ima-buf template is not required
 for keys tests
In-Reply-To: <20210222023421.12576-1-nramas@linux.microsoft.com>
References: <20210222023421.12576-1-nramas@linux.microsoft.com>
Message-ID: <YDTJtl9C9HbRILQb@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Lakmasi,

> ima-buf is the default IMA template used for all buffer measurements.
> Therefore, IMA policy rule for measuring keys need not specify
> an IMA template.
Good catch. But was it alway?
IMHO ima-buf as default was added in dea87d0889dd ("ima: select ima-buf template for buffer measurement") in v5.11-rc1.
But test1() tests 450d0fd51564 ("IMA: Call workqueue functions to measure queued keys") from v5.6-rc1.
Is it safe to ignore it?
BTW template=ima-buf requirement was added in commit b0418c93f ("IMA/ima_keys.sh: Require template=ima-buf, fix grep pattern")

Also, shouldn't we check that there is none of the other templates (e.g. template=ima-ng, ...)?

> Update keys tests to not check for ima template in the policy rule.

> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> ---
> This patch is based
> in https://github.com/pevik/ltp/commits/ima/selinux.v2.draft
> in branch ima/selinux.v2.draft.

>  testcases/kernel/security/integrity/ima/tests/ima_keys.sh | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> index c9eef4b68..a3a7afbf7 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
> @@ -15,8 +15,7 @@ TST_CLEANUP=cleanup
>  . ima_setup.sh

>  FUNC_KEYCHECK='func=KEY_CHECK'
> -TEMPLATE_BUF='template=ima-buf'
> -REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK.*$TEMPLATE_BUF|$TEMPLATE_BUF.*$FUNC_KEYCHECK)"
> +REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK)"
nit: remove brackets:
REQUIRED_POLICY="^measure.*$FUNC_KEYCHECK"

There is
testcases/kernel/security/integrity/ima/datafiles/ima_keys/keycheck.policy file,
which should be a helper to load proper policy and needs to be updated as well:
-measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf
+measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test

I was also thinking to move keyrings to REQUIRED_POLICY, e.g.:

KEYRINGS="keyrings=\.[a-z]+"
REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK.*$KEYRINGS|$KEYRINGS.*$FUNC_KEYCHECK)"

Kind regards,
Petr

>  setup()
>  {
> @@ -33,7 +32,7 @@ check_keys_policy()
>  	local pattern="$1"

>  	if ! grep -E "$pattern" $TST_TMPDIR/policy.txt; then
> -		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK, $TEMPLATE_BUF"
> +		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK"
>  		return 1
>  	fi
>  	return 0
