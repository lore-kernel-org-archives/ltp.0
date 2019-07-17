From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Jul 2019 15:21:09 +0800
Subject: [LTP] [PATCH] snd_timer: check if file /dev/snd/timer exist before
 opening
Message-ID: <20190717072109.7077-1-liwang@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

1. check if /dev/snd/timer exist

2. add tst_fzsync_pair_reset(&fzsync_pair, NULL) to reset variables
needed by fzsync. Especially for pair->exec_time_start, we use it to
control the test time in case that the execution loops timed out on
slow machine.

Signed-off-by: Li Wang <liwang@redhat.com>
Cc: Michael Moese <mmoese@suse.de>
---
 testcases/kernel/sound/snd_timer01.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/sound/snd_timer01.c b/testcases/kernel/sound/snd_timer01.c
index 36f0ce9fd..f62696659 100644
--- a/testcases/kernel/sound/snd_timer01.c
+++ b/testcases/kernel/sound/snd_timer01.c
@@ -67,6 +67,9 @@ static void *ioctl_thread(void *unused)
 
 static void setup(void)
 {
+	if(access("/dev/snd/timer", F_OK))
+		tst_brk(TCONF, "The file '/dev/snd/timer' is not exist");
+
 	tst_fzsync_pair_init(&fzsync_pair);
 	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
 	snd_fd = SAFE_OPEN("/dev/snd/timer",
@@ -75,7 +78,8 @@ static void setup(void)
 
 static void cleanup(void)
 {
-	SAFE_CLOSE(snd_fd);
+	if (snd_fd > 0)
+		SAFE_CLOSE(snd_fd);
 }
 
 static void run(void)
@@ -95,6 +99,7 @@ static void run(void)
 	iov.iov_base = read_buf;
 	iov.iov_len = sizeof(read_buf) - 1;
 
+	tst_fzsync_pair_reset(&fzsync_pair, NULL);
 	while (tst_fzsync_run_a(&fzsync_pair)) {
 		nz = 0;
 		memset(read_buf, 0, sizeof(read_buf));
-- 
2.20.1

