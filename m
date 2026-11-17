Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8E2606A31C
	for <ltp@archiver.kernel.org>; Tue, 17 Nov 2026 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=e2au5JO1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g/jK3RGL
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794922679; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=gXTbsS6IC+oUZSbyl04TcUZ1mKEBHbyH92nF806telw=;
 b=e2au5JO1J9sEDn6Z4PTwdJCrpcdCNaYv8fNHQN8KmDYxSWd3lo5giMneL3IBLFvRo+noO
 q2R5JoZ8xCtPuch2K/PdL9cKN0CF4EoB8pr61nodjrQ75hkxp1JivymAUyeDp2lFGP7S8SH
 FuxO6ZQWMKWZx6d0mfhrdnfdBqkgxfo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FA9E3EBB09
	for <ltp@archiver.kernel.org>; Tue, 17 Nov 2026 14:37:59 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CDD203EB40B
 for <ltp@lists.linux.it>; Tue, 17 Nov 2026 14:37:40 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D7FD61400BFD
 for <ltp@lists.linux.it>; Tue, 17 Nov 2026 14:37:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794922657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=M9XHhPikf49X1c7h6zI8vAInQBmAnSJ3xu0qnVtfJ1o=;
 b=g/jK3RGLiFv74KmFitrGGDaiRan4ezkMJp40AxYhoBKSIx0xmXjB/2zV4OetDDQbenZwdh
 1esKAh6fTERXgcH/V4CDBE/9KK+26TCdrqHz9uu3O9UUSTZFesGCZBWthpZkv6BhNWfEIx
 bBOpB2G2auK8MV62pvh/rYrgWUxMuek=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-X5tENAAEN4Csfy5qWprIFA-1; Tue, 17 Nov 2026 08:37:36 -0500
X-MC-Unique: X5tENAAEN4Csfy5qWprIFA-1
X-Mimecast-MFC-AGG-ID: X5tENAAEN4Csfy5qWprIFA_1794922656
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-9495af07676so669994985a.2
 for <ltp@lists.linux.it>; Tue, 17 Nov 2026 05:37:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794922656; x=1795527456;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M9XHhPikf49X1c7h6zI8vAInQBmAnSJ3xu0qnVtfJ1o=;
 b=LUm2qzHaopT0DqiA3iHHoOV4odxioUn0hAmqNMo+qHwdVQMcEp43MjT/lGk5BfdCJl
 TOEuex+085FjkWvZ4kG8Pr6oJVR5Ueqp7qKse9TEsh4JKKyglmvUJ/mFU5rOnI25d/fi
 1NUzqnCmW/5zxDmrvdt4Qnt2VzEaAeSsEOaBdGhJxtqLc/qxxusS3AN7jfSG/Px03avS
 Et4JK+ptyrn/obdTYNFu7fssljSv2xDgjPwgFPkkL3vwE/StSFxwLlFPT8PhBkaUjxO+
 OK4293u51Me/zFCNj6o4lBS9T7eR/IDm8qVCLX/ltW4NCUuuHjKmbmy+IzczVVZbgf/t
 GCdA==
X-Gm-Message-State: APuU4Z9h6IrOHNpDZXLrhn0BgCNszxvJ7M7b6EmE1dJOMKVsEmQKzME6
 1DTqhpbNxr16kHk08nF9PPGNy6+COy/op+0aPQjfOQS8ASUwBGQ6jwhlznmx5sM6JjLxqQz8CVX
 +Bk76FWAQHvjO2saf4Ex+jg/5OHv1AAXDGEPvX75gifu5P/LuZifx55cq3HxNvstAwc+TeX/AvC
 rwvXfBtsTxBaWsnnOuygqy8TVSjHyog6NQKKAq
X-Gm-Gg: AYBFou3aAMXmFTigELYLOapEEDlI+HaA5Lzd7QIFxfxVk1Y21z7ohMMuf8+rI0u0xyh
 iLIN2xfQefI29nrGjUz4ROAhN3ITFx28ZCQ7cMwFIs6iQKp0nXSEvVA3ccomdLpNS2gRDFyKmlI
 sDIM/FSjd+NlLf3WUMgFE3f6MVs4lB07Y2A44frOKcZTS89+QQ/7beKO5ZIDLJxhVFi6+MV80tZ
 TpHj7YMuE/rQRXffjRORA99i8IyuFHfaS0UKeOaq+pjxLaDC8rWZDDh4I2NP97c758DkggK61T3
 lHgo1ohaGZ/leTwkK7rx05Y4aVD59jU23djyBO5DcgEDojd4Gn4XwZ3gNrDgF2i3ZlxTBr28HYM
 JLu6jAioXdWk9nIyKYPTX4SB/5U4kdv1G0mrFd0A4SnCJSQGl25MqIxlqBca5Yd4i6TjmLmDXEm
 WDe4gK
