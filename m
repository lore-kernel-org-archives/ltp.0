From: Khem Raj <raj.khem@gmail.com>
Date: Tue, 19 May 2020 22:23:18 -0700
Subject: [LTP] [PATCH] ptrace01: Fix missing format string
Message-ID: <20200520052318.3261805-1-raj.khem@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes
| ptrace01.c:89:2: error: format string is not a string literal
(potentially insecure) [-Werror,-Wformat-security]
|         tst_res(TINFO, tc->message);
|         ^              ~~~~~~~~~~~

Signed-off-by: Khem Raj <raj.khem@gmail.com>
---
 testcases/kernel/syscalls/ptrace/ptrace01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ptrace/ptrace01.c b/testcases/kernel/syscalls/ptrace/ptrace01.c
index 87a99e4150..9071bbabaf 100644
--- a/testcases/kernel/syscalls/ptrace/ptrace01.c
+++ b/testcases/kernel/syscalls/ptrace/ptrace01.c
@@ -86,7 +86,7 @@ static void run(unsigned int i)
 
 	got_signal = 0;
 
-	tst_res(TINFO, tc->message);
+	tst_res(TINFO, "%s", tc->message);
 
 	if (tc->handler == 1) {
 		parent_act.sa_handler = parent_handler;
-- 
2.26.2

