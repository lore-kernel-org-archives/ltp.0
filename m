From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Tue, 19 Jan 2016 18:47:44 +0300
Subject: [LTP] [PATCH] device-drivers/uaccess: use linux/uaccess.h
Message-ID: <1453218464-13605-1-git-send-email-stanislav.kholmanskikh@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The current code fails to build on sparc64.

It turns out that <linux/uaccess.h> is a better candidate than
<asm-generic/uaccess.h>, since the former takes into account
possible architecture-specific changes.

Signed-off-by: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
---
 .../kernel/device-drivers/uaccess/ltp_uaccess.c    |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/testcases/kernel/device-drivers/uaccess/ltp_uaccess.c b/testcases/kernel/device-drivers/uaccess/ltp_uaccess.c
index e628ba9..a9a06e9 100644
--- a/testcases/kernel/device-drivers/uaccess/ltp_uaccess.c
+++ b/testcases/kernel/device-drivers/uaccess/ltp_uaccess.c
@@ -21,7 +21,7 @@
 
 #include <linux/module.h>
 #include <linux/device.h>
-#include <asm-generic/uaccess.h>
+#include <linux/uaccess.h>
 #include "ltp_uaccess.h"
 
 MODULE_AUTHOR("Alexey Kodanev <alexey.kodanev@oracle.com>");
-- 
1.7.1

