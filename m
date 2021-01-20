From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Wed, 20 Jan 2021 09:45:37 +0800
Subject: [LTP] [PATCH v3 1/2] cpuset: skip test when cpu or nodes are
 not numbered continuously from 0
In-Reply-To: <YAbAvorwMJUaeIGP@pevik>
References: <X/8ehCeZbWs6TIA4@yuki.lan>
 <1610590728-15813-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <600543C9.9080708@cn.fujitsu.com> <YAbAvorwMJUaeIGP@pevik>
Message-ID: <60078B41.4020906@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr
> Hi Xu,
>
>>> These cpuset cases(cpuset_base_ops_test, cpuset_hierarchy_test, cpuset_inherit_test...)
>>> seem all not consider the situation(cpus/memory are not numbered continuously). It is
>>> continuously from 0 as default. Skip test if there are not numbered continuously to
>>> avoid unexpected error.
>
>>> This patch also fix cpu_inherit error by using original mem value.
>
>>> cpuset_inherit case fails on 4 numa nodes pc, as below:
>>> cpuset_inherit 1 TPASS: cpus: Inherited information is right!
>>> cpuset_inherit 3 TPASS: cpus: Inherited information is right!
>>> cpuset_inherit 5 TPASS: cpus: Inherited information is right!
>>> cpuset_inherit 7 TPASS: cpus: Inherited information is right!
>>> cpuset_inherit 9 TPASS: cpus: Inherited information is right!
>>> cpuset_inherit 11 TPASS: cpus: Inherited information is right!
>>> cpuset_inherit 13 TPASS: mems: Inherited information is right!
>>> cpuset_inherit 15 TPASS: mems: Inherited information is right!
>>> cpuset_inherit 17 TPASS: mems: Inherited information is right!
>>> cpuset_inherit 19 TPASS: mems: Inherited information is right!
>>> cpuset_inherit 21 TPASS: mems: Inherited information is right!
>>> cpuset_inherit 23 TFAIL: mems: Test result - 0-3 Expected string - "4"
>
> Good catch :).
>
> BTW how this happen? hot-unplug on lpar?
> Maybe add brief note about it into commit message.
I have added it and merged this patchset, thanks for you and cyril's review.
>
> Reviewed-by: Petr Vorel<pvorel@suse.cz>
>
> ...
>>> +++ b/testcases/kernel/controllers/cpuset/cpuset_funcs.sh
>>> @@ -26,23 +26,34 @@
>
>>>    . test.sh
>
>>> +cpu_string="`cat /sys/devices/system/cpu/online`"
>>>    NR_CPUS=`tst_ncpus`
>>> +
>>>    if [ -f "/sys/devices/system/node/has_high_memory" ]; then
>>> -	N_NODES="`cat /sys/devices/system/node/has_high_memory | tr ',' ' '`"
>>> +	mem_string="`cat /sys/devices/system/node/has_high_memory`"
>>>    else
>>> -	N_NODES="`cat /sys/devices/system/node/has_normal_memory | tr ',' ' '`"
>>> +	mem_string="`cat /sys/devices/system/node/has_normal_memory`"
>>>    fi
>>> +N_NODES="`echo $mem_string | tr ',' ' '`"
>
> nit: I'd personally do:
>
> f="/sys/devices/system/node/has_high_memory"
> [ -f "$f" ] || f="/sys/devices/system/node/has_normal_memory"
> N_NODES="$(cat $f | tr ',' ' ')"
>
> but that's a tiny detail.
>
> It'd be great to rewrite these tests into C.
Yes, I will create a issue to avoid we forget this.
>
> Kind regards,
> Petr
>
>
> .
>



