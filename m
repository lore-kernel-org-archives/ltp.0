From: Shuang Qiu <shuang.qiu@oracle.com>
Date: Tue, 10 Nov 2015 12:03:34 +0800
Subject: [LTP] [PATCH] containers/netns/netns_sysfs.sh:load dummy module
 before collecting sysfs interface
In-Reply-To: <563CE067.90803@redhat.com>
References: <1446195470-7568-1-git-send-email-shuang.qiu@oracle.com>
 <563CE067.90803@redhat.com>
Message-ID: <56416C96.20201@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jiri,
On 11/07/2015 01:16 AM, Jiri Jaburek wrote:
> On 10/30/2015 09:57 AM, shuang.qiu@oracle.com wrote:
>> From: Shuang Qiu <shuang.qiu@oracle.com>
>>
>> If dummy is compiled as module in kernel,it is loaded dynamically when
>> adding dummy device.And it will also create a default dummy interface.So
>> the sysfs_after will have one more interface than sysfs_before which
>> makes testcase #3 failed.Loading dummy module before collecting sysfs
>> interface to workaround such issue.
> I cannot reproduce this on any RHEL or Fedora system, but I can
> reproduce it on Debian (Jessie). If we accounted only for the module
> version of 'dummy', it could be countered by adding
>
>    options dummy numdummies=0
>
> to any /etc/modprobe.d/* config (temporarily), however for the built-in
> version of the module, such option would need to be passed via kernel
> cmdline.
>
> We could check [ -d /sys/module/dummy ] and if it exists, presume that
> no extra setup is necessary, because
>
>    1) if it's a module, our creation of additional dummy interface won't
>       affect existing interfaces as dummy0 is created only on insmod
>       (dummy_init_one() is called during __init with numdummies=1)
>    2) if it's built in, well .. see (1)
>
> otherwise we can try modprobing it and if it fails, end with CONF.
>
> However - wouldn't it be simply easier to add an exception for dummy0
> during the comparison check? The test operates with iface names other
> than dummy0, so a possible namespace bug would be found anyway.
> (See attached diff.)
I did not learn dummy module much before and not sure if there is a 
specify iface name.
As you explained,we will have a expect name and may find a namespace 
bug,so I also prefer your way.

Thanks
Shuang
>
> However the (quite possibly) best solution would be a one which cleans
> up after itself, so maybe the [ -d /sys/module/dummy ] solution with
> explicit modprobe / modprobe -r would work better.
>
> Your choice. :)
>
> Jiri
>
>> Signed-off-by: Shuang Qiu <shuang.qiu@oracle.com>
>> ---
>>   testcases/kernel/containers/netns/netns_sysfs.sh |    4 ++++
>>   1 files changed, 4 insertions(+), 0 deletions(-)
>>
>> diff --git a/testcases/kernel/containers/netns/netns_sysfs.sh b/testcases/kernel/containers/netns/netns_sysfs.sh
>> index 7dea52b..b5791bd 100755
>> --- a/testcases/kernel/containers/netns/netns_sysfs.sh
>> +++ b/testcases/kernel/containers/netns/netns_sysfs.sh
>> @@ -47,6 +47,10 @@ if [ $? -eq 1 ]; then
>>   	tst_brkm TBROK "unable to create a new network namespace"
>>   fi
>>   TST_CLEANUP=cleanup
>> +
>> +#Load dummy module before collecting sysfs interface
>> +lsmod | grep dummy || modprobe dummy
>> +[ $? -eq 0 ] || tst_brkm TBROK "failed to load dummy module"
>>   ls /sys/class/net >sysfs_before
>>   
>>   ns_exec $NS_HANDLE $NS_TYPE mount --make-rprivate /sys
>>


