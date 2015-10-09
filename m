From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri,  9 Oct 2015 12:45:15 +0300
Subject: [LTP] [Committed] network/nfs_stress/nfs01: fix test binary name
Message-ID: <1444383915-22848-1-git-send-email-alexey.kodanev@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Alexey Kodanev <alexey.kodanev@oracle.com>
---
 testcases/network/nfs/nfs_stress/nfs01 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/network/nfs/nfs_stress/nfs01 b/testcases/network/nfs/nfs_stress/nfs01
index 0f6877e..19c7f4b 100755
--- a/testcases/network/nfs/nfs_stress/nfs01
+++ b/testcases/network/nfs/nfs_stress/nfs01
@@ -29,8 +29,8 @@ TST_CLEANUP="nfs_cleanup"
 
 do_test()
 {
-	tst_resm TINFO "starting 'open_files $NFILES'"
-	ROD open_files $NFILES
+	tst_resm TINFO "starting 'nfs01_open_files $NFILES'"
+	ROD nfs01_open_files $NFILES
 
 	cd $LTPROOT
 	ROD umount $TST_TMPDIR
-- 
1.7.1

