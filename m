From: Khem Raj <raj.khem@gmail.com>
Date: Fri,  8 Jan 2016 08:11:34 +0000
Subject: [LTP] [PATCH 14/31] hyperthreading: Include sys/types.h for pid_t
	definition
In-Reply-To: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
References: <1452240711-51180-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452240711-51180-14-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

If sys/types.h is not included then it will not define pid_t_needed
and therefore typedef wont be included and we get errors about pid_t
being not known

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.h  | 1 +
 testcases/kernel/sched/hyperthreading/ht_enabled/ht_utils.h   | 1 +
 testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.h | 1 +
 3 files changed, 3 insertions(+)

diff --git a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.h b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.h
index 1ec9794..9084aa7 100644
--- a/testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.h
+++ b/testcases/kernel/sched/hyperthreading/ht_affinity/ht_utils.h
@@ -3,6 +3,7 @@
 #define _HTUTILS_H_
 
 #include <stdlib.h>
+#include <sys/types.h>
 
 int is_cmdline_para(const char *para);
 
diff --git a/testcases/kernel/sched/hyperthreading/ht_enabled/ht_utils.h b/testcases/kernel/sched/hyperthreading/ht_enabled/ht_utils.h
index 1ec9794..c03a124 100644
--- a/testcases/kernel/sched/hyperthreading/ht_enabled/ht_utils.h
+++ b/testcases/kernel/sched/hyperthreading/ht_enabled/ht_utils.h
@@ -2,6 +2,7 @@
 #ifndef _HTUTILS_H_
 #define _HTUTILS_H_
 
+#include <sys/types.h>
 #include <stdlib.h>
 
 int is_cmdline_para(const char *para);
diff --git a/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.h b/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.h
index 2977ad0..6b484e1 100644
--- a/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.h
+++ b/testcases/kernel/sched/hyperthreading/ht_interrupt/ht_utils.h
@@ -3,6 +3,7 @@
 #define _HTUTILS_H_
 
 #include <stdlib.h>
+#include <sys/types.h>
 
 int is_cmdline_para(const char *para);
 
-- 
2.7.0

