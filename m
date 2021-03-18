From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Thu, 18 Mar 2021 13:09:34 +0000
Subject: [LTP] [PATCH v2 6/7] API: Add tst_ncpus_available
In-Reply-To: <20210318130935.28528-1-rpalethorpe@suse.com>
References: <20210318130935.28528-1-rpalethorpe@suse.com>
Message-ID: <20210318130935.28528-7-rpalethorpe@suse.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Same as tst_ncpus, but takes CPU affinity into account.

Signed-off-by: Richard Palethorpe <rpalethorpe@suse.com>
---
 include/tst_cpu.h |  1 +
 lib/tst_cpu.c     | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/tst_cpu.h b/include/tst_cpu.h
index 117e27087..b3a449bea 100644
--- a/include/tst_cpu.h
+++ b/include/tst_cpu.h
@@ -8,6 +8,7 @@
 long tst_ncpus(void);
 long tst_ncpus_conf(void);
 long tst_ncpus_max(void);
+long tst_ncpus_available(void);
 
 #define VIRT_ANY	0	/* catch-all argument for tst_is_virt() */
 #define VIRT_XEN	1	/* xen dom0/domU */
diff --git a/lib/tst_cpu.c b/lib/tst_cpu.c
index 033155e47..581215199 100644
--- a/lib/tst_cpu.c
+++ b/lib/tst_cpu.c
@@ -17,6 +17,8 @@
  *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
+#include "lapi/cpuset.h"
+
 #include <stdlib.h>
 #include <unistd.h>
 #include "test.h"
@@ -71,3 +73,24 @@ long tst_ncpus_max(void)
 	}
 	return ncpus_max;
 }
+
+long tst_ncpus_available(void)
+{
+#ifdef CPU_COUNT
+	long ncpus = tst_ncpus_max();
+	size_t cpusz = CPU_ALLOC_SIZE(ncpus);
+	cpu_set_t *cpus = CPU_ALLOC(ncpus);
+
+	if (sched_getaffinity(0, cpusz, cpus)) {
+		tst_resm(TWARN | TERRNO, "sched_getaffinity(0, %zu, %zx)",
+			cpusz, (size_t)cpus);
+	} else {
+		ncpus = CPU_COUNT(cpus);
+	}
+	free(cpus);
+
+	return ncpus;
+#else
+	return tst_ncpus();
+#endif
+}
-- 
2.30.1

