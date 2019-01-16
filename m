From: Jia Zhang <zhang.jia@linux.alibaba.com>
Date: Wed, 16 Jan 2019 10:53:19 +0800
Subject: [LTP] [PATCH 6/6] ima/ima_violations: Temporarily remove the
 printk rate limit
In-Reply-To: <20190115172401.GC2954@dell5510>
References: <1547518476-34008-1-git-send-email-zhang.jia@linux.alibaba.com>
 <1547518476-34008-7-git-send-email-zhang.jia@linux.alibaba.com>
 <20190115150759.GA2954@dell5510>
 <698e6865-d0af-f71e-d51e-c4791ef1a096@linux.alibaba.com>
 <20190115172401.GC2954@dell5510>
Message-ID: <a4c87b61-33a4-cc8b-489e-023c74bfcc48@linux.alibaba.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it



On 2019/1/16 上午1:24, Petr Vorel wrote:
> Hi Jia,
> 
>>>> +	reset_printk_ratelimit
>>> This should be called in cleanup function.
>>> Actually as it's called only once I'd put it into cleanup function.
> 
>> I recognized that ima_setup.sh already defines a cleanup() so I cannot
>> define another cleanup function in ima_violations.sh. Do you mean moving
>> reset_printk_ratelimit into cleanup() defined in ima_setup.sh?
> No. You can define redefine local cleanup function in ima_violations.sh after
> loading ima_setup.sh and call ima_cleanup() in it.
> 
> + you can change setup in ima_setup.sh:
> TST_CLEANUP="${TST_CLEANUP:-ima_cleanup}"
> (see testcases/network/stress/ipsec/ipsec_lib.sh and testcases/network/stress/ipsec/ipsec_lib.sh and it's usage).
> 
> Cleanup of something defined in setup should be always in cleanup function and
> not in any tests as it's called always after tst_brk() calls (some tests might
> get skipped, so cleanup cannot be in them).

Thanks for the comments. I will send V3 to address this.

Jia

> 
> Kind regards,
> Petr
> 
