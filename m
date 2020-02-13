From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 13 Feb 2020 18:35:20 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/kill11,
 abort01: Also raise hard limit when possible
Message-ID: <1581590121-4626-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Currently, running this two cases will report EINVAL error if I run "ulimit -c
1023" command firstly. From setrlimit(2)manpage, it got EINVAL error because
rlim->rlim_cur was greater than rlim->rlim_max. So raise the limit when possible.

Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
---
 testcases/kernel/syscalls/abort/abort01.c | 9 +++++++++
 testcases/kernel/syscalls/kill/kill11.c   | 8 ++++++++
 2 files changed, 17 insertions(+)

diff --git a/testcases/kernel/syscalls/abort/abort01.c b/testcases/kernel/syscalls/abort/abort01.c
index 386a22f26..6fde3721c 100644
--- a/testcases/kernel/syscalls/abort/abort01.c
+++ b/testcases/kernel/syscalls/abort/abort01.c
@@ -70,6 +70,15 @@ static void setup(void)
 
 	/* make sure we get core dumps */
 	SAFE_GETRLIMIT(RLIMIT_CORE, &rlim);
+
+	if (rlim.rlim_max < MIN_RLIMIT_CORE) {
+		if (geteuid() != 0) {
+			tst_brk(TCONF, "hard limit(%lu)less than MIN_RLIMT_CORE(%i)",
+				rlim.rlim_max, MIN_RLIMIT_CORE);
+		}
+		tst_res(TINFO, "Raising rlim_max to %i", MIN_RLIMIT_CORE);
+		rlim.rlim_max = MIN_RLIMIT_CORE;
+	}
 	if (rlim.rlim_cur < MIN_RLIMIT_CORE) {
 		rlim.rlim_cur = MIN_RLIMIT_CORE;
 		SAFE_SETRLIMIT(RLIMIT_CORE, &rlim);
diff --git a/testcases/kernel/syscalls/kill/kill11.c b/testcases/kernel/syscalls/kill/kill11.c
index 83fba5beb..4025fcc87 100644
--- a/testcases/kernel/syscalls/kill/kill11.c
+++ b/testcases/kernel/syscalls/kill/kill11.c
@@ -201,6 +201,14 @@ void setup(void)
 
 	SAFE_GETRLIMIT(NULL, RLIMIT_CORE, &rlim);
 
+	if (rlim.rlim_max < MIN_RLIMIT_CORE) {
+		if (geteuid() != 0) {
+			tst_brkm(TCONF, NULL, "hard limit(%lu)less than MIN_RLIMT_CORE(%i)",
+				rlim.rlim_max, MIN_RLIMIT_CORE);
+		}
+		tst_resm(TINFO, "Raising rlim_max to %i", MIN_RLIMIT_CORE);
+		rlim.rlim_max = MIN_RLIMIT_CORE;
+	}
 	if (rlim.rlim_cur < MIN_RLIMIT_CORE) {
 		tst_resm(TINFO, "Adjusting RLIMIT_CORE to %i", MIN_RLIMIT_CORE);
 		rlim.rlim_cur = MIN_RLIMIT_CORE;
-- 
2.18.0



