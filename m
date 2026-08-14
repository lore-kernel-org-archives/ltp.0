Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DF00C5CFDB
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 12:50:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 591283C7319
	for <ltp@archiver.kernel.org>; Fri, 14 Aug 2026 14:50:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C4603C71CE
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 14:49:55 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 378B11400997
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 14:49:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0C7553EF8
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786711790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KA1CBt5Y1xVWkYgfkFlfvmJrEYryKih/wcHK6YXhWUE=;
 b=C5olCCzz99etLrjz+oOlnX3rt22a/kwjXu3MHiz45F94wNERgV1Zk/yx/7G74msW8y2KIt
 Qg/OZTi3l1viANdTbuk+/7ICvFK3gEXx0S8m0HPcYKf6KipHSaQad5GZxrECv/LMxfcTi7
 rxtGD8CmDr3rQ8adGnf+ZZ6Pf+IZIak=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786711790;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KA1CBt5Y1xVWkYgfkFlfvmJrEYryKih/wcHK6YXhWUE=;
 b=90o4l18JDYjtqxw+0zjqjPTQLtMCYxfymAtnk7Uwl5lbcKIW0xzKWNATZ37jLEzVjFB5Vr
 i/LY7WDU3s97npAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Tk4aK88W;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=K7foTKm5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786711786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KA1CBt5Y1xVWkYgfkFlfvmJrEYryKih/wcHK6YXhWUE=;
 b=Tk4aK88WjEWlvxbnFQBi+plJaKZs02/yBuT9evoT4g/lYyaGSzzEkeeid5V8tA1vVIChIp
 aqWVSCpIh7l6nzXfWJZZ7ugdZjgYOcu7YMQcXDS/l0hEliuqrlGvWuTZKibrCFDW+gqEvq
 FMBDZqsksJWmDMn+fj73AT82OXWGFok=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786711786;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KA1CBt5Y1xVWkYgfkFlfvmJrEYryKih/wcHK6YXhWUE=;
 b=K7foTKm5ssWzTgVS6t5g9WIIvJ2hY+4Y6sFjY5HQWNIu1g8sTohrdkA5E97szHBM25P/U2
 LxhEvdTpnIliNvDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E847D783B1
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:49:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2LVxN+kOf2rlKgAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Fri, 14 Aug 2026 12:49:45 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 14 Aug 2026 14:49:38 +0200
Message-ID: <20260814124943.36853-4-mdoucha@suse.cz>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260814124943.36853-1-mdoucha@suse.cz>
References: <20260814124943.36853-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid,suse.cz:dkim];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: 0C7553EF8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 3/3] file_attr02: Simplify device mounting
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

The file_attr02 test creates an XFS partition with reflinks enabled.
However, some kernels cannot mount such partitions so the test
needs to check kernel support. The LTP library can now do the check
internally so use this feature instead of mounting explicitly in setup().

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 .../kernel/syscalls/file_attr/file_attr02.c     | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/file_attr/file_attr02.c b/testcases/kernel/syscalls/file_attr/file_attr02.c
index f6625985a..0adfa5f6e 100644
--- a/testcases/kernel/syscalls/file_attr/file_attr02.c
+++ b/testcases/kernel/syscalls/file_attr/file_attr02.c
@@ -9,7 +9,6 @@
  * currently implementing the features we need.
  */
 
-#include <sys/mount.h>
 #include "tst_test.h"
 #include "lapi/fs.h"
 
@@ -44,15 +43,6 @@ static void setup(void)
 {
 	struct stat statbuf;
 
-	SAFE_MKDIR(MNTPOINT, 0755);
-	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL));
-
-	if (TST_RET == -1 && TST_ERR == EOPNOTSUPP)
-		tst_brk(TCONF, "Kernel does not support XFS reflinks");
-
-	if (TST_RET)
-		tst_brk(TBROK | TTERRNO, "Mount failed");
-
 	SAFE_STAT(MNTPOINT, &statbuf);
 
 	dfd = SAFE_OPEN(MNTPOINT, O_RDONLY);
@@ -82,9 +72,6 @@ static void cleanup(void)
 
 	if (dfd != -1)
 		SAFE_CLOSE(dfd);
-
-	if (tst_is_mounted(MNTPOINT))
-		SAFE_UMOUNT(MNTPOINT);
 }
 
 static struct tst_test test = {
@@ -92,10 +79,12 @@ static struct tst_test test = {
 	.setup = setup,
 	.cleanup = cleanup,
 	.needs_root = 1,
-	.format_device = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT,
 	.filesystems = (struct tst_fs []) {
 		{
 			.type = "xfs",
+			.mount_check_support = 1,
 			.mkfs_opts = (const char *const[]){
 				"-m", "reflink=1", NULL
 			},
-- 
2.54.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
