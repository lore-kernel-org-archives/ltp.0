From: =?unknown-8bit?b?6Ziu5q2j5pe6?= <ruanzw@xiaopeng.com>
Date: Fri, 12 Apr 2019 12:45:37 +0800
Subject: [LTP]
 =?utf-8?b?5Zue5aSN77yaW1BBVENIIHYxXSBpbmNsdWRlL21rL2Vudl9w?=
 =?utf-8?q?ost=2Emk=3A_enable_=5F=5FANDROID=5F=5F_definition_for_Android_b?=
 =?utf-8?q?uild?=
In-Reply-To: <20190411234041.GB381@x230>
References: <1554782710-27144-1-git-send-email-ruanzw@xiaopeng.com>
 <db7687f3-40ca-495e-aa76-efcce204cda7.ruanzw@xiaopeng.com>
 <20190410141615.GA10303@x230> <20190411162724.GC124555@google.com>
 <20190411173755.GA9800@dell5510> <20190411234041.GB381@x230>
Message-ID: <5bad3463-5c4f-2b70-6500-70d715fd3181@xiaopeng.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

  Hi Petr,


-------- Original Message --------
From: Petr Vorel
Sent: Fri, 12 Apr 2019 01:40:42 +0200
To: Sandeep Patil
Cc: Ltp
Subject: Re: [LTP] 回复：[PATCH v1] include/mk/env_post.mk: enable 
__ANDROID__ definition for Android b uild
> Hi Sandeep,
>
>>>>> -CFLAGS    += -Werror-implicit-function-declaration
>>>>> +CFLAGS    += -Werror-implicit-function-declaration -D__ANDROID__
>>>> Would adding __ANDROID__ definition help building LTP with distro
>>>> cross-compiler? (i.e. no NDK, no inside AOSP tree)?
>>>> I guess so and therefore, I'd be for this change.
>>>> I see some projects added it as well (busybox [1] [2], dnsmasq [3]).
>>>> BTW: where is defined for AOSP and NDK?
>>> I think I've used __ANDROID__ and __BIONIC__ in the past for android-specific
>>> things.  Honestly, I haven't tried to build for Android outside of AOSP tree
>>> yet. I am happy to test this if you tell me how? (sorry for that.)
>> Great, thanks a lot!
>> According to [1] android toolchain (I guess both AOSP and NDK toolchain) define
>> __ANDROID__. Which is what I'd expect.
>> Grepping aosp only dnsmasq and swiftshader use -D__ANDROID__ (these are from
>> externals). -DANDROID is use more times (e.g. some drivers in hardware - ril,
>> qcom, libsensors and wpa_supplicant).
>>  From my point of view, instead of -D__ANDROID__ or -DANDROID I'd prefer to to have
>> proper #ifdef HAVE_FOO guarders made by autotools checks. As android is not the
>> only minor libc. But I understand it's not always possible and we already use
>> some #ifdef __ANDROID__ in library sources and headers, so ack from myself to
>> help compilation outside AOSP and without NDK.
> Actually I was wrong. 1) I was using NDK toolchain. I'd expect it'd generate
> __ANDROID__, but I don't see it in the output. 2) Building for android with
> distro toolchain doesn't make sense as it wouldn't have Bionic.

1) Did you build outside AOSP? If so,  I think it is reasonable since 
whatever __ANDROID__ or ANDROID are defined by Android build system 
instead of toolchain. I also tried to build the external/* thing and 
found ANDROID was actually generated. In my test, ANDROID seems to be 
the more suitable one, but in fact we can not build ltp inside AOSP 
because there is no Android.mk in ltp (please correct me if I am 
wrong...),  so ANDROID is meaningless to us here. Actually, this is why 
I think this patch is still useful, since __ANDROID__ is enough to 
distinguish what to compile if ANDROID=1 is set with make.

2) In the case of cross-compilation, I think it still makes sense, since 
we can use the same toolchain, such as clang,  and build parameters (the 
specify the include headers and libs, etc) as AOSP. This is what I am 
doing now, you can see my steps I posted in my previous reply. But in 
this case, we need to obviously set -D__ANDROID__ in CFLAGS. After that 
, the process should be similar as we launch a build inside AOSP.


Regards,

Zhengwang

>
> Kind regards,
> Petr
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190412/ce8bc90a/attachment.html>
