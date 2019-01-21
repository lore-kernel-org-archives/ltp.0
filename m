From: Jia Zhang <zhang.jia@linux.alibaba.com>
Date: Mon, 21 Jan 2019 09:49:36 +0800
Subject: [LTP] [PATCH v3 6/6] ima/ima_violations: Temporarily remove the
 printk rate limit
In-Reply-To: <1548009534.3982.216.camel@linux.ibm.com>
References: <1547607461-11233-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547607461-11233-7-git-send-email-zhang.jia@linux.alibaba.com>
 <1548009534.3982.216.camel@linux.ibm.com>
Message-ID: <f06ff349-0dcb-b86b-35ef-e9aca48c65fd@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



On 2019/1/21 上午2:38, Mimi Zohar wrote:
> On Wed, 2019-01-16 at 10:57 +0800, Jia Zhang wrote:
>> The output frequency of audit log is limited by printk_ratelimit()
>> in kernel if auditd not used. Thus, the test cases heavily depending
>> on searching certain keywords in log file may fail if the matching
>> patterns are exactly suppressed by printk_ratelimit().
>>
>> In order to fix such a sort of failure, just temporarily remove the
>> printk rate limit, and restore its original setting when doing
>> cleanup.
>>
>> Signed-off-by: Jia Zhang <zhang.jia@linux.alibaba.com>
> 
> Thanks, I wasn't aware of the sysctl.  If the message isn't in
> /var/log/messages or /var/log/audit/audit.log, do we now need to also
> check journalctl?

Not necessary. If user land's auditd is not used, kauditd will send the
log to /var/log/message with printk rate limit:

static void kauditd_printk_skb(struct sk_buff *skb)
{
        struct nlmsghdr *nlh = nlmsg_hdr(skb);
        char *data = nlmsg_data(nlh);

        if (nlh->nlmsg_type != AUDIT_EOE && printk_ratelimit())
                pr_notice("type=%d %s\n", nlh->nlmsg_type, data);
}

So just work around the potential loss with sysctl to temporarily
disable the limit.

Jia

> 
> Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
> 
>> ---
>>  .../kernel/security/integrity/ima/tests/ima_setup.sh      |  2 +-
>>  .../kernel/security/integrity/ima/tests/ima_violations.sh | 15 +++++++++++++++
>>  2 files changed, 16 insertions(+), 1 deletion(-)
>>
>> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
>> index 6dfb4d2..fe60981 100644
>> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
>> +++ b/testcases/kernel/security/integrity/ima/tests/ima_setup.sh
>> @@ -20,7 +20,7 @@
>>  TST_TESTFUNC="test"
>>  TST_SETUP_CALLER="$TST_SETUP"
>>  TST_SETUP="ima_setup"
>> -TST_CLEANUP="ima_cleanup"
>> +TST_CLEANUP="${TST_CLEANUP:-ima_cleanup}"
>>  TST_NEEDS_TMPDIR=1
>>  TST_NEEDS_ROOT=1
>>  
>> diff --git a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
>> index f3f40d4..74223c2 100755
>> --- a/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
>> +++ b/testcases/kernel/security/integrity/ima/tests/ima_violations.sh
>> @@ -20,6 +20,7 @@
>>  # Test whether ToMToU and open_writer violations invalidatethe PCR and are logged.
>>  
>>  TST_SETUP="setup"
>> +TST_CLEANUP="cleanup"
>>  TST_CNT=3
>>  TST_NEEDS_DEVICE=1
>>  
>> @@ -31,15 +32,29 @@ setup()
>>  	FILE="test.txt"
>>  	IMA_VIOLATIONS="$SECURITYFS/ima/violations"
>>  	LOG="/var/log/messages"
>> +	PRINTK_RATE_LIMIT="0"
>>  
>>  	if status_daemon auditd; then
>>  		LOG="/var/log/audit/audit.log"
>> +	else
>> +		tst_check_cmds sysctl
>> +
>> +		PRINTK_RATE_LIMIT=`sysctl -n kernel.printk_ratelimit`
>> +		sysctl -wq kernel.printk_ratelimit=0
>>  	fi
>>  	[ -f "$LOG" ] || \
>>  		tst_brk TBROK "log $LOG does not exist (bug in detection?)"
>>  	tst_res TINFO "using log $LOG"
>>  }
>>  
>> +cleanup()
>> +{
>> +	[ "$PRINTK_RATE_LIMIT" != "0" ] && \
>> +		sysctl -wq kernel.printk_ratelimit=$PRINTK_RATE_LIMIT
>> +
>> +	ima_cleanup
>> +}
>> +
>>  open_file_read()
>>  {
>>  	exec 3< $FILE || exit 1
