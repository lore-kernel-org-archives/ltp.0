Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83222C433EF
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 17:50:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A89F3CAD87
	for <ltp@archiver.kernel.org>; Tue,  3 May 2022 19:50:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4BF63CA9AB
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:19 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5A2D91400520
 for <ltp@lists.linux.it>; Tue,  3 May 2022 19:45:19 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 178A51F88A;
 Tue,  3 May 2022 17:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651599919; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vT56Ocb9mXHF+e5dw49x1SKNBXT6xpjUnN+0EHTu348=;
 b=JrdBS5YgbQhrkUxeJTV146TEjQuwLx6uebTc2/9nX0V8hzYxcSuxEfUZ9LCXyfgmHrrveg
 Y8f761DHUix5H3Jsggb4wEQ9DS4UCCfgi7s0mOCEGlKavbF5EfdXxxNz9XHeTcxij3gVz3
 cYljvJKtK/7Ahkl2CGGUe3CjvHQGirI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651599919;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vT56Ocb9mXHF+e5dw49x1SKNBXT6xpjUnN+0EHTu348=;
 b=AWg/Pmh9+ak5+IZp6LrUingIsJrJsGc9ZF0eqLwfgK4DHcsBkaa8VwkarcTUY2K0awz/t4
 ddpFansL4eplYHBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0132113ABE;
 Tue,  3 May 2022 17:45:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZkkdOi5qcWI0PgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 03 May 2022 17:45:18 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 May 2022 19:47:18 +0200
Message-Id: <20220503174718.21205-31-chrubis@suse.cz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220503174718.21205-1-chrubis@suse.cz>
References: <20220503174718.21205-1-chrubis@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 30/30] tst_test: Remove timeout stubs
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
index c084ce4bc..5a84195c7 100644
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
index 096acef96..2ec81ab0e 100644
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
