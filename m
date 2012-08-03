Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SxGN7-0004id-7t
	for ltp-list@lists.sourceforge.net; Fri, 03 Aug 2012 11:48:49 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SxGN6-0005WN-CJ
	for ltp-list@lists.sourceforge.net; Fri, 03 Aug 2012 11:48:49 +0000
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q73Bmgkx011686
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 3 Aug 2012 07:48:42 -0400
From: Jan Stancek <jstancek@redhat.com>
Date: Fri,  3 Aug 2012 13:48:37 +0200
Message-Id: <13ebcba495cd84de8ffb6db190d3cfc5490c7af2.1343994187.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH] sockioctl01: fix expected errno for pipe ioctl
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: ltp-list@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


commit 46ce341b2f176c2611f12ac390adf862e932eb02
Author: Will Deacon <will.deacon@arm.com>
Date:   Fri May 25 11:39:13 2012 +0100

    pipe: return -ENOIOCTLCMD instead of -EINVAL on unknown ioctl
command

This commit (v3.4-8603-g46ce341 in linux-stable) changed pipe_ioctl,
so vfs_ioctl() now returns ENOTTY instead of EINVAL.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/sockioctl/sockioctl01.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0001-sockioctl01-fix-expected-errno-for-pipe-ioctl.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0001-sockioctl01-fix-expected-errno-for-pipe-ioctl.patch"

diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
index 2b51b26..3300423 100644
--- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
+++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
@@ -202,6 +202,13 @@ void setup0(void)
 		if ((s = open("test", O_RDWR)) == -1)
 			tst_brkm(TBROK, cleanup, "Could not open test - "
 				 "errno: %s", strerror(errno));
+		/*
+		 * kernel commit 46ce341b2f176c2611f12ac390adf862e932eb02
+		 * changed -EINVAL to -ENOIOCTLCMD, so vfs_ioctl now
+		 * returns -ENOTTY.
+		 */
+		if ((tst_kvercmp(3, 5, 0)) >= 0)
+			tdat[testno].experrno = ENOTTY;
 	}
 }
 

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------1.7.1--



