From: Xie Ziyao <xieziyao@huawei.com>
Date: Thu, 6 May 2021 15:11:18 +0800
Subject: [LTP] [PATCH] syscalls/chown: Delete unused macro definition
Message-ID: <20210506071118.140135-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Delete unused macro definition for chown02.

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/chown/chown02.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/testcases/kernel/syscalls/chown/chown02.c b/testcases/kernel/syscalls/chown/chown02.c
index cd2c80dbd..a92a1fd2d 100644
--- a/testcases/kernel/syscalls/chown/chown02.c
+++ b/testcases/kernel/syscalls/chown/chown02.c
@@ -21,7 +21,6 @@
 #include "compat_tst_16.h"
 #include "tst_safe_macros.h"

-#define FILE_MODE	(S_IFREG|S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH)
 #define NEW_PERMS1	(S_IFREG|S_IRWXU|S_IRWXG|S_ISUID|S_ISGID)
 #define NEW_PERMS2	(S_IFREG|S_IRWXU|S_ISGID)
 #define EXP_PERMS	(S_IFREG|S_IRWXU|S_IRWXG)
--
2.17.1

