From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Tue, 29 Jun 2021 14:10:45 +0200
Subject: [LTP] [PATCH v4 2/4] tst_pid.c: fix fork failure on small memory
 systems
In-Reply-To: <20210629121047.100391-1-krzysztof.kozlowski@canonical.com>
References: <20210629121047.100391-1-krzysztof.kozlowski@canonical.com>
Message-ID: <20210629121047.100391-3-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Running syscalls/msgstress04 on a system with less than ~4 GB of RAM fails:

    Fork failure in the first child of child group 4396
    Fork failure in the second child of child group 4413
    msgstress04    1  TFAIL  :  msgstress04.c:222: Child exit status = 1

The reason is cgroups pid limit set by systemd user.slice.  The limit is
set for login session, also for root user.  For example on 2 GB RAM
machine it is set as:
    /sys/fs/cgroup/pids/user.slice/user-0.slice/pids.max:5207

Read the maximum number of pids and adjust the test limit.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 include/tst_pid.h |  4 ++-
 lib/tst_pid.c     | 70 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 72 insertions(+), 2 deletions(-)

diff --git a/include/tst_pid.h b/include/tst_pid.h
index 6c42f73a57e7..8d999a655f1a 100644
--- a/include/tst_pid.h
+++ b/include/tst_pid.h
@@ -14,7 +14,9 @@ pid_t tst_get_unused_pid_(void (*cleanup_fn)(void));
 
 /*
  * Returns number of free pids by subtraction of the number of pids
- * currently used ('ps -eT') from max_pids
+ * currently used ('ps -eT') from maximum number of processes.
+ * The limit of processes come from kernel pid_max and cgroup session limits
+ * (e.g. configured by systemd user.slice).
  */
 int tst_get_free_pids_(void (*cleanup_fn)(void));
 
diff --git a/lib/tst_pid.c b/lib/tst_pid.c
index 9568cc9e91d2..c408172675a7 100644
--- a/lib/tst_pid.c
+++ b/lib/tst_pid.c
@@ -18,14 +18,20 @@
  *   Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
 
+#include <errno.h>
 #include <fcntl.h>
 #include <limits.h>
+#include <stdio.h>
+#include <stdlib.h>
 #include <sys/types.h>
+#include <unistd.h>
 #include "test.h"
 #include "tst_pid.h"
 #include "old_safe_file_ops.h"
 
 #define PID_MAX_PATH "/proc/sys/kernel/pid_max"
+#define CGROUPS_V1_SLICE_FMT "/sys/fs/cgroup/pids/user.slice/user-%d.slice/pids.max"
+#define CGROUPS_V2_SLICE_FMT "/sys/fs/cgroup/user.slice/user-%d.slice/pids.max"
 
 pid_t tst_get_unused_pid_(void (*cleanup_fn) (void))
 {
@@ -36,10 +42,68 @@ pid_t tst_get_unused_pid_(void (*cleanup_fn) (void))
 	return pid;
 }
 
+/*
+ * Get the effective session UID - either one invoking current test via sudo
+ * or the real UID.
+ */
+static unsigned int get_session_uid(void)
+{
+	const char *sudo_uid;
+
+	sudo_uid = getenv("SUDO_UID");
+	if (sudo_uid) {
+		unsigned int real_uid;
+		int ret;
+
+		ret = sscanf(sudo_uid, "%u", &real_uid);
+		if (ret == 1)
+			return real_uid;
+	}
+
+	return getuid();
+}
+
+static int read_session_pids_limit(const char *path_fmt, int uid,
+				   void (*cleanup_fn) (void))
+{
+	int max_pids, ret;
+	char path[PATH_MAX];
+
+	ret = snprintf(path, sizeof(path), path_fmt, uid);
+	if (ret < 0 || (size_t)ret >= sizeof(path))
+		return -1;
+
+	if (access(path, R_OK) != 0) {
+		tst_resm(TINFO, "Cannot read session user limits from '%s'", path);
+		return -1;
+	}
+
+	SAFE_FILE_SCANF(cleanup_fn, path, "%d", &max_pids);
+	tst_resm(TINFO, "Found limit of processes %d (from %s)", max_pids, path);
+
+	return max_pids;
+}
+
+static int get_session_pids_limit(void (*cleanup_fn) (void))
+{
+	int max_pids, uid;
+
+	uid = get_session_uid();
+	max_pids = read_session_pids_limit(CGROUPS_V2_SLICE_FMT, uid, cleanup_fn);
+	if (max_pids < 0)
+		max_pids = read_session_pids_limit(CGROUPS_V1_SLICE_FMT, uid,
+						   cleanup_fn);
+
+	if (max_pids < 0)
+		return -1;
+
+	return max_pids;
+}
+
 int tst_get_free_pids_(void (*cleanup_fn) (void))
 {
 	FILE *f;
-	int rc, used_pids, max_pids;
+	int rc, used_pids, max_pids, max_session_pids;
 
 	f = popen("ps -eT | wc -l", "r");
 	if (!f) {
@@ -57,6 +121,10 @@ int tst_get_free_pids_(void (*cleanup_fn) (void))
 
 	SAFE_FILE_SCANF(cleanup_fn, PID_MAX_PATH, "%d", &max_pids);
 
+	max_session_pids = get_session_pids_limit(cleanup_fn);
+	if ((max_session_pids > 0) && (max_session_pids < max_pids))
+		max_pids = max_session_pids;
+
 	/* max_pids contains the maximum PID + 1,
 	 * used_pids contains used PIDs + 1,
 	 * so this additional '1' is eliminated by the substraction */
-- 
2.27.0

