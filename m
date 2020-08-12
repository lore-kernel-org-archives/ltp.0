From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 12 Aug 2020 14:34:26 +0200
Subject: [LTP] [PATCH] [COMMITTED] crypto/af_alg07: Include lapi/fcntl.h
Message-ID: <20200812123426.17528-1-chrubis@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

To get AF_EMPTY_PATH defined on older distros.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 testcases/kernel/crypto/af_alg07.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/testcases/kernel/crypto/af_alg07.c b/testcases/kernel/crypto/af_alg07.c
index efcdd0016..1e37f9858 100644
--- a/testcases/kernel/crypto/af_alg07.c
+++ b/testcases/kernel/crypto/af_alg07.c
@@ -28,6 +28,7 @@
 #include <sys/stat.h>
 #include <unistd.h>
 #include <pwd.h>
+#include "lapi/fcntl.h"
 
 #include "tst_test.h"
 #include "tst_af_alg.h"
-- 
2.26.2

