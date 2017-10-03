From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 17:40:57 +0200
Subject: [LTP] [COMMITTED] [PATCH 10/13] Make use of SAFE_WAITPID()
In-Reply-To: <20171003154100.807-1-chrubis@suse.cz>
References: <20171003154100.807-1-chrubis@suse.cz>
Message-ID: <20171003154100.807-10-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/fork/fork12.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/fork/fork12.c b/testcases/kernel/syscalls/fork/fork12.c
index 711fe9874..75278b012 100644
--- a/testcases/kernel/syscalls/fork/fork12.c
+++ b/testcases/kernel/syscalls/fork/fork12.c
@@ -44,6 +44,7 @@
 #include <errno.h>
 #include <string.h>
 #include "test.h"
+#include "safe_macros.h"
 
 char *TCID = "fork12";
 int TST_TOTAL = 1;
@@ -73,11 +74,7 @@ int main(int ac, char **av)
 				exit(0);
 			}
 			forks++;
-			ret = waitpid(-1, &status, WNOHANG);
-			if (ret < 0)
-				tst_brkm(TBROK, cleanup,
-					 "waitpid failed %d: %s\n", errno,
-					 strerror(errno));
+			ret = SAFE_WAITPID(cleanup, -1, &status, WNOHANG);
 			if (ret > 0) {
 				/* a child may be killed by OOM killer */
 				if (WTERMSIG(status) == SIGKILL)
-- 
2.13.5

