From: Petr Vorel <petr.vorel@gmail.com>
Date: Fri, 25 Nov 2016 22:01:24 +0100
Subject: [LTP] [PATCH v2 3/4] shell: fix bashism (( ))
In-Reply-To: <20161125210125.7299-1-petr.vorel@gmail.com>
References: <20161125210125.7299-1-petr.vorel@gmail.com>
Message-ID: <20161125210125.7299-3-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/kernel/device-drivers/zram/zram01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/device-drivers/zram/zram01.sh b/testcases/kernel/device-drivers/zram/zram01.sh
index caa0e05..64284d5 100755
--- a/testcases/kernel/device-drivers/zram/zram01.sh
+++ b/testcases/kernel/device-drivers/zram/zram01.sh
@@ -54,7 +54,7 @@ zram_fill_fs()
 	for i in $(seq 0 $(($dev_num - 1))); do
 		tst_resm TINFO "fill zram$i..."
 		local b=0
-		while ((1)); do
+		while true; do
 			dd conv=notrunc if=/dev/zero of=zram${i}/file \
 				oflag=append count=1 bs=1024 status=none \
 				> /dev/null 2>&1 || break
-- 
2.10.2

