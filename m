Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FABD44166
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 10:40:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75DFB3C83E0
	for <ltp@archiver.kernel.org>; Fri, 12 Dec 2025 11:40:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 590EA3C6344
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 11:40:31 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EA05F200C21
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 11:40:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7A380336B4
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 10:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765536028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=55MzoXG7VZ4TSRUOtpuiy43l6x+ICxKZEigmQZr8egE=;
 b=Pr+8WZxH+TT21CWLVlS4Pac8AJjT2f+OWDkzjQ1lT4PM9CznomXjJKkhigonZib8zc2Emq
 2TJyGz7EL8886XVp+gZJfFFtqksLW7Rz4iwERB7RCnfF5QvINFOsRjN9VooueHWzyYVSUm
 kJ1pxef2xoJFZyWa3/Nqqt8m38EaraU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765536028;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=55MzoXG7VZ4TSRUOtpuiy43l6x+ICxKZEigmQZr8egE=;
 b=9jY9cFJd1L76KavA8N7xTl5IFaKPg32dMbEEnMWBBCKataRN0CeDnTgYef2JgkhEiGfckf
 4VdLwpcgwGxhnJBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1765536028; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=55MzoXG7VZ4TSRUOtpuiy43l6x+ICxKZEigmQZr8egE=;
 b=Pr+8WZxH+TT21CWLVlS4Pac8AJjT2f+OWDkzjQ1lT4PM9CznomXjJKkhigonZib8zc2Emq
 2TJyGz7EL8886XVp+gZJfFFtqksLW7Rz4iwERB7RCnfF5QvINFOsRjN9VooueHWzyYVSUm
 kJ1pxef2xoJFZyWa3/Nqqt8m38EaraU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1765536028;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=55MzoXG7VZ4TSRUOtpuiy43l6x+ICxKZEigmQZr8egE=;
 b=9jY9cFJd1L76KavA8N7xTl5IFaKPg32dMbEEnMWBBCKataRN0CeDnTgYef2JgkhEiGfckf
 4VdLwpcgwGxhnJBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 654E43EA63
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 10:40:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SbOEGBzxO2ncbwAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 12 Dec 2025 10:40:28 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 12 Dec 2025 11:40:23 +0100
Message-ID: <20251212104025.15924-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.68 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_SHORT(-0.08)[-0.411]; RCPT_COUNT_ONE(0.00)[1];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_detach_device: Clear leftover partitions
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

Some kernels have a race condition during loop device release
which results in partitions being left over on unattached device.
The partitions then cause mkfs.vfat failures in later tests.

Check for loop device partitions after detaching it and clear them
if necessary.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 lib/tst_device.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 78 insertions(+), 1 deletion(-)

diff --git a/lib/tst_device.c b/lib/tst_device.c
index 6ae914720..85f5f8cac 100644
--- a/lib/tst_device.c
+++ b/lib/tst_device.c
@@ -239,7 +239,7 @@ uint64_t tst_get_device_size(const char *dev_path)
 	return size/1024/1024;
 }
 
-int tst_detach_device_by_fd(const char *dev, int *dev_fd)
+static int detach_loop_fd(const char *dev, int *dev_fd)
 {
 	int ret, i, retval = 1;
 
@@ -275,6 +275,83 @@ exit:
 	return retval;
 }
 
+static int find_loop_device_partition(const char *dev, char *part_path,
+	unsigned int path_size)
+{
+	int dev_num = -1;
+	unsigned int i;
+
+	snprintf(part_path, path_size, "%sp1", dev);
+
+	if (!access(part_path, F_OK))
+		return 1;
+
+	/* Parse loop device number */
+	for (i = 0; i < ARRAY_SIZE(dev_loop_variants); i++) {
+		if (sscanf(dev, dev_loop_variants[i], &dev_num) == 1)
+			break;
+
+		dev_num = -1;
+	}
+
+	if (dev_num < 0) {
+		tst_resm(TWARN, "Cannot parse %s device number", dev);
+		return 0;
+	}
+
+	snprintf(part_path, path_size, "/sys/block/loop%d/loop%dp1", dev_num,
+		dev_num);
+
+	if (!access(part_path, F_OK))
+		return 1;
+
+	/* The loop device has no leftover partitions */
+	return 0;
+}
+
+static int clear_loop_device_partitions(const char *dev)
+{
+	char part_path[PATH_MAX];
+	struct loop_info loopinfo = {};
+	int dev_fd;
+
+	if (!find_loop_device_partition(dev, part_path, PATH_MAX))
+		return 0;
+
+	tst_resm(TWARN, "Detached device %s has leftover partitions", dev);
+	tst_fill_file(DEV_FILE, 0, 1024 * 1024, 1);
+	tst_attach_device(dev, DEV_FILE);
+	dev_fd = open(dev, O_RDWR);
+
+	if (dev_fd < 0) {
+		tst_resm(TWARN | TERRNO,
+			"Cannot clear leftover partitions on %s", dev);
+		/* Do not detach device to prevent infinite recursion */
+		return 1;
+	}
+
+	loopinfo.lo_flags = LO_FLAGS_PARTSCAN;
+	ioctl(dev_fd, LOOP_SET_STATUS, &loopinfo);
+
+	if (!access(part_path, F_OK)) {
+		tst_resm(TWARN, "Cannot clear leftover partitions on %s", dev);
+		detach_loop_fd(dev, &dev_fd);
+		return 1;
+	}
+
+	return detach_loop_fd(dev, &dev_fd);
+}
+
+int tst_detach_device_by_fd(const char *dev, int *dev_fd)
+{
+	int ret = detach_loop_fd(dev, dev_fd);
+
+	if (!ret)
+		ret = clear_loop_device_partitions(dev);
+
+	return ret;
+}
+
 int tst_detach_device(const char *dev)
 {
 	int dev_fd, ret;
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
