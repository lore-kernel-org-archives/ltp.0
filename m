From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 12 Oct 2017 20:33:27 +0200
Subject: [LTP] [PATCH v3 10/18] io/aiocp: Exit with TCONF when libaio is not
	available
In-Reply-To: <20171012183335.24568-1-pvorel@suse.cz>
References: <20171012183335.24568-1-pvorel@suse.cz>
Message-ID: <20171012183335.24568-11-pvorel@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/io/ltp-aiodio/aiocp.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
index a00a1a09f..93984bf28 100644
--- a/testcases/kernel/io/ltp-aiodio/aiocp.c
+++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
@@ -34,7 +34,9 @@
 #include <mntent.h>
 #include <sys/select.h>
 #include <sys/mount.h>
+
 #include "config.h"
+#include "tst_res_flags.h"
 
 #if HAVE_LIBAIO_H
 
@@ -602,7 +604,7 @@ int main(int argc, char *const *argv)
 int main(void)
 {
 	fprintf(stderr, "System doesn't have libaio support.\n");
-	return 1;
+	return TCONF;
 }
 
 #endif
-- 
2.14.2

