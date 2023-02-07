Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 132F9C636CC
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 13:17:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 662E73CD0EC
	for <ltp@archiver.kernel.org>; Tue,  7 Feb 2023 14:17:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 210D33C7835
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 14:17:20 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E1E971A00997
 for <ltp@lists.linux.it>; Tue,  7 Feb 2023 14:17:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 81CF33F7EA;
 Tue,  7 Feb 2023 13:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675775839; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NcwzSyIDTv65KHPWGkpALp0vcMBOwFqZ39k6j9u5zwE=;
 b=DyY/AaVVuN5M+AkE7GV7PdjRKSU5mGLQ81x96WfmZQBXbEen/pc6xx5wtJEGVAMm/kC/oK
 rrCAVbuwmaW61WxVgwXQfQ0uPt1YY+E08hsWg4FKUOosvhvVNFzkkvLWHtzVo/z1W80hbD
 GR+LkB6TvXtGPsE3nCXgpCfvmsCdNRs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675775839;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NcwzSyIDTv65KHPWGkpALp0vcMBOwFqZ39k6j9u5zwE=;
 b=e23NnOkP7iYjOVPEiK5aW9J23TzuaUrP/mr0uzkMeLu5AtHAKsy2Sr/HXdjhyqKWiwtqXj
 zs54gOTYjUzUBxCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F7BF13467;
 Tue,  7 Feb 2023 13:17:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iLT0AF9P4mOJbQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 07 Feb 2023 13:17:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  7 Feb 2023 14:17:13 +0100
Message-Id: <20230207131714.2500-3-pvorel@suse.cz>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230207131714.2500-1-pvorel@suse.cz>
References: <20230207131714.2500-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/3] ioctl01: Check tty device
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

tty device must be a char device.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/ioctl/ioctl01.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl01.c b/testcases/kernel/syscalls/ioctl/ioctl01.c
index cb184aee40..5e121ae460 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl01.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl01.c
@@ -25,6 +25,7 @@
 #include <termios.h>
 #include "tst_test.h"
 #include "lapi/ioctl.h"
+#include "tst_safe_macros.h"
 
 #define	INVAL_IOCTL	9999999
 #define	DEFAULT_TTY_DEVICE	"/dev/tty0"
@@ -70,11 +71,20 @@ static void verify_ioctl(unsigned int i)
 
 static void setup(void)
 {
+	struct stat st;
+
 	if (!device)
 		device = DEFAULT_TTY_DEVICE;
 
 	tst_res(TINFO, "Using device '%s'", device);
 
+	if (access(device, F_OK))
+		tst_brk(TCONF, "Device '%s' does not exist", device);
+
+	SAFE_STAT(device, &st);
+	if (!S_ISCHR(st.st_mode))
+		tst_brk(TCONF, "Device '%s' is not a char device", device);
+
 	fd = SAFE_OPEN(device, O_RDWR, 0777);
 	fd_file = SAFE_OPEN("x", O_CREAT, 0777);
 }
-- 
2.39.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
