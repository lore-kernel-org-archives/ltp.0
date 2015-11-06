From: Shuang Qiu <shuang.qiu@oracle.com>
Date: Fri, 06 Nov 2015 18:28:21 +0800
Subject: [LTP] [PATCH] containers/netns/netns_sysfs.sh:load dummy module
 before collecting sysfs interface
In-Reply-To: <20151105140528.GE7226@rei>
References: <1446195470-7568-1-git-send-email-shuang.qiu@oracle.com>
 <20151104124927.GC17823@rei> <563ADF10.2030803@oracle.com>
 <20151105140528.GE7226@rei>
Message-ID: <563C80C5.2080406@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 11/05/2015 10:05 PM, Cyril Hrubis wrote:
> Hi!
>>>> diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
>>>> index 7dea52b..b5791bd 100755
>>>> --- a/testcases/kernel/containers/netns/netns_sysfs.sh
>>>> +++ b/testcases/kernel/containers/netns/netns_sysfs.sh
>>>> @@ -47,6 +47,10 @@ if [ $? -eq 1 ]; then
>>>>    	tst_brkm TBROK "unable to create a new network namespace"
>>>>    fi
>>>>    TST_CLEANUP=cleanup
>>>> +
>>>> +#Load dummy module before collecting sysfs interface
>>>> +lsmod | grep dummy || modprobe dummy
>>>> +[ $? -eq 0 ] || tst_brkm TBROK "failed to load dummy module"
>>> But this will fail when dummy wasn't compiled in the kernel, right?
>> Yes,if dummy wasn't compiled in the kernel,it will also fail when adding
>> dummy device in the next step:
>> ===cut===
>> ns_exec $NS_HANDLE $NS_TYPE ip link add $DUMMYDEV type dummy || \
>>       tst_brkm TBROK "failed to add a new dummy device"
>> ===cut===
> I meaned "wasn't compiled as module" i.e. compiled in kernel, sorry for
> the confusion. In that case this would work fine but the modprobe would
> fail.
Aha,yes,thanks for clarification.
>
>>> Since modprobe will exit with 1 when module couldn't be found. So we
>>> should either just call 'modprobe dummy' and ignore the return value or
>>> change the code to ignore the default dummy interface.
>> I prefer 'modprobe dummy' and ignore the return value,because I'm not
>> sure whether there is any other default dummy interface name except
>> "dummy0".
> Sounds good to me.
ok,I will submit another patch.

Thanks
Shuang
>

