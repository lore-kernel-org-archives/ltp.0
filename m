From: Zhao Gongyi <zhaogongyi@huawei.com>
Date: Wed, 10 Mar 2021 16:10:48 +0800
Subject: [LTP] [PATCH] lib/tst_device.c: Add exception handling of function
 tst_find_free_loopdev
Message-ID: <20210310081048.27993-1-zhaogongyi@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Because of race condition or abnormal env, set_dev_path may be
return 1. And when set_dev_path return 1 in tst_find_free_loopdev,
we should return Immediately.

Signed-off-by: Zhao Gongyi <zhaogongyi@huawei.com>
---
 lib/tst_device.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index c096b418b..51cf1ba7e 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -83,8 +83,13 @@ int tst_find_free_loopdev(char *path, size_t path_len)
 		rc = ioctl(ctl_fd, LOOP_CTL_GET_FREE);
 		close(ctl_fd);
 		if (rc >= 0) {
-			if (path)
-				set_dev_path(rc, path, path_len);
+			if (path)
+				if (!set_dev_path(rc, path, path_len)) {
+					tst_resm(TINFO,
+						"loop device not exist");
+					return -1;
+				}
+
 			tst_resm(TINFO, "Found free device %d '%s'",
 				rc, path ?: "");
 			return rc;
--
2.17.1

