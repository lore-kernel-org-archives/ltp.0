From: Jan Stancek <jstancek@redhat.com>
Date: Tue,  6 Aug 2019 13:10:55 +0200
Subject: [LTP] [PATCH 1/2] clock_getres01: pass non-NULL res as parameter
Message-ID: <76fa74b68aa0794f58e01d5794fffa3a02df0203.1565089789.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Since commit a9446a906f52 ("lib/vdso/32: Remove inconsistent NULL pointer checks")
VDSO treats NULL parameter differently than in syscall.

Pass valid pointer. Subsequent patch will add test variants that test NULL
res parameter using syscall.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 testcases/kernel/syscalls/clock_getres/clock_getres01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/clock_getres/clock_getres01.c b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
index 15f32310839a..6b556965530e 100644
--- a/testcases/kernel/syscalls/clock_getres/clock_getres01.c
+++ b/testcases/kernel/syscalls/clock_getres/clock_getres01.c
@@ -28,7 +28,7 @@ static struct test_case {
 	{"MONOTONIC", CLOCK_MONOTONIC, &res, 0, 0},
 	{"PROCESS_CPUTIME_ID", CLOCK_PROCESS_CPUTIME_ID, &res, 0, 0},
 	{"THREAD_CPUTIME_ID", CLOCK_THREAD_CPUTIME_ID, &res, 0, 0},
-	{"REALTIME", CLOCK_REALTIME, NULL, 0, 0},
+	{"REALTIME", CLOCK_REALTIME, &res, 0, 0},
 	{"CLOCK_MONOTONIC_RAW", CLOCK_MONOTONIC_RAW, &res, 0, 0,},
 	{"CLOCK_REALTIME_COARSE", CLOCK_REALTIME_COARSE, &res, 0, 0,},
 	{"CLOCK_MONOTONIC_COARSE", CLOCK_MONOTONIC_COARSE, &res, 0, 0,},
-- 
1.8.3.1

