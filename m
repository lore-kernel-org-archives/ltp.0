From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 30 Sep 2020 20:27:59 +0800
Subject: [LTP] [PATCH] controllers/cpuset_base_ops_testset.sh: Accept
 either 0 or -EINVAL when passing '0-'
In-Reply-To: <20200930104709.GC6611@yuki.lan>
References: <20200929025606.322543-1-yangx.jy@cn.fujitsu.com>
 <20200930104709.GC6611@yuki.lan>
Message-ID: <5F7479CF.4090007@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/9/30 18:47, Cyril Hrubis wrote:
> Hi!
>> When we write '0-' to cpuset.cpus/cpuset.mems, new bitmap_parselist()
>> in kernel(e.g. newer than v4.2) treats it as an invalid value and old
>> one treats it as a valid '0':
>> -------------------------------------------
>> on v5.8.0:
>>   # echo 0->  cpuset.cpus
>>   -bash: echo: write error: Invalid argument
>>   # echo 0->  cpuset.mems
>>   -bash: echo: write error: Invalid argument
>>
>> on v4.0.0:
>>   # echo '0-'>cpuset.cpus
>>   # cat cpuset.cpus
>>   0
>>   # echo '0-'>cpuset.mems
>>   # cat cpuset.cpus
>>   0
>> -------------------------------------------
>> Note: commit d9282cb66353b changes the behavior.
>>
>> Drop the check of kernel version and accept either 0 or -EINVAL
>> because the change of behavior can be backported into old kernel.
> Why can't we just simply adjust the kernel check, it looks like the
> commit you mentioned was added to 4.3 so it should be fixed by changing
> the line to:
>
> 	if tst_kvcmp -lt "4.3 RHEL6:2.6.32"; then
>
> We want to at least keep the check for kernels newer than 4.3 just to
> make sure that kernel keeps rejecting the '0-' invalid value.
Hi Cyril,

Thanks for your reply. :-)
1) I still got '0' value instead of -EINVAL on Centos 6.10(2.6.32-754) 
so not sure why we have the wrong kernel check before.
     Perhaps, is there anothe older kernel commit to change the behavior 
as well?
2) I don't think that kernel check is enough because  the change of 
behavior may be backported into old kernel.

How about removing the combination directly as Richard suggested on #695.

Best Regards,
Xiao Yang


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200930/d1be3b57/attachment-0001.htm>
