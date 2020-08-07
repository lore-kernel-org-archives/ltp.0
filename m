From: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Date: Fri, 7 Aug 2020 07:19:35 -0700
Subject: [LTP] [PATCH 1/1] IMA/ima_keys.sh Fix policy content check usage
In-Reply-To: <20200807141524.GA3247@dell5510>
References: <20200807112929.8984-1-pvorel@suse.cz>
 <20200807141524.GA3247@dell5510>
Message-ID: <51daca31-72b6-2a59-bed2-40609af9e420@linux.microsoft.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 8/7/20 7:15 AM, Petr Vorel wrote:
> Hi all,
> 
> ...
>> --- a/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
>> +++ b/testcases/kernel/security/integrity/ima/tests/ima_keys.sh
>> @@ -16,11 +16,14 @@ TST_NEEDS_DEVICE=1
>>   # (450d0fd51564 - "IMA: Call workqueue functions to measure queued keys")
>>   test1()
>>   {
>> -	local keyrings keycheck_lines keycheck_line templates test_file="file.txt"
>> +	local keyrings keycheck_lines keycheck_line templates
>> +	local policy="func=KEY_CHECK"
>> +	local test_file="file.txt"
> 
>>   	tst_res TINFO "verifying key measurement for keyrings and templates specified in IMA policy file"
> 
>> -	keycheck_lines=$(require_ima_policy_content "func=KEY_CHECK" "")
>> +	require_ima_policy_content $policy
>> +	keycheck_lines=$(check_ima_policy_content $policy "")
>>   	keycheck_line=$(echo "$keycheck_lines" | grep "keyrings" | head -n1)
> While working on this patchset, I wonder, why we don't check for
> 'func=KEY_CHECK.*keyrings' in single grep call instead of grepping it twice.
> IMHO single grep call is enough. Or am I missing something?
> 

Instead require_ima_policy_content calling "tst_brk" in error condition, 
it can just return false and the caller can handle it as appropriate. 
Would that avoid two grep calls?

thanks,
  -lakshmi
