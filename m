From: Xie Ziyao <xieziyao@huawei.com>
Date: Tue, 16 Mar 2021 09:34:24 +0800
Subject: [LTP] [PATCH] kernel/syscalls: Use TERRNO because we're not using
 the TEST() macro.
Message-ID: <20210316013424.196511-1-xieziyao@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

For those:
  testcases/kernel/syscalls/fallocate/fallocate01.c
  testcases/kernel/syscalls/memfd_create/memfd_create01.c
  testcases/kernel/syscalls/perf_event_open/perf_event_open01.c

Signed-off-by: Xie Ziyao <xieziyao@huawei.com>
---
 testcases/kernel/syscalls/fallocate/fallocate01.c           | 4 ++--
 testcases/kernel/syscalls/memfd_create/memfd_create01.c     | 2 +-
 .../kernel/syscalls/perf_event_open/perf_event_open01.c     | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/syscalls/fallocate/fallocate01.c b/testcases/kernel/syscalls/fallocate/fallocate01.c
index 02aa33100..c60e160f4 100644
--- a/testcases/kernel/syscalls/fallocate/fallocate01.c
+++ b/testcases/kernel/syscalls/fallocate/fallocate01.c
@@ -247,14 +247,14 @@ void runtest(int mode, int fd, loff_t expected_size)
 		tst_resm(TFAIL | TERRNO, "fstat failed after fallocate()");

 	if (file_stat.st_size != expected_size)
-		tst_resm(TFAIL | TTERRNO,
+		tst_resm(TFAIL | TERRNO,
 			 "fstat test fails on fallocate (%d, %d, %" PRId64 ", %"
 			 PRId64 ") Failed on mode", fd, mode, offset, len);

 	write_offset = random() % len;
 	lseek_offset = lseek(fd, write_offset, SEEK_CUR);
 	if (lseek_offset != offset + write_offset) {
-		tst_resm(TFAIL | TTERRNO,
+		tst_resm(TFAIL | TERRNO,
 			 "lseek fails in fallocate(%d, %d, %" PRId64 ", %"
 			 PRId64 ") failed on mode", fd, mode, offset, len);
 		return;
diff --git a/testcases/kernel/syscalls/memfd_create/memfd_create01.c b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
index e0db69dff..bdc0c8512 100644
--- a/testcases/kernel/syscalls/memfd_create/memfd_create01.c
+++ b/testcases/kernel/syscalls/memfd_create/memfd_create01.c
@@ -258,7 +258,7 @@ static void setup(void)
 	 * is this flag is missing.
 	 */
 	if (!MFD_FLAGS_AVAILABLE(MFD_ALLOW_SEALING)) {
-		tst_brk(TCONF | TTERRNO,
+		tst_brk(TCONF | TERRNO,
 			"memfd_create(%u) not implemented", MFD_ALLOW_SEALING);
 	}
 }
diff --git a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
index 5568035d9..6286d415d 100644
--- a/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
+++ b/testcases/kernel/syscalls/perf_event_open/perf_event_open01.c
@@ -165,19 +165,19 @@ static void verify(struct test_case_t *tc)
 	fd = TEST_RETURN;

 	if (ioctl(fd, PERF_EVENT_IOC_RESET, 0) == -1) {
-		tst_brkm(TFAIL | TTERRNO, cleanup,
+		tst_brkm(TFAIL | TERRNO, cleanup,
 			 "ioctl set PERF_EVENT_IOC_RESET failed");
 	}

 	if (ioctl(fd, PERF_EVENT_IOC_ENABLE, 0) == -1) {
-		tst_brkm(TFAIL | TTERRNO, cleanup,
+		tst_brkm(TFAIL | TERRNO, cleanup,
 			 "ioctl set PERF_EVENT_IOC_ENABLE failed");
 	}

 	do_work();

 	if (ioctl(fd, PERF_EVENT_IOC_DISABLE, 0) == -1) {
-		tst_brkm(TFAIL | TTERRNO, cleanup,
+		tst_brkm(TFAIL | TERRNO, cleanup,
 			 "ioctl set PERF_EVENT_IOC_RESET failed");
 	}

--
2.17.1

