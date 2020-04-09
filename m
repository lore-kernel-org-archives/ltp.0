From: Martin Doucha <mdoucha@suse.cz>
Date: Thu,  9 Apr 2020 13:32:59 +0200
Subject: [LTP] [PATCH] Add write()/ioctl() race variant to snd_seq01
Message-ID: <20200409113259.27515-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

CVE 2018-7566 has two different reproducers, this is the other one for the sake
of completeness.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Both races should finish in less than 2 seconds on a patched system but
triggering the bug in the ioctl()/write() race will result in unkillable
process stuck in syscall. Waiting 5 minutes to find out is a waste of time
so I've reduced the timeout to 30 seconds.

I've also added another ioctl() to clear kernel buffer before every race,
otherwise the write() call will block forever when the buffer gets full.

 testcases/kernel/sound/snd_seq01.c | 43 +++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 6 deletions(-)

diff --git a/testcases/kernel/sound/snd_seq01.c b/testcases/kernel/sound/snd_seq01.c
index e0f197e74..c3b4b6ac2 100644
--- a/testcases/kernel/sound/snd_seq01.c
+++ b/testcases/kernel/sound/snd_seq01.c
@@ -24,10 +24,27 @@
 #include "tst_fuzzy_sync.h"
 #include "tst_taint.h"
 
+typedef void (*racefunc_t)(void);
+
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
 
+static void race_ioctl(void);
+static void race_write(void);
+
+racefunc_t testfunc_list[] = {race_ioctl, race_write};
+
 static void setup(void)
 {
 	struct snd_seq_queue_info qconf = { .queue = 0 };
@@ -44,6 +61,7 @@ static void setup(void)
 
 	SAFE_IOCTL(fd, SNDRV_SEQ_IOCTL_CLIENT_ID, &client_id);
 	SAFE_IOCTL(fd, SNDRV_SEQ_IOCTL_CREATE_QUEUE, &qconf);
+	ssev.dest.client = client_id;
 
 	fzsync_pair.exec_loops = 100000;
 	tst_fzsync_pair_init(&fzsync_pair);
@@ -63,28 +81,39 @@ static void reinit_pool(int pool_size)
 		.client = client_id
 	};
 
-	SAFE_IOCTL(fd, SNDRV_SEQ_IOCTL_SET_CLIENT_POOL, &pconf);
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
+	write(fd, &ssev, sizeof(ssev));
 }
 
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
@@ -97,9 +126,11 @@ static void run(void)
 }
 
 static struct tst_test test = {
-	.test_all = run,
+	.test = run,
+	.tcnt = ARRAY_SIZE(testfunc_list),
 	.setup = setup,
 	.cleanup = cleanup,
+	.timeout = 30,
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "d15d662e89fc"},
 		{"CVE", "2018-7566"},
-- 
2.26.0

