From: Jia Zhang <zhang.jia@linux.alibaba.com>
Date: Wed, 16 Jan 2019 00:42:13 +0800
Subject: [LTP] [PATCH 6/6] ima/ima_violations: Temporarily remove the
 printk rate limit
In-Reply-To: <20190115150759.GA2954@dell5510>
References: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547518476-34008-7-git-send-email-zhang.jia@linux.alibaba.com>
 <20190115150759.GA2954@dell5510>
Message-ID: <698e6865-d0af-f71e-d51e-c4791ef1a096@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



On 2019/1/15 下午11:07, Petr Vorel wrote:
> Hi Jia, Mimi,
> 
> ...
>> +reset_printk_ratelimit()
>> +{
>> +	[ "$PRINTK_RATE_LIMIT" != "0" ] && \
>> +		sysctl -wq kernel.printk_ratelimit=$PRINTK_RATE_LIMIT
>> +}
> ...
>> @@ -151,6 +163,8 @@ test3()
> 
>>  	validate $num_violations $count $search
> 
>> +	reset_printk_ratelimit
> This should be called in cleanup function.
> Actually as it's called only once I'd put it into cleanup function.

I recognized that ima_setup.sh already defines a cleanup() so I cannot
define another cleanup function in ima_violations.sh. Do you mean moving
reset_printk_ratelimit into cleanup() defined in ima_setup.sh?

Thanks,
Jia

> No need to resent the patchset, if it's the only change, I change it before
> merge.
> 
> @Mimi: do you agree with this change?
> I've seen some issues on some distros when not using auditd daemon,
> but now cannot reproduce them any more.
> 
> Kind regards,
> Petr
> 
