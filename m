From: Jia Zhang <zhang.jia@linux.alibaba.com>
Date: Tue, 15 Jan 2019 09:12:53 +0800
Subject: [LTP] [PATCH 6/6] ima: Use ima tcb policy files for test
In-Reply-To: <1547494342.4156.188.camel@linux.ibm.com>
References: <1546827989-43569-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1546827989-43569-7-git-send-email-zhang.jia@linux.alibaba.com>
 <1547494342.4156.188.camel@linux.ibm.com>
Message-ID: <d2ae740e-ecc8-92ed-cbbb-0ece1fcdce0e@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



On 2019/1/15 上午3:32, Mimi Zohar wrote:
> On Mon, 2019-01-07 at 10:26 +0800, Jia Zhang wrote:
>> In order to make all tests running smoothly, the policy files should
>> keep up with the default ima tcb policy.
> 
> Keeping the policy rules in sync is a good idea, but some of the rules
> might cause a regression with older kernels (eg. NSFS magic).  Not
> including the rule, also poses a problem.
> 
> The kernel headers package includes magic.h.  One solution would be to check whether a magic name is included in magic.h.
> 
>> Especially ima_violations.sh
>> expects to have a func=FILE_CHECK with mask=MAY_WRITE to trigger open
>> writer and ToMtoU violations. Unfortunately, if ima_policy.sh
>> which would change the system IMA policy ran before ima_violations.sh,
>> ima_violations.sh would fail for sure because its prerequisite is broken.
> 
> We're not really interested in measuring files that are opened for
> write.  They're changing.  The violation checking is independent of
> having a measurement write rule.  Look at the
> kernel ima_rdwr_violation_check().

Thanks for the commits. I will drop this patch in V2.

Jia

> 
> Mimi
> 
>>
>> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
>> ---
>>  .../security/integrity/ima/datafiles/measure.policy     | 17 +++++++++++++++--
>>  .../integrity/ima/datafiles/measure.policy-invalid      | 17 +++++++++++++++--
>>  2 files changed, 30 insertions(+), 4 deletions(-)
>>
>> diff --git a/testcases/kernel/security/integrity/ima/datafiles/measure.policy b/testcases/kernel/security/integrity/ima/datafiles/measure.policy
>> index 9976ddf..546267c 100644
>> --- a/testcases/kernel/security/integrity/ima/datafiles/measure.policy
>> +++ b/testcases/kernel/security/integrity/ima/datafiles/measure.policy
>> @@ -11,6 +11,19 @@ dont_measure fsmagic=0x64626720
>>  dont_measure fsmagic=0x01021994
>>  # SECURITYFS_MAGIC
>>  dont_measure fsmagic=0x73636673
>> -measure func=FILE_MMAP mask=MAY_EXEC
>> +# DEVPTS_SUPER_MAGIC
>> +dont_measure fsmagic=0x1cd1
>> +# BINFMTFS_MAGIC
>> +dont_measure fsmagic=0x42494e4d
>> +# SELINUX_MAGIC
>> +dont_measure fsmagic=0xf97cff8c
>> +# CGROUP_SUPER_MAGIC
>> +dont_measure fsmagic=0x27e0eb
>> +# NSFS_MAGIC
>> +dont_measure fsmagic=0x6e736673
>> +measure func=MMAP_CHECK mask=MAY_EXEC
>>  measure func=BPRM_CHECK mask=MAY_EXEC
>> -measure func=FILE_CHECK mask=MAY_READ uid=0
>> +measure func=FILE_CHECK euid=0
>> +measure func=FILE_CHECK uid=0
>> +measure func=MODULE_CHECK
>> +measure func=FIRMWARE_CHECK
>> diff --git a/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid b/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid
>> index 04dff89..bc72d0c 100644
>> --- a/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid
>> +++ b/testcases/kernel/security/integrity/ima/datafiles/measure.policy-invalid
>> @@ -11,6 +11,19 @@ dont_measure fsmagic=0x64626720
>>  dont_measure fsmagic=0x01021994
>>  # SECURITYFS_MAGIC
>>  dnt_measure fsmagic=0x73636673
>> -measure func=FILE_MMAP mask=MAY_EXEC
>> +# DEVPTS_SUPER_MAGIC
>> +dont_measure fsmagic=0x1cd1
>> +# BINFMTFS_MAGIC
>> +dont_measure fsmagic=0x42494e4d
>> +# SELINUX_MAGIC
>> +dont_measure fsmagic=0xf97cff8c
>> +# CGROUP_SUPER_MAGIC
>> +dont_measure fsmagic=0x27e0eb
>> +# NSFS_MAGIC
>> +dont_measure fsmagic=0x6e736673
>> +measure func=MMAP_CHECK mask=MAY_EXEC
>>  measure func=BPRM_CHECK mask=MAY_EXEC
>> -measure func=FILE_CHECK mask=MAY_READ uid=0
>> +measure func=FILE_CHECK euid=0
>> +measure func=FILE_CHECK uid=0
>> +measure func=MODULE_CHECK
>> +measure func=FIRMWARE_CHECK
