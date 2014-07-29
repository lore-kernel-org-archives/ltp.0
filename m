Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1XC7I6-0008EO-IN
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 13:18:06 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XC7I4-0003Ji-01
	for ltp-list@lists.sourceforge.net; Tue, 29 Jul 2014 13:18:06 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6TDHvX0025742
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jul 2014 09:17:57 -0400
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id s6TDHtHl003638
	for <ltp-list@lists.sourceforge.net>; Tue, 29 Jul 2014 09:17:56 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 29 Jul 2014 15:17:53 +0200
Message-Id: <49518ab05d50db10c44b8692334cfeab6ae57a48.1406639842.git.jstancek@redhat.com>
Subject: [LTP] [PATCH] move cpuset01 to stress runtest
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This reproducer takes significant time, it runs for 1 hour,
which is ~1/3 of time spent by all mm testcases. Move it to
stress runtest.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 runtest/mm           |    2 --
 runtest/stress.part1 |    4 +++-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/runtest/mm b/runtest/mm
index 131bc3d..031d766 100644
--- a/runtest/mm
+++ b/runtest/mm
@@ -73,8 +73,6 @@ ksm06 ksm06
 ksm06_1 ksm06 -n 10
 ksm06_2 ksm06 -n 10000
 
-cpuset01 cpuset01 -I 3600
-
 oom01 oom01
 oom02 oom02
 oom03 oom03
diff --git a/runtest/stress.part1 b/runtest/stress.part1
index 529716c..fc8363d 100644
--- a/runtest/stress.part1
+++ b/runtest/stress.part1
@@ -23,7 +23,6 @@ mem02 mem02
 # -s(seconds) settings, if default not desired
 mmap-corruption01 mmap-corruption01 -h1 -m1 -s1
 
-
 page01 page01
 page02 page02
 
@@ -39,6 +38,9 @@ shmt07 shmt07
 shmt08 shmt08
 shmt09 shmt09
 shmt10 shmt10
+
+cpuset01 cpuset01 -I 3600
+
 fsx-linux export TCbin=$LTPROOT/testcases/bin;fsxtest02 10000
 #fsx-ext2 fsxtest $SCRATCHDEV ext2 10000
 #fsx-ext3 fsxtest $SCRATCHDEV ext3 10000
-- 
1.7.1


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
