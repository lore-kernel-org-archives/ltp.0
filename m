From: Michael Moese <mmoese@suse.de>
Date: Wed, 24 Jan 2018 14:02:56 +0100
Subject: [LTP] [PATCH 03/19] fix old style definition in nfs_lock.c
In-Reply-To: <20180124130312.7665-1-mmoese@suse.de>
References: <20180124130312.7665-1-mmoese@suse.de>
Message-ID: <20180124130312.7665-4-mmoese@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Michael Moese <mmoese@suse.de>
---
 testcases/network/nfs/nfslock01/nfs_flock.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/testcases/network/nfs/nfslock01/nfs_flock.c b/testcases/network/nfs/nfslock01/nfs_flock.c
index 39f612599..a7673c751 100644
--- a/testcases/network/nfs/nfslock01/nfs_flock.c
+++ b/testcases/network/nfs/nfslock01/nfs_flock.c
@@ -13,9 +13,7 @@
 #define BYTES 64
 #define LINES 16384
 
-int main(argc, argv)
-int argc;
-char **argv;
+int main(int argc, char **argv)
 {
 	int i, fd, mac;
 	int offset = 0;
-- 
2.13.6

