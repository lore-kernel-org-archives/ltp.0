Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAF1EC433F5
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 12:41:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F143B3CA9D4
	for <ltp@archiver.kernel.org>; Thu, 12 May 2022 14:41:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 490AE3CA9D6
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CB146100040A
 for <ltp@lists.linux.it>; Thu, 12 May 2022 14:36:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8C14E1F897;
 Thu, 12 May 2022 12:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652358977; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y8bz1SkFjTVBqhSOFwqpdtN3mC5BitcBeFm31y016ro=;
 b=Jp4I03T2EwFtmo5W+BSAR/ZqJouAAIll/fN3jgMZi4RTQY4IjPAS4oIK5Qi8boC/FPIQvH
 6Cye5C/cDOy1zt3x2tZwQC8vHYQWCT5MUZmlxPaYrOkpPtdpwOctgVvTwcqx2emTiJmuhT
 eDvf3tMUnDbVO1zcKkuiJmXSxOuvFVE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652358977;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y8bz1SkFjTVBqhSOFwqpdtN3mC5BitcBeFm31y016ro=;
 b=JASX2oYrcMQbXxh1AGcA6rUaqh2Y5tX04COiyP/ISu4vXXZohzqiUw9wUU/D+RDEQR1MTR
 DdUZom6GDZdL5xCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B71713ABE;
 Thu, 12 May 2022 12:36:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fXB+HUH/fGJoGgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 12 May 2022 12:36:17 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 12 May 2022 14:38:16 +0200
Message-Id: <20220512123816.24399-30-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220512123816.24399-1-chrubis@suse.cz>
References: <20220512123816.24399-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 29/29] tst_test: Remove timeout stubs
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
Cc: automated-testing@lists.yoctoproject.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 include/tst_test.h |  4 ----
 lib/tst_test.c     | 11 -----------
 2 files changed, 15 deletions(-)

diff --git a/include/tst_test.h b/include/tst_test.h
index 01be56cd8..60316092d 100644
--- a/include/tst_test.h
+++ b/include/tst_test.h
@@ -236,8 +236,6 @@ struct tst_test {
 	unsigned int mnt_flags;
 	void *mnt_data;
 
-	/* override default timeout per test run, disabled == -1 */
-	int timeout;
 	/*
 	 * Maximal test runtime in seconds.
 	 *
@@ -333,9 +331,7 @@ const char *tst_strsig(int sig);
  */
 const char *tst_strstatus(int status);
 
-unsigned int tst_timeout_remaining(void);
 unsigned int tst_multiply_timeout(unsigned int timeout);
-void tst_set_timeout(int timeout);
 
 /*
  * Returns remaining test runtime. Test that runs for more than a few seconds
diff --git a/lib/tst_test.c b/lib/tst_test.c
index ef2e614bb..dad8aad92 100644
--- a/lib/tst_test.c
+++ b/lib/tst_test.c
@@ -1471,12 +1471,6 @@ static void sigint_handler(int sig LTP_ATTRIBUTE_UNUSED)
 	}
 }
 
-unsigned int tst_timeout_remaining(void)
-{
-	tst_brk(TBROK, "Stub called!");
-	return 0;
-}
-
 unsigned int tst_remaining_runtime(void)
 {
 	static struct timespec now;
@@ -1509,11 +1503,6 @@ unsigned int tst_multiply_timeout(unsigned int timeout)
 	return timeout * timeout_mul;
 }
 
-void tst_set_timeout(int timeout)
-{
-	tst_brk(TBROK, "Stub called!");
-}
-
 static void set_timeout(void)
 {
 	unsigned int timeout = DEFAULT_TIMEOUT;
-- 
2.35.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
