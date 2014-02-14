Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <naresh.kamboju@linaro.org>) id 1WEEfe-0002Eu-5x
	for ltp-list@lists.sourceforge.net; Fri, 14 Feb 2014 09:02:54 +0000
Received: from mail-yh0-f45.google.com ([209.85.213.45])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1WEEfd-0000km-0N
	for ltp-list@lists.sourceforge.net; Fri, 14 Feb 2014 09:02:53 +0000
Received: by mail-yh0-f45.google.com with SMTP id i57so11343263yha.32
	for <ltp-list@lists.sourceforge.net>;
	Fri, 14 Feb 2014 01:02:47 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 14 Feb 2014 14:32:47 +0530
Message-ID: <CA+G9fYuT4TSs=3j6K9zztsTgFNVp2YG6JT-2Q_L==1P5G+SBew@mail.gmail.com>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Subject: [LTP] How to get the Linux kernel coverage data on ARM arch when I
	run LTP test?
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
To: Arnd Bergmann <arnd.bergmann@linaro.org>, fhrbata@redhat.com, oberpar@linux.vnet.ibm.com, Paul Larson <paul.larson@canonical.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, ltp-coverage <ltp-coverage@lists.sourceforge.net>, Mark Brown <mark.brown@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Deepak Saxena <dsaxena@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Milosz Wasilewski <milosz.wasilewski@linaro.org>

Hi All,

Sorry for the wide distribution:

According to LTP page info,
http://ltp.sourceforge.net/coverage/gcov.php
http://ltp.sourceforge.net/coverage/lcov.php

My question is
How to get kernel coverage when I run LTP test?

Since we do not have direct GCOV support on ARM I have enabled ( just
for experiment)

$ git diff  kernel/gcov/Kconfig
diff --git a/kernel/gcov/Kconfig b/kernel/gcov/Kconfig
index d4da55d..fceac85 100644
--- a/kernel/gcov/Kconfig
+++ b/kernel/gcov/Kconfig
@@ -35,7 +35,7 @@ config GCOV_KERNEL
 config GCOV_PROFILE_ALL
        bool "Profile entire Kernel"
        depends on GCOV_KERNEL
-       depends on SUPERH || S390 || X86 || PPC || MICROBLAZE
+       depends on SUPERH || S390 || X86 || PPC || MICROBLAZE || ARM
        default n
        ---help---
        This options activates profiling for the entire kernel.

I have enabled below kernel config and built the kernel.
CONFIG_GCOV_KERNEL=y
CONFIG_GCOV_PROFILE_ALL=y
CONFIG_GCOV_FORMAT_AUTODETECT=y

of course I have disabled gcov on below folders and files, because
since it is an experiment i would like to be on safe side
- arch/arm/mm/
- arch/arm/kernel/
- arch/arm/boot/
- arch/arm/boot/compressed/
- arch/arm/boot/bootp/
- arch/arm/boot/dts

Arndale booted with this configuration successfully.
Took more than 65 seconds to finish boot.

gcov related files are found under /sys/ similer to X86 machine.
And  gcov supporting files filename.gcda are having links to kernel source
root@linaro-developer:~# ls /sys/kernel/debug/gcov/
reset  tmp
root@linaro-developer:~#

root@linaro-developer:~# ls /sys/kernel/debug/gcov/tmp/
linux-linaro-3.13-2014.01
root@linaro-developer:~# ls
/sys/kernel/debug/gcov/tmp/linux-linaro-3.13-2014.01/
arch  block  crypto  drivers  fs  init  ipc  kernel  lib  mm  security  virt
root@linaro-developer:~# ls
/sys/kernel/debug/gcov/tmp/linux-linaro-3.13-2014.01/kernel/time.* -l
-rw------- 1 root root 0 Jan  1  1970
/sys/kernel/debug/gcov/tmp/linux-linaro-3.13-2014.01/kernel/time.gcda
lrwxrwxrwx 1 root root 0 Jan  1  1970
/sys/kernel/debug/gcov/tmp/linux-linaro-3.13-2014.01/kernel/time.gcno
-> /tmp/linux-linaro-3.13-2014.01/kernel/time.gcno
root@linaro-developer:~#

Source are placed under /tmp/
root@linaro-developer:/tmp/linux-linaro-3.13-2014.01# ls  kernel/time.* -l
-rw-rw-r-- 1 linaro linaro  19233 Jan 24  2014 kernel/time.c
-rw-rw-r-- 1 linaro linaro  12768 Feb 13  2014 kernel/time.gcno
-rw-rw-r-- 1 linaro linaro 136444 Feb 13  2014 kernel/time.o
root@linaro-developer:/tmp/linux-linaro-3.13-2014.01#


root@linaro-developer:/tmp/linux-linaro-3.13-2014.01# gcov kernel/gcov/base.c -o
 /sys/kernel/debug/gcov/tmp/linux-linaro-3.13-2014.01/kernel/gcov/
File 'kernel/gcov/base.c'
Lines executed:43.18% of 44
Creating 'base.c.gcov'

root@linaro-developer:/tmp/linux-linaro-3.13-2014.01#

The above experiment gives coverage of a single file base.c when i run
gcov manually.
Is there any way to get Linux kernel coverage of all files after
running LTP test cases ?

Thanks in advance.

Best regards
Naresh Kamboju

------------------------------------------------------------------------------
Android apps run on BlackBerry 10
Introducing the new BlackBerry 10.2.1 Runtime for Android apps.
Now with support for Jelly Bean, Bluetooth, Mapview and more.
Get your Android app in front of a whole new audience.  Start now.
http://pubads.g.doubleclick.net/gampad/clk?id=124407151&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
