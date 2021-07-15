From: Leo Liang <ycliang@andestech.com>
Date: Thu, 15 Jul 2021 22:24:48 +0800
Subject: [LTP] [PATCH v2,
 1/2] lib/tst_test.sh: Make tst_umount work with argument that
Message-ID: <20210715142448.GA30641@atcfdc88>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

/proc/mounts shows the mount point without terminating slashes, e.g.
~ $ cat /proc/mounts
xxx /root/cgroup cgroup rw,relatime,cpu 0 0

So current tst_umount would not work with argument that has terminating slash, e.g.
tst_umount cgroup/ would give "The device is not mounted".

Fix this by using mountpoint command instead of grepping /proc/mounts.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 testcases/lib/tst_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index c6aa2c487..7e77711f1 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -282,7 +282,7 @@ tst_umount()
 
 	[ -z "$device" ] && return
 
-	if ! grep -q "$device" /proc/mounts; then
+	if ! mountpoint -q "$device"; then
 		tst_res TINFO "The $device is not mounted, skipping umount"
 		return
 	fi
-- 
2.17.0

