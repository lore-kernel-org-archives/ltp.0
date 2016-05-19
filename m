From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 19 May 2016 16:58:45 +0200
Subject: [LTP] [PATCH] mem/oom: fork may fail before test
Message-ID: <9e8fc1797bd3bf0fe725a4b589e4fabda09ea0b8.1463669846.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On systems with small RAM and vm.overcommit_memory == 2,
the system may already be in state where Committed_AS is
larger than CommitLimit due to various backround daemons
(NM, tuned, polkitd,...) asking for big allocations.

In such instances oom testcases report TBROK on very first fork.
This patch allows this to be a valid outcome (TPASS).

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/mem/lib/mem.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/mem/lib/mem.c b/testcases/kernel/mem/lib/mem.c
index c55a55d57915..3d853a393d28 100644
--- a/testcases/kernel/mem/lib/mem.c
+++ b/testcases/kernel/mem/lib/mem.c
@@ -127,6 +127,10 @@ void oom(int testcase, int lite, int retcode, int allow_sigkill)
 
 	switch (pid = fork()) {
 	case -1:
+		if (errno == retcode) {
+			tst_resm(TPASS | TERRNO, "fork");
+			return;
+		}
 		tst_brkm(TBROK | TERRNO, cleanup, "fork");
 	case 0:
 		threads = MAX(1, tst_ncpus() - 1);
-- 
1.8.3.1

