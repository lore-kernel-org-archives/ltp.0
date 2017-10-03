From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 17:40:52 +0200
Subject: [LTP] [COMMITTED] [PATCH 05/13] Make use of SAFE_PIPE()
In-Reply-To: <20171003154100.807-1-chrubis@suse.cz>
References: <20171003154100.807-1-chrubis@suse.cz>
Message-ID: <20171003154100.807-5-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/containers/pidns/pidns05.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/containers/pidns/pidns05.c b/testcases/kernel/containers/pidns/pidns05.c
index cdcf76a14..8462243cd 100644
--- a/testcases/kernel/containers/pidns/pidns05.c
+++ b/testcases/kernel/containers/pidns/pidns05.c
@@ -49,6 +49,7 @@
 #include <errno.h>
 #include "pidns_helper.h"
 #include "test.h"
+#include "safe_macros.h"
 
 #define INIT_PID	1
 #define CINIT_PID	1
@@ -230,9 +231,7 @@ int main(int argc, char *argv[])
 
 	pid = getpid();
 	pgid = getpgid(pid);
-	ret = pipe(fd);
-	if (ret == -1)
-		tst_brkm(TBROK | TERRNO, NULL, "pipe failed");
+	SAFE_PIPE(NULL, fd);
 
 	TEST(do_clone_unshare_test(T_CLONE, CLONE_NEWPID,
 				   create_nested_container, (void *)&count));
-- 
2.13.5

