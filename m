Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <monstr@monstr.eu>) id 1MQiaj-0000Sx-OY
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2009 14:02:45 +0000
Received: from mail-fx0-f208.google.com ([209.85.220.208])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MQiaf-0007uc-CI
	for ltp-list@lists.sourceforge.net; Tue, 14 Jul 2009 14:02:45 +0000
Received: by fxm4 with SMTP id 4so253771fxm.10
	for <ltp-list@lists.sourceforge.net>;
	Tue, 14 Jul 2009 07:02:39 -0700 (PDT)
Message-ID: <4A5C8068.6020203@monstr.eu>
Date: Tue, 14 Jul 2009 14:56:08 +0200
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
Subject: [LTP] access_ok macor
Reply-To: monstr@monstr.eu
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
To: Linux Kernel list <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, LTP <ltp-list@lists.sourceforge.net>

Hi,

I am trying to solve one thing around access_ok macro.
Microblaze memory map is below
Text address for user app is 0x1000 0000
for library 0x4800 0000
and stack below 0xc000 0000


# cat /proc/1/maps
10000000-10106000 r-xp 00000000 00:01 379        /bin/busybox
10106000-10107000 rw-p 00106000 00:01 379        /bin/busybox
10107000-1012a000 rwxp 00000000 00:00 0          [heap]
48000000-4801c000 r-xp 00000000 00:01 400        /lib/ld-2.3.3.so
4801c000-4801e000 rw-p 0001b000 00:01 400        /lib/ld-2.3.3.so
4801e000-480ec000 r-xp 00000000 00:01 396        /lib/libm-2.3.3.so
480ec000-480ee000 rw-p 000ce000 00:01 396        /lib/libm-2.3.3.so
480ee000-4824c000 r-xp 00000000 00:01 390        /lib/libc-2.3.3.so
4824c000-4824f000 r--p 0015d000 00:01 390        /lib/libc-2.3.3.so
4824f000-48251000 rw-p 00160000 00:01 390        /lib/libc-2.3.3.so
48251000-48255000 rw-p 00000000 00:00 0
bfa38000-bfa4d000 rwxp 00000000 00:00 0          [stack]
#

I found that I can setup text base in binutils/ld/emulparam/elf32mb_linux.sh

The problem which I have is that if I run socketpair, getsockname, getpeername LTP
tests with invalid salen pointer there are addresses close to 0x0. Microblaze
has no text there and the sigsegv fault is generated.

This fault could be fixed by changed access_ok macro where I check bottom limit
at 0x1000 0000 too. After this change the LTP program not failed but I am not sure
if is the right solution because none arch do it. All archs just check upper limit
not lower.

What is the correct solution for it? Moving .text base to 0x0 or is there any other
elegant solution?

Thanks,
Michal




-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have
the opportunity to enter the BlackBerry Developer Challenge. See full prize  
details at: http://p.sf.net/sfu/Challenge
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
