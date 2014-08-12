Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <zlang@redhat.com>) id 1XH8sX-0003m2-Nu
	for ltp-list@lists.sourceforge.net; Tue, 12 Aug 2014 10:00:29 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1XH8sV-0005SP-LJ
	for ltp-list@lists.sourceforge.net; Tue, 12 Aug 2014 10:00:29 +0000
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s7CA0K4o020724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK)
	for <ltp-list@lists.sourceforge.net>; Tue, 12 Aug 2014 06:00:20 -0400
From: Zorro Lang <zlang@redhat.com>
Date: Tue, 12 Aug 2014 18:00:16 +0800
Message-Id: <1407837616-13078-1-git-send-email-zlang@redhat.com>
Subject: [LTP] [PATCH] fs/fsstress: modify compile warning about fsstress.c
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

when compile kernel/fs/fsstress/fsstress.c, some warning always be printed.
Because there is a new field 'isxfs' be added in opdesc_t struct,
but some lines of opdesc_t ops[] forget to init this field.

Signed-off-by: Zorro Lang <zlang@redhat.com>
---
 testcases/kernel/fs/fsstress/fsstress.c | 40 ++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/testcases/kernel/fs/fsstress/fsstress.c b/testcases/kernel/fs/fsstress/fsstress.c
index 4a8a1c2..1783783 100644
--- a/testcases/kernel/fs/fsstress/fsstress.c
+++ b/testcases/kernel/fs/fsstress/fsstress.c
@@ -164,35 +164,35 @@ opdesc_t ops[] = {
 	{OP_BULKSTAT, "bulkstat", bulkstat_f, 1, 0, 1},
 	{OP_BULKSTAT1, "bulkstat1", bulkstat1_f, 1, 0, 1},
 #endif
-	{OP_CHOWN, "chown", chown_f, 3, 1},
-	{OP_CREAT, "creat", creat_f, 4, 1},
-	{OP_DREAD, "dread", dread_f, 4, 0},
-	{OP_DWRITE, "dwrite", dwrite_f, 4, 1},
-	{OP_FDATASYNC, "fdatasync", fdatasync_f, 1, 1},
+	{OP_CHOWN, "chown", chown_f, 3, 1, 0},
+	{OP_CREAT, "creat", creat_f, 4, 1, 0},
+	{OP_DREAD, "dread", dread_f, 4, 0, 0},
+	{OP_DWRITE, "dwrite", dwrite_f, 4, 1, 0},
+	{OP_FDATASYNC, "fdatasync", fdatasync_f, 1, 1, 0},
 #ifndef NO_XFS
 	{OP_FREESP, "freesp", freesp_f, 1, 1, 1},
 #endif
-	{OP_FSYNC, "fsync", fsync_f, 1, 1},
-	{OP_GETDENTS, "getdents", getdents_f, 1, 0},
-	{OP_LINK, "link", link_f, 1, 1},
-	{OP_MKDIR, "mkdir", mkdir_f, 2, 1},
-	{OP_MKNOD, "mknod", mknod_f, 2, 1},
-	{OP_READ, "read", read_f, 1, 0},
-	{OP_READLINK, "readlink", readlink_f, 1, 0},
-	{OP_RENAME, "rename", rename_f, 2, 1},
+	{OP_FSYNC, "fsync", fsync_f, 1, 1, 0},
+	{OP_GETDENTS, "getdents", getdents_f, 1, 0, 0},
+	{OP_LINK, "link", link_f, 1, 1, 0},
+	{OP_MKDIR, "mkdir", mkdir_f, 2, 1, 0},
+	{OP_MKNOD, "mknod", mknod_f, 2, 1, 0},
+	{OP_READ, "read", read_f, 1, 0, 0},
+	{OP_READLINK, "readlink", readlink_f, 1, 0, 0},
+	{OP_RENAME, "rename", rename_f, 2, 1, 0},
 #ifndef NO_XFS
 	{OP_RESVSP, "resvsp", resvsp_f, 1, 1, 1},
 #endif
-	{OP_RMDIR, "rmdir", rmdir_f, 1, 1},
-	{OP_STAT, "stat", stat_f, 1, 0},
-	{OP_SYMLINK, "symlink", symlink_f, 2, 1},
-	{OP_SYNC, "sync", sync_f, 1, 0},
-	{OP_TRUNCATE, "truncate", truncate_f, 2, 1},
-	{OP_UNLINK, "unlink", unlink_f, 1, 1},
+	{OP_RMDIR, "rmdir", rmdir_f, 1, 1, 0},
+	{OP_STAT, "stat", stat_f, 1, 0, 0},
+	{OP_SYMLINK, "symlink", symlink_f, 2, 1, 0},
+	{OP_SYNC, "sync", sync_f, 1, 0, 0},
+	{OP_TRUNCATE, "truncate", truncate_f, 2, 1, 0},
+	{OP_UNLINK, "unlink", unlink_f, 1, 1, 0},
 #ifndef NO_XFS
 	{OP_UNRESVSP, "unresvsp", unresvsp_f, 1, 1, 1},
 #endif
-	{OP_WRITE, "write", write_f, 4, 1},
+	{OP_WRITE, "write", write_f, 4, 1, 0},
 }, *ops_end;
 
 flist_t flist[FT_nft] = {
-- 
1.9.3


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
