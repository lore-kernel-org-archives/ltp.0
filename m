Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xzhou@redhat.com>) id 1XKJjv-0004vN-AQ
	for ltp-list@lists.sourceforge.net; Thu, 21 Aug 2014 04:12:43 +0000
Received: from mx5-phx2.redhat.com ([209.132.183.37])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XKJju-0008No-0C
	for ltp-list@lists.sourceforge.net; Thu, 21 Aug 2014 04:12:43 +0000
Date: Thu, 21 Aug 2014 00:12:35 -0400 (EDT)
From: Xiong Zhou <xzhou@redhat.com>
Message-ID: <389062153.22364213.1408594355921.JavaMail.zimbra@redhat.com>
In-Reply-To: <951473587.22362927.1408594230035.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Subject: [LTP] [PATCH v3 1/3] fcntl16: Skip fcntl16 tests on NFS
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
To: ltp-list@lists.sourceforge.net


According to nfs(5), NLM supports advisory file locks only. So skip
fcntl16 test if NFS.

Signed-off-by: Xiong Zhou <xzhou@redhat.com>
---
 testcases/kernel/syscalls/fcntl/fcntl16.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl16.c b/testcases/kernel/syscalls/fcntl/fcntl16.c
index 44b6a80..7dba6ea 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl16.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl16.c
@@ -51,6 +51,8 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
+#include "tst_fs_type.h"
+
 #define SKIPVAL 0x0f00
 //#define       SKIP    SKIPVAL, 0, 0L, 0L, IGNORED
 #define SKIP 0,0,0L,0L,0
@@ -412,6 +414,12 @@ void setup(void)
 
 	tst_tmpdir();
 
+	/* On NFS or not */
+	if (tst_fs_type(cleanup, ".") == TST_NFS_MAGIC) {
+		tst_brkm(TCONF, cleanup, "Cannot test madatory locking "
+			"on a file located on an NFS filesystem");
+	}
+
 	/* set up temp filename */
 	sprintf(tmpname, "fcntl4.%d", parent);
 
-- 
1.8.3.1


------------------------------------------------------------------------------
Slashdot TV.  
Video for Nerds.  Stuff that matters.
http://tv.slashdot.org/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
