From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Feb 2017 12:11:26 +0100
Subject: [LTP] [COMMITTED] [PATCH 04/23] syscalls/rename14: Change default
	runtime from 45s to 5s
In-Reply-To: <20170228111145.3265-1-chrubis@suse.cz>
References: <20170228111145.3265-1-chrubis@suse.cz>
Message-ID: <20170228111145.3265-4-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/rename/rename14.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/rename/rename14.c b/testcases/kernel/syscalls/rename/rename14.c
index f79b5c6..726b35c 100644
--- a/testcases/kernel/syscalls/rename/rename14.c
+++ b/testcases/kernel/syscalls/rename/rename14.c
@@ -53,7 +53,7 @@ int local_flag = PASSED;
 char *TCID = "rename14";
 int TST_TOTAL = 1;
 
-#define RUNTIME	45
+#define RUNTIME	5
 
 int kidpid[2];
 int parent_pid;
-- 
2.10.2