X-Received: by 2002:a05:620a:a89c:10b0:949:61c5:73b8 with SMTP id
 af79cd13be357-94961c57b7fmr1270231385a.44.1794922655698; 
 Tue, 17 Nov 2026 05:37:35 -0800 (PST)
X-Received: by 2002:a05:620a:a89c:10b0:949:61c5:73b8 with SMTP id
 af79cd13be357-94961c57b7fmr1270228685a.44.1794922655062; 
 Tue, 17 Nov 2026 05:37:35 -0800 (PST)
Received: from sbertram-thinkpadp1gen5.redhat.corp ([67.189.222.97])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c836f62sm1094354785a.23.2026.11.17.05.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 05:37:34 -0800 (PST)
To: ltp@lists.linux.it
Date: Tue, 17 Nov 2026 08:37:20 -0500
Message-ID: <20261117133731.1035637-1-sbertram@redhat.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XOfjsskRybndXKVJdntYXGV0o78RXMnfbSmo0Tiwzec_1794922656
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] sound/snd_timer02: Detect CVE-2026-74503 from the
 fallback timer
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Stephen Bertram via ltp <ltp@lists.linux.it>
Reply-To: Stephen Bertram <sbertram@redhat.com>
Cc: Stephen Bertram <sbertram@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Stephen Bertram <sbertram@redhat.com>

Open HRTIMER instances until SELECT returns EBUSY, move the queue to
the system timer, then drop one slot and switch the queue back to
HRTIMER. The matching slave makes snd_timer_check_master() fail, so
snd_seq_timer_open() reuses the instance for the system-timer fallback.

snd_timer_start1() rejects the start while SNDRV_TIMER_IFLG_DEAD is
set, so an unfixed kernel leaves the queue stopped. Point linux-git
at c2744d5f3aea.

Signed-off-by: Stephen Bertram <sbertram@redhat.com>
---
 runtest/cve                          |   1 +
 testcases/kernel/sound/.gitignore    |   1 +
 testcases/kernel/sound/snd_timer02.c | 292 +++++++++++++++++++++++++++
 3 files changed, 294 insertions(+)
 create mode 100644 testcases/kernel/sound/snd_timer02.c

diff --git a/runtest/cve b/runtest/cve
index 0fe25cd83..71d8e3bce 100644
--- a/runtest/cve
+++ b/runtest/cve
@@ -91,6 +91,7 @@ cve-2023-52879 fanotify25
 cve-2026-43499 ghostlock
 cve-2026-53362 setsockopt11
 cve-2026-64600 refluxfs
+cve-2026-74503 snd_timer02
 cve-2026-99999 pwnescape
 # Tests below may cause kernel memory leak
 cve-2020-25704 perf_event_open03
diff --git a/testcases/kernel/sound/.gitignore b/testcases/kernel/sound/.gitignore
index e33480fb6..b2e4041df 100644
--- a/testcases/kernel/sound/.gitignore
+++ b/testcases/kernel/sound/.gitignore
@@ -1,2 +1,3 @@
 snd_timer01
+snd_timer02
 /snd_seq01
