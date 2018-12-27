From: Steve Muckle <smuckle@google.com>
Date: Wed, 26 Dec 2018 16:31:01 -0800
Subject: [LTP] [PATCH 2/3] syscalls/sched_setaffinity: move cpu set macros
	to include/lapi
In-Reply-To: <20181227003102.246617-1-smuckle@google.com>
References: <20181227003102.246617-1-smuckle@google.com>
Message-ID: <20181227003102.246617-2-smuckle@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

The compatibility macros for cpu sets can be used elsewhere in LTP.

Signed-off-by: Steve Muckle <smuckle@google.com>
---
 .../sched_setaffinity.h => include/lapi/cpuset.h            | 6 +++---
 .../kernel/syscalls/sched_setaffinity/sched_setaffinity01.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)
 rename testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity.h => include/lapi/cpuset.h (94%)

diff --git a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity.h b/include/lapi/cpuset.h
similarity index 94%
rename from testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity.h
rename to include/lapi/cpuset.h
index 906864a2c..5dc3fcc05 100644
--- a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity.h
+++ b/include/lapi/cpuset.h
@@ -29,8 +29,8 @@
 #define _GNU_SOURCE
 #include <sched.h>
 
-#ifndef LTP_SCHED_SETAFFINITY_H
-#define LTP_SCHED_SETAFFINITY_H
+#ifndef LTP_CPUSET_H
+#define LTP_CPUSET_H
 
 #ifndef CPU_ALLOC
 #define CPU_ALLOC(ncpus) malloc(sizeof(cpu_set_t)); \
@@ -56,4 +56,4 @@ if (ncpus > CPU_SETSIZE) { \
 #define CPU_SET_S(cpu, size, mask) CPU_SET(cpu, mask)
 #endif
 
-#endif /* LTP_SCHED_SETAFFINITY_H */
+#endif /* LTP_CPUSET_H */
diff --git a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
index 43f8efc9f..e9367d603 100644
--- a/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
+++ b/testcases/kernel/syscalls/sched_setaffinity/sched_setaffinity01.c
@@ -40,7 +40,7 @@
 #include <sys/wait.h>
 #include "test.h"
 #include "safe_macros.h"
-#include "sched_setaffinity.h"
+#include "lapi/cpuset.h"
 #include "lapi/syscalls.h"
 
 char *TCID = "sched_setaffinity01";
-- 
2.20.1.415.g653613c723-goog

