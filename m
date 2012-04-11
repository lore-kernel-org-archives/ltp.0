Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rejish.rajagopala@sasken.com>) id 1SHtrS-0003TB-Aw
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 09:29:10 +0000
Received: from mta-blr1.sasken.com ([203.200.200.72])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1SHtrN-0006JJ-6o
	for ltp-list@lists.sourceforge.net; Wed, 11 Apr 2012 09:29:10 +0000
From: Rejish Rajagopala <rejish.rajagopala@sasken.com>
Date: Wed, 11 Apr 2012 14:58:29 +0530
Message-ID: <6F91E0FFDA542149961F7BDED2D2B94B56372F8DFE@EXGMBX01.sasken.com>
References: <loom.20120228T103647-261@post.gmane.org>
	<20120229162236.GA29987@saboteur.suse.cz>
	<6F91E0FFDA542149961F7BDED2D2B94B549365C4B6@EXGMBX01.sasken.com>
	<20120302125851.GA8394@saboteur.suse.cz>
	<6F91E0FFDA542149961F7BDED2D2B94B549F7328E7@EXGMBX01.sasken.com>
	<CAMhs6YzaQ_1gKqCskOX1F8db-nKg=P_Zsy-FgHYnhczDvm9UhQ@mail.gmail.com>
	<6F91E0FFDA542149961F7BDED2D2B94B56372F8DCD@EXGMBX01.sasken.com>
	<CAMhs6Yyv_-v_TWKpVxv6tVeyg=jnH_VDZpaOQYnkZxF5C-O2fQ@mail.gmail.com>
	<6F91E0FFDA542149961F7BDED2D2B94B56372F8DEA@EXGMBX01.sasken.com>,
	<3319EDD9-0FB3-4DB6-9251-ACFC01032122@gmail.com>
In-Reply-To: <3319EDD9-0FB3-4DB6-9251-ACFC01032122@gmail.com>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [LTP] Need help in cross compiling LTP for android
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: Garrett Cooper <yanegomi@gmail.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi,

Please find more details about the error.

+ /u/ltp/android-ndk-r7b/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin/arm-linux-androideabi-gcc -march=armv7-a -mtune=xscale -msoft-float -fpic -mthumb-interwork -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -O2 -fomit-frame-pointer -funswitch-loops -finline-limit=300 -g -O2 -fno-strict-aliasing -pipe -Wall -I/u/ltp/android-ndk-r7b/platforms/android-14/arch-arm/usr/include -D__ARM_ARCH_7__ -D__ARM_ARCH_7A__ -D__ARM_ARCH_7R__ -D__ARM_ARCH_7M__ -DANDROID -D__linux__ -DDEV_BSIZE=512 -DSIGCLD=SIGCHLD -D_FILE_OFFSET_BITS=64 -I/u/ltp/ltp-full-20120104/testcases/kernel/include -D_GNU_SOURCE -I/u/ltp/ltp-full-20120104/testcases/kernel/timers/clock_gettime/../include -I../../../../include -I../../../../include -nostdlib -Bdynamic -Wl,-dynamic-linker,/system/bin/linker -Wl,--gc-sections -Wl,-z,nocopyreloc -L/u/ltp/android-ndk-r7b/platforms/android-14/arch-arm/usr/lib -L../../../../lib clock_gettime02.c /u/ltp/android-ndk-r7b/platforms/android-1
 4/arch-arm/usr/lib/crtbegin_dynamic.o -Wl,-rpath-link=/u/ltp/android-ndk-r7b/platforms/android-14/arch-arm/usr/lib /u/ltp/android-ndk-r7b/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin/../lib/gcc/arm-linux-androideabi/4.4.3/libgcc.a -lc /u/ltp/android-ndk-r7b/platforms/android-14/arch-arm/usr/lib/crtend_android.o -L/u/ltp/android-ndk-r7b/platforms/android-14/arch-arm/usr/lib -lltp -o clock_gettime02
