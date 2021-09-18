From: QI Fuli <fukuri.sai@gmail.com>
Date: Sat, 18 Sep 2021 21:11:14 +0900
Subject: [LTP] [PATCH v5 5/5] syscalls/dup2: rename dup205 to dup204
In-Reply-To: <20210918121114.10694-1-qi.fuli@fujitsu.com>
References: <20210918121114.10694-1-qi.fuli@fujitsu.com>
Message-ID: <20210918121114.10694-6-qi.fuli@fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: QI Fuli <qi.fuli@fujitsu.com>

Signed-off-by: QI Fuli <qi.fuli@fujitsu.com>
---
 runtest/syscalls                                      | 1 -
 testcases/kernel/syscalls/dup2/.gitignore             | 1 -
 testcases/kernel/syscalls/dup2/Makefile               | 2 +-
 testcases/kernel/syscalls/dup2/{dup205.c => dup204.c} | 2 +-
 4 files changed, 2 insertions(+), 4 deletions(-)
 rename testcases/kernel/syscalls/dup2/{dup205.c => dup204.c} (97%)

diff --git a/runtest/syscalls b/runtest/syscalls
index 29d7752c7..75304f2f1 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -152,7 +152,6 @@ dup201 dup201
 dup202 dup202
 dup203 dup203
 dup204 dup204
-dup205 dup205
 
 dup3_01 dup3_01
 dup3_02 dup3_02
diff --git a/testcases/kernel/syscalls/dup2/.gitignore b/testcases/kernel/syscalls/dup2/.gitignore
index 6c4685b80..0c9a8cd75 100644
--- a/testcases/kernel/syscalls/dup2/.gitignore
+++ b/testcases/kernel/syscalls/dup2/.gitignore
@@ -2,4 +2,3 @@
 /dup202
 /dup203
 /dup204
-/dup205
diff --git a/testcases/kernel/syscalls/dup2/Makefile b/testcases/kernel/syscalls/dup2/Makefile
index 28fc158e4..fcdd146b7 100644
--- a/testcases/kernel/syscalls/dup2/Makefile
+++ b/testcases/kernel/syscalls/dup2/Makefile
@@ -6,7 +6,7 @@ top_srcdir		?= ../../../..
 include $(top_srcdir)/include/mk/testcases.mk
 
 ifeq ($(ANDROID),1)
-FILTER_OUT_MAKE_TARGETS	+= dup201 dup205
+FILTER_OUT_MAKE_TARGETS	+= dup201 dup204
 endif
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/syscalls/dup2/dup205.c b/testcases/kernel/syscalls/dup2/dup204.c
similarity index 97%
rename from testcases/kernel/syscalls/dup2/dup205.c
rename to testcases/kernel/syscalls/dup2/dup204.c
index e6fc175c3..5ac263143 100644
--- a/testcases/kernel/syscalls/dup2/dup205.c
+++ b/testcases/kernel/syscalls/dup2/dup204.c
@@ -23,7 +23,7 @@ static void setup(void)
 {
 	min = getdtablesize();	/* get number of files allowed open */
 	fildes = SAFE_MALLOC((min + 10) * sizeof(int));
-	sprintf(pfilname, "./dup205.%d\n", getpid());
+	sprintf(pfilname, "./dup204.%d\n", getpid());
 }
 
 static void cleanup(void)
-- 
2.31.1

