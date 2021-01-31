From: Xiao Yang <ice_yangxiao@163.com>
Date: Sun, 31 Jan 2021 15:51:35 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/sched_getparam{01,
 02}: Convert to new API and cleanup
In-Reply-To: <YBQL7EiQNkqv7nuV@yuki.lan>
References: <20201214063729.1656200-1-yangx.jy@cn.fujitsu.com>
 <20210126022631.2566169-1-yangx.jy@cn.fujitsu.com>
 <YBQL7EiQNkqv7nuV@yuki.lan>
Message-ID: <80aca9cc-2a64-cd12-90b1-a00148805a7d@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 1/29/21 9:21 PM, Cyril Hrubis wrote:
> Hi!
>> +		if (param.sched_priority) {
>> +			tst_res(TFAIL,
>> +				"sched_getparam(%d) got wrong sched_priority %d, expected 0",
>> +				pids[n], param.sched_priority);
>> +			exit(1);
> I do not think that we should do exit(1) here, since that would cause
> TBROK in the library when we reap the children. The failure is
> propagated by the tst_res(TFAIL, ...) here already.
>
> With the exit(1) replaced by exit(0):
>
> 	Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Hi Cyril,

Thanks for your comment.? Pushed with two minor changes:

Replaced exit(1) and updated description in sched_getparam01.

Best Regards,

Xiao Yang

>

