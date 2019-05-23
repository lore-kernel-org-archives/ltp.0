From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 23 May 2019 15:45:49 +0200
Subject: [LTP] [PATCH] [COMMITTED] syscalls/fcntl33: Fix typo overlapfs ->
	overlayfs
Message-ID: <20190523134549.23103-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fcntl/fcntl33.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl33.c b/testcases/kernel/syscalls/fcntl/fcntl33.c
index 43dc5a2af..627823c5c 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl33.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl33.c
@@ -117,7 +117,7 @@ static void do_test(unsigned int i)
 	if (TST_RET == -1) {
 		if (type == TST_OVERLAYFS_MAGIC && TST_ERR == EAGAIN) {
 			tst_res(TINFO | TTERRNO,
-				"fcntl(F_SETLEASE, F_WRLCK) failed on overlapfs as expected");
+				"fcntl(F_SETLEASE, F_WRLCK) failed on overlayfs as expected");
 		} else {
 			tst_res(TFAIL | TTERRNO, "fcntl() failed to set lease");
 		}
-- 
2.19.2

