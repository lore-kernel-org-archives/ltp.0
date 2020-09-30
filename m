From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Wed, 30 Sep 2020 20:58:05 +0800
Subject: [LTP] [PATCH] controllers/cpuset_base_ops_testset.sh: Accept
 either 0 or -EINVAL when passing '0-'
In-Reply-To: <20200930124018.GF6611@yuki.lan>
References: <20200929025606.322543-1-yangx.jy@cn.fujitsu.com>
 <20200930104709.GC6611@yuki.lan> <5F7479CF.4090007@cn.fujitsu.com>
 <20200930124018.GF6611@yuki.lan>
Message-ID: <5F7480DD.8080803@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/9/30 20:40, Cyril Hrubis wrote:
> Hi!
>> Thanks for your reply. :-)
>> 1) I still got '0' value instead of -EINVAL on Centos 6.10(2.6.32-754)
>> so not sure why we have the wrong kernel check before.
>>       Perhaps, is there anothe older kernel commit to change the behavior
>> as well?
>> 2) I don't think that kernel check is enough because  the change of
>> behavior may be backported into old kernel.
>>
>> How about removing the combination directly as Richard suggested on #695.
> So what about disabling the test on older kernels completely and expect
> EINVAL on 4.3 and newer?
>
> That will still catch regression in mailine kernel but will not fail on
> older ones.
Hi Cyril,

It is reasonable for me to foucs on new kernel(4.3 and newer).
I will send v2 patch soon. :-)

BTW:
Sorry, I misread the meaning of 'tst_kvcmp -lt "3.0 RHEL6:2.6.32"'.
It means that writing '0-' also get -EINVAL on very old 
kernel(3.0/RHEL6:2.6.32 and older),
so I think there is another old commit to change the behavior as well.

Thanks,
Xiao Yang


