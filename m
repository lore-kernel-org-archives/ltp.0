Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1TfVox-0007db-1O
	for ltp-list@lists.sourceforge.net; Mon, 03 Dec 2012 13:12:27 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1TfVor-0002jZ-8Y
	for ltp-list@lists.sourceforge.net; Mon, 03 Dec 2012 13:12:26 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id qB3DCEIc002484
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Dec 2012 08:12:15 -0500
Received: from dustball.brq.redhat.com (dustball.brq.redhat.com [10.34.26.57])
	by int-mx11.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with
	ESMTP id qB3CK2Uj026337
	for <ltp-list@lists.sourceforge.net>; Mon, 3 Dec 2012 07:20:07 -0500
From: Jan Stancek <jstancek@redhat.com>
Date: Mon,  3 Dec 2012 13:19:56 +0100
Message-Id: <1354537197-5353-1-git-send-email-jstancek@redhat.com>
Subject: [LTP] [PATCH] clone: increase stack size to 1M
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

16k is not enough for some LTP signal handlers:
http://article.gmane.org/gmane.linux.ltp/16992
1M should be plenty for all architectures.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/clone/clone_platform.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/syscalls/clone/clone_platform.h b/testcases/kernel/syscalls/clone/clone_platform.h
index ae7ae1a..b5ba8c9 100644
--- a/testcases/kernel/syscalls/clone/clone_platform.h
+++ b/testcases/kernel/syscalls/clone/clone_platform.h
@@ -17,4 +17,4 @@
 /* Common platform specific defines for the clone system call tests */
 
 //#define CHILD_STACK_SIZE 8192
-#define CHILD_STACK_SIZE 16384
+#define CHILD_STACK_SIZE (1024*1024)
-- 
1.7.1


------------------------------------------------------------------------------
Keep yourself connected to Go Parallel: 
BUILD Helping you discover the best ways to construct your parallel projects.
http://goparallel.sourceforge.net
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
