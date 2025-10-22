Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C896CCD1BB
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 09:58:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7582D3CF0C9
	for <ltp@archiver.kernel.org>; Wed, 22 Oct 2025 11:58:22 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 237C43C0296
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 11:58:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8197760073A
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 11:58:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B7F0A211FA
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 09:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761127081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vTrrp1ioUqz5V+8bDwBi/FeOlVq9FA2ppMFxQbIi734=;
 b=VA0GtAnNmk+Sewjp6FhZsp3AJuwUoGVhw/SSkutx+idid48e2Eu1hTxESlJ7upwrHeURm6
 2jYV30fPfInvHwq6dYQFrZD4z7YhJOJLzv5m1SnlvhUErxLadhK0QOx/Lc+Edr+GUmvpQ6
 QC5O28fp1hA8eXIsFPRmtCJrFfqwXu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761127081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vTrrp1ioUqz5V+8bDwBi/FeOlVq9FA2ppMFxQbIi734=;
 b=lZhh12XOaUSvPTwjdeT1HRAPyUTybdKurm4enQIrcXJ8XG4+NolqWrVFYOdk/pJXjp/40T
 J13mIzPCZll+UWDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vq5IVWSX;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=9q1kWuPb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761127077; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vTrrp1ioUqz5V+8bDwBi/FeOlVq9FA2ppMFxQbIi734=;
 b=vq5IVWSXvPMfyPe6vn4LFP3MM+zySRD6iIGTQqnlIRE8dpg4BIJhpk1BrrvQdc6cXJ1PO6
 bDKuQJukqbCOIjQEMFxT721gGN7VfsA4aRZb9aqhMTzhTw/6mdm9QftODsQBR/ngiPgh9a
 KoffZ1s5zK4CyBHeKR0doPAivESyLD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761127077;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vTrrp1ioUqz5V+8bDwBi/FeOlVq9FA2ppMFxQbIi734=;
 b=9q1kWuPbbln1ARKwlBtciqqyZgo8hnGZt8VOSaV3IKBLIQd6g0PxNTde+OwReUE0KGg06R
 QocOGC/wETMHjPBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB30513A29
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 09:57:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D/6XKaWq+GjDIgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 22 Oct 2025 09:57:57 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 22 Oct 2025 11:57:37 +0200
Message-ID: <20251022095740.8747-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Rspamd-Queue-Id: B7F0A211FA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:mid,suse.cz:dkim];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
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
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] ioctl_sg01: Skip USB devices
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

Some USB devices write hardware info and flags to the ioctl(SG_IO)
response buffer which results in test failure. But the info is constant
and doesn't represent any security risk. Skip USB devices to prevent
false positives.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

I've tested this patch on kernels v4.4 through v6.16. Non-USB generic SCSI
block devices get correctly found and used, USB block device get skipped.

 testcases/kernel/syscalls/ioctl/ioctl_sg01.c | 55 +++++++++++++++-----
 1 file changed, 42 insertions(+), 13 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
index fba3816c3..66ff980ce 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_sg01.c
@@ -29,6 +29,9 @@
 #include "tst_test.h"
 #include "tst_memutils.h"
 
+#define SYSDIR "/sys/block"
+#define BLOCKDIR "/sys/block/%s/device"
+
 #define BUF_SIZE (128 * 4096)
 #define CMD_SIZE 6
 
@@ -38,42 +41,68 @@ static unsigned char command[CMD_SIZE];
 static struct sg_io_hdr query;
 
 /* TODO: split this off to a separate SCSI library? */
-static const char *find_generic_scsi_device(int access_flags)
+static const char *find_generic_scsi_device(int access_flags, int skip_usb)
 {
-	DIR *devdir;
+	DIR *sysdir;
 	struct dirent *ent;
 	int tmpfd;
-	static char devpath[PATH_MAX];
+	ssize_t length;
+	char *filename;
+	static char devpath[PATH_MAX], syspath[PATH_MAX];
 
-	errno = 0;
-	devdir = opendir("/dev");
+	sysdir = opendir(SYSDIR);
 
-	if (!devdir)
+	if (!sysdir)
 		return NULL;
 
-	while ((ent = SAFE_READDIR(devdir))) {
-		/* The bug is most likely reproducible only on /dev/sg* */
-		if (strncmp(ent->d_name, "sg", 2) || !isdigit(ent->d_name[2]))
+	/* Scan block devices */
+	while ((ent = SAFE_READDIR(sysdir))) {
+		if (ent->d_name[0] == '.')
+			continue;
+
+		snprintf(syspath, PATH_MAX, BLOCKDIR, ent->d_name);
+		syspath[PATH_MAX - 1] = '\0';
+
+		/* Real device path matches the physical HW bus path */
+		if (!realpath(syspath, devpath))
+			continue;
+
+		strncat(devpath, "/generic", PATH_MAX - strlen(devpath) - 1);
+		devpath[PATH_MAX - 1] = '\0';
+		length = readlink(devpath, syspath, PATH_MAX - 1);
+
+		if (length < 0)
+			continue;
+
+		syspath[length] = '\0';
+		filename = basename(syspath);
+
+		/* USB devices often return HW info in SG_IO response buffer */
+		if (skip_usb && strstr(devpath, "/usb")) {
+			tst_res(TINFO, "Skipping USB device %s", filename);
 			continue;
+		}
 
-		snprintf(devpath, PATH_MAX, "/dev/%s", ent->d_name);
+		snprintf(devpath, PATH_MAX, "/dev/%s", filename);
 		/* access() makes incorrect assumptions about block devices */
 		tmpfd = open(devpath, access_flags);
 
 		if (tmpfd >= 0) {
 			SAFE_CLOSE(tmpfd);
-			SAFE_CLOSEDIR(devdir);
+			SAFE_CLOSEDIR(sysdir);
 			return devpath;
 		}
+
+		tst_res(TINFO | TERRNO, "Cannot open device %s", devpath);
 	}
 
-	SAFE_CLOSEDIR(devdir);
+	SAFE_CLOSEDIR(sysdir);
 	return NULL;
 }
 
 static void setup(void)
 {
-	const char *devpath = find_generic_scsi_device(O_RDONLY);
+	const char *devpath = find_generic_scsi_device(O_RDONLY, 1);
 
 	if (!devpath)
 		tst_brk(TCONF, "Could not find any usable SCSI device");
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
