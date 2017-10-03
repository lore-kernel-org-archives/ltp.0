From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue,  3 Oct 2017 16:19:46 +0200
Subject: [LTP] [COMMITTED] [PATCH 13/40] Make use of SAFE_LINK()
In-Reply-To: <20171003142013.25230-1-chrubis@suse.cz>
References: <20171003142013.25230-1-chrubis@suse.cz>
Message-ID: <20171003142013.25230-13-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/syscalls/rename/rename13.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/syscalls/rename/rename13.c b/testcases/kernel/syscalls/rename/rename13.c
index a42beba35..72394a2d7 100644
--- a/testcases/kernel/syscalls/rename/rename13.c
+++ b/testcases/kernel/syscalls/rename/rename13.c
@@ -65,6 +65,7 @@
 #include <errno.h>
 
 #include "test.h"
+#include "safe_macros.h"
 
 void setup();
 void cleanup();
@@ -179,10 +180,7 @@ void setup(void)
 	oldino = buf1.st_ino;
 
 	/* link the "new" file to the "old" file */
-	if (link(fname, mname) == -1) {
-		tst_brkm(TBROK, cleanup,
-			 "link from %s to %s failed!", fname, mname);
-	}
+	SAFE_LINK(cleanup, fname, mname);
 }
 
 /*
-- 
2.13.5

