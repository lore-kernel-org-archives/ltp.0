Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F4AC5B572
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 15:23:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54CFE3E7226
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 17:23:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7A5CD3DB039
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 17:23:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E776260065E
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 17:23:10 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 67A94823B8
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786548185; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NBH6ZRu+MTN9aZtpw2V4lKd8fEkpIZRf2ue4fLglINE=;
 b=F+5AHApMLVlSDxBCPApAHdJKlRyT3O25K5sLvTfKBAz8+55SDpazgTdjwi2ChDXSHeI2Ke
 b0njJZkd4FoZc5LGD62Q5Rp0tvYeEKw5atwUl206j4NtO2iorzghB9/5nELudcZ3kBTRoM
 0eEfdaKQ7j8GpD/M7DH9Ad8brpEdfmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786548185;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NBH6ZRu+MTN9aZtpw2V4lKd8fEkpIZRf2ue4fLglINE=;
 b=GJFPVcYOZjVoXHyE0p7c0R+kKRJGE4+9QFdjqBcak+06tqf35B82bu5891rE8t2IT1HOyD
 Q+2b9MpLPQVBMGBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786548181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NBH6ZRu+MTN9aZtpw2V4lKd8fEkpIZRf2ue4fLglINE=;
 b=bVN9EIix9Vks3M68tpQMMpbfuv2g/IBDUzl6t7HSW+0llezVW0H5xNbot76EztMYAmUVdz
 3TUD21wubRej2WC7GGZ5bLeTaJQ0Q9u9RRt/WFjv8DyVARofREGHqh11ggrNtTpqIWsK8u
 QLwMfeSEA0fDe0M6x+Lm2d6Lf2tgtxk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786548181;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NBH6ZRu+MTN9aZtpw2V4lKd8fEkpIZRf2ue4fLglINE=;
 b=0NCoCEOMu9n0rcX1IkKcAS9k//3Ia4VlTLgjYWKaq5rB0ImMqbP3xuuo70F+aTnmY4ZtEf
 zuO7vEXGpLfwvXCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54324779B1
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:23:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ljZNFNWPfGrGUQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 15:23:01 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 12 Aug 2026 17:22:57 +0200
Message-ID: <20260812152300.64499-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; ARC_NA(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_NONE(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] refluxfs: Check kernel reflink support before mount
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

On some systems, mkfs.xfs can format XFS partition with reflink support
but the kernel then cannot mount it. Check for kernel reflink support
in setup() before mount.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/cve/refluxfs.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/testcases/cve/refluxfs.c b/testcases/cve/refluxfs.c
index e41f35c53..277d56bb7 100644
--- a/testcases/cve/refluxfs.c
+++ b/testcases/cve/refluxfs.c
@@ -38,6 +38,7 @@
  */
 
 #include <pwd.h>
+#include <sys/mount.h>
 
 #include "tst_test.h"
 #include "tst_safe_prw.h"
@@ -94,6 +95,15 @@ static void setup(void)
 	int probe_fd, probe_dio_fd;
 	struct stat sb;
 
+	SAFE_MKDIR(MNTPOINT, 0755);
+	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL));
+
+	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
+		tst_brk(TCONF, "Kernel does not support XFS reflinks");
+
+	if (TST_RET)
+		tst_brk(TBROK | TTERRNO, "Mount failed");
+
 	SAFE_STAT(MNTPOINT, &sb);
 	blksize = sb.st_blksize;
 
@@ -197,6 +207,11 @@ static void cleanup(void)
 	free(tbuf);
 	free(wbuf);
 	free(rbuf);
+
+	SAFE_SETEUID(0);
+
+	if (tst_is_mounted(MNTPOINT))
+		SAFE_UMOUNT(MNTPOINT);
 }
 
 static struct tst_test test = {
@@ -205,8 +220,7 @@ static struct tst_test test = {
 	.cleanup = cleanup,
 	.runtime = 180,
 	.needs_root = 1,
-	.mount_device = 1,
-	.mntpoint = MNTPOINT,
+	.format_device = 1,
 	.filesystems = (struct tst_fs []) {
 		{
 			.type = "xfs",
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
