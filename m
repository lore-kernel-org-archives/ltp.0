Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1SS5R7-0002ll-8a
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 11:52:05 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SS5R6-0001bq-BV
	for ltp-list@lists.sourceforge.net; Wed, 09 May 2012 11:52:05 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q49Bpwpm007730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Wed, 9 May 2012 07:51:58 -0400
Message-ID: <4FAA5A59.8070707@redhat.com>
Date: Wed, 09 May 2012 13:51:53 +0200
From: Jan Stancek <jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010109040701030004090506"
Subject: [LTP] [PATCH v2] move_pages08: E2BIG was removed in 2.6.29
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
--------------010109040701030004090506
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
 .../kernel/syscalls/move_pages/move_pages08.c      |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)



--------------010109040701030004090506
Content-Type: text/x-patch;
	name="0001-move_pages08-E2BIG-was-removed-in-2.6.29.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-move_pages08-E2BIG-was-removed-in-2.6.29.patch"

diff --git a/testcases/kernel/syscalls/move_pages/move_pages08.c b/testcases/kernel/syscalls/move_pages/move_pages08.c
index a7ce6e4..e6902f4 100644
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
@@ -129,6 +129,17 @@ int main(int argc, char **argv)
  */
 void setup(void)
 {
+	/*
+	 * commit 3140a2273009c01c27d316f35ab76a37e105fdd8
+	 * Author: Brice Goglin <Brice.Goglin@inria.fr>
+	 * Date:   Tue Jan 6 14:38:57 2009 -0800
+	 *     mm: rework do_pages_move() to work on page_sized chunks
+	 *
+	 * reworked do_pages_move() to work by page-sized chunks and removed E2BIG
+	 */
+	if ((tst_kvercmp(2, 6, 29)) >= 0)
+		tst_brkm(TCONF, NULL, "move_pages: E2BIG was removed in "
+		    "commit 3140a2273009c01c27d316f35ab76a37e105fdd8");
 
 	tst_sig(FORK, DEF_HANDLER, cleanup);
 
@@ -151,4 +162,4 @@ void cleanup(void)
 	 */
 	TEST_CLEANUP;
 
- }
\ No newline at end of file
+ }


--------------010109040701030004090506
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
--------------010109040701030004090506
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--------------010109040701030004090506--

