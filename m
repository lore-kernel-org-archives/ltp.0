Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <stanislav.kholmanskikh@oracle.com>)
	id 1VgqZB-0000ee-RI
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 06:38:13 +0000
Received: from userp1040.oracle.com ([156.151.31.81])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VgqZ9-00038n-Se
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 06:38:13 +0000
Received: from acsinet21.oracle.com (acsinet21.oracle.com [141.146.126.237])
	by userp1040.oracle.com (Sentrion-MTA-4.3.1/Sentrion-MTA-4.3.1) with
	ESMTP id rAE6c4ME021258
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Nov 2013 06:38:05 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
	by acsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAE6c41u015322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Nov 2013 06:38:04 GMT
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
	by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id
	rAE6c4c7001241
	for <ltp-list@lists.sourceforge.net>; Thu, 14 Nov 2013 06:38:04 GMT
From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Thu, 14 Nov 2013 10:37:57 +0400
Message-Id: <1384411077-26013-2-git-send-email-stanislav.kholmanskikh@oracle.com>
In-Reply-To: <20131113175008.GE12406@rei.Home>
References: <20131113175008.GE12406@rei.Home>
Subject: [LTP] [PATCH V3 2/2] tst_checkpoint_signal_child: implemented
	timeout
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
Cc: vasily.isaenko@oracle.com

If a child exits before opening TST_CHECKPOINT_FIFO
for reading, tst_checkpoint_signal_child() issued from the parent
will block forever.

To handle such situations added timeout logic to tst_checkpoint_signal_child();

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 lib/tst_checkpoint.c |   36 +++++++++++++++++++++++++++++++++++-
 1 files changed, 35 insertions(+), 1 deletions(-)

diff --git a/lib/tst_checkpoint.c b/lib/tst_checkpoint.c
index 56c86b5..e53c499 100644
--- a/lib/tst_checkpoint.c
+++ b/lib/tst_checkpoint.c
@@ -33,6 +33,40 @@
 
 #include "tst_checkpoint.h"
 
+/*
+ * Issue open() on 'path' fifo with O_WRONLY flag and wait for
+ * a reader up to 'timeout' ms.
+ *
+ * Returns:
+ *   > 0 - file descriptor
+ *   -1  - an error has occurred (errno is set accordingly)
+ *
+ */
+int open_wronly_timed(const char *path, unsigned int timeout)
+{
+	int fd;
+	int i;
+	int interval = 1; /* how often issue open(O_NONBLOCK), in ms */
+
+	for (i = 0; i < timeout; i += interval) {
+		fd = open(path, O_WRONLY | O_NONBLOCK);
+		if (fd < 0) {
+			if ((errno == ENXIO) || (errno == EINTR)) {
+				usleep(interval * 1000);
+
+				continue;
+			}
+
+			return -1;
+		}
+
+		return fd;
+	}
+
+	errno = ETIMEDOUT;
+	return -1;
+}
+
 void tst_checkpoint_init(const char *file, const int lineno,
                          struct tst_checkpoint *self)
 {
@@ -195,7 +229,7 @@ void tst_checkpoint_signal_child(const char *file, const int lineno,
 {
 	int ret, fd;
 	
-	fd = open(TST_CHECKPOINT_FIFO, O_WRONLY);
+	fd = open_wronly_timed(TST_CHECKPOINT_FIFO, self->timeout);
 
 	if (fd < 0) {
 		tst_brkm(TBROK | TERRNO, cleanup_fn,
-- 
1.7.1


------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
