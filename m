Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4CB5D3EE97
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 17:13:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 262D03CB9FE
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 18:13:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C70A33CB041
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 18:12:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4D4291000658
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 18:12:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8C3BD3368B
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 17:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769101970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6YXZb590lemvgTElR1Y0zIC5IidUa5mMehhJl8HXoLA=;
 b=HjtxpCNj5S5KOF13JO7ZD6CW2CTzVetHOmvQnqMn86v7t/+nBLkcHN0tZd1fNmtYLrW+3a
 BClNzwyQmN02/1w3UrF8jfNifwWJa0fSPYIdYbjd8qLlM1vjloGP8H2Nrtjcp3shTUG3hr
 2iLFc3TXD2RPaCLgB7IX9UzKiCpeAFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769101970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6YXZb590lemvgTElR1Y0zIC5IidUa5mMehhJl8HXoLA=;
 b=jSasbU7AHon212REojFsG9hZ2AB6IUMwCieqDApJLJq4Qi5ut9b1VkcU1zcPQrtoXPHHsT
 XdDzleVX7MpYxNDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=HjtxpCNj;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jSasbU7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1769101970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6YXZb590lemvgTElR1Y0zIC5IidUa5mMehhJl8HXoLA=;
 b=HjtxpCNj5S5KOF13JO7ZD6CW2CTzVetHOmvQnqMn86v7t/+nBLkcHN0tZd1fNmtYLrW+3a
 BClNzwyQmN02/1w3UrF8jfNifwWJa0fSPYIdYbjd8qLlM1vjloGP8H2Nrtjcp3shTUG3hr
 2iLFc3TXD2RPaCLgB7IX9UzKiCpeAFQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1769101970;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=6YXZb590lemvgTElR1Y0zIC5IidUa5mMehhJl8HXoLA=;
 b=jSasbU7AHon212REojFsG9hZ2AB6IUMwCieqDApJLJq4Qi5ut9b1VkcU1zcPQrtoXPHHsT
 XdDzleVX7MpYxNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 75C4B1395E
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 17:12:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8DyLHJJacmnWRgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 17:12:50 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 22 Jan 2026 18:12:32 +0100
Message-ID: <20260122171249.31590-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, suse.cz:mid, suse.cz:dkim, suse.cz:email]
X-Rspamd-Queue-Id: 8C3BD3368B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] ioctl_sg01: Allow using USB device again
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

The failures when the ioctl_sg01 test tried to query a USB device
turned out to be another data leak. Allow using USB devices again
but keep the improved device lookup algorithm.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Tested on kernels v4.4 and v6.12.

 testcases/kernel/syscalls/ioctl/ioctl_sg01.c | 29 ++++++--------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
index dada174e0..9862d7324 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
@@ -30,7 +30,7 @@
 #include "tst_memutils.h"
 
 #define SYSDIR "/sys/block"
-#define BLOCKDIR "/sys/block/%s/device"
+#define BLOCKDIR "/sys/block/%s/device/generic"
 
 #define BUF_SIZE (128 * 4096)
 #define CMD_SIZE 6
@@ -41,14 +41,14 @@ static unsigned char command[CMD_SIZE];
 static struct sg_io_hdr query;
 
 /* TODO: split this off to a separate SCSI library? */
-static const char *find_generic_scsi_device(int access_flags, int skip_usb)
+static const char *find_generic_scsi_device(int access_flags)
 {
 	DIR *sysdir;
 	struct dirent *ent;
 	int tmpfd;
 	ssize_t length;
 	char *filename;
-	static char devpath[PATH_MAX], syspath[PATH_MAX];
+	static char devpath[PATH_MAX], genpath[PATH_MAX];
 
 	sysdir = opendir(SYSDIR);
 
@@ -60,28 +60,15 @@ static const char *find_generic_scsi_device(int access_flags, int skip_usb)
 		if (ent->d_name[0] == '.')
 			continue;
 
-		snprintf(syspath, PATH_MAX, BLOCKDIR, ent->d_name);
-		syspath[PATH_MAX - 1] = '\0';
-
-		/* Real device path matches the physical HW bus path */
-		if (!realpath(syspath, devpath))
-			continue;
-
-		strncat(devpath, "/generic", PATH_MAX - strlen(devpath) - 1);
+		snprintf(devpath, PATH_MAX, BLOCKDIR, ent->d_name);
 		devpath[PATH_MAX - 1] = '\0';
-		length = readlink(devpath, syspath, PATH_MAX - 1);
+		length = readlink(devpath, genpath, PATH_MAX - 1);
 
 		if (length < 0)
 			continue;
 
-		syspath[length] = '\0';
-		filename = basename(syspath);
-
-		/* USB devices often return HW info in SG_IO response buffer */
-		if (skip_usb && strstr(devpath, "/usb")) {
-			tst_res(TINFO, "Skipping USB device %s", filename);
-			continue;
-		}
+		genpath[length] = '\0';
+		filename = basename(genpath);
 
 		snprintf(devpath, PATH_MAX, "/dev/%s", filename);
 		/* access() makes incorrect assumptions about block devices */
@@ -121,7 +108,7 @@ static void dump_hex(const char *str, size_t size)
 
 static void setup(void)
 {
-	const char *devpath = find_generic_scsi_device(O_RDONLY, 1);
+	const char *devpath = find_generic_scsi_device(O_RDONLY);
 
 	if (!devpath)
 		tst_brk(TCONF, "Could not find any usable SCSI device");
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
