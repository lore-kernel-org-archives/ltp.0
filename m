From: Khem Raj <raj.khem@gmail.com>
Date: Sat,  9 Jan 2016 01:14:11 +0000
Subject: [LTP] [PATCH V2 23/32] ptrace: Use int instead of enum
	__ptrace_request
In-Reply-To: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
References: <1452302060-103643-1-git-send-email-raj.khem@gmail.com>
Message-ID: <1452302060-103643-23-git-send-email-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

__ptrace_request is only available with glibc

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/syscalls/ptrace/ptrace03.c           | 4 ++++
 testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace03.c b/testcases/kernel/syscalls/ptrace/ptrace03.c
index a4028fc..f1880cd 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace03.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace03.c
@@ -102,7 +102,11 @@ static pid_t unused_pid;
 static pid_t zero_pid;
 
 struct test_case_t {
+#ifdef __GLIBC__
 	enum __ptrace_request request;
+#else
+	int request;
+#endif
 	pid_t *pid;
 	int exp_errno;
 } test_cases[] = {
diff --git a/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h b/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h
index ae538e9..85aa89d 100644
--- a/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h
+++ b/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h
@@ -130,7 +130,11 @@ static char *strings[] = {
 	SPT(KILL)
 	SPT(SINGLESTEP)
 };
+#ifdef __GLIBC__
 static inline char *strptrace(enum __ptrace_request request)
+#else
+static inline char *strptrace(int request)
+#endif
 {
 	return strings[request];
 }
-- 
2.7.0

