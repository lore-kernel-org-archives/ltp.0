Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1396C5AC7A
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 15:48:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70F993D0875
	for <ltp@archiver.kernel.org>; Fri, 20 Feb 2026 16:48:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A3A23D0861
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 16:47:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6CE36600683
 for <ltp@lists.linux.it>; Fri, 20 Feb 2026 16:47:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 46C165BD54;
 Fri, 20 Feb 2026 15:47:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771602468; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=74TiH35V7DLzzeXipXeyEUGT4RF1jLTLWOOH6ZcXIjc=;
 b=iXb9CEKfxLXqxXEF9+gD+7fhjZAGE1F+2N2G0ByzfPhaIJnQhBqLdPMqNpwtqOSHoa+Xn/
 NxXhDjQsV5ETMcHy1R2zo4K8ug6aM7mqGpCd04mC7zST2GSkMbjlj1ZaeTMPxsvMsNEItu
 jS3hmu51/3elrX1qALECEDGIeMzNe5k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771602468;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=74TiH35V7DLzzeXipXeyEUGT4RF1jLTLWOOH6ZcXIjc=;
 b=GTsJdShhQgYN8bhI/+R0sLzWsS+kgaKEDVk/3udY38wJ+f0FklYzo46bUNb73ma+EzZfP7
 FySyxh2Qfz+KzsCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ClCTykWh;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rMTUczEH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771602467; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=74TiH35V7DLzzeXipXeyEUGT4RF1jLTLWOOH6ZcXIjc=;
 b=ClCTykWhyfoQqZSb1nKqhziXFfAzrBeE6m1s5yOdwEm34mD6DADW8DvCm2tuOGzCZfnVCT
 +B28ei62pmhJ4HVWQneq+3E47+qcA/cY7u0xL9jayNYP5HNRVijrQ5+GQBPThOvDt3vRY9
 2nLZ8pksDFVkD4xQ/9w9lz94Ux70MKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771602467;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=74TiH35V7DLzzeXipXeyEUGT4RF1jLTLWOOH6ZcXIjc=;
 b=rMTUczEHdhdLtpTO6nN29Qo3C1f/shHTy9+yjqdm2n7hC7dQhKo/M7hEen8/uKneQTziaY
 Sp5oDzI67/QmUDAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 22A473EA67;
 Fri, 20 Feb 2026 15:47:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YN5PCCOCmGkmdwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Fri, 20 Feb 2026 15:47:47 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ppavlu@suse.cz,
	ltp@lists.linux.it
Date: Fri, 20 Feb 2026 16:47:09 +0100
Message-ID: <20260220154742.54150-3-mdoucha@suse.cz>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260220154742.54150-1-mdoucha@suse.cz>
References: <20260220154742.54150-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 46C165BD54
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/2] Add test for fanotify monitoring of tracing
 filesystem
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Add a test that will start monitoring the kernel tracing filesystem,
write new configuration into tracing sysfiles and then verify
that the writes triggered fanotify events.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 runtest/syscalls                              |   1 +
 runtest/tracing                               |   1 +
 testcases/kernel/syscalls/fanotify/.gitignore |   1 +
 .../kernel/syscalls/fanotify/fanotify25.c     | 126 ++++++++++++++++++
 4 files changed, 129 insertions(+)
 create mode 100644 testcases/kernel/syscalls/fanotify/fanotify25.c

diff --git a/runtest/syscalls b/runtest/syscalls
index 2f629e4e4..30224f5b4 100644
--- a/runtest/syscalls
+++ b/runtest/syscalls
@@ -671,6 +671,7 @@ fanotify21 fanotify21
 fanotify22 fanotify22
 fanotify23 fanotify23
 fanotify24 fanotify24
+fanotify25 fanotify25
 
 ioperm01 ioperm01
 ioperm02 ioperm02
diff --git a/runtest/tracing b/runtest/tracing
index d2700ca57..674e2ad97 100644
--- a/runtest/tracing
+++ b/runtest/tracing
@@ -3,6 +3,7 @@ ftrace_regression01	ftrace_regression01.sh
 ftrace_regression02	ftrace_regression02.sh
 ftrace-stress-test	ftrace_stress_test.sh 90
 dynamic_debug01		dynamic_debug01.sh
+fanotify25 fanotify25
 pt_full_trace_basic pt_test
 pt_snapshot_trace_basic pt_test -m
 pt_ex_user pt_test -e user
diff --git a/testcases/kernel/syscalls/fanotify/.gitignore b/testcases/kernel/syscalls/fanotify/.gitignore
index 16af3db85..d6d0599f1 100644
--- a/testcases/kernel/syscalls/fanotify/.gitignore
+++ b/testcases/kernel/syscalls/fanotify/.gitignore
@@ -22,4 +22,5 @@
 /fanotify22
 /fanotify23
 /fanotify24
