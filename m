Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 692A6C6FA86
	for <ltp@archiver.kernel.org>; Thu,  8 Sep 2022 14:50:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9E0B3CAA15
	for <ltp@archiver.kernel.org>; Thu,  8 Sep 2022 16:50:24 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 530FA3C07BD
 for <ltp@lists.linux.it>; Thu,  8 Sep 2022 16:50:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 839DC6017EE
 for <ltp@lists.linux.it>; Thu,  8 Sep 2022 16:50:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1EBDC33B23
 for <ltp@lists.linux.it>; Thu,  8 Sep 2022 14:50:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662648612; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YfY6+5rfhkbEilO5on83GOeBFaKL3Gx6E7WXXt9hIEk=;
 b=hdTo9JEtZ6ew4ijFkEPX5EYVitBJ04JAwbg00nTRs8tKLdKZPdjpVGDCTrRTsOcooDzpNN
 6BE0Jf2J2DMDBQIZBKeBfABqqc7u+c8elNaPl0RE2inIQ24r7OK92YUJ0KDhUo83VyHPst
 3IPSuKdTzVXbHH+yh+NEAshhA8+e/L8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662648612;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=YfY6+5rfhkbEilO5on83GOeBFaKL3Gx6E7WXXt9hIEk=;
 b=vEhIzKnOQI07S3aGy4cIgaMzA3HImLAIRuAugZQHok8brP7c+eL2caEUuaxhvqOw8H2DDu
 m2V54Lp2Mq6FwgAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0EF6513A6D
 for <ltp@lists.linux.it>; Thu,  8 Sep 2022 14:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jdxXAiQBGmMcYQAAMHmgww
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Thu, 08 Sep 2022 14:50:12 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Thu,  8 Sep 2022 16:50:11 +0200
Message-Id: <20220908145011.21212-1-mdoucha@suse.cz>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] inotify11: Fix race condition between fork() and
 inotify init
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

When the child process runs a few churn cycles before the parent completes
inotify initialization, the parent will get stuck reading the inotify
file descriptor until it eventually times out. Create inotify watch
befory fork()ing to prevent this race condition.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---
 testcases/kernel/syscalls/inotify/inotify11.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/testcases/kernel/syscalls/inotify/inotify11.c b/testcases/kernel/syscalls/inotify/inotify11.c
index e426f9e1c..dd32ea7fd 100644
--- a/testcases/kernel/syscalls/inotify/inotify11.c
+++ b/testcases/kernel/syscalls/inotify/inotify11.c
@@ -61,15 +61,16 @@ static void verify_inotify(void)
 	struct inotify_event *event;
 	int inotify_fd;
 
+	inotify_fd = SAFE_MYINOTIFY_INIT();
+	SAFE_MYINOTIFY_ADD_WATCH(inotify_fd, ".", IN_DELETE);
+
 	pid = SAFE_FORK();
 	if (pid == 0) {
+		SAFE_CLOSE(inotify_fd);
 		churn();
 		return;
 	}
 
-	inotify_fd = SAFE_MYINOTIFY_INIT();
-	SAFE_MYINOTIFY_ADD_WATCH(inotify_fd, ".", IN_DELETE);
-
 	while (!opened && nevents < CHURN_FILES) {
 		int i, fd, len;
 
-- 
2.37.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
