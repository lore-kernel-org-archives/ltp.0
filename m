From: =?unknown-8bit?b?6Ziu5q2j5pe6?= <ruanzw@xiaopeng.com>
Date: Fri, 12 Apr 2019 23:36:46 +0800
Subject: [LTP] [PATCH v1] rt_tgsigqueueinfo01.c: replace definition
 ANDROID with __ANDROID__
In-Reply-To: <20190411174638.GA11576@dell5510>
References: <1554992779-14595-1-git-send-email-ruanzw@xiaopeng.com>
 <20190411174638.GA11576@dell5510>
Message-ID: <ee2af517-8cb1-de29-0ec1-a16818087d0b@xiaopeng.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Petr, Sandeep, Steve,


-------- Original Message --------
From: Petr Vorel
Sent: Thu, 11 Apr 2019 19:46:38 +0200
To: Zhengwang Ruan, Steve Muckle, Sandeep Patil
Cc: Ltp
Subject: Re: [LTP] [PATCH v1] rt_tgsigqueueinfo01.c: replace definition 
ANDROID with __ANDROID__
> Hi,
>
>> Replace the incorrect definition of ANDROID with __ANDROID__.
>> +++ b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
>> @@ -25,7 +25,7 @@
>>   #include "tst_test.h"
>>   #include "lapi/syscalls.h"
>> -#ifndef ANDROID
>> +#ifndef __ANDROID__
> Simple grep in AOSP tree would be for this change (and I'd personally prefer it as well)
> I'd kindly ask android devs which one is correct :). BTW ANDROID was added by Steve.

According to also [1], this patch is acceptable, right?

>
> $ cgrep '#if.* __ANDROID__' |wc -l
> 405
>
> $ cgrep '#if.* ANDROID[^_]' |wc -l
> 22
>
> Kind regards,
> Petr

Regards,

Zhengwang

[1] https://groups.google.com/forum/#!topic/android-ndk/cf9_f1SLXls

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190412/9d22423b/attachment.html>
