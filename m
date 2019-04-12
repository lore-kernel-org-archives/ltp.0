From: =?unknown-8bit?b?6Ziu5q2j5pe6?= <ruanzw@xiaopeng.com>
Date: Sat, 13 Apr 2019 00:15:18 +0800
Subject: [LTP]
 =?utf-8?b?5Zue5aSN77yaW1BBVENIIHYxXSBpbmNsdWRlL21rL2Vudl9w?=
 =?utf-8?q?ost=2Emk=3A_enable_=5F=5FANDROID=5F=5F_definition_for_Android_b?=
 =?utf-8?q?uild?=
In-Reply-To: <20190412062814.GA18106@dell5510>
References: <1554782710-27144-1-git-send-email-ruanzw@xiaopeng.com>
 <db7687f3-40ca-495e-aa76-efcce204cda7.ruanzw@xiaopeng.com>
 <20190410141615.GA10303@x230> <20190411162724.GC124555@google.com>
 <20190411173755.GA9800@dell5510> <20190411234041.GB381@x230>
 <5bad3463-5c4f-2b70-6500-70d715fd3181@xiaopeng.com>
 <20190412062814.GA18106@dell5510>
Message-ID: <ee797e09-e650-4869-60b7-f6e8e32844bb@xiaopeng.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it


-------- Original Message --------
From: Petr Vorel
Sent: Fri, 12 Apr 2019 08:28:14 +0200
To: 阮正旺
Cc: Sandeep Patil, Ltp, Steve Muckle
Subject: Re: [LTP] 回复：[PATCH v1] include/mk/env_post.mk : enable 
__ANDROID__ definition for Android build
> Hi Zhengwang,
>
>>>> According to [1] android toolchain (I guess both AOSP and NDK toolchain) define
>>>> __ANDROID__. Which is what I'd expect.
>>>> Grepping aosp only dnsmasq and swiftshader use -D__ANDROID__ (these are from
>>>> externals). -DANDROID is use more times (e.g. some drivers in hardware - ril,
>>>> qcom, libsensors and wpa_supplicant).
>>>>   From my point of view, instead of -D__ANDROID__ or -DANDROID I'd prefer to to have
>>>> proper #ifdef HAVE_FOO guarders made by autotools checks. As android is not the
>>>> only minor libc. But I understand it's not always possible and we already use
>>>> some #ifdef __ANDROID__ in library sources and headers, so ack from myself to
>>>> help compilation outside AOSP and without NDK.
>>> Actually I was wrong. 1) I was using NDK toolchain. I'd expect it'd generate
>>> __ANDROID__, but I don't see it in the output. 2) Building for android with
>>> distro toolchain doesn't make sense as it wouldn't have Bionic.
>> 1) Did you build outside AOSP? If so,  I think it is reasonable since
> Yes, with android NDK (for Bionic and special toolchain tweeks).
> Then I use ANDROID=1
>
>> whatever __ANDROID__ or ANDROID are defined by Android build system instead
>> of toolchain. I also tried to build the external/* thing and found ANDROID
>> was actually generated. In my test, ANDROID seems to be the more suitable
>> one, but in fact we can not build ltp inside AOSP because there is no
>> Android.mk in ltp (please correct me if I am wrong...),  so ANDROID is
> Yes, inside AOSP you need to use Android fork [1] which uses usual Android.bp.
> Therefore AOSP does not use our build system.
>
>> meaningless to us here. Actually, this is why I think this patch is still
>> useful, since __ANDROID__ is enough to distinguish what to compile if
>> ANDROID=1 is set with make.
>> 2) In the case of cross-compilation, I think it still makes sense, since we
>> can use the same toolchain, such as clang,  and build parameters (the
>> specify the include headers and libs, etc) as AOSP. This is what I am doing
>> now, you can see my steps I posted in my previous reply. But in this case,
>> we need to obviously set -D__ANDROID__ in CFLAGS. After that , the process
>> should be similar as we launch a build inside AOSP.
> I don't know much about android toolchain, but IMHO there are some other tweaks
> in their build system (to comply changes in Bionic), so not sure if it's even
> possible to avoid using NDK for out-of-aosp tree. See also [2]. But that's a
> question for for Android devs.

According to also [2], the situation gets clear now. All android targets 
should get __ANDROID__ defined by the compiler, but ANDROID only means 
'this is AOSP' and is only for Windows targets. In our case, __ANDROID__ 
should be preferred.


Regards,

Zhengwang

>
>> Regards,
>> Zhengwang
> Kind regards,
> Petr
>
> [1] https://android.googlesource.com/platform/external/ltp/
> [2] https://groups.google.com/forum/#!topic/android-ndk/cf9_f1SLXls
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190413/747d6cf9/attachment.html>
