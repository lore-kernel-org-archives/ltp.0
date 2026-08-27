Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2A2C61DC6
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 11:30:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BA0B3D69E8
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 13:30:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 425A83D5989
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:43 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2A93E600124
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 13:22:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CF11F1F84B
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829757; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OaEAjEW9roemzxvo0ffE5Z/kSAT43v30/x+3AH4Pe+Y=;
 b=xXW6dThi6oC3Kk0Yxnk3R0k/Ik869chFapU+lGiZiIgWUBPg2zZr+z7oECJZTH8OQfkT6+
 U9kUQpnDfSEOlw3qOVnFMhsx8mLdviD9jbMjVtHG9DlWRfW67YqOc3Bjy+eRkU90uBjdgv
 Z6bL8TKkPLRmHQjFl7B+vKH5M1vIEaU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829757;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OaEAjEW9roemzxvo0ffE5Z/kSAT43v30/x+3AH4Pe+Y=;
 b=0CR1n/yBhH5dq55OshnORZdHbgaP9ZgAhXnhXOHHY/7D5TWyZWUXN1iXVevUI+TVEQJ7il
 Aayqxbjqfb13v6DA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=njtrY4if;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=c32aTrHR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1787829752; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OaEAjEW9roemzxvo0ffE5Z/kSAT43v30/x+3AH4Pe+Y=;
 b=njtrY4ifCaJXl0E/3KE/ZpDJ+u0KMGflsejNQ2J+ybqYYGRQ1bhuTwOKRcwzy9DTS8b7RD
 eb584Jt8dM1dVULIq0IPl4ghFgZDy9CHwzKpAqnuDIHf1wRjki0ChYVDrpxlnYbllN0QTp
 Arv4hfJHBlH5vSqfgAqLz1k/b8kMPGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1787829752;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OaEAjEW9roemzxvo0ffE5Z/kSAT43v30/x+3AH4Pe+Y=;
 b=c32aTrHRPtR3Xxk1EnxXLmYyD6hZMSM1Sze0e5splmaKpKirpSIaJU5Fn+uJ6WbVKaZKy5
 Afi5u5oo0F0mEaCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4B1FD13687
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SDhUEvMdkGqfawAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 11:22:27 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 27 Aug 2026 13:21:50 +0200
Message-ID: <20260827112157.1748734-25-chrubis@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260827112157.1748734-1-chrubis@suse.cz>
References: <20260827112157.1748734-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: CF11F1F84B
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 24/31] testcases: sysfs: Add sys_block_loop01
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

