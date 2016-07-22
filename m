From: Khem Raj <raj.khem@gmail.com>
Date: Thu, 21 Jul 2016 21:26:40 -0700
Subject: [LTP] [PATCH V3 07/23] ptrace: Use int instead of enum
	__ptrace_request
In-Reply-To: <20160722042656.22346-1-raj.khem@gmail.com>
References: <20160722042656.22346-1-raj.khem@gmail.com>
Message-ID: <20160722042656.22346-7-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

__ptrace_request is only available with glibc

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/syscalls/ptrace/ptrace03.c           | 2 +-
 testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace03.c b/testcases/kernel/syscalls/ptrace/ptrace03.c
index a4028fc..f326b83 100644
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
diff --git a/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h b/testcases/kernel/syscalls/ptrace/spawn_ptrace_child.h
index ae538e9..83de9b4 100644
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
2.9.0

