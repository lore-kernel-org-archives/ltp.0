Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SS5RA-0002m5-7h
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 11:52:08 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SS5R6-0001bp-BV
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 11:52:08 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q49Bpwm3017459
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 9 May 2012 07:51:58 -0400
Message-ID: <4FAA5A5B.1030704@redhat.com>
Date: Wed, 09 May 2012 13:51:55 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000105030900070709080301"
Subject: [LTP] [PATCH v2] move_pages09: move_pages returns 0 if nothing got
	migrated
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
Cc: Jeffrey Burke <jburke@redhat.com>

This is a multi-part message in MIME format.
--------------000105030900070709080301
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Following commit changed the behavior to return 0 when no pages
require migration.

commit e78bbfa8262424417a29349a8064a535053912b9
Author: Brice Goglin <Brice.Goglin@inria.fr>
Date:   Sat Oct 18 20:27:15 2008 -0700
    mm: stop returning -ENOENT from sys_move_pages() if nothing got
migrated

So testing for ENOENT in move_pages09, makes sense only for
kernel < 2.6.28.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/move_pages/move_pages09.c      |   27 ++++++++++++++-----
 1 files changed, 20 insertions(+), 7 deletions(-)



--------------000105030900070709080301
Content-Type: text/x-patch;
	name="0002-move_pages09-move_pages-returns-0-if-nothing-got-mig.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0002-move_pages09-move_pages-returns-0-if-nothing-got-mig.pa";
	filename*1="tch"

diff --git a/testcases/kernel/syscalls/move_pages/move_pages09.c b/testcases/kernel/syscalls/move_pages/move_pages09.c
index 4cedb6a..85e3547 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages09.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages09.c
@@ -105,12 +105,25 @@ int main(int argc, char **argv)
 		ret = numa_move_pages(0, TEST_PAGES, pages, nodes,
 				      status, MPOL_MF_MOVE);
 		TEST_ERRNO = errno;
-		if (ret == -1 && errno == ENOENT)
-			tst_resm(TPASS, "move_pages failed with "
-				 "ENOENT as expected");
-		else
-			tst_resm(TFAIL, "move pages did not fail "
-				 "with ENOENT");
+
+		/*
+		 * commit e78bbfa8262424417a29349a8064a535053912b9
+		 * Author: Brice Goglin <Brice.Goglin@inria.fr>
+		 * Date:   Sat Oct 18 20:27:15 2008 -0700
+		 *     mm: stop returning -ENOENT from sys_move_pages() if nothing got migrated
+		 */
+		if ((tst_kvercmp(2, 6, 28)) >= 0) {
+			if (ret == 0)
+				tst_resm(TPASS, "move_pages succeeded");
+			else
+				tst_resm(TFAIL|TERRNO, "move_pages");
+		} else {
+			if (ret == -1 && errno == ENOENT)
+				tst_resm(TPASS, "move_pages failed with "
+				    "ENOENT as expected");
+			else
+				tst_resm(TFAIL|TERRNO, "move_pages");
+		}
 
 		free_pages(pages, TEST_PAGES);
 	}
@@ -150,4 +163,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }


--------------000105030900070709080301
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
--------------000105030900070709080301
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------000105030900070709080301--