../../../../lib/libltp.a(parse_opts.o): In function `usc_test_looping':
/u/ltp/ltp-full-20120104/lib/parse_opts.c:716: undefined reference to `__aeabi_fcmpeq'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:725: undefined reference to `__aeabi_fcmpeq'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:734: undefined reference to `__aeabi_fcmpeq'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:735: undefined reference to `__aeabi_i2f'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:735: undefined reference to `__aeabi_fmul'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:735: undefined reference to `__aeabi_f2iz'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:746: undefined reference to `__aeabi_fcmpeq'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:772: undefined reference to `__aeabi_fcmpeq'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:716: undefined reference to `__aeabi_fcmpeq'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:727: undefined reference to `__aeabi_fmul'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:727: undefined reference to `__aeabi_f2iz'
../../../../lib/libltp.a(parse_opts.o): In function `parse_opts':
/u/ltp/ltp-full-20120104/lib/parse_opts.c:289: undefined reference to `__aeabi_d2f'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:293: undefined reference to `__aeabi_d2f'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:294: undefined reference to `__aeabi_fcmpeq'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:438: undefined reference to `__aeabi_fcmpge'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:441: undefined reference to `__aeabi_f2d'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:421: undefined reference to `__aeabi_fcmpge'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:425: undefined reference to `__aeabi_fcmpeq'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:408: undefined reference to `__aeabi_fcmpge'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:413: undefined reference to `__aeabi_fcmpeq'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:424: undefined reference to `__aeabi_f2d'
/u/ltp/ltp-full-20120104/lib/parse_opts.c:411: undefined reference to `__aeabi_f2d'
collect2: ld returned 1 exit status

Thanks & Regards,
Rejish
________________________________________
From: Garrett Cooper [yanegomi@gmail.com]
Sent: Wednesday, April 11, 2012 2:53 PM
To: Rejish Rajagopala
Cc: Maxin B John; ltp-list@lists.sourceforge.net
Subject: Re: [LTP] Need help in cross compiling LTP for android

Not enough context was provided to determine why linking failed.

On Apr 2, 2012, at 2:33 AM, Rejish Rajagopala <rejish.rajagopala@sasken.com> wrote:

> Hi Maxin,
>
> I could resolve the configuration issue and I could cross compile on of the LTP modules (pty) for Android. Now I am trying to cross compile another  module (timers) for Andorid using the tool chain NDK r-7. I am facing the below error:
>
> collect2: ld returned 1 exit status
> make[2]: *** [clock_gettime02] Error 1
> make[2]: Leaving directory `/u/ltp/ltp-full-20120104/testcases/kernel/timers/clock_gettime'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/u/ltp/ltp-full-20120104/testcases/kernel/timers'
> make: *** [testcases/kernel/timers-all] Error 2
>
>
> Please let me know why this is coming and what should I do to overcome this issue.
>
> Thanks & Regards,
> Rejish
> ________________________________________
> From: Maxin B John [maxin.john@gmail.com]
> Sent: Thursday, March 08, 2012 2:27 PM
> To: Rejish Rajagopala
> Cc: Cyril Hrubis; ltp-list@lists.sourceforge.net
> Subject: Re: [LTP] Need help in cross compiling LTP for android
>
> Hi,
>
> On Wed, Mar 7, 2012 at 12:21 PM, Rejish Rajagopala
> <rejish.rajagopala@sasken.com> wrote:
>> Hi Maxin,
>>
>> Thanks for your reply.
>>
>> I downloaded busybox and super user apk from android market, But its not working.
>
> It's a bit difficult to believe as you  are doubting the integrity of
> "Android Market" here :)
>
>> Even I tried cross compiling busybox with Android tool chain. I used the following script to cross compile it.
>
> IMHO, cross compiling LTP for any platform isn't really a nice topic
> of discussion in a mailing-list like this.
> Your life will be a lot simpler if you try to use the available
> "busybox" package in Android Market itself.
>
>> #!/bin/sh
>> # Build Busybox against Android's bionic
>> # Originally by Dan Fandrich
>> #
>> # Configure with android_defconfig
>> # This file has been tested on Android Froyo (the lack of ttyname_r in
>> # the must be patched around) and Gingerbread.
>>
>> # Point this to the Android root directory; it's used in the defconfig CFLAGS
>> export A="/u/android-ndk-r5b"
>>
>> # Android product being built
>> P=android-3
>>
>> # Toolchain version in use by this version of Android
>> GCCVER=4.4.0
>>
>> export PATH="$A/toolchains/arm-eabi-4.4.0/prebuilt/linux-x86/bin/arm-eabi-$GCCVER:$PATH"
>>
>> # Set the linker flags; compiler flags are in the defconfig file
>> if grep "^CONFIG_STATIC=y" .config >/dev/null ; then
>>       # Static linking
>>       LDFLAGS="-static -Xlinker -z -Xlinker muldefs -nostdlib $A/platforms/$P/arch-arm/usr/lib/crtbegin_static.o $A/platforms/$P/arch-arm/usr/lib/crtend_android.o -L$A/platforms/$P/arch-arm/usr/lib -L$A/platforms/$P/arch-arm/usr/lib/libm.so -L$A/platforms/$P/arch-arm/usr/lib/libc.so"
>>       LDLIBS="m c gcc"
>> else
>>       # Dynamic linking
>>       LDFLAGS="-Xlinker -z -Xlinker muldefs -nostdlib -Bdynamic -Xlinker -Xlinker -dynamic-linker -Xlinker /system/bin/linker -Xlinker -z -Xlinker nocopyreloc -#Xlinker --no-undefined $A/platforms/$P/arch-arm/usr/lib/crtbegin_dynamic.o $A/platforms/$P/arch-arm/usr/lib/crtend_android.o -L$A/platforms/$P/arch-arm/usr/lib/"
>>       LDLIBS="dl m c gcc"
>> fi
>>
>> make EXTRA_LDFLAGS="$LDFLAGS" LDLIBS="$LDLIBS" "$@"
>>
>> In the above script am facing some issue with linkers
>> [ LDFLAGS="-Xlinker -z -Xlinker muldefs -nostdlib -Bdynamic -Xlinker -T$A/build/core/armelf.x -Xlinker -dynamic-linker -Xlinker /system/bin/linker -Xlinker -z -Xlinker nocopyreloc -Xlinker --no-undefined $A/out/target/product/$P/obj/lib/crtbegin_dynamic.o $A/out/target/product/$P/obj/lib/crtend_android.o -L$A/out/target/product/$P/obj/lib" ]
>>
>> That is am not able to set linker properly and so system is failing to recognize it. Can you please look into and suggest me what to do.
>
> Hmm.. The Android toolchain (Android NDK) wasn't really a "developer
> friendly" one and it still keep that status. The procedure and helper
> scripts doesn't work nice with every NDK releases.  Just start with a
> simple hello world program and then proceed to something complex like
> LTP.
>
>> Thanks & Regards,
>> Rejish
>
> Warm Regards,
> Maxin B. John
> ________________________________________
>> From: Maxin B John [maxin.john@gmail.com]
>> Sent: Tuesday, March 06, 2012 5:27 PM
>> To: Rejish Rajagopala
>> Cc: Cyril Hrubis; ltp-list@lists.sourceforge.net
>> Subject: Re: [LTP] Need help in cross compiling LTP for android
>>
>> Hi,
>>
>> On Mon, Mar 5, 2012 at 6:25 AM, Rejish Rajagopala
>> <rejish.rajagopala@sasken.com> wrote:
>>> Hi Cyril,
>>> Thanks for your input.
>>> I have one more doubt that is if I want to check whether my LTP has been cross compiled properly then how can I confirm that without running the LTP in android phone.
>>
>> You can copy any one of the cross compiled binaries in LTP (eg:
>> testcases/kernel/syscalls/open/open01) to Android device and execute
>> it there.
>> It is better to have "busybox" ready in your Android device to run LTP
>> properly.  If you finds it difficult to cross-compile "Busybox", it is
>> available in Android Market also.
>>
>>> Thanks & Regards,
>>> Rejish
>>
>> Warm Regards,
>> Maxin B. John
>> ________________________________________
>>> From: Cyril Hrubis [chrubis@suse.cz]
>>> Sent: Friday, March 02, 2012 6:28 PM
>>> To: Rejish Rajagopala
>>> Cc: ltp-list@lists.sourceforge.net
>>> Subject: Re: [LTP] Need help in cross compiling LTP for android
>>>
>>> Hi!
>>>> + LOGFILE_NAME=2012_Mar_02-14h_25m_52s
>>>> + LOGFILE=-l /data/ltp/make_2802_02_2012/results/LTP_RUN_ON-2012_Mar_02-14h_25m_52s.log
>>>> + ALT_DIR_RES=1
>>>> + PRETTY_PRT= -p
>>>> + [ !  ]
>>>> + ALT_DIR_OUT=1
>>>> + [ !  ]
>>>> + [ ! -l /data/ltp/make_2802_02_2012/results/LTP_RUN_ON-2012_Mar_02-14h_25m_52s.log ]
>>>> + basename 2012_Mar_02-14h_25m_52s
>>>> + FAILED_FILE_NAME=2012_Mar_02-14h_25m_52s
>>>> + FAILCMDFILE=-C /data/ltp/make_2802_02_2012/output/LTP_RUN_ON-2012_Mar_02-14h_25m_52s.failed
>>>> + [ 0 -eq 1 ]
>>>> + [ 1 -eq 1 ]
>>>> + [ ! -d /data/ltp/make_2802_02_2012/output ]
>>>> + [ 1 -eq 1 ]
>>>> + echo INFO: creating /data/ltp/make_2802_02_2012/results directory
>>>> INFO: creating /data/ltp/make_2802_02_2012/results directory
>>>> + [ ! -d /data/ltp/make_2802_02_2012/results ]
>>>> + mkdir -m 777 -p /data/ltp/make_2802_02_2012/tmp
>>>> mkdir failed for -m, File exists
>>>> + echo FATAL: Unable to make temporary directory /data/ltp/make_2802_02_2012/tmp
>>>> FATAL: Unable to make temporary directory /data/ltp/make_2802_02_2012/tmp
>>>
>>> Hmm, this is strange, mkdir -p must not fail with 'File exists'.
>>>
>>>> + export TMPTEMPLATE=/data/ltp/make_2802_02_2012/tmp/ltp-XXXXXXXXXX
>>>> + mktemp -d /data/ltp/make_2802_02_2012/tmp/ltp-XXXXXXXXXX
>>>> + TMP=/data/ltp/make_2802_02_2012/tmp/ltp-hYXbVD3460
>>>> + export TMP
>>>> + export TMPDIR=/data/ltp/make_2802_02_2012/tmp/ltp-hYXbVD3460
>>>> + chmod 777 /data/ltp/make_2802_02_2012/tmp/ltp-hYXbVD3460
>>>> + cd /data/ltp/make_2802_02_2012/tmp/ltp-hYXbVD3460
>>>> + [ -n  ]
>>>> + [ 0 -eq 1 ]
>>>> + [ -z  ]
>>>> + [ -z  ]
>>>> + cat
>>>> + + cat /data/ltp/make_2802_02_2012/scenario_groups/default
>>>> tr \012
>>>
>>> ...
>>>
>>>> + rm -f /data/ltp/make_2802_02_2012/tmp/ltp-hYXbVD3460/cat_ok.3443
>>>> rm failed for -f, No such file or directory
>>>
>>> And this is even much more wrong.
>>>
>>> I'm not familiar with android but this sugests that you have very
>>> crippled busybox or whatever is installed there to provide basic
>>> commands like rm, mkdir and so.
>>>
>>> --
>>> Cyril Hrubis
>>> chrubis@suse.cz
>>>
>>> SASKEN BUSINESS DISCLAIMER: This message may contain confidential, proprietary or legally privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email.
>>> Read Disclaimer at http://www.sasken.com/extras/mail_disclaimer.html
>>>
>>> ------------------------------------------------------------------------------
>>> Keep Your Developer Skills Current with LearnDevNow!
>>> The most comprehensive online learning library for Microsoft developers
>>> is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
>>> Metro Style Apps, more. Free future releases when you subscribe now!
>>> http://p.sf.net/sfu/learndevnow-d2d
>>> _______________________________________________
>>> Ltp-list mailing list
>>> Ltp-list@lists.sourceforge.net
>>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>
> ------------------------------------------------------------------------------
> Better than sec? Nothing is better than sec when it comes to
> monitoring Big Data applications. Try Boundary one-second
> resolution app monitoring today. Free.
> http://p.sf.net/sfu/Boundary-dev2dev
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list

------------------------------------------------------------------------------
Better than sec? Nothing is better than sec when it comes to
monitoring Big Data applications. Try Boundary one-second 
resolution app monitoring today. Free.
http://p.sf.net/sfu/Boundary-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
