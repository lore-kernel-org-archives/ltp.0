Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.74)
	(envelope-from <czhang@redhat.com>) id 1Q8uGF-0004dE-Th
	for ltp-list@lists.sourceforge.net; Sun, 10 Apr 2011 13:01:03 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.74)
	id 1Q8uGF-0004Sa-7F
	for ltp-list@lists.sourceforge.net; Sun, 10 Apr 2011 13:01:03 +0000
Received: from int-mx12.intmail.prod.int.phx2.redhat.com
	(int-mx12.intmail.prod.int.phx2.redhat.com [10.5.11.25])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id p3AD0vKU012783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Sun, 10 Apr 2011 09:00:57 -0400
From: Caspar Zhang <czhang@redhat.com>
Date: Sun, 10 Apr 2011 21:00:44 +0800
Message-Id: <31e14b5b388ec4591dd62f86fa2b35b5ae4f408f.1302440251.git.czhang@redhat.com>
In-Reply-To: <f4ad73abd0251782d607e88f90a4a1a26001d9ea.1302440251.git.czhang@redhat.com>
References: <f4ad73abd0251782d607e88f90a4a1a26001d9ea.1302440251.git.czhang@redhat.com>
In-Reply-To: <06e447138f8f007517bb5c09cd96ffd4804a95d5.1302319401.git.czhang@redhat.com>
References: <06e447138f8f007517bb5c09cd96ffd4804a95d5.1302319401.git.czhang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------1.7.1"
Subject: [LTP] [PATCH v3] [mm] mbind01: not working on some systems
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
To: LTP List <ltp-list@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------1.7.1
Content-Type: text/plain; charset=UTF-8; format=fixed
Content-Transfer-Encoding: 8bit


when executing mem/mbind01 testcase under some systems, it returns
ENOSYS error, indicating that mbind syscall is not implemented on this
system. This behavior is allowed and should not return error.

Signed-off-by: Caspar Zhang <czhang@redhat.com>
---
 testcases/kernel/syscalls/mbind/mbind02.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)


--------------1.7.1
Content-Type: text/x-patch;
	name="0002-mm-mbind01-not-working-on-some-systems.patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="0002-mm-mbind01-not-working-on-some-systems.patch"

diff --git a/testcases/kernel/syscalls/mbind/mbind02.c b/testcases/kernel/syscalls/mbind/mbind02.c
index 78d4a11..c829558 100644
--- a/testcases/kernel/syscalls/mbind/mbind02.c
+++ b/testcases/kernel/syscalls/mbind/mbind02.c
@@ -43,6 +43,7 @@ int TST_TOTAL = 1;
 #include <unistd.h>
 #include <stdlib.h>
 #include <string.h>
+#include <errno.h>
 
 static unsigned long pagesize;
 static int opt_node;
@@ -90,8 +91,13 @@ int main(int argc, char** argv)
 		/* first mbind */
 		err = mbind(addr+pagesize, pagesize, MPOL_BIND, nmask->maskp,
 			nmask->size, MPOL_MF_MOVE_ALL);
-		if (err != 0)
-			tst_brkm(TBROK|TERRNO, NULL, "mbind1");
+		if (err != 0) {
+			if (errno != ENOSYS)
+				tst_brkm(TBROK|TERRNO, NULL, "mbind1");
+			else
+				tst_brkm(TCONF, NULL,
+					"mbind syscall not implemented on this system.");
+		}
 
 		/* second mbind */
 		err = mbind(addr, pagesize*3, MPOL_DEFAULT, NULL, 0, 0);

--------------1.7.1
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Xperia(TM) PLAY
It's a major breakthrough. An authentic gaming
smartphone on the nation's most reliable network.
And it wants your games.
http://p.sf.net/sfu/verizon-sfdev
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



