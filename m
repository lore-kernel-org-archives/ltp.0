Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52668C636CC
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 13:18:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0F3B3CD0EC
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 14:18:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0916A3CC229
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 14:17:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D33ED600819
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 14:17:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EEBBE20BA8;
 Tue,  7 Feb 2023 13:17:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675775838; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8jHfbgWCPTwBbjJZcQA+nImmHTDgsw6zzc6wW1EUog=;
 b=l+z9Sq0hLvAGqE5T3md+IwAUUxAAAH3hB6KJDsd+0xyt77ckz8Qta8VsK96fo20P7sQmIY
 EtpabHGG0edhbcHgmQE3L+giH9J4AJRBWt2vjNohGNxd+VvEICsmsx3r4rW6KQDfANHOSA
 fUBVvUA70duVLCCMWFNIggnjEHvVT/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675775838;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D8jHfbgWCPTwBbjJZcQA+nImmHTDgsw6zzc6wW1EUog=;
 b=s1YfmgcgIVaQbUbuiXrC+XtTkaXq7/aZlXw/clPVDnHAtbPwMpt2oDjUxnbCXLu3V5VDHk
 msZzbRWVvgsQn0DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9A33813467;
 Tue,  7 Feb 2023 13:17:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gKMyIl5P4mOJbQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 07 Feb 2023 13:17:18 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  7 Feb 2023 14:17:12 +0100
Message-Id: <20230207131714.2500-2-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207131714.2500-1-pvorel@suse.cz>
References: <20230207131714.2500-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] ioctl01: Add default tty device
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

Saves user to specify it when run manually.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/ioctl/ioctl01.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index 1be38e79d3..cb184aee40 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -27,6 +27,7 @@
 #include "lapi/ioctl.h"
 
 #define	INVAL_IOCTL	9999999
+#define	DEFAULT_TTY_DEVICE	"/dev/tty0"
 
 static int fd, fd_file;
 static int bfd = -1;
@@ -70,7 +71,9 @@ static void verify_ioctl(unsigned int i)
 static void setup(void)
 {
 	if (!device)
-		tst_brk(TBROK, "You must specify a tty device with -D option");
+		device = DEFAULT_TTY_DEVICE;
+
+	tst_res(TINFO, "Using device '%s'", device);
 
 	fd = SAFE_OPEN(device, O_RDWR, 0777);
 	fd_file = SAFE_OPEN("x", O_CREAT, 0777);
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
