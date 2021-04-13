From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Tue, 13 Apr 2021 08:07:53 +0100
Subject: [LTP] [PATCH v4 7/7] fzsync: Check processor affinity
In-Reply-To: <20210413070753.1691-1-rpalethorpe@suse.com>
References: <20210413070753.1691-1-rpalethorpe@suse.com>
Message-ID: <20210413070753.1691-8-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

It is useful for testing Fuzzy Sync itself to set the CPU affinity to
a single core. The current processes affinity does not effect
tst_ncpus(), but we can get the affinity separately.

Note that checking this still does not guarantee we will use yield
when restricted to only one core. We would have to periodically probe
which CPUs threads are running on until we detect more than one CPU.

Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>
Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Acked-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
---
 include/tst_fuzzy_sync.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/tst_fuzzy_sync.h b/include/tst_fuzzy_sync.h
index 36a604e13..8f97bb8f6 100644
--- a/include/tst_fuzzy_sync.h
+++ b/include/tst_fuzzy_sync.h
@@ -61,7 +61,6 @@
 
 #include <math.h>
 #include <pthread.h>
-#include <sched.h>
 #include <stdbool.h>
 #include <stdlib.h>
 #include <sys/time.h>
@@ -218,7 +217,9 @@ static void tst_fzsync_pair_init(struct tst_fzsync_pair *pair)
 	CHK(max_dev_ratio, 0, 1, 0.1);
 	CHK(exec_time_p, 0, 1, 0.5);
 	CHK(exec_loops, 20, INT_MAX, 3000000);
-	CHK(yield_in_wait, 0, 1, (tst_ncpus() <= 1));
+
+	if (tst_ncpus_available() <= 1)
+		pair->yield_in_wait = 1;
 }
 #undef CHK
 
-- 
2.30.2

