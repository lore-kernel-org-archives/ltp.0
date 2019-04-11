From: =?unknown-8bit?b?6Ziu5q2j5pe6?= <ruanzw@xiaopeng.com>
Date: Thu, 11 Apr 2019 11:38:49 +0800
Subject: [LTP]
 =?utf-8?b?5Zue5aSN77yaW1BBVENIIHYxXSBpbmNsdWRlL21rL2Vudl9w?=
 =?utf-8?q?ost=2Emk=3A_enable_=5F=5FANDROID=5F=5F_definition_for_Android_b?=
 =?utf-8?q?uild?=
In-Reply-To: <20190410141615.GA10303@x230>
References: <1554782710-27144-1-git-send-email-ruanzw@xiaopeng.com>
 <db7687f3-40ca-495e-aa76-efcce204cda7.ruanzw@xiaopeng.com>
 <20190410141615.GA10303@x230>
Message-ID: <be95833a-a39c-493b-12af-3766345f96fc@xiaopeng.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

Hi Petr,


-------- Original Message --------
From: Petr Vorel
Sent: Wed, 10 Apr 2019 16:16:15 +0200
To: Sandeep Patil, Steve Muckle
Cc: Ltp, Zhengwang Ruan, Cyril Hrubis
Subject: Re: [LTP] 回复：[PATCH v1] include/mk/env_post.mk : enable 
__ANDROID__ definition for Android build
> Hi Sandeep, Steve,
>
>> Could anyone help me to review this patch? This is useful to cross-compile ltp for Android without specifying '-D__ANDROID__' in configure step.
>> Thanks!
>> Zhengwang
>
>> ------------------------------------------------------------------
>> 发件人：Zhengwang Ruan <ruanzw@xiaopeng.com>
>> 发送时间：2019年4月9日(星期二) 12:05
>> 收件人：ltp <ltp@lists.linux.it>
>> 抄　送：Zhengwang Ruan <ruanzw@xiaopeng.com>
>> 主　题：[PATCH v1] include/mk/env_post.mk: enable __ANDROID__ definition for Android build
>> Enable the __ANDROID__ definition by default for Android build, otherwise we
>> should manually enable it by configure command.
>> Signed-off-by: Zhengwang Ruan <ruanzw@xiaopeng.com>
>> ---
>>   include/mk/env_post.mk | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> diff --git a/include/mk/env_post.mk b/include/mk/env_post.mk
>> index 913bdf5..7953e0a 100644
>> --- a/include/mk/env_post.mk
>> +++ b/include/mk/env_post.mk
>> @@ -44,7 +44,7 @@ endif
>>   ifeq ($(ANDROID),1)
>>   # There are many undeclared functions, it's best not to accidentally overlook
>>   # them.
>> -CFLAGS    += -Werror-implicit-function-declaration
>> +CFLAGS    += -Werror-implicit-function-declaration -D__ANDROID__
> Would adding __ANDROID__ definition help building LTP with distro
> cross-compiler? (i.e. no NDK, no inside AOSP tree)?
> I guess so and therefore, I'd be for this change.
> I see some projects added it as well (busybox [1] [2], dnsmasq [3]).
> BTW: where is defined for AOSP and NDK?


I found that '-DANDROID' instead of '-D__ANDROID__' was passed while 
cross-compiling binaries in my AOSP project.


Thanks!

Zhengwang

>
> BTW (@cyril): I guess -Werror-implicit-function-declaration is the code which
> requires adding <string.h> and <strings.h> (see my fix 4053a2551 ("lib: Add
> missing <string.h> and <strings.h> includes")), I'd be for either adding it to
> for all or removing it.
>
>>   LDFLAGS    += -L$(top_builddir)/lib/android_libpthread
>>   LDFLAGS    += -L$(top_builddir)/lib/android_librt
> Kind regards,
> Petr
>
> [1] https://git.busybox.net/busybox/tree/configs/android_defconfig
> [2] https://git.busybox.net/busybox/tree/configs/android_ndk_defconfig
> [3] http://thekelleys.org.uk/gitweb/?p=dnsmasq.git;a=blob_plain;f=bld/Android.mk;hb=HEAD
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190411/ff848e3f/attachment.html>
