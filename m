Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1TEhst-000685-J0
	for ltp-list@lists.sourceforge.net; Thu, 20 Sep 2012 14:37:43 +0000
Date: Thu, 20 Sep 2012 16:37:31 +0200
From: chrubis@suse.cz
Message-ID: <20120920143731.GD7902@saboteur.suse.cz>
References: <CALFGhcTOGwfj=WQJL8FJn8q8LsEPe3fD+KEJBTjidxM47=PL6A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CALFGhcTOGwfj=WQJL8FJn8q8LsEPe3fD+KEJBTjidxM47=PL6A@mail.gmail.com>
Subject: Re: [LTP] Compling LTP for android Using Ndk revision 8
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
To: vikas bisla <vikasbisla15@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> We are trying to compile LTP for android using NDK tool chain.
> 
> Flags set while configuration-
> 
> ./configure --host=arm-eabi
> CC=/home/vikas/Desktop/LTP/arm-eabi-4.4.3/bin/arm-eabi-gcc
> CPPFLAGS="-I/home/vikas/Desktop/android-ndk-r8b/platforms/android-14/arch-arm/usr/include/"
> CFLAGS="-nostdlib"
> LDFLAGS="-Wl,-rpath-link=/home/vikas/Desktop/android-ndk-r8b/platforms/android-14/arch-arm/usr/lib/
> -L/home/vikas/Desktop/android-ndk-r8b/platforms/android-14/arch-arm/usr/lib/"
> LIBS="-lc"
> 
> After Config we are doing
> 
> Make ARCH=arm
> 
> it is giving following error.
> 
> /Desktop/LTP/ltp-full-20120903$ make ARCH=arm
> make -C "lib" \
> -f "/home/vikas/Desktop/LTP/ltp-full-20120903/lib/Makefile" all
> make[1]: Entering directory `/home/vikas/Desktop/LTP/ltp-full-20120903/lib'
> /home/vikas/Desktop/LTP/arm-eabi-4.4.3/bin/arm-eabi-gcc -nostdlib -g -O2
> -fno-strict-aliasing -pipe -Wall
> -I/home/vikas/Desktop/android-ndk-r8b/platforms/android-14/arch-arm/usr/include/
> -I../include -I../include -I../include -I../include  -c -o
> bytes_by_prefix.o bytes_by_prefix.c
> bytes_by_prefix.c: In function 'bytes_by_prefix':
> bytes_by_prefix.c:94: error: 'B_MULT' undeclared (first use in this
> function)
> bytes_by_prefix.c:94: error: (Each undeclared identifier is reported only
> once
> bytes_by_prefix.c:94: error: for each function it appears in.)
> bytes_by_prefix.c: In function 'lbytes_by_prefix':
> bytes_by_prefix.c:142: error: 'B_MULT' undeclared (first use in this
> function)
> bytes_by_prefix.c: In function 'llbytes_by_prefix':
> bytes_by_prefix.c:193: error: 'B_MULT' undeclared (first use in this
> function)
> make[1]: *** [bytes_by_prefix.o] Error 1
> make[1]: Leaving directory `/home/vikas/Desktop/LTP/ltp-full-20120903/lib'
> make: *** [lib-all] Error 2
> 
> Can anybody please suggest some pointer so that we can go forward.

Look at the lib/bytes_by_prefix.c there are ugly ifdefs that comes from
legacy code that are trying to figure out disk block size. Just define
the B_MULT to someting reasonable like 4k to continue.

And that rises question whether are these still needed and if so what is
reasonable default...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://ad.doubleclick.net/clk;258768047;13503038;j?
http://info.appdynamics.com/FreeJavaPerformanceDownload.html
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
