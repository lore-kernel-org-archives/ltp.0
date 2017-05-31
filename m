From: Jakub =?unknown-8bit?q?Ra=C4=8Dek?= <jracek@redhat.com>
Date: Wed, 31 May 2017 10:39:56 +0200
Subject: [LTP] [PATCH] syscalls/syslog: mitigate reading syslog issue in
 multiple files
In-Reply-To: <20170529155110.GD6618@rei.lan>
References: <1491317717-14113-1-git-send-email-jracek@redhat.com>
 <20170529155110.GD6618@rei.lan>
Message-ID: <5048b300-0102-9e42-8cdc-23f14647e90c@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

thanks for the review on this patch, but after some consideration of 
opinion from someone more experienced, I think this patch shouldn't be 
applied at all.

We don't know for sure why the test is sporadically failing. And even 
though I really don't like that busy waiting (e.g. sleep 1 - why 1?), if 
we apply the patch I posted, we may never know what was wrong and could 
theoretically miss/mask a worse issue.

I think it would be best to leave this be and write different patch, 
merely to get more info when failure occurs.

Of course, if you want this patch, then I can make the changes that you 
suggested and post V2.

Thanks!

Best regards,

Jakub Racek

On 05/29/2017 05:51 PM, Cyril Hrubis wrote:
> Hi!
>> diff --git a/testcases/kernel/syscalls/syslog/syslog-lib.sh b/testcases/kernel/syscalls/syslog/syslog-lib.sh
>> index e166d3a..3afd80f 100755
>> --- a/testcases/kernel/syscalls/syslog/syslog-lib.sh
>> +++ b/testcases/kernel/syscalls/syslog/syslog-lib.sh
>> @@ -151,6 +151,37 @@ restart_syslog_daemon()
>>  	fi
>>  }
>>
>> +check_syslog_content()
>> +{
>> +	logfile=$1
>> +	newvalue_getter=$2
>> +	oldvalue_getter=$3
>
> The oldvalue seems to be constant, at least I haven't noticed any
> different getter than 'echo $value', why don't we pass it as constant
> instead?
>
>> +	cond=$4
>> +	attempts=$5
>
> The 'attempts' value seems to be 25 in all cases, why do we pass it as a
> parameter in the first place.
>
>> +	for i in `seq 1 $attempts`;
>> +	do
>> +		tst_resm TINFO "reading $logfile, attempt $i"
>> +
>> +		if [ $(( `eval $newvalue_getter` - `eval $oldvalue_getter` )) $cond ]; then
>> +			return 0
>
> What about returning the difference instead of passing the $cond to this
> fucntion, then we could do something as:
>
> 	res=check_syslog_content "$LOG" "$getter" "$oldval"
> 	if [ $res -ge 1 ]; then
> 		tst_resm TPASS ...
> 	else
> 		tst_resm TFAIL ...
>
>> +		fi
>> +		sleep 1
>
> Can we shorten the sleep (use tst_sleep with subsecond interval) and
> increase number of attempts accordingly?
>
>> +	done
>> +
>> +	tst_resm TFAIL "expected line is not in syslog - giving up."
>> +	get_info_on_fail "$logfile"
>> +	return 1
>> +}
>> +
>> +get_info_on_fail()
>> +{
>> +	status_daemon systemd-journald
>
> We should first check that systemd-journal is even installed, possibly
> with command  if systemd-journal is a binary that is present in one of
> the directories in $PATH.
>
>> +	status_daemon rsyslog
>
> This should use $SYSLOG_DAEMON instead of rsyslog.
>
>> +	cat $1
>> +	set -x
>> +}
>> +
>
