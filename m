Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA09BC433EF
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 19:35:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6922D3C9229
	for <ltp@archiver.kernel.org>; Tue, 21 Dec 2021 20:35:17 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 855AE3C9219
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 20:35:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 429B36006E2
 for <ltp@lists.linux.it>; Tue, 21 Dec 2021 20:35:05 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6FC9A1F3A6;
 Tue, 21 Dec 2021 19:35:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1640115305; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mcvCXECUCmB3pR0U7x/fF1vGhClVyH5n57TugnQgcHM=;
 b=pisPjzvppy/4M1gFZ5o83Djf+v4Q2veQ9ZN5Z//WbUaZkREXELmclmXZl0XhHT9QlQY17f
 EE1txgmQY1zkw3S0Zv8aBHJT91qrXTp0kgUePO9ktZQOn4UUeyoUq0CtvDNt73pTQCtCFo
 hpUta/SA2dnpYIewslOWnu9dC8X4oOA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1640115305;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mcvCXECUCmB3pR0U7x/fF1vGhClVyH5n57TugnQgcHM=;
 b=PR0Ucml7mO2zuWk+LT2pLM7Qr9PGtU2/5XbTTfT3Fu4c+2BHR2B+emSiWO1d0zc2Cs/hU2
 EQ59G1UavmwHK+DA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35A8413B18;
 Tue, 21 Dec 2021 19:35:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bHr8CmkswmFOQQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 21 Dec 2021 19:35:05 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 21 Dec 2021 20:35:00 +0100
Message-Id: <20211221193500.31950-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] lib: Skip tst_{disable,
 enable}_oom_protection() for non-root
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

If needed to set value also for non-root, use set_oom_score_adj().

Fixes: 8a0827766d ("lib: add functions to adjust oom score")

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 include/tst_memutils.h | 11 ++++++++++-
 lib/tst_memutils.c     |  6 ++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/tst_memutils.h b/include/tst_memutils.h
index 68a6e37714..e6f946ac0c 100644
--- a/include/tst_memutils.h
+++ b/include/tst_memutils.h
@@ -30,11 +30,15 @@ long long tst_available_mem(void);
  *   echo -1000 >/proc/$PID/oom_score_adj
  * If the pid is 0 which means it will set on current(self) process.
  *
+ * WARNING:
+ *  Do nothing for non-root, because setting value < 0 requires root.
+    If you want to set value also for non-root, use set_oom_score_adj().
+ *
  * Note:
  *  This exported tst_enable_oom_protection function can be used at anywhere
  *  you want to protect, but please remember that if you do enable protection
  *  on a process($PID) that all the children will inherit its score and be
- *  ignored by OOM Killer as well. So that's why tst_disable_oom_protection
+ *  ignored by OOM Killer as well. So that's why tst_disable_oom_protection()
  *  to be used in combination.
  */
 void tst_enable_oom_protection(pid_t pid);
@@ -42,6 +46,11 @@ void tst_enable_oom_protection(pid_t pid);
 /*
  * Disable the OOM protection for the process($PID).
  *   echo 0 >/proc/$PID/oom_score_adj
+ *
+ * WARNING:
+ *  Do nothing for non-root, because it's expected to be cleanup after
+ *  tst_enable_oom_protection(). Use set_oom_score_adj(), if you want to set
+ *  value also for non-root.
  */
 void tst_disable_oom_protection(pid_t pid);
 
diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
index 4346508d9a..f0695e026a 100644
--- a/lib/tst_memutils.c
+++ b/lib/tst_memutils.c
@@ -126,10 +126,16 @@ static void set_oom_score_adj(pid_t pid, int value)
 
 void tst_enable_oom_protection(pid_t pid)
 {
+	if (geteuid() != 0)
+		return;
+
 	set_oom_score_adj(pid, -1000);
 }
 
 void tst_disable_oom_protection(pid_t pid)
 {
+	if (geteuid() != 0)
+		return;
+
 	set_oom_score_adj(pid, 0);
 }
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
