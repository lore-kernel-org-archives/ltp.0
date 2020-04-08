From: Martin Doucha <mdoucha@suse.cz>
Date: Wed,  8 Apr 2020 12:30:50 +0200
Subject: [LTP] [PATCH] Add test for CVE 2018-7566
Message-ID: <20200408103050.27706-1-mdoucha@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Fixes #606
---

There are two reproducers for this CVE:
- ioctl()/ioctl() race
- ioctl()/write() race

I've implemented the first one because it reliably crashes SLE-12SP3 GM kernel.
The other reproducer gets stuck in one of the syscalls but I couldn't get it
to trigger an actual crash. Should I implement the other one as well?

 runtest/cve                        |   1 +
 testcases/kernel/sound/.gitignore  |   1 +
 testcases/kernel/sound/Makefile    |   2 +
 testcases/kernel/sound/snd_seq01.c | 107 +++++++++++++++++++++++++++++
 4 files changed, 111 insertions(+)
 create mode 100644 testcases/kernel/sound/snd_seq01.c

diff --git a/runtest/cve b/runtest/cve
index dbd065fd1..7d754085e 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -40,6 +40,7 @@ cve-2017-17053 cve-2017-17053
 cve-2017-18075 pcrypt_aead01
 cve-2017-1000380 snd_timer01
 cve-2018-5803 sctp_big_chunk
+cve-2018-7566 snd_seq01
 cve-2018-1000001 realpath01
 cve-2018-1000199 ptrace08
 cve-2018-1000204 ioctl_sg01
diff --git a/testcases/kernel/sound/.gitignore b/testcases/kernel/sound/.gitignore
index 33692e690..e33480fb6 100644
--- a/testcases/kernel/sound/.gitignore
+++ b/testcases/kernel/sound/.gitignore
@@ -1 +1,2 @@
 snd_timer01
+/snd_seq01
diff --git a/testcases/kernel/sound/Makefile b/testcases/kernel/sound/Makefile
index 9abcc2b27..022e69197 100644
--- a/testcases/kernel/sound/Makefile
+++ b/testcases/kernel/sound/Makefile
@@ -8,5 +8,7 @@ CPPFLAGS		+= -D_GNU_SOURCE
 
 snd_timer01: CFLAGS+=-pthread
 snd_timer01: LDLIBS+=-lrt
+snd_seq01:	CFLAGS += -pthread
+snd_seq01:	LDLIBS += -lrt
 
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sound/snd_seq01.c b/testcases/kernel/sound/snd_seq01.c
new file mode 100644
index 000000000..b057a9cfc
--- /dev/null
+++ b/testcases/kernel/sound/snd_seq01.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2018 SUSE LLC <nstange@suse.de>
+ * Copyright (C) 2020 SUSE LLC <mdoucha@suse.cz>
+ *
+ * CVE-2018-7566
+ *
+ * Test for race condition when initializing client pool on /dev/snd/seq
+ * Kernel crash fixed in:
+ *
+ *  commit d15d662e89fc667b90cd294b0eb45694e33144da
+ *  Author: Takashi Iwai <tiwai@suse.de>
+ *  Date:   Mon Feb 12 15:20:51 2018 +0100
+ *
+ *  ALSA: seq: Fix racy pool initializations
+ */
+
+#include <linux/types.h>
+#include <sound/asound.h>
+#include <sound/asequencer.h>
+
+#include "tst_test.h"
+#include "tst_fuzzy_sync.h"
+#include "tst_taint.h"
+
+static int fd = -1;
+static int client_id;
+static struct tst_fzsync_pair fzsync_pair;
+
+static void setup(void)
+{
+	struct snd_seq_queue_info qconf = { .queue = 0 };
+
+	tst_taint_init(TST_TAINT_W | TST_TAINT_D);
+	errno = 0;
+	fd = open("/dev/snd/seq", O_RDWR);
+
+	if (fd == -1 && (errno == ENOENT || errno == EACCES))
+		tst_brk(TCONF | TERRNO, "Cannot open /dev/snd/seq");
+
+	if (fd < 0)
+		tst_brk(TBROK | TERRNO, "Cannot open /dev/snd/seq");
+
+	SAFE_IOCTL(fd, SNDRV_SEQ_IOCTL_CLIENT_ID, &client_id);
+	SAFE_IOCTL(fd, SNDRV_SEQ_IOCTL_CREATE_QUEUE, &qconf);
+
+	fzsync_pair.exec_loops = 100000;
+	tst_fzsync_pair_init(&fzsync_pair);
+}
+
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+	tst_fzsync_pair_cleanup(&fzsync_pair);
+}
+
+static void reinit_pool(int pool_size)
+{
+	struct snd_seq_client_pool pconf = {
+		.output_pool = pool_size,
+		.client = client_id
+	};
+
+	SAFE_IOCTL(fd, SNDRV_SEQ_IOCTL_SET_CLIENT_POOL, &pconf);
+}
+
+static void *thread_run(void *arg)
+{
+	while (tst_fzsync_run_b(&fzsync_pair)) {
+		tst_fzsync_start_race_b(&fzsync_pair);
+		reinit_pool(512);
+		tst_fzsync_end_race_b(&fzsync_pair);
+	}
+
+	return arg;
+}
+
+static void run(void)
+{
+	tst_fzsync_pair_reset(&fzsync_pair, thread_run);
+
+	while (tst_fzsync_run_a(&fzsync_pair)) {
+		reinit_pool(1);
+		tst_fzsync_start_race_a(&fzsync_pair);
+		reinit_pool(2);
+		tst_fzsync_end_race_a(&fzsync_pair);
+
+		if (tst_taint_check()) {
+			tst_res(TFAIL, "Kernel is vulnerable");
+			return;
+		}
+	}
+
+	tst_res(TPASS, "Nothing bad happened, probably");
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "d15d662e89fc"},
+		{"CVE", "2018-7566"},
+		{}
+	}
+};
-- 
2.26.0

