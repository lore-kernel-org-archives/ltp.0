From: Petr Vorel <petr.vorel@gmail.com>
Date: Mon, 18 Mar 2019 04:23:28 +0100
Subject: [LTP] [PATCH 3/5] ptrace: Use int instead of enum __ptrace_request
In-Reply-To: <20190318032330.3346-1-petr.vorel@gmail.com>
References: <20190318032330.3346-1-petr.vorel@gmail.com>
Message-ID: <20190318032330.3346-4-petr.vorel@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

enum __ptrace_request is glibc/uclibc specific.

Signed-off-by: Petr Vorel <petr.vorel@gmail.com>
---
 testcases/kernel/syscalls/ptrace/ptrace03.c           | 2 +-
 testcases/kernel/syscalls/ptrace/ptrace06.c           | 2 +-
 testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace03.c b/testcases/kernel/syscalls/ptrace/ptrace03.c
index a4028fc26..f326b834d 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace03.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace03.c
@@ -102,7 +102,7 @@ static pid_t unused_pid;
 static pid_t zero_pid;
 
 struct test_case_t {
-	enum __ptrace_request request;
+	int request;
 	pid_t *pid;
 	int exp_errno;
 } test_cases[] = {
diff --git a/testcases/kernel/syscalls/ptrace/ptrace06.c b/testcases/kernel/syscalls/ptrace/ptrace06.c
index ba92ed11f..c0cb3b9bd 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace06.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace06.c
@@ -38,7 +38,7 @@
 char *TCID = "ptrace06";
 
 struct test_case_t {
-	enum __ptrace_request request;
+	int request;
 	long addr;
 	long data;
 } test_cases[] = {
diff --git a/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h b/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h
index ae538e900..83de9b447 100644
--- a/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h
+++ b/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h
@@ -130,7 +130,7 @@ static char *strings[] = {
 	SPT(KILL)
 	SPT(SINGLESTEP)
 };
-static inline char *strptrace(enum __ptrace_request request)
+static inline char *strptrace(int request)
 {
 	return strings[request];
 }
-- 
2.20.1

