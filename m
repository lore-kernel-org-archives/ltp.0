Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A4D4CAC5AE
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 20:29:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6E8913CDAB5
	for <ltp@archiver.kernel.org>; Wed, 24 Sep 2025 22:29:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFE0C3CB2AF
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 22:29:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4214C60090F
 for <ltp@lists.linux.it>; Wed, 24 Sep 2025 22:29:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7891138CA2;
 Wed, 24 Sep 2025 20:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758745763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3CVZ9PLZzBTFL5l2wiuQzwTQ7/5ylXEeVOh0G8YMDUQ=;
 b=yA7XR/wb98E1A/ygnDlGxqIxevQc9F3QYyHwX/1rh5pJ4fkub62XNAgeksFvHnJhFXWGqc
 sSfYiHyDCrSQV/Vjr1H2EFFXHEQsMO4pVDYQxMOdOOdZcR6Aa8zkYpvOPP6Yyj28niBJTg
 Dum5+sSZC0tVKBZ9QKFIHcSliGmLC9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758745763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3CVZ9PLZzBTFL5l2wiuQzwTQ7/5ylXEeVOh0G8YMDUQ=;
 b=wO6vE35BHvZI26g1Fwvr7JlHGCIPLTCYkeerAkBse2ul6n/MyA+raVG4HpfMF+9nDEeyke
 0IpEfNlnCD97egBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1758745763; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3CVZ9PLZzBTFL5l2wiuQzwTQ7/5ylXEeVOh0G8YMDUQ=;
 b=yA7XR/wb98E1A/ygnDlGxqIxevQc9F3QYyHwX/1rh5pJ4fkub62XNAgeksFvHnJhFXWGqc
 sSfYiHyDCrSQV/Vjr1H2EFFXHEQsMO4pVDYQxMOdOOdZcR6Aa8zkYpvOPP6Yyj28niBJTg
 Dum5+sSZC0tVKBZ9QKFIHcSliGmLC9I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1758745763;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3CVZ9PLZzBTFL5l2wiuQzwTQ7/5ylXEeVOh0G8YMDUQ=;
 b=wO6vE35BHvZI26g1Fwvr7JlHGCIPLTCYkeerAkBse2ul6n/MyA+raVG4HpfMF+9nDEeyke
 0IpEfNlnCD97egBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6DA6413647;
 Wed, 24 Sep 2025 20:29:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LbixGqNU1GijdAAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 24 Sep 2025 20:29:23 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 24 Sep 2025 22:29:18 +0200
Message-ID: <20250924202923.9202-1-akumar@suse.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <aNOuYfhEU160i2gE@yuki.lan>
References: <aNOuYfhEU160i2gE@yuki.lan>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_NONE(0.00)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4] Introduce ioctl_pidfd_get_info_supported() function
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

Check if ioctl(PIDFD_GET_INFO) is implemented or not
before proceeding in ioctl_pidfd05 test

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Suggested-by: Petr Vorel <pvorel@suse.cz>
Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/ioctl/ioctl_pidfd.h | 28 +++++++++++++++++++
 .../kernel/syscalls/ioctl/ioctl_pidfd05.c     |  9 +++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
index 811f969cd..b785d8043 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd.h
@@ -9,6 +9,34 @@
 #include "tst_test.h"
 #include "lapi/pidfd.h"
 
+static inline bool ioctl_pidfd_get_info_supported(void)
+{
+	pid_t pid;
+	int pidfd, ret;
+	int supported = 0;
+	struct pidfd_info info;
+
+	if (tst_kvercmp(6, 13, 0) >= 0)
+		return 1;
+
+	memset(&info, 0, sizeof(struct pidfd_info));
+
+	pid = SAFE_FORK();
+	if (!pid)
+		exit(100);
+
+	pidfd = SAFE_PIDFD_OPEN(pid, 0);
+
+	ret = ioctl(pidfd, PIDFD_GET_INFO, &info);
+	SAFE_WAITPID(pid, NULL, 0);
+
+	if (ret != -1)
+		supported = 1;
+
+	SAFE_CLOSE(pidfd);
+	return supported;
+}
+
 static inline int ioctl_pidfd_info_exit_supported(void)
 {
 	int ret;
diff --git a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
index c379717b3..d20c6f074 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl_pidfd05.c
@@ -14,7 +14,7 @@
 #include "tst_test.h"
 #include "lapi/pidfd.h"
 #include "lapi/sched.h"
-#include "lapi/ioctl.h"
+#include "ioctl_pidfd.h"
 
 struct pidfd_info_invalid {
 	uint32_t dummy;
@@ -48,8 +48,15 @@ static void run(void)
 	SAFE_CLOSE(pidfd);
 }
 
+static void setup(void)
+{
+	if (!ioctl_pidfd_get_info_supported())
+		tst_brk(TCONF, "ioctl(PIDFD_GET_INFO) is not implemented");
+}
+
 static struct tst_test test = {
 	.test_all = run,
+	.setup = setup,
 	.forks_child = 1,
 	.bufs = (struct tst_buffers []) {
 		{&args, .size = sizeof(*args)},
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
