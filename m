From: Leo Liang <ycliang@andestech.com>
Date: Fri, 16 Jul 2021 22:01:46 +0800
Subject: [LTP] [PATCH v3,
 1/2] lib/tst_test.sh: Make tst_umount work with argument that has
 trailing slash
Message-ID: <20210716140142.GA7113@andestech.com>
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

Fix this by filtering out the trailing slash before grepping /proc/mounts.

Signed-off-by: Leo Yu-Chi Liang <ycliang@andestech.com>
---
 testcases/lib/tst_test.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index c6aa2c487..f132512e7 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -282,13 +282,14 @@ tst_umount()
 
 	[ -z "$device" ] && return
 
+	device=${device%/} 
 	if ! grep -q "$device" /proc/mounts; then
 		tst_res TINFO "The $device is not mounted, skipping umount"
 		return
 	fi
 
 	while [ "$i" -lt 50 ]; do
-		if umount "$device" > /dev/null; then
+		if umount "$device"/ > /dev/null; then
 			return
 		fi
 
-- 
2.17.0
