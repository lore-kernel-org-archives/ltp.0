Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <qcai@redhat.com>) id 1XUus2-0001wO-VW
	for ltp-list@lists.sourceforge.net; Fri, 19 Sep 2014 09:52:54 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XUus1-0007rJ-Nr
	for ltp-list@lists.sourceforge.net; Fri, 19 Sep 2014 09:52:54 +0000
Date: Fri, 19 Sep 2014 05:52:25 -0400 (EDT)
From: CAI Qian <caiqian@redhat.com>
Message-ID: <293476264.25264480.1411120345360.JavaMail.zimbra@redhat.com>
In-Reply-To: <145412866.25258463.1411119061796.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [RFC] autokdump - automated kdump testsuite
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
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: ltp-list <ltp-list@lists.sourceforge.net>, crash-utility <crash-utility@redhat.com>, kexec <kexec@lists.infradead.org>, kexec kdump redhat mailing list <kexec-kdump-list@redhat.com>

I plan to release an automated kdump testsuite that will be
focus on testing kernel and the crash utility. It should work
for all major distros since it will use none of distro-specific
stuff, and also support different arches including x86, ARM,
PPC64 and s390x.

It does the following:
1) check if there is a memory reserved for kdump. If not,
   reserve the memory and reboot the system.
2) once the system is back, load kexec on panic and
   prepare a separate initramfs that including needed
   modules to load a local filesystem and necessary utilities
   in order to analyse /proc/vmcore in the 2nd kernel.
3) trigger the system crash using methods like sysrq-c, NMI,
   and panic_on_hung_task etc.
4) in the 2nd kernel, mount a filesystem and use the crash
   utility to analyse /proc/vmcore. Then, gather the analyse
   logs, serial console output, dmesg etc into the filesystem.
5) reboot back into the 1st kernel.

implementation:
It will setup a daemon to handle reboots.

plan:
I might also to test the makedumpfile all together later.
   CAI Qian

------------------------------------------------------------------------------
Slashdot TV.  Video for Nerds.  Stuff that Matters.
http://pubads.g.doubleclick.net/gampad/clk?id=160591471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
