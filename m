From: Martin Doucha <mdoucha@suse.cz>
Date: Thu, 16 Apr 2020 15:41:28 +0200
Subject: [LTP] [PATCH v2] Add write()/ioctl() race variant to snd_seq01
Message-ID: <20200416134128.4539-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

CVE 2018-7566 has two different reproducers, this is the other one for the sake
of completeness.

Also fix licence, it should have been GPL-2.0-or-later from the beginning.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1:
- slight refactoring of the test case list
- wrapped the write() call with the TEST() macro to silence compiler warning
- increased race iteration limit to make the write()/ioctl() race more reliable
- increased test timeout
- fixed licence

SAFE_WRITE() is not usable here because the write() call is sometimes expected
to fail but we don't care about the return value. The TEST() macro is good
enough to silence the warning.

 testcases/kernel/sound/snd_seq01.c | 60 +++++++++++++++++++++---------
 1 file changed, 43 insertions(+), 17 deletions(-)

diff --git a/testcases/kernel/sound/snd_seq01.c b/testcases/kernel/sound/snd_seq01.c
index e0f197e74..0c1a44f48 100644
--- a/testcases/kernel/sound/snd_seq01.c
+++ b/testcases/kernel/sound/snd_seq01.c
@@ -1,4 +1,4 @@
-// SPDX-License-Identifier: GPL-2.0
+// SPDX-License-Identifier: GPL-2.0-or-later
 /*
  * Copyright (C) 2018 SUSE LLC <nstange@suse.de>
  * Copyright (C) 2020 SUSE LLC <mdoucha@suse.cz>
@@ -26,8 +26,40 @@
 
 static int fd = -1;
 static int client_id;
+static struct snd_seq_remove_events rminfo = {
+	.remove_mode = SNDRV_SEQ_REMOVE_OUTPUT
+};
+static struct snd_seq_event ssev = {
+	.flags = SNDRV_SEQ_TIME_STAMP_TICK | SNDRV_SEQ_TIME_MODE_REL,
+	.queue = 0,
+	.type = SNDRV_SEQ_EVENT_USR0,
+	.time = { .tick = 10 }
+};
+
 static struct tst_fzsync_pair fzsync_pair;
 
+static void reinit_pool(int pool_size)
+{
+	struct snd_seq_client_pool pconf = {
+		.output_pool = pool_size,
+		.client = client_id
+	};
+
+	ioctl(fd, SNDRV_SEQ_IOCTL_SET_CLIENT_POOL, &pconf);
+}
+
+static void race_ioctl(void)
+{
+	reinit_pool(512);
+}
+
+static void race_write(void)
+{
+	TEST(write(fd, &ssev, sizeof(ssev)));
+}
+
+void (*testfunc_list[])(void) = {race_ioctl, race_write};
+
 static void setup(void)
 {
 	struct snd_seq_queue_info qconf = { .queue = 0 };
@@ -44,8 +76,9 @@ static void setup(void)
 
 	SAFE_IOCTL(fd, SNDRV_SEQ_IOCTL_CLIENT_ID, &client_id);
 	SAFE_IOCTL(fd, SNDRV_SEQ_IOCTL_CREATE_QUEUE, &qconf);
+	ssev.dest.client = client_id;
 
-	fzsync_pair.exec_loops = 100000;
+	fzsync_pair.exec_loops = 1000000;
 	tst_fzsync_pair_init(&fzsync_pair);
 }
 
@@ -56,35 +89,26 @@ static void cleanup(void)
 	tst_fzsync_pair_cleanup(&fzsync_pair);
 }
 
-static void reinit_pool(int pool_size)
-{
-	struct snd_seq_client_pool pconf = {
-		.output_pool = pool_size,
-		.client = client_id
-	};
-
-	SAFE_IOCTL(fd, SNDRV_SEQ_IOCTL_SET_CLIENT_POOL, &pconf);
-}
-
 static void *thread_run(void *arg)
 {
 	while (tst_fzsync_run_b(&fzsync_pair)) {
 		tst_fzsync_start_race_b(&fzsync_pair);
-		reinit_pool(512);
+		reinit_pool(10);
 		tst_fzsync_end_race_b(&fzsync_pair);
 	}
 
 	return arg;
 }
 
-static void run(void)
+static void run(unsigned int n)
 {
 	tst_fzsync_pair_reset(&fzsync_pair, thread_run);
 
 	while (tst_fzsync_run_a(&fzsync_pair)) {
-		reinit_pool(1);
+		reinit_pool(5);
+		SAFE_IOCTL(fd, SNDRV_SEQ_IOCTL_REMOVE_EVENTS, &rminfo);
 		tst_fzsync_start_race_a(&fzsync_pair);
-		reinit_pool(2);
+		testfunc_list[n]();
 		tst_fzsync_end_race_a(&fzsync_pair);
 
 		if (tst_taint_check()) {
@@ -97,9 +121,11 @@ static void run(void)
 }
 
 static struct tst_test test = {
-	.test_all = run,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testfunc_list),
 	.setup = setup,
 	.cleanup = cleanup,
+	.timeout = 120,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d15d662e89fc"},
 		{"CVE", "2018-7566"},
-- 
2.26.0

