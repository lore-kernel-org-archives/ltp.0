From: Zhengwang Ruan <ruanzw@xiaopeng.com>
Date: Thu, 11 Apr 2019 22:26:19 +0800
Subject: [LTP] [PATCH v1] rt_tgsigqueueinfo01.c: replace definition ANDROID
	with __ANDROID__
Message-ID: <1554992779-14595-1-git-send-email-ruanzw@xiaopeng.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Replace the incorrect definition of ANDROID with __ANDROID__.

Signed-off-by: Zhengwang Ruan <ruanzw@xiaopeng.com>
---
 testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
index c8252ed..bee6a62 100644
--- a/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
+++ b/testcases/kernel/syscalls/rt_tgsigqueueinfo/rt_tgsigqueueinfo01.c
@@ -25,7 +25,7 @@
 #include "tst_test.h"
 #include "lapi/syscalls.h"
 
-#ifndef ANDROID
+#ifndef __ANDROID__
 #define SI_SIGVAL si_sigval
 #else
 #define SI_SIGVAL _sigval
-- 
2.7.4

