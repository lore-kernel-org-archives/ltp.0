From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Tue, 23 Feb 2021 07:52:34 -0800
Subject: [LTP] [PATCH] IMA: Check for ima-buf template is not required
 for keys tests
In-Reply-To: <YDTJtl9C9HbRILQb@pevik>
References: <20210222023421.12576-1-nramas@linux.microsoft.com>
 <YDTJtl9C9HbRILQb@pevik>
Message-ID: <2b7f2f88-7df8-bd31-59cb-fd74bfe555fd@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2/23/21 1:24 AM, Petr Vorel wrote:

Hi Petr,

> 
>> ima-buf is the default IMA template used for all buffer measurements.
>> Therefore, IMA policy rule for measuring keys need not specify
>> an IMA template.
> Good catch. But was it alway?

> IMHO ima-buf as default was added in dea87d0889dd ("ima: select ima-buf template for buffer measurement") in v5.11-rc1.
For key measurements ima-buf template was required in the policy rule, 
but with the above commit (dea87d0889dd) it was changed to ima-buf. So 
we no longer need to specify the template in the policy.

> But test1() tests 450d0fd51564 ("IMA: Call workqueue functions to measure queued keys") from v5.6-rc1.
> Is it safe to ignore it?
Even when the key is queued for measurement, ima-buf template will be 
used when the key is dequeued. Not sure if that answers your question.

> BTW template=ima-buf requirement was added in commit b0418c93f ("IMA/ima_keys.sh: Require template=ima-buf, fix grep pattern")
> 
> Also, shouldn't we check that there is none of the other templates (e.g. template=ima-ng, ...)?
This is a good point - yes: we should check if no other template other 
than ima-buf is specified in the policy rule for measuring keys.

> 
>> Update keys tests to not check for ima template in the policy rule.
> 
>> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
>> ---
>> This patch is based
>> in https://github.com/pevik/ltp/commits/ima/selinux.v2.draft
>> in branch ima/selinux.v2.draft.
> 
>>   testcases/kernel/security/integrity/ima/tests/ima_keys.sh | 5 ++---
>>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
>> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
>> index c9eef4b68..a3a7afbf7 100755
>> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
>> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
>> @@ -15,8 +15,7 @@ TST_CLEANUP=cleanup
>>   . ima_setup.sh
> 
>>   FUNC_KEYCHECK='func=KEY_CHECK'
>> -TEMPLATE_BUF='template=ima-buf'
>> -REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK.*$TEMPLATE_BUF|$TEMPLATE_BUF.*$FUNC_KEYCHECK)"
>> +REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK)"
> nit: remove brackets:
> REQUIRED_POLICY="^measure.*$FUNC_KEYCHECK"
Sure - will remove that.

> 
> There is
> testcases/kernel/security/integrity/ima/datafiles/ima_keys/keycheck.policy file,
> which should be a helper to load proper policy and needs to be updated as well:
> -measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test template=ima-buf
> +measure func=KEY_CHECK keyrings=.ima|.evm|.builtin_trusted_keys|.blacklist|key_import_test
> 
> I was also thinking to move keyrings to REQUIRED_POLICY, e.g.:
> 
> KEYRINGS="keyrings=\.[a-z]+"
> REQUIRED_POLICY="^measure.*($FUNC_KEYCHECK.*$KEYRINGS|$KEYRINGS.*$FUNC_KEYCHECK)"
"keyrings=" is optional in the policy. If keyrings is specified it 
should be checked.

thanks,
  -lakshmi

> 
>>   setup()
>>   {
>> @@ -33,7 +32,7 @@ check_keys_policy()
>>   	local pattern="$1"
> 
>>   	if ! grep -E "$pattern" $TST_TMPDIR/policy.txt; then
>> -		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK, $TEMPLATE_BUF"
>> +		tst_res TCONF "IMA policy must specify $pattern, $FUNC_KEYCHECK"
>>   		return 1
>>   	fi
>>   	return 0

