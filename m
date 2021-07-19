From: Leo Liang <ycliang@andestech.com>
Date: Mon, 19 Jul 2021 17:21:11 +0800
Subject: [LTP] [PATCH v4,
 1/2] lib/tst_test.sh: Make tst_umount work with argument has
 trailing slash
Message-ID: <20210719092107.GA1406@atcfdc88>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

/proc/mounts shows the mount point without trailing slashes, e.g.
~ $ cat /proc/mounts
xxx /root/cgroup cgroup rw,relatime,cpu 0 0

So current tst_umount would not work with argument that has trailing slash, e.g.
tst_umount cgroup/ would give "The device is not mounted".

Fix this by filtering out the trailing slash in the argument for grep.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 testcases/lib/tst_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index c6aa2c487..cbdfb707a 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -282,7 +282,7 @@ tst_umount()
 
 	[ -z "$device" ] && return
 
-	if ! grep -q "$device" /proc/mounts; then
+	if ! grep -q "${device%/}" /proc/mounts; then
 		tst_res TINFO "The $device is not mounted, skipping umount"
 		return
 	fi
-- 
2.17.0