A test for /sys/block/loop*/* files.

The test attaches loop device with different attributes and checks that
the sysfs files are correctly populated.

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 runtest/sysfs                                 |   1 +
 testcases/kernel/sysfs/block/.gitignore       |   1 +
 testcases/kernel/sysfs/block/Makefile         |   7 +
 .../kernel/sysfs/block/sys_block_loop01.c     | 320 ++++++++++++++++++
 4 files changed, 329 insertions(+)
 create mode 100644 testcases/kernel/sysfs/block/.gitignore
 create mode 100644 testcases/kernel/sysfs/block/Makefile
 create mode 100644 testcases/kernel/sysfs/block/sys_block_loop01.c

diff --git a/runtest/sysfs b/runtest/sysfs
index 290866349..26a229f03 100644
--- a/runtest/sysfs
+++ b/runtest/sysfs
@@ -19,3 +19,4 @@ sys_net01 sys_net01
 sys_net02 sys_net02
 sys_net03 sys_net03
 sys_net04 sys_net04
+sys_block_loop01 sys_block_loop01
diff --git a/testcases/kernel/sysfs/block/.gitignore b/testcases/kernel/sysfs/block/.gitignore
new file mode 100644
index 000000000..c64e99087
--- /dev/null
+++ b/testcases/kernel/sysfs/block/.gitignore
@@ -0,0 +1 @@
+/sys_block_loop01
diff --git a/testcases/kernel/sysfs/block/Makefile b/testcases/kernel/sysfs/block/Makefile
new file mode 100644
index 000000000..66e633f40
--- /dev/null
+++ b/testcases/kernel/sysfs/block/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+
+top_srcdir		?= ../../../..
+
+include $(top_srcdir)/include/mk/testcases.mk
+include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git a/testcases/kernel/sysfs/block/sys_block_loop01.c b/testcases/kernel/sysfs/block/sys_block_loop01.c
new file mode 100644
index 000000000..a99083a99
--- /dev/null
+++ b/testcases/kernel/sysfs/block/sys_block_loop01.c
@@ -0,0 +1,320 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (c) 2026 Cyril Hrubis <chrubis@suse.cz>
+ */
+
+/*\
+ * Verifies that the loop device sysfs attributes exported under
+ * /sys/block/loopN/loop/ correctly reflect the state of an attached backing
+ * file, and reset once the device is detached again.
+ *
+ * The test creates a plain file, attaches it to a free loop device and
+ * verifies that:
+ *
+ * - loop/backing_file matches the absolute path of the attached file
+ * - loop/offset and loop/sizelimit are 0 (defaults for a plain attach)
+ * - loop/autoclear, loop/partscan and loop/dio (when present) are booleans
+ *   and default to 0
+ * - the device's own size (in 512 byte sectors) matches the backing file
+ *   size
+ * - ro is 0 (attached read-write by default)
+ *
+ * After detaching the device it verifies that:
+ *
+ * - the device's size is back to 0
+ * - loop/backing_file no longer exists or reads back empty
+ *
+ * The device is then reconfigured via the LOOP_SET_STATUS64 ioctl (offset,
+ * sizelimit and the partscan flag) and it is verified that:
+ *
+ * - loop/offset and loop/sizelimit match the values that were set
+ * - loop/partscan reflects the requested flag
+ * - the device's size matches sizelimit/512, i.e. it is capped by sizelimit
+ *   rather than reflecting the whole backing file
+ *
+ * Note that LO_FLAGS_READ_ONLY is not exercised this way: on an already
+ * attached (read-write) device, LOOP_SET_STATUS64 does not actually flip the
+ * device to read-only, ro stays 0 regardless of the flag passed in. Read-only
+ * mode has to be requested at LOOP_SET_FD time instead, by opening the loop
+ * device (or the backing file) O_RDONLY before issuing the ioctl, which is
+ * exercised separately: the device is attached this way and it is verified
+ * that:
+ *
+ * - ro reads back as 1
+ * - the device genuinely rejects being opened or written to O_RDWR, not just
+ *   that the attribute says so
+ *
+ * ro turns out not to reset to 0 merely from detaching: it is a property of
+ * the whole gendisk, recalculated only on the next LOOP_SET_FD, so after
+ * detaching the device is reattached read-write and ro is checked to be 0
+ * then instead.
+ *
+ * Finally, autoclear is exercised for real rather than just checking that
+ * the attribute round-trips: the device is attached again, LO_FLAGS_AUTOCLEAR
+ * is set and the last open file descriptor on the device is closed without
+ * calling LOOP_CLR_FD explicitly. The kernel is expected to detach the
+ * device on its own (asynchronously, hence the test polls for it).
+ *
+ * This needs root to attach a loop device.
+ */
+
+#include <errno.h>
+#include <limits.h>
+#include <stdio.h>
+#include <string.h>
+#include <unistd.h>
+
+#include "tst_test.h"
+#include "tst_device.h"
+#include "tst_sysfs_assert.h"
+#include "lapi/loop.h"
+
+#define BACKING_FILE "sys_block_loop01.img"
+#define FILE_SIZE_MB 4
+#define RECONF_OFFSET 4096
+#define RECONF_SIZELIMIT (1024 * 1024)
+
+static char dev_path[64];
+static char loop_dir[64];
+static char abs_backing_file[PATH_MAX + sizeof(BACKING_FILE)];
+static int dev_num;
+static int attached;
+
+static void setup(void)
+{
+	char cwd[PATH_MAX];
+
+	dev_num = tst_find_free_loopdev(dev_path, sizeof(dev_path));
+	if (dev_num < 0)
+		tst_brk(TBROK, "Failed to find free loop device");
+
+	snprintf(loop_dir, sizeof(loop_dir), "/sys/block/loop%d", dev_num);
+
+	tst_prealloc_file(BACKING_FILE, 1024 * 1024, FILE_SIZE_MB);
+
+	SAFE_GETCWD(cwd, sizeof(cwd));
+	snprintf(abs_backing_file, sizeof(abs_backing_file), "%s/%s", cwd,
+		 BACKING_FILE);
+}
+
+static void check_backing_file(void)
+{
+	char actual[PATH_MAX] = "";
+
+	TST_SYSFS_READ_STR(actual, sizeof(actual), "%s/loop/backing_file",
+			   loop_dir);
+
+	TST_EXP_EQ_STR(actual, abs_backing_file);
+}
+
+static void check_attached(void)
+{
+	check_backing_file();
+
+	TST_SYSFS_EXP_EQ_LI(0, "%s/loop/offset", loop_dir);
+	TST_SYSFS_EXP_EQ_LI(0, "%s/loop/sizelimit", loop_dir);
+
+	TST_SYSFS_ASSERT_BOOL("%s/loop/autoclear", loop_dir);
+	TST_SYSFS_EXP_EQ_LI(0, "%s/loop/autoclear", loop_dir);
+
+	TST_SYSFS_ASSERT_BOOL("%s/loop/partscan", loop_dir);
+	TST_SYSFS_EXP_EQ_LI(0, "%s/loop/partscan", loop_dir);
+
+	if (tst_sysfs_exists("%s/loop/dio", loop_dir)) {
+		TST_SYSFS_ASSERT_BOOL("%s/loop/dio", loop_dir);
+		TST_SYSFS_EXP_EQ_LI(0, "%s/loop/dio", loop_dir);
+	} else {
+		tst_res(TCONF, "%s/loop/dio does not exist", loop_dir);
+	}
+
+	TST_SYSFS_ASSERT_BOOL("/sys/block/loop%d/ro", dev_num);
+	TST_SYSFS_EXP_EQ_LI(0, "/sys/block/loop%d/ro", dev_num);
+
+	TST_SYSFS_EXP_EQ_LI((long)FILE_SIZE_MB * 1024 * 1024 / 512,
+			 "/sys/block/loop%d/size", dev_num);
+}
+
+static void check_detached(void)
+{
+	TST_SYSFS_EXP_EQ_LI(0, "/sys/block/loop%d/size", dev_num);
+
+	if (!tst_sysfs_exists("%s/loop/backing_file", loop_dir)) {
+		tst_res(TPASS, "backing_file no longer exists after detach");
+		return;
+	}
+
+	char actual[PATH_MAX] = "";
+
+	TST_SYSFS_READ_STR(actual, sizeof(actual), "%s/loop/backing_file",
+			   loop_dir);
+
+	if (actual[0] == '\0')
+		tst_res(TPASS, "backing_file is empty after detach");
+	else
+		tst_res(TFAIL, "backing_file = '%s' after detach, expected empty",
+			actual);
+}
+
+static void check_reconfigured(void)
+{
+	struct loop_info64 info = { 0 };
+	int fd;
+
+	fd = SAFE_OPEN(dev_path, O_RDWR);
+
+	info.lo_offset = RECONF_OFFSET;
+	info.lo_sizelimit = RECONF_SIZELIMIT;
+	info.lo_flags = LO_FLAGS_PARTSCAN;
+
+	SAFE_IOCTL(fd, LOOP_SET_STATUS64, &info);
+	SAFE_CLOSE(fd);
+
+	tst_res(TINFO,
+		"Reconfigured via LOOP_SET_STATUS64: offset=%d sizelimit=%d partscan",
+		RECONF_OFFSET, RECONF_SIZELIMIT);
+
+	TST_SYSFS_EXP_EQ_LI(RECONF_OFFSET, "%s/loop/offset", loop_dir);
+	TST_SYSFS_EXP_EQ_LI(RECONF_SIZELIMIT, "%s/loop/sizelimit", loop_dir);
+	TST_SYSFS_EXP_EQ_LI(1, "%s/loop/partscan", loop_dir);
+	TST_SYSFS_EXP_EQ_LI(RECONF_SIZELIMIT / 512, "/sys/block/loop%d/size",
+			 dev_num);
+}
+
+static void check_readonly_attach(void)
+{
+	int dev_fd, file_fd;
+
+	tst_res(TINFO,
+		"Checking a read-only attach (LOOP_SET_FD with an O_RDONLY device fd)");
+
+	dev_fd = SAFE_OPEN(dev_path, O_RDWR);
+	file_fd = SAFE_OPEN(BACKING_FILE, O_RDONLY);
+
+	SAFE_IOCTL(dev_fd, LOOP_SET_FD, file_fd);
+	SAFE_CLOSE(file_fd);
+	SAFE_CLOSE(dev_fd);
+	attached = 1;
+
+	TST_SYSFS_EXP_EQ_LI(1, "/sys/block/loop%d/ro", dev_num);
+
+	dev_fd = open(dev_path, O_RDWR);
+
+	if (dev_fd < 0) {
+		tst_res(TPASS,
+			"open(%s, O_RDWR) failed as expected on a read-only device: %s",
+			dev_path, tst_strerrno(errno));
+	} else {
+		char buf[512] = { 0 };
+		ssize_t written = write(dev_fd, buf, sizeof(buf));
+
+		if (written < 0) {
+			tst_res(TPASS,
+				"write() to a read-only loop device failed as expected: %s",
+				tst_strerrno(errno));
+		} else {
+			tst_res(TFAIL,
+				"write() to a read-only loop device unexpectedly succeeded (%zd bytes)",
+				written);
+		}
+
+		SAFE_CLOSE(dev_fd);
+	}
+
+	if (tst_detach_device(dev_path))
+		tst_brk(TBROK, "Failed to detach %s", dev_path);
+	attached = 0;
+
+	/*
+	 * ro does not reset to 0 merely from detaching, it is a property of
+	 * the whole gendisk that is only recalculated on the next LOOP_SET_FD,
+	 * so the device is reattached read-write here to verify that.
+	 */
+	if (tst_attach_device(dev_path, BACKING_FILE))
+		tst_brk(TBROK, "Failed to attach %s to %s", BACKING_FILE,
+			dev_path);
+	attached = 1;
+
+	TST_SYSFS_EXP_EQ_LI(0, "/sys/block/loop%d/ro", dev_num);
+
+	if (tst_detach_device(dev_path))
+		tst_brk(TBROK, "Failed to detach %s", dev_path);
+	attached = 0;
+}
+
+/* Reads back /sys/block/loopN/size, used to poll for autoclear below. */
+static long read_loop_size(void)
+{
+	return TST_SYSFS_READ_LI("/sys/block/loop%d/size", dev_num);
+}
+
+static void check_autoclear_behavior(void)
+{
+	struct loop_info64 info = { 0 };
+	long size;
+	int fd;
+
+	tst_res(TINFO,
+		"Checking that autoclear detaches the device on last close");
+
+	if (tst_attach_device(dev_path, BACKING_FILE)) {
+		tst_res(TFAIL, "Failed to attach %s to %s for autoclear check",
+			BACKING_FILE, dev_path);
+		return;
+	}
+	attached = 1;
+
+	fd = SAFE_OPEN(dev_path, O_RDWR);
+	info.lo_flags = LO_FLAGS_AUTOCLEAR;
+	SAFE_IOCTL(fd, LOOP_SET_STATUS64, &info);
+	SAFE_CLOSE(fd);
+
+	/* autoclear runs asynchronously off a kernel workqueue, poll for it */
+	size = TST_RETRY_FN_EXP_BACKOFF(read_loop_size(), TST_RETVAL_EQ0, 5);
+
+	if (size == 0) {
+		tst_res(TPASS, "Device auto-detached");
+		attached = 0;
+	} else {
+		tst_res(TFAIL, "Device did not auto-detach in time");
+		tst_detach_device(dev_path);
+		attached = 0;
+	}
+}
+
+static void run(void)
+{
+	if (tst_attach_device(dev_path, BACKING_FILE))
+		tst_brk(TBROK, "Failed to attach %s to %s", BACKING_FILE,
+			dev_path);
+	attached = 1;
+
+	check_attached();
+	check_reconfigured();
+
+	if (tst_detach_device(dev_path))
+		tst_brk(TBROK, "Failed to detach %s", dev_path);
+	attached = 0;
+
+	check_detached();
+
+	check_readonly_attach();
+	check_autoclear_behavior();
+}
+
+static void cleanup(void)
+{
+	if (attached)
+		tst_detach_device(dev_path);
+}
+
+static struct tst_test test = {
+	.test_all = run,
+	.setup = setup,
+	.cleanup = cleanup,
+	.needs_root = 1,
+	.needs_tmpdir = 1,
+	.needs_kconfigs = (const char *const[]){
+		"CONFIG_BLK_DEV_LOOP",
+		NULL
+	},
+};
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
