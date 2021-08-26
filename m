From: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Date: Thu, 26 Aug 2021 12:27:08 +0200
Subject: [LTP] [PATCH v6] syscalls/msgstress: tune limit of processes for
 small machines
Message-ID: <20210826102708.23721-1-krzysztof.kozlowski@canonical.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Forking the exactly amount of processes as the limit (either from
max_pids or from cgroups) is risky - OS might be doing some work and
interfere with the test.  Instead leave some reserve (hard-coded
to 50) for the OS so the test won't fail on fork failure.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v5:
1. Move the max-pid-reserve to cover non-systemd case.
---
 lib/tst_pid.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/tst_pid.c b/lib/tst_pid.c
index 23753988ca57..897a1b96ac1d 100644
--- a/lib/tst_pid.c
+++ b/lib/tst_pid.c
@@ -32,6 +32,8 @@
 #define PID_MAX_PATH "/proc/sys/kernel/pid_max"
 #define CGROUPS_V1_SLICE_FMT "/sys/fs/cgroup/pids/user.slice/user-%d.slice/pids.max"
 #define CGROUPS_V2_SLICE_FMT "/sys/fs/cgroup/user.slice/user-%d.slice/pids.max"
+/* Leave some available processes for the OS */
+#define PIDS_RESERVE 50
 
 pid_t tst_get_unused_pid_(void (*cleanup_fn) (void))
 {
@@ -124,6 +126,11 @@ int tst_get_free_pids_(void (*cleanup_fn) (void))
 	if ((max_session_pids > 0) && (max_session_pids < max_pids))
 		max_pids = max_session_pids;
 
+	if (max_pids > PIDS_RESERVE)
+		max_pids -= PIDS_RESERVE;
+	else
+		max_pids = 0;
+
 	/* max_pids contains the maximum PID + 1,
 	 * used_pids contains used PIDs + 1,
 	 * so this additional '1' is eliminated by the substraction */
-- 
2.30.2