diff --git a/testcases/kernel/sound/snd_timer02.c b/testcases/kernel/sound/snd_timer02.c
new file mode 100644
index 000000000..673ea96b6
--- /dev/null
+++ b/testcases/kernel/sound/snd_timer02.c
@@ -0,0 +1,292 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 Red Hat, Inc.
+ */
+
+/*\
+ * Test for CVE-2026-74503.
+ *
+ * snd_timer_close_locked() sets SNDRV_TIMER_IFLG_DEAD and returns
+ * immediately when that flag is already set. remove_slave_links() used
+ * to leave the flag set, so snd_seq_timer_open() could reuse the same
+ * instance for its fallback open and a later close would free an object
+ * that was still on timer->open_list_head.
+ *
+ * Fill the HRTIMER global timer to one below its instance limit and
+ * register a pending slave whose key matches the sequencer queue. Switching
+ * the queue onto HRTIMER then fails in snd_timer_check_master() and the
+ * fallback opens the system timer on that same instance. A fixed kernel
+ * clears SNDRV_TIMER_IFLG_DEAD, so the queue timer starts. An unfixed
+ * kernel still has the flag set, and snd_timer_start1() rejects the start.
+ *
+ * Fixed by c2744d5f3aea ("ALSA: timer: Clear SNDRV_TIMER_IFLG_DEAD once the
+ * close completes").
+ */
+
+#include <stdio.h>
+#include <string.h>
+#include <sys/ioctl.h>
+
+#include "tst_test.h"
+#include "tst_safe_stdio.h"
+
+#include <sound/asound.h>
+#include <sound/asequencer.h>
+
+#define TIMER_DEV	"/dev/snd/timer"
+#define SEQ_DEV		"/dev/snd/seq"
+#define PROC_TIMERS	"/proc/asound/timers"
+
+static int seq_fd = -1;
+static int slave_fd = -1;
+static int *fill_fds;
+static unsigned int fill_n;
+static int queue_id = -1;
+
+static int open_snd(const char *path)
+{
+	int fd = open(path, O_RDWR);
+
+	if (fd >= 0)
+		return fd;
+
+	if (errno == ENOENT || errno == ENODEV || errno == EACCES)
+		tst_brk(TCONF | TERRNO, "open(%s)", path);
+
+	tst_brk(TBROK | TERRNO, "open(%s)", path);
+	return -1;
+}
+
+static void raise_nofile(void)
+{
+	struct rlimit rl;
+
+	SAFE_GETRLIMIT(RLIMIT_NOFILE, &rl);
+	if (rl.rlim_cur >= rl.rlim_max) {
+		tst_brk(TCONF, "RLIMIT_NOFILE %llu cannot hold the HRTIMER instances",
+			(unsigned long long)rl.rlim_cur);
+	}
+
+	rl.rlim_cur = rl.rlim_max;
+	SAFE_SETRLIMIT(RLIMIT_NOFILE, &rl);
+}
+
+static int select_timer(int fd, int dev_class, int dev_sclass, int device)
+{
+	struct snd_timer_select ts = {
+		.id.dev_class = dev_class,
+		.id.dev_sclass = dev_sclass,
+		.id.card = -1,
+		.id.device = device,
+	};
+
+	return ioctl(fd, SNDRV_TIMER_IOCTL_SELECT, &ts);
+}
+
+/*
+ * Open HRTIMER instances until SELECT returns EBUSY, which is
+ * num_instances >= max_instances in snd_timer_open(). The caller drops
+ * one so the sequencer open is the one that reaches the limit.
+ */
+static void fill_hrtimer(void)
+{
+	int raised = 0;
+	struct snd_timer_select ts = {
+		.id.dev_class = SNDRV_TIMER_CLASS_GLOBAL,
+		.id.dev_sclass = SNDRV_TIMER_SCLASS_NONE,
+		.id.card = -1,
+		.id.device = SNDRV_TIMER_GLOBAL_HRTIMER,
+	};
+
+	for (;;) {
+		int fd = open(TIMER_DEV, O_RDWR);
+
+		if (fd < 0) {
+			if (errno == EMFILE && !raised) {
+				raise_nofile();
+				raised = 1;
+				continue;
+			}
+			tst_brk(TBROK | TERRNO, "open(%s)", TIMER_DEV);
+		}
+
+		if (ioctl(fd, SNDRV_TIMER_IOCTL_SELECT, &ts) < 0) {
+			int err = errno;
+
+			SAFE_CLOSE(fd);
+			errno = err;
+			if (err == EBUSY)
+				break;
+			if (!fill_n)
+				tst_brk(TCONF | TERRNO, "HRTIMER global timer not available");
+			tst_brk(TBROK | TERRNO, "SNDRV_TIMER_IOCTL_SELECT");
+		}
+
+		fill_fds = SAFE_REALLOC(fill_fds, (fill_n + 1) * sizeof(*fill_fds));
+		fill_fds[fill_n++] = fd;
+	}
+
+	if (!fill_n)
+		tst_brk(TCONF, "HRTIMER global timer is already at max_instances");
+
+	tst_res(TINFO, "opened %u HRTIMER instances before EBUSY", fill_n);
+}
+
+static void release_hrtimer(void)
+{
+	unsigned int i;
+
+	for (i = 0; i < fill_n; i++)
+		SAFE_CLOSE(fill_fds[i]);
+	free(fill_fds);
+	fill_fds = NULL;
+	fill_n = 0;
+}
+
+static void set_queue_timer(int device)
+{
+	struct snd_seq_queue_timer qt = {
+		.queue = queue_id,
+		.type = SNDRV_SEQ_TIMER_ALSA,
+		.u.alsa.id.dev_class = SNDRV_TIMER_CLASS_GLOBAL,
+		.u.alsa.id.dev_sclass = SNDRV_TIMER_SCLASS_NONE,
+		.u.alsa.id.card = -1,
+		.u.alsa.id.device = device,
+	};
+
+	SAFE_IOCTL(seq_fd, SNDRV_SEQ_IOCTL_SET_QUEUE_TIMER, &qt);
+}
+
+static void setup(void)
+{
+	struct snd_seq_queue_info qinfo = {};
+
+	if (access(TIMER_DEV, F_OK) && errno == ENOENT)
+		tst_brk(TCONF, "%s not present", TIMER_DEV);
+	if (access(SEQ_DEV, F_OK) && errno == ENOENT)
+		tst_brk(TCONF, "%s not present", SEQ_DEV);
+
+	seq_fd = open_snd(SEQ_DEV);
+	SAFE_IOCTL(seq_fd, SNDRV_SEQ_IOCTL_CREATE_QUEUE, &qinfo);
+	queue_id = qinfo.queue;
+
+	/*
+	 * The default queue timer is often HRTIMER. Move it off that timer
+	 * before filling, or SET_QUEUE_TIMER closes the queue's own slot and
+	 * the following open is no longer the one that reaches the limit.
+	 *
+	 * snd_timer_user keeps a slave's dev_sclass. snd_seq_timer_open()
+	 * forces the master slave_class to SNDRV_TIMER_SCLASS_SEQUENCER and
+	 * passes the queue id as slave_id.
+	 */
+	set_queue_timer(SNDRV_TIMER_GLOBAL_SYSTEM);
+
+	slave_fd = open_snd(TIMER_DEV);
+	if (select_timer(slave_fd, SNDRV_TIMER_CLASS_SLAVE,
+			 SNDRV_TIMER_SCLASS_SEQUENCER, queue_id) < 0)
+		tst_brk(TBROK | TERRNO, "SNDRV_TIMER_IOCTL_SELECT slave");
+}
+
+static void start_queue(void)
+{
+	struct snd_seq_event ev = {
+		.type = SNDRV_SEQ_EVENT_START,
+		.flags = SNDRV_SEQ_EVENT_LENGTH_FIXED,
+		.queue = SNDRV_SEQ_QUEUE_DIRECT,
+		.dest.client = SNDRV_SEQ_CLIENT_SYSTEM,
+		.dest.port = SNDRV_SEQ_PORT_SYSTEM_TIMER,
+		.data.queue.queue = queue_id,
+	};
+
+	SAFE_WRITE(SAFE_WRITE_ALL, seq_fd, &ev, sizeof(ev));
+}
+
+static void check_queue_timer(void)
+{
+	char buf[256];
+	char expect[64];
+	FILE *fp;
+	int dev = -1;
+	int found = 0;
+	int running = 0;
+
+	snprintf(expect, sizeof(expect), "sequencer queue %d :", queue_id);
+	fp = SAFE_FOPEN(PROC_TIMERS, "r");
+
+	while (fgets(buf, sizeof(buf), fp)) {
+		int gdev;
+
+		if (sscanf(buf, "G%d:", &gdev) == 1) {
+			dev = gdev;
+			continue;
+		}
+
+		if (!strstr(buf, expect))
+			continue;
+
+		found = 1;
+		running = strstr(buf, "running") != NULL;
+		break;
+	}
+	SAFE_FCLOSE(fp);
+
+	if (!found) {
+		tst_brk(TBROK, "queue %d timer missing from %s",
+			queue_id, PROC_TIMERS);
+	}
+
+	if (dev != SNDRV_TIMER_GLOBAL_SYSTEM) {
+		tst_brk(TBROK,
+			"queue %d is on timer G%d, fallback to the system timer did not run",
+			queue_id, dev);
+	}
+
+	if (!running) {
+		tst_res(TFAIL, "queue %d timer did not start", queue_id);
+		return;
+	}
+
+	if (tst_taint_check())
+		tst_res(TFAIL, "kernel tainted after the queue timer started");
+	else
+		tst_res(TPASS, "queue %d timer is running", queue_id);
+}
+
+static void run(void)
+{
+	/*
+	 * Fill HRTIMER to its instance limit, drop one, then point the
+	 * queue at it. The open passes the max_instances check and
+	 * snd_timer_check_master() fails while adopting the matching
+	 * slave. That close sets IFLG_DEAD and the fallback open reuses
+	 * the instance on the system timer.
+	 */
+	fill_hrtimer();
+	SAFE_CLOSE(fill_fds[--fill_n]);
+	set_queue_timer(SNDRV_TIMER_GLOBAL_HRTIMER);
+	start_queue();
+	check_queue_timer();
+}
+
+static void cleanup(void)
+{
+	if (slave_fd >= 0)
+		SAFE_CLOSE(slave_fd);
+
+	release_hrtimer();
+
+	if (seq_fd >= 0)
+		SAFE_CLOSE(seq_fd);
+}
+
+static struct tst_test test = {
+	.setup = setup,
+	.cleanup = cleanup,
+	.test_all = run,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.tags = (const struct tst_tag[]) {
+		{"linux-git", "c2744d5f3aea474513fd2298daecb94a952ce441"},
+		{"CVE", "2026-74503"},
+		{}
+	},
+};
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
