From: Leo Liang <ycliang@andestech.com>
Date: Tue, 24 Aug 2021 20:18:06 +0800
Subject: [LTP] [PATCH v7, 2/4] doc: change the default behavior of tst_umount
Message-ID: <YSTjfqHs/vgYmU2l@ubuntu02>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Modify tst_umount to umount TST_MNTPOINT by default in previous commit.
Modify the document accordingly.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 doc/shell-test-api.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/shell-test-api.txt b/doc/shell-test-api.txt
index bf297ab07..ecdbe9e6a 100644
--- a/doc/shell-test-api.txt
+++ b/doc/shell-test-api.txt
@@ -515,11 +515,11 @@ The 'tst_mount' mounts '$TST_DEVICE' of '$TST_FS_TYPE' (optional) to
 '$TST_MNT_PARAMS'. The '$TST_MNTPOINT' directory is created if it didn't
 exist prior to the function call.
 
-If the path passed (optional, defaults to '$TST_DEVICE') to the 'tst_umount' is
+If the path passed (optional, defaults to '$TST_MNTPOINT') to the 'tst_umount' is
 not mounted (present in '/proc/mounts') it's noop.
-Otherwise it retries to umount the filesystem a few times on a failure, which
-is a workaround since there are a daemons dumb enough to probe all newly
-mounted filesystems, which prevents them from umounting shortly after they
+Otherwise it retries to umount the filesystem a few times on failure.
+This is a workaround since there are daemons dumb enough to probe all newly
+mounted filesystems, and prevents them from being umounted shortly after they
 were mounted.
 
 ROD and ROD_SILENT
-- 
2.17.0