+/fanotify25
 /fanotify_child
diff --git a/testcases/kernel/syscalls/fanotify/fanotify25.c b/testcases/kernel/syscalls/fanotify/fanotify25.c
new file mode 100644
index 000000000..c982f3225
--- /dev/null
+++ b/testcases/kernel/syscalls/fanotify/fanotify25.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2026 SUSE LLC
+ * Author: Petr Pavlu <ppavlu@suse.cz>
+ * LTP port: Martin Doucha <mdoucha@suse.cz>
+ */
+
+/*\
+ * Verify that fanotify monitoring can be applied to the tracing filesystem
+ * and write events will be correctly delivered.
+ */
+
+#define _GNU_SOURCE
+#include "tst_test.h"
+#include "lapi/mount.h"
+
+#ifdef HAVE_SYS_FANOTIFY_H
+#include "fanotify.h"
+
+#define MNTPOINT "/sys/kernel/tracing"
+#define EVENTS_SYSFILE MNTPOINT "/kprobe_events"
+
+static const struct traceconfig {
+	const char *filename;
+	const char *wdata;
+} trace_cmds[] = {
+	{EVENTS_SYSFILE, "p:ltp_load_module_0 load_module"},
+	{MNTPOINT "/events/kprobes/ltp_load_module_0/enable", "1"},
+	{MNTPOINT "/events/kprobes/ltp_load_module_0/enable", "0"},
+	{EVENTS_SYSFILE, "-:ltp_load_module_0"},
+	{}
+};
+
+static int fan_fd = -1;
+static int unmount_needed;
+
+static void setup(void)
+{
+	if (tst_fs_type(MNTPOINT) != TST_TRACEFS_MAGIC) {
+		SAFE_MOUNT("tracefs", MNTPOINT, "tracefs",
+			MS_NODEV | MS_NOEXEC | MS_NOSUID, NULL);
+		unmount_needed = 1;
+	}
+
+	if (access(EVENTS_SYSFILE, F_OK))
+		tst_brk(TCONF, "Kprobe events not supported by kernel");
+
+	fan_fd = SAFE_FANOTIFY_INIT(FAN_CLASS_NOTIF | FAN_NONBLOCK, O_RDONLY);
+	SAFE_FANOTIFY_MARK(fan_fd, FAN_MARK_ADD | FAN_MARK_MOUNT, FAN_MODIFY,
+		-1, MNTPOINT);
+}
+
+static void do_child(void)
+{
+	int i, fd, events, ret;
+	pid_t pid = getpid();
+	struct fanotify_event_metadata buf;
+
+	for (i = 0, events = 0; trace_cmds[i].filename; i++) {
+		fd = SAFE_OPEN(trace_cmds[i].filename, O_WRONLY, 0644);
+		SAFE_WRITE(1, fd, trace_cmds[i].wdata,
+			strlen(trace_cmds[i].wdata));
+		SAFE_CLOSE(fd);
+
+		while ((ret = read(fan_fd, &buf, sizeof(buf))) > 0) {
+			if (buf.pid != pid)
+				continue;
+
+			if (!(buf.mask & FAN_MODIFY)) {
+				tst_res(TFAIL, "Unexpected event %llx",
+					buf.mask);
+				continue;
+			}
+
+			events++;
+		}
+
+		if (ret < 0 && errno != EAGAIN)
+			tst_res(TFAIL | TERRNO, "fanotify read() failed");
+	}
+
+	if (events == i)
+		tst_res(TPASS, "Received %d events", events);
+	else
+		tst_res(TFAIL, "Received %d events, expected %d", events, i);
+}
+
+static void run(void)
+{
+	/*
+	 * Fork a child to do the actual trace writes, otherwise tracefs
+	 * would be busy until the current process exits and it would become
+	 * impossible to unmount in cleanup().
+	 */
+	if (!SAFE_FORK()) {
+		do_child();
+		SAFE_CLOSE(fan_fd);
+		exit(0);
+	}
+}
+
+static void cleanup(void)
+{
+	if (fan_fd >= 0)
+		SAFE_CLOSE(fan_fd);
+
+	if (unmount_needed)
+		SAFE_UMOUNT(MNTPOINT);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.forks_child = 1,
+	.taint_check = TST_TAINT_W | TST_TAINT_D,
+	.needs_kconfigs = (const char *[]) {
+		"CONFIG_TRACING",
+		NULL
+	}
+};
+
+#else
+	TST_TEST_TCONF("system doesn't have required fanotify support");
+#endif
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
