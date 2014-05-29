Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <glt-ltp-list@m.gmane.org>) id 1WpySQ-00025D-VU
	for ltp-list@lists.sourceforge.net; Thu, 29 May 2014 11:25:14 +0000
Received: from plane.gmane.org ([80.91.229.3])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1WpySP-0001LQ-LH
	for ltp-list@lists.sourceforge.net; Thu, 29 May 2014 11:25:14 +0000
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <glt-ltp-list@m.gmane.org>) id 1WpySG-0000KF-D4
	for ltp-list@lists.sourceforge.net; Thu, 29 May 2014 13:25:04 +0200
Received: from 2021ob.scansafe.net ([115.111.223.43])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <ltp-list@lists.sourceforge.net>; Thu, 29 May 2014 13:25:04 +0200
Received: from ashagow by 2021ob.scansafe.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <ltp-list@lists.sourceforge.net>; Thu, 29 May 2014 13:25:04 +0200
From: meena <ashagow@gmail.com>
Date: Thu, 29 May 2014 11:21:27 +0000 (UTC)
Message-ID: <loom.20140529T131657-599@post.gmane.org>
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
	<20120502120742.GB366@saboteur.suse.cz>
Mime-Version: 1.0
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
To: ltp-list@lists.sourceforge.net


Thanks,
Cyril Hrubis <chrubis@...> writes:

> 
> Hi!
> > +
> /u/ltp/android-ndk-r7b/toolchains/arm-linux-androideabi-
4.4.3/prebuilt/linux-x86/bin/arm-linux-androideabi-gcc
> -march=armv7-a -mtune=xscale -msoft-float -fpic -mthumb-interwork -
ffunction-sections
> -funwind-tables -fstack-protector -fno-short-enums -O2 -fomit-frame-
pointer -funswitch-loops
> -finline-limit=300 -g -O2 -fno-strict-aliasing -pipe -Wall
> -I/u/ltp/android-ndk-r7b/platforms/android-14/arch-arm/usr/include -
D__ARM_ARCH_7__
> -D__ARM_ARCH_7A__ -D__ARM_ARCH_7R__ -D__ARM_ARCH_7M__ -DANDROID -
D__linux__ -DDEV_BSIZE=512
> -DSIGCLD=SIGCHLD -D_FILE_OFFSET_BITS=64 -I/u/ltp/ltp-full-
20120104/testcases/kernel/include
> -D_GNU_SOURCE -I/u/ltp/ltp-full-
20120104/testcases/kernel/timers/clock_gettime/../include
> -I../../../../include -I../../../../include -nostdlib -Bdynamic -Wl,-
dynamic-linker,/syst
>  em/bin/linker -Wl,--gc-sections -Wl,-z,nocopyreloc
> -L/u/ltp/android-ndk-r7b/platforms/android-14/arch-arm/usr/lib -
L../../../../lib
> clock_gettime02.c /u/ltp/android-ndk-r7b/platforms/android-1
> >  4/arch-arm/usr/lib/crtbegin_dynamic.o
> -Wl,-rpath-link=/u/ltp/android-ndk-r7b/platforms/android-14/arch-
arm/usr/lib
> /u/ltp/android-ndk-r7b/toolchains/arm-linux-androideabi-
4.4.3/prebuilt/linux-x86/bin/../lib/gcc/arm-linux-androideabi/4.4.3/libgcc.a
> -lc /u/ltp/android-ndk-r7b/platforms/android-14/arch-
arm/usr/lib/crtend_android.o
> -L/u/ltp/android-ndk-r7b/platforms/android-14/arch-arm/usr/lib -lltp -o 
clock_gettime02
> > ../../../../lib/libltp.a(parse_opts.o): In function `usc_test_looping':
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:716: undefined reference to 
`__aeabi_fcmpeq'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:725: undefined reference to 
`__aeabi_fcmpeq'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:734: undefined reference to 
`__aeabi_fcmpeq'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:735: undefined reference to 
`__aeabi_i2f'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:735: undefined reference to 
`__aeabi_fmul'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:735: undefined reference to 
`__aeabi_f2iz'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:746: undefined reference to 
`__aeabi_fcmpeq'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:772: undefined reference to 
`__aeabi_fcmpeq'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:716: undefined reference to 
`__aeabi_fcmpeq'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:727: undefined reference to 
`__aeabi_fmul'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:727: undefined reference to 
`__aeabi_f2iz'
> > ../../../../lib/libltp.a(parse_opts.o): In function `parse_opts':
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:289: undefined reference to 
`__aeabi_d2f'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:293: undefined reference to 
`__aeabi_d2f'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:294: undefined reference to 
`__aeabi_fcmpeq'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:438: undefined reference to 
`__aeabi_fcmpge'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:441: undefined reference to 
`__aeabi_f2d'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:421: undefined reference to 
`__aeabi_fcmpge'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:425: undefined reference to 
`__aeabi_fcmpeq'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:408: undefined reference to 
`__aeabi_fcmpge'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:413: undefined reference to 
`__aeabi_fcmpeq'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:424: undefined reference to 
`__aeabi_f2d'
> > /u/ltp/ltp-full-20120104/lib/parse_opts.c:411: undefined reference to 
`__aeabi_f2d'
> > collect2: ld returned 1 exit status
> 
> That suggets that the linker wasn't been able to pick up symbols from
> libgcc.a, possibly because linker flags and static libraries are passed
> to it in the wrong order.
> 
Hi,

I am able to cross compile for android but not able to execute it on android 
platform.
I if execute any of the binaries i am getting " no such file or directory"
I checked that the issue with dynamic linker :


readelf --program

Elf file type is EXEC (Executable file)
Entry point 0x87e8
There are 8 program headers, starting at offset 52

Program Headers:
  Type           Offset   VirtAddr   PhysAddr   FileSiz MemSiz  Flg Align
  EXIDX          0x000a7c 0x00008a7c 0x00008a7c 0x00048 0x00048 R   0x4
  PHDR           0x000034 0x00008034 0x00008034 0x00100 0x00100 R E 0x4
  INTERP         0x000134 0x00008134 0x00008134 0x00013 0x00013 R   0x1
      [Requesting program interpreter: /lib/ld-linux.so.3]
  LOAD           0x000000 0x00008000 0x00008000 0x00ac8 0x00ac8 R E 0x8000
  LOAD           0x000ac8 0x00010ac8 0x00010ac8 0x00148 0x00158 RW  0x8000
  DYNAMIC        0x000ad4 0x00010ad4 0x00010ad4 0x000f0 0x000f0 RW  0x4
  NOTE           0x000148 0x00008148 0x00008148 0x00020 0x00020 R   0x4
  GNU_STACK      0x000000 0x00000000 0x00000000 0x00000 0x00000 RW  0x10

Its taking default linker file as /lib/ld-linux, it should be 
/system/bin/linker for android i guess.
Can someone suggest me hoe to change this.





------------------------------------------------------------------------------
Time is money. Stop wasting it! Get your web API in 5 minutes.
www.restlet.com/download
http://p.sf.net/sfu/restlet
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
