Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jjaburek@redhat.com>) id 1Vnn21-0007Ry-5k
	for ltp-list@lists.sourceforge.net; Tue, 03 Dec 2013 10:16:41 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vnn20-0001Yb-22
	for ltp-list@lists.sourceforge.net; Tue, 03 Dec 2013 10:16:41 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB3AGXqF022586
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Dec 2013 05:16:34 -0500
Received: from robin.brq.redhat.com (ovpn-112-58.ams2.redhat.com
	[10.36.112.58])
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id rB3AGTDN026430
	for <ltp-list@lists.sourceforge.net>; Tue, 3 Dec 2013 05:16:33 -0500
From: Jiri Jaburek <jjaburek@redhat.com>
Date: Tue,  3 Dec 2013 11:16:13 +0100
Message-Id: <1386065776-1961-3-git-send-email-jjaburek@redhat.com>
In-Reply-To: <1386065776-1961-1-git-send-email-jjaburek@redhat.com>
References: <1386065776-1961-1-git-send-email-jjaburek@redhat.com>
Subject: [LTP] [PATCH 2/5] ssh: remove unused ssh_set_passwd script
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

This script is not used anywhere in the suite. Furthermore,
the same functionality is already provided by passwd(1) itself:

  echo "my secret pass" | passwd --stdin myusername

Signed-off-by: Jiri Jaburek <jjaburek@redhat.com>
---
 testcases/network/tcp_cmds/ssh/ssh_set_passwd | 28 ---------------------------
 1 file changed, 28 deletions(-)
 delete mode 100755 testcases/network/tcp_cmds/ssh/ssh_set_passwd

diff --git a/testcases/network/tcp_cmds/ssh/ssh_set_passwd b/testcases/network/tcp_cmds/ssh/ssh_set_passwd
deleted file mode 100755
index 1b7bb7d..0000000
--- a/testcases/network/tcp_cmds/ssh/ssh_set_passwd
+++ /dev/null
@@ -1,28 +0,0 @@
-#!/usr/bin/expect
-#
-# Set Password for a specific new user
-# This script should be run as 'root'
-#
-# Example:
-#		./set_passwd USER PASSWD
-#
-
-if { [llength $argv] < 2} {
-	exit 1
-}
-
-set USER [lindex $argv 0]
-set PASSWD [lindex $argv 1]
-
-set timeout 30
-
-spawn passwd $USER
-expect "password:"
-sleep 1
-send "$PASSWD\r"
-expect "Re-type password:"
-sleep 1
-send "$PASSWD\r"
-expect succeed
-
-exit 0
-- 
1.8.3.1


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
