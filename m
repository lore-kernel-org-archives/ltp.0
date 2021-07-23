From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 23 Jul 2021 15:19:57 +0200
Subject: [LTP] [PATCH] clock_gettime01: avoid zero exec runtime due to irq
 and steal time accounting
Message-ID: <15dd5ab99369da3cba33a748d1bf05be145ef373.1627046193.git.jstancek@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Test is sporadically failing on KVM guests with zero-ed timespec
returned by CLOCK_{PROCESS,THREAD}_CPUTIME_ID. This can be reproduced
on kernels v4.18 and v5.13-rc3 which have IRQ and PARAVIRT TIME
ACCOUNTING enabled.

Task exectime is usually updated on call of clock_gettime().
But update_rq_clock_task() may not update clock_task if there's
more unaccounted irq or steal time than rq->clock delta since
last call. In this instance rq->clock_task does not advance
and it is left for next update to account rest. Because LTP
test is quick and checks only once, it sometimes sees zero
timespec and treats it as failure.

Add a small warm-up to setup() in form of busy loop, to make
sure that clock_task advanced. In case of bug we would either
hit a timeout or still report zeroed timespec.

Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 .../kernel/syscalls/clock_gettime/clock_gettime01.c      | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c b/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
index be9573afcc8e..11da39cf07cf 100644
--- a/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
+++ b/testcases/kernel/syscalls/clock_gettime/clock_gettime01.c
@@ -73,7 +73,15 @@ static struct time64_variants variants[] = {
 
 static void setup(void)
 {
+	long unsigned utime;
+
 	tst_res(TINFO, "Testing variant: %s", variants[tst_variant].desc);
+
+	do {
+		SAFE_FILE_SCANF("/proc/self/stat",
+			"%*d %*s %*c %*d %*d %*d %*d %*d %*u %*u %*u %*u %*u %lu",
+			&utime);
+	} while (utime == 0);
 }
 
 static void verify_clock_gettime(unsigned int i)
@@ -118,4 +126,5 @@ static struct tst_test test = {
 	.test_variants = ARRAY_SIZE(variants),
 	.setup = setup,
 	.needs_root = 1,
+	.timeout = 10,
 };
-- 
2.27.0

