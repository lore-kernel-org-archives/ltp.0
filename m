Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UNKiT-00010r-C0
	for ltp-list@lists.sourceforge.net; Wed, 03 Apr 2013 10:14:53 +0000
Date: Wed, 3 Apr 2013 12:15:38 +0200
From: chrubis@suse.cz
Message-ID: <20130403101537.GD1545@rei>
References: <CAFzFL17=aoZ-dWXSv7kY8RUfC8r-b_VU=g5L3w0yfPtwbRZMaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFzFL17=aoZ-dWXSv7kY8RUfC8r-b_VU=g5L3w0yfPtwbRZMaQ@mail.gmail.com>
Subject: Re: [LTP] LTP for Android
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
To: Sagar Padhye <sgr.m.pdy@gmail.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> I am trying to test android kernel with LTP without any success.
> What I have tried:
> environment setup:
> ARCH=arm-eabi
> CROSS_COMPILER=/home/sagar/mytoolchain/bin/arm-linux-androideabi
> NDK_ROOT=/home/sagar/android-ndk-r8d
> CC=$CROSS_COMPILER-gcc
> LD=$CROSS_COMPILER-ld
> AR=$CROSS_COMPILER-ar
> STRIP=$CROSS_COMPILER-strip
> RANLIB=$CROSS_COMPILER-ranlib
> CFLAGS="-I/home/sagar/android-ndk-r8d/platforms/android-14/arch-arm/usr/include
> -D_ANDROID -nostdlib -DDEV_BSIZE=512"
> LDFLAGS="-Wl,-rpath-link=/home/sagar/android-ndk-r8d/platforms/android-14/arch-arm/usr/lib
> -L/home/sagar/android-ndk-r8d/platforms/android-14/arch-arm/usr/lib"
> LIBS="-lc"
> 
> when I do "./configure --host=arm-eabi" & "make", I get
> parse_opts.c:76:24: fatal error: sys/signal.h: No such file or directory

There were several attempts to port LTP on android, some of the patches
went in but it is not complete.

To my knowledge devs from mips were working on this, they have forked
repo on github:

https://github.com/piet-delaney/android-ltp-ndk

But they weren't sending any patches lately so I'm not aware of the
progress. You should ask them.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Minimize network downtime and maximize team effectiveness.
Reduce network management and security costs.Learn how to hire 
the most talented Cisco Certified professionals. Visit the 
Employer Resources Portal
http://www.cisco.com/web/learning/employer_resources/index.html
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
