Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1SPYN7-0002yp-VH
	for ltp-list@lists.sourceforge.net; Wed, 02 May 2012 12:09:29 +0000
Date: Wed, 2 May 2012 14:07:42 +0200
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120502120742.GB366@saboteur.suse.cz>
References: <20120229162236.GA29987@saboteur.suse.cz>
	<6F91E0FFDA542149961F7BDED2D2B94B549365C4B6@EXGMBX01.sasken.com>
	<20120302125851.GA8394@saboteur.suse.cz>
	<6F91E0FFDA542149961F7BDED2D2B94B549F7328E7@EXGMBX01.sasken.com>
	<CAMhs6YzaQ_1gKqCskOX1F8db-nKg=P_Zsy-FgHYnhczDvm9UhQ@mail.gmail.com>
	<6F91E0FFDA542149961F7BDED2D2B94B56372F8DCD@EXGMBX01.sasken.com>
	<CAMhs6Yyv_-v_TWKpVxv6tVeyg=jnH_VDZpaOQYnkZxF5C-O2fQ@mail.gmail.com>
	<6F91E0FFDA542149961F7BDED2D2B94B56372F8DEA@EXGMBX01.sasken.com>
	<3319EDD9-0FB3-4DB6-9251-ACFC01032122@gmail.com>
	<6F91E0FFDA542149961F7BDED2D2B94B56372F8DFE@EXGMBX01.sasken.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6F91E0FFDA542149961F7BDED2D2B94B56372F8DFE@EXGMBX01.sasken.com>
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
To: Rejish Rajagopala <rejish.rajagopala@sasken.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> + /u/ltp/android-ndk-r7b/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin/arm-linux-androideabi-gcc -march=armv7-a -mtune=xscale -msoft-float -fpic -mthumb-interwork -ffunction-sections -funwind-tables -fstack-protector -fno-short-enums -O2 -fomit-frame-pointer -funswitch-loops -finline-limit=300 -g -O2 -fno-strict-aliasing -pipe -Wall -I/u/ltp/android-ndk-r7b/platforms/android-14/arch-arm/usr/include -D__ARM_ARCH_7__ -D__ARM_ARCH_7A__ -D__ARM_ARCH_7R__ -D__ARM_ARCH_7M__ -DANDROID -D__linux__ -DDEV_BSIZE=512 -DSIGCLD=SIGCHLD -D_FILE_OFFSET_BITS=64 -I/u/ltp/ltp-full-20120104/testcases/kernel/include -D_GNU_SOURCE -I/u/ltp/ltp-full-20120104/testcases/kernel/timers/clock_gettime/../include -I../../../../include -I../../../../include -nostdlib -Bdynamic -Wl,-dynamic-linker,/system/bin/linker -Wl,--gc-sections -Wl,-z,nocopyreloc -L/u/ltp/android-ndk-r7b/platforms/android-14/arch-arm/usr/lib -L../../../../lib clock_gettime02.c /u/ltp/android-ndk-r7b/platforms/android
 -1
>  4/arch-arm/usr/lib/crtbegin_dynamic.o -Wl,-rpath-link=/u/ltp/android-ndk-r7b/platforms/android-14/arch-arm/usr/lib /u/ltp/android-ndk-r7b/toolchains/arm-linux-androideabi-4.4.3/prebuilt/linux-x86/bin/../lib/gcc/arm-linux-androideabi/4.4.3/libgcc.a -lc /u/ltp/android-ndk-r7b/platforms/android-14/arch-arm/usr/lib/crtend_android.o -L/u/ltp/android-ndk-r7b/platforms/android-14/arch-arm/usr/lib -lltp -o clock_gettime02
> ../../../../lib/libltp.a(parse_opts.o): In function `usc_test_looping':
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:716: undefined reference to `__aeabi_fcmpeq'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:725: undefined reference to `__aeabi_fcmpeq'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:734: undefined reference to `__aeabi_fcmpeq'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:735: undefined reference to `__aeabi_i2f'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:735: undefined reference to `__aeabi_fmul'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:735: undefined reference to `__aeabi_f2iz'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:746: undefined reference to `__aeabi_fcmpeq'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:772: undefined reference to `__aeabi_fcmpeq'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:716: undefined reference to `__aeabi_fcmpeq'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:727: undefined reference to `__aeabi_fmul'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:727: undefined reference to `__aeabi_f2iz'
> ../../../../lib/libltp.a(parse_opts.o): In function `parse_opts':
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:289: undefined reference to `__aeabi_d2f'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:293: undefined reference to `__aeabi_d2f'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:294: undefined reference to `__aeabi_fcmpeq'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:438: undefined reference to `__aeabi_fcmpge'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:441: undefined reference to `__aeabi_f2d'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:421: undefined reference to `__aeabi_fcmpge'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:425: undefined reference to `__aeabi_fcmpeq'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:408: undefined reference to `__aeabi_fcmpge'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:413: undefined reference to `__aeabi_fcmpeq'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:424: undefined reference to `__aeabi_f2d'
> /u/ltp/ltp-full-20120104/lib/parse_opts.c:411: undefined reference to `__aeabi_f2d'
> collect2: ld returned 1 exit status

That suggets that the linker wasn't been able to pick up symbols from
libgcc.a, possibly because linker flags and static libraries are passed
to it in the wrong order.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
