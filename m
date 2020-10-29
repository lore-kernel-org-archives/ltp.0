From: Yang Xu <xuyang_jy_0410@163.com>
Date: Fri, 30 Oct 2020 00:35:45 +0800
Subject: [LTP] [PATCH 2/2] syscalls/ptrace08: Add exception for RHEL8 4.18
 kernel
In-Reply-To: <20201029163545.9829-1-xuyang_jy_0410@163.com>
References: <20201029163545.9829-1-xuyang_jy_0410@163.com>
Message-ID: <20201029163545.9829-2-xuyang_jy_0410@163.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

RHEL 4.18 kernel got this patch
commit bd14406b78e6d("perf/hw_breakpoint: Modify breakpoint even if the new attrhas disabled set") since 4.18.0-49.

Without this fix, this case failed as below on RHEL8:
tst_kernel.c:79: TINFO: uname.machine=x86_64 kernel is 64bit
ptrace08.c:96: TINFO: Trying address 0xffff800000000000
ptrace08.c:122: TFAIL: ptrace() breakpoint with kernel addr succeeded
ptrace08.c:96: TINFO: Trying address 0xffffffffffffffff
ptrace08.c:122: TFAIL: ptrace() breakpoint with kernel addr succeeded
ptrace08.c:96: TINFO: Trying address 0xffffbfffffffffff
ptrace08.c:122: TFAIL: ptrace() breakpoint with kernel addr succeeded

Signed-off-by: Yang Xu <xuyang_jy_0410@163.com>
---
 testcases/kernel/syscalls/ptrace/ptrace08.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace08.c b/testcases/kernel/syscalls/ptrace/ptrace08.c
index 63086f1fd..2796c40e2 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace08.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace08.c
@@ -56,6 +56,11 @@ static pid_t child_pid;
 
 static int deffered_check;
 
+static struct tst_kern_exv kvers[] = {
+	{"RHEL8", "4.18.0-49"},
+	{NULL, NULL},
+};
+
 static void setup(void)
 {
 	/*
@@ -70,9 +75,10 @@ static void setup(void)
 	 * The original fix for the kernel haven't rejected the kernel address
 	 * right away when breakpoint was modified from userspace it was
 	 * disabled instead and the EINVAL was returned when dr7 was written to
-	 * enable it again.
+	 * enable it again. On RHEL8, it has introduced the right fix since
+	 * 4.18.0-49.
 	 */
-	if (tst_kvercmp(4, 19, 0) < 0)
+	if (tst_kvercmp2(4, 19, 0, kvers) < 0)
 		deffered_check = 1;
 }
 
-- 
2.18.1


