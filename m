Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5CBC6FA8E
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 10:36:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C865B3CCE03
	for <ltp@archiver.kernel.org>; Thu,  2 Mar 2023 11:36:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB3F23CB9C9
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 11:36:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4D8D060085E
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 11:36:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2F0171FE65
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 10:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1677753395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9f7fRcoy++uWfQbtJ29ahHo3uaSY70x73p3VE5tPYGU=;
 b=OGafIo6kEw/++n4x23mhG/Ly1z5vPIocOzFq0tRilQId3PVpxuAud9wKCe796Q44K5QwJd
 nRCdpEiSc5fKDtsucQBfAcOsZCo21O8iA1owlkDuBj5UpocCx5hZ7C7KKXvY1CmpVmRYQ/
 kwMmDQR2XQWYeArai6vH4UwqVoeIt0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1677753395;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9f7fRcoy++uWfQbtJ29ahHo3uaSY70x73p3VE5tPYGU=;
 b=bZNeN/M+JwFuxC+6HN+6K28/uvIOrzWGah8Lt6plLXXKLQ9NuneyCiWjJG7g+1GL2NUQXK
 JAHOwhWpnWdYS5Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2068813349
 for <ltp@lists.linux.it>; Thu,  2 Mar 2023 10:36:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ynIxBzN8AGR3YAAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 02 Mar 2023 10:36:35 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  2 Mar 2023 11:35:52 +0100
Message-Id: <20230302103552.10800-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] fsconfig03: Fix return value validation on older
 kernels
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

On older kernels, Btrfs is not the only filesystem using the legacy
fsconfig() handlers. Assume that fsconfig() is using legacy_parse_param()
and allow it to return success regardless of filesystem up until the point
where the legacy buffer would get full.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Tested on kernel 5.3 both with and without the CVE fix.

 .../kernel/syscalls/fsconfig/fsconfig03.c     | 27 +++++++++++++++----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/fsconfig/fsconfig03.c b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
index 7ee37f4ae..e891c9f98 100644
--- a/testcases/kernel/syscalls/fsconfig/fsconfig03.c
+++ b/testcases/kernel/syscalls/fsconfig/fsconfig03.c
@@ -45,11 +45,21 @@ static void run(void)
 		/* use same logic in kernel legacy_parse_param function */
 		const size_t len = i * (strlen(val) + 2) + (strlen(val) + 1) + 2;
 
-		if (!strcmp(tst_device->fs_type, "btrfs") && len <= (size_t)pagesize)
-			TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
-		else
-			TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
-					    EINVAL);
+		TEST(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
+
+		/* Legacy fsconfig() just copies arguments to buffer */
+		if (!TST_RET && len <= (size_t)pagesize)
+			continue;
+
+		if (!TST_RET) {
+			tst_res(TFAIL, "fsconfig() passed unexpectedly");
+		} else if (TST_RET != -1) {
+			tst_brk(TBROK | TTERRNO,
+				"Invalid fsconfig() return value %ld", TST_RET);
+		} else if (TST_ERR != EINVAL) {
+			tst_res(TFAIL | TTERRNO,
+				"fsconfig() failed with unexpected error");
+		}
 	}
 
 	if (fd != -1)
@@ -63,9 +73,16 @@ static void run(void)
 			tst_device->fs_type);
 }
 
+static void cleanup(void)
+{
+	if (fd >= 0)
+		SAFE_CLOSE(fd);
+}
+
 static struct tst_test test = {
 	.test_all = run,
 	.setup = setup,
+	.cleanup = cleanup,
 	.needs_root = 1,
 	.format_device = 1,
 	.mntpoint = MNTPOINT,
-- 
2.39.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
