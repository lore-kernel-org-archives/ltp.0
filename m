Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2B33EB64DD
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 06:02:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A6153CD1DF
	for <ltp@archiver.kernel.org>; Mon,  7 Aug 2023 08:02:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B3DF3CB9FB
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 08:02:03 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 66D09600663
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 08:02:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2BBF1F893
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 06:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1691388119; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wDbQR6J9h04UXdnL2JMJjCC+rYZIEF9n3dO8Aqcle8A=;
 b=pAyrPOkpGymeDnFJdGxvFUZyp/V9VR5SmyKs4PchBGwd5U+euylxqkTmsoXVKO6MNgyefn
 SvDj4DoNvBC147GK9MWNoS/hEQ1Z2ZG+ywJTkF8dek4T+6aeWCLOhcNqBdHNfZxUntl8Hx
 TWvJ5RYQqKRKk6mnXwy6b08O5CfiO5s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1691388119;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=wDbQR6J9h04UXdnL2JMJjCC+rYZIEF9n3dO8Aqcle8A=;
 b=OOQ1p/xwT4XZ6Xfi+N3H0Z5eQtPMNkuckuGnlcOKB0FrJMQ76xZkIzP14n6HTvCydiVlDH
 NqepLyYfgwsW5bAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 721AF13487
 for <ltp@lists.linux.it>; Mon,  7 Aug 2023 06:01:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kAQVEteI0GS6PAAAMHmgww
 (envelope-from <akumar@suse.de>)
 for <ltp@lists.linux.it>; Mon, 07 Aug 2023 06:01:59 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Mon,  7 Aug 2023 11:31:56 +0530
Message-ID: <20230807060157.5089-1-akumar@suse.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/write05: Use volatile int var for signal
 handler
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

Signed-off-by: Avinesh Kumar <akumar@suse.de>
---
 testcases/kernel/syscalls/write/write05.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/write/write05.c b/testcases/kernel/syscalls/write/write05.c
index 128c29856..b907624a8 100644
--- a/testcases/kernel/syscalls/write/write05.c
+++ b/testcases/kernel/syscalls/write/write05.c
@@ -45,7 +45,7 @@ static struct tcase {
 	{&pipefd[1], &buf, sizeof(buf), EPIPE},
 };
 
-static int sigpipe_cnt;
+static volatile int sigpipe_cnt;
 
 static void sighandler(int sig)
 {
-- 
2.41.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
