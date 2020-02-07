From: Martin Doucha <mdoucha@suse.cz>
Date: Fri,  7 Feb 2020 15:54:03 +0100
Subject: [LTP] [PATCH v2] Taunt OOM killer in fork12 setup()
In-Reply-To: <1041474174.5093428.1580463462902.JavaMail.zimbra@redhat.com>
References: <1041474174.5093428.1580463462902.JavaMail.zimbra@redhat.com>
Message-ID: <20200207145403.23193-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On a system with low memory, fork12 can trigger OOM killer before it hits
any fork() limits. The OOM killer might accidentally kill e.g. the parent
shell and external testing tools will assume the test failed.

Set high oom_score_adj on the children of the main fork12 process so that
the OOM killer focuses on them.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: Set oom_score_adj after fork() so that OOM killer will
ignore the main fork12 process.

 testcases/kernel/syscalls/fork/fork12.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/testcases/kernel/syscalls/fork/fork12.c b/testcases/kernel/syscalls/fork/fork12.c
index 75278b012..1c55c0c30 100644
--- a/testcases/kernel/syscalls/fork/fork12.c
+++ b/testcases/kernel/syscalls/fork/fork12.c
@@ -70,6 +70,12 @@ int main(int ac, char **av)
 		forks = 0;
 		while ((pid1 = fork()) != -1) {
 			if (pid1 == 0) {	/* child */
+				/*
+				 * Taunt the OOM killer so that it doesn't
+				 * kill system processes
+				 */
+				SAFE_FILE_PRINTF(NULL,
+					"/proc/self/oom_score_adj", "500");
 				pause();
 				exit(0);
 			}
-- 
2.25.0

