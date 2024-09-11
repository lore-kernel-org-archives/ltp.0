Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5767AEE57C2
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 16:36:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF2BC3C1D73
	for <ltp@archiver.kernel.org>; Wed, 11 Sep 2024 18:36:04 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 171813C0359
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 18:34:57 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=mdoucha@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5D3452348DE
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 18:34:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 92D7F1FD01
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726072495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrp9qJXdOYAOKyIGOB/wXyt2gGcW5tqE3evDMzMLtp4=;
 b=u25T8Mz1hR44Hm1s1pRLuZ81rtM2GCkl//IP8OHTVaM3QEoMX0DMujg6o+X4kREro/aSUe
 KlU9qe0CDEjhPnmbajgAR0iy9WxKtNYdl4aZUEf83mYEFYcQUSSY5j5WarGp90X/bRPAdo
 RlfD28CuFydFgDGgofo8AAweZMpEiZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726072495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrp9qJXdOYAOKyIGOB/wXyt2gGcW5tqE3evDMzMLtp4=;
 b=fKJmlJybcTOXtHEWcB2EkzxRBsv+YyX/k7l7hpQ+sZAHcRzvhKurd5MKYrWd+5N8msvnMj
 kLiVd77lYsK8vIDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u25T8Mz1;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=fKJmlJyb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1726072495; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrp9qJXdOYAOKyIGOB/wXyt2gGcW5tqE3evDMzMLtp4=;
 b=u25T8Mz1hR44Hm1s1pRLuZ81rtM2GCkl//IP8OHTVaM3QEoMX0DMujg6o+X4kREro/aSUe
 KlU9qe0CDEjhPnmbajgAR0iy9WxKtNYdl4aZUEf83mYEFYcQUSSY5j5WarGp90X/bRPAdo
 RlfD28CuFydFgDGgofo8AAweZMpEiZk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1726072495;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rrp9qJXdOYAOKyIGOB/wXyt2gGcW5tqE3evDMzMLtp4=;
 b=fKJmlJybcTOXtHEWcB2EkzxRBsv+YyX/k7l7hpQ+sZAHcRzvhKurd5MKYrWd+5N8msvnMj
 kLiVd77lYsK8vIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7CD7213A7E
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:34:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id OHo+Hq/G4WZcBQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Wed, 11 Sep 2024 16:34:55 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 11 Sep 2024 18:34:35 +0200
Message-ID: <20240911163443.95398-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911163443.95398-1-mdoucha@suse.cz>
References: <20240911163443.95398-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 92D7F1FD01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/5] readdir01: Enable .all_filesystems
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

Run the functional readdir() test on all filesystems.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/readdir/readdir01.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/readdir/readdir01.c b/testcases/kernel/syscalls/readdir/readdir01.c
index 1bf70fd1f..2dc8f916d 100644
--- a/testcases/kernel/syscalls/readdir/readdir01.c
+++ b/testcases/kernel/syscalls/readdir/readdir01.c
@@ -22,6 +22,8 @@
 #include <stdio.h>
 #include "tst_test.h"
 
+#define MNTPOINT "mntpoint"
+
 static const char prefix[] = "readdirfile";
 static int nfiles = 10;
 
@@ -32,7 +34,7 @@ static void setup(void)
 	int fd;
 
 	for (i = 0; i < nfiles; i++) {
-		sprintf(fname, "%s_%d", prefix, i);
+		sprintf(fname, "%s/%s_%d", MNTPOINT, prefix, i);
 		fd = SAFE_OPEN(fname, O_RDWR | O_CREAT, 0700);
 		SAFE_WRITE(SAFE_WRITE_ALL, fd, "hello\n", 6);
 		SAFE_CLOSE(fd);
@@ -45,7 +47,7 @@ static void verify_readdir(void)
 	DIR *test_dir;
 	struct dirent *ent;
 
-	test_dir = SAFE_OPENDIR(".");
+	test_dir = SAFE_OPENDIR(MNTPOINT);
 	while ((ent = SAFE_READDIR(test_dir))) {
 		if (!strcmp(ent->d_name, ".") || !strcmp(ent->d_name, ".."))
 			continue;
@@ -66,5 +68,8 @@ static void verify_readdir(void)
 static struct tst_test test = {
 	.setup = setup,
 	.test_all = verify_readdir,
-	.needs_tmpdir = 1,
+	.needs_root = 1,
+	.all_filesystems = 1,
+	.mount_device = 1,
+	.mntpoint = MNTPOINT
 };
-- 
2.46.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
