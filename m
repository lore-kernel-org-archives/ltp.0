From: Mimi Zohar <zohar@linux.ibm.com>
Date: Mon, 14 Jan 2019 16:09:15 -0500
Subject: [LTP] [PATCH 4/6] ima: Code cleanup
In-Reply-To: <1546827989-43569-5-git-send-email-zhang.jia@linux.alibaba.com>
References: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1546827989-43569-5-git-send-email-zhang.jia@linux.alibaba.com>
Message-ID: <1547500155.4156.204.camel@linux.ibm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, 2019-01-07 at 10:26 +0800, Jia Zhang wrote:
> - Don't use the legacy policy function name in policy files.

The name change is from PATH_CHECK to FILE_CHECK, nothing to do with
"policy".

> - Use the variable IMA_POLICY instead of hard code path.
> 
> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>

After removing the word "policy" above,

Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>

> ---
>  testcases/kernel/security/integrity/ima/policy/measure.policy         | 2 +-
>  testcases/kernel/security/integrity/ima/policy/measure.policy-invalid | 2 +-
>  testcases/kernel/security/integrity/ima/tests/ima_policy.sh           | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/security/integrity/ima/policy/measure.policy b/testcases/kernel/security/integrity/ima/policy/measure.policy
> index c68e722..9976ddf 100644
> --- a/testcases/kernel/security/integrity/ima/policy/measure.policy
> +++ b/testcases/kernel/security/integrity/ima/policy/measure.policy
> @@ -13,4 +13,4 @@ dont_measure fsmagic=0x01021994
>  dont_measure fsmagic=0x73636673
>  measure func=FILE_MMAP mask=MAY_EXEC
>  measure func=BPRM_CHECK mask=MAY_EXEC
> -measure func=PATH_CHECK mask=MAY_READ uid=0
> +measure func=FILE_CHECK mask=MAY_READ uid=0
> diff --git a/testcases/kernel/security/integrity/ima/policy/measure.policy-invalid b/testcases/kernel/security/integrity/ima/policy/measure.policy-invalid
> index e406757..04dff89 100644
> --- a/testcases/kernel/security/integrity/ima/policy/measure.policy-invalid
> +++ b/testcases/kernel/security/integrity/ima/policy/measure.policy-invalid
> @@ -13,4 +13,4 @@ dont_measure fsmagic=0x01021994
>  dnt_measure fsmagic=0x73636673
>  measure func=FILE_MMAP mask=MAY_EXEC
>  measure func=BPRM_CHECK mask=MAY_EXEC
> -measure func=PATH_CHECK mask=MAY_READ uid=0
> +measure func=FILE_CHECK mask=MAY_READ uid=0
> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> index 64aa8cb..a0c7869 100755
> --- a/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> +++ b/testcases/kernel/security/integrity/ima/tests/ima_policy.sh
> @@ -28,7 +28,7 @@ check_policy_writable()
>  {
>  	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
> 
> -	[ -f /sys/kernel/security/ima/policy ] || tst_brk TCONF "$err"
> +	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
>  	# CONFIG_IMA_READ_POLICY
>  	echo "" 2> log > $IMA_POLICY
>  	grep -q "Device or resource busy" log && tst_brk TCONF "$err"

