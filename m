Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SS2w8-0008QR-85
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 09:11:56 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SS2w2-0004z9-Lb
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 09:11:56 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q499BiZf018625
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 9 May 2012 05:11:44 -0400
Message-ID: <4FAA34CF.6050809@redhat.com>
Date: Wed, 09 May 2012 11:11:43 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010103000100000901090403"
Subject: [LTP] [PATCH] move_pages08: E2BIG was removed in 2.6.29
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
--------------010103000100000901090403
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


Following commit reworked do_pages_move() to work by page-sized
chunks and also removed E2BIG:

commit 3140a2273009c01c27d316f35ab76a37e105fdd8
Author: Brice Goglin <Brice.Goglin@inria.fr>
Date:   Tue Jan 6 14:38:57 2009 -0800
    mm: rework do_pages_move() to work on page_sized chunks

So, move_pages08 makes sense only for kernels < 2.6.29.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/move_pages/move_pages08.c      |   18 ++++++++++++++++--
 1 files changed, 16 insertions(+), 2 deletions(-)



--------------010103000100000901090403
Content-Type: text/x-patch;
	name="0001-move_pages08-E2BIG-was-removed-in-2.6.29.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-move_pages08-E2BIG-was-removed-in-2.6.29.patch"

diff --git a/testcases/kernel/syscalls/move_pages/move_pages08.c b/testcases/kernel/syscalls/move_pages/move_pages08.c
index a7ce6e4..f6f01d6 100644
--- a/testcases/kernel/syscalls/move_pages/move_pages08.c
+++ b/testcases/kernel/syscalls/move_pages/move_pages08.c
@@ -46,7 +46,7 @@
  *		Initial Version.
  *
  * Restrictions
- *	None
+ *	kernel < 2.6.29
  */
 
 #include <sys/mman.h>
@@ -96,6 +96,20 @@ int main(int argc, char **argv)
 		/* reset Tst_count in case we are looping */
 		Tst_count = 0;
 
+		/*
+		 * commit 3140a2273009c01c27d316f35ab76a37e105fdd8
+		 * Author: Brice Goglin <Brice.Goglin@inria.fr>
+		 * Date:   Tue Jan 6 14:38:57 2009 -0800
+		 *     mm: rework do_pages_move() to work on page_sized chunks
+		 *
+		 * reworked do_pages_move() to work by page-sized chunks and removed E2BIG
+		 */
+		if ((tst_kvercmp(2, 6, 29)) >= 0) {
+			tst_resm(TCONF, "move_pages: E2BIG was removed in "
+			    "commit 3140a2273009c01c27d316f35ab76a37e105fdd8");
+			break;
+		}
+
 		ret = alloc_pages_on_node(pages, TEST_PAGES, from_node);
 		if (ret == -1)
 			continue;
@@ -151,4 +165,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }


--------------010103000100000901090403
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
--------------010103000100000901090403
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010103000100000901090403--

