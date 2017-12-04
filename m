From: Punit Agrawal <punit.agrawal@arm.com>
Date: Mon,  4 Dec 2017 16:36:54 +0000
Subject: [LTP] [PATCH v3 11/12] perf_event_open: Handle absence of PMU
	gracefully
In-Reply-To: <20171204163655.8838-1-punit.agrawal@arm.com>
References: <20171204163655.8838-1-punit.agrawal@arm.com>
Message-ID: <20171204163655.8838-12-punit.agrawal@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

From: "Suzuki K. Poulose" <suzuki.poulose@arm.com>

The perf_event_open0{1,2} syscall tests fail for an absence of a
PMU (which returns ENODEV). Handle the return code gracefully as we
check for ENOENT.

Without the patch:

$ perf_event_open01
perf_event_open01    1  TFAIL  :  perf_event_open01.c:162: perf_event_open \
		failed unexpectedly: TEST_ERRNO=ENODEV(19): No such device

With the patch:

$ perf_event_open01
perf_event_open01    1  TCONF  :  perf_event_open01.c:159: perf_event_open for PERF_COUNT_HW_INSTRUCTIONS : No such device
perf_event_open01    2  TCONF  :  perf_event_open01.c:159: perf_event_open for PERF_COUNT_HW_CACHE_REFERENCES : No such device
perf_event_open01    3  TCONF  :  perf_event_open01.c:159: perf_event_open for PERF_COUNT_HW_CACHE_MISSES : No such device
perf_event_open01    4  TCONF  :  perf_event_open01.c:159: perf_event_open for PERF_COUNT_HW_BRANCH_INSTRUCTIONS : No such file or directory
perf_event_open01    5  TCONF  :  perf_event_open01.c:159: perf_event_open for PERF_COUNT_HW_BRANCH_MISSES : No such device
perf_event_open01    0  TINFO  :  read event counter succeeded, value: 833765520
perf_event_open01    6  TPASS  :  test PERF_TYPE_HARDWARE: PERF_COUNT_SW_CPU_CLOCK succeeded
perf_event_open01    0  TINFO  :  read event counter succeeded, value: 833967380
perf_event_open01    7  TPASS  :  test PERF_TYPE_HARDWARE: PERF_COUNT_SW_TASK_CLOCK succeeded

Signed-off-by: Suzuki K. Poulose <suzuki.poulose@arm.com>
Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
---
 testcases/kernel/syscalls/perf_event_open/perf_event_open01.c | 3 ++-
 testcases/kernel/syscalls/perf_event_open/perf_event_open02.c | 4 ++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
index 5c814b60c..5568035d9 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
@@ -149,7 +149,8 @@ static void verify(struct test_case_t *tc)
 
 	TEST(perf_event_open(&pe, 0, -1, -1, 0));
 	if (TEST_RETURN == -1) {
-		if (TEST_ERRNO == ENOENT || TEST_ERRNO == EOPNOTSUPP) {
+		if (TEST_ERRNO == ENOENT || TEST_ERRNO == EOPNOTSUPP ||
+		    TEST_ERRNO == ENODEV) {
 			tst_resm(TCONF | TTERRNO,
 			         "perf_event_open for %s not supported",
 			         tc->config_name);
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
index 7d54cbd52..13a17948a 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open02.c
@@ -160,8 +160,8 @@ static int count_hardware_counters(void)
 	for (i = 0; i < MAX_CTRS; i++) {
 		fdarry[i] = perf_event_open(&hw_event, 0, -1, -1, 0);
 		if (fdarry[i] == -1) {
-			if (errno == ENOENT) {
-				tst_brkm(TCONF, cleanup,
+			if (errno == ENOENT || errno == ENODEV) {
+				tst_brkm(TCONF | TERRNO, cleanup,
 				         "PERF_COUNT_HW_INSTRUCTIONS not supported");
 			}
 			tst_brkm(TBROK | TERRNO, cleanup,
-- 
2.15.0

