Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6409DC5AD49
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 16:13:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2E893CA07F
	for <ltp@archiver.kernel.org>; Tue,  3 Jun 2025 18:13:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D33263C0546
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 18:13:34 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 7B05B2005D3
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 18:13:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8349A21AAE
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 16:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748967213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wscJYNRjSEFGuGf1erPcaCpjr81e2p/DR0hzFRgvDDI=;
 b=r0dv34klcWEl1kgxOt3xEqGKX1ddvurpWnipVz8vJ7aEIJCowXlqOlKi8hlY+WJdruzO8+
 u5e4nRzbf5Of7PRaszb2As7HkK9+uPjSmEjLxZoNPYma5b7Yq4k7JtRYJ5a3rb5gdChzCn
 Guwg2S7IqXPa2ODsOgjgD9Sj15zlCEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748967213;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wscJYNRjSEFGuGf1erPcaCpjr81e2p/DR0hzFRgvDDI=;
 b=vRHVwo2ESMeo6otmecrfe54Yt0pDe038UwsduRDxCtcx+z5Cqlgv56SPVeFgkuKC3dRCFr
 GlVdf4QTQ0KNeZBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=r0dv34kl;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=vRHVwo2E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748967213; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wscJYNRjSEFGuGf1erPcaCpjr81e2p/DR0hzFRgvDDI=;
 b=r0dv34klcWEl1kgxOt3xEqGKX1ddvurpWnipVz8vJ7aEIJCowXlqOlKi8hlY+WJdruzO8+
 u5e4nRzbf5Of7PRaszb2As7HkK9+uPjSmEjLxZoNPYma5b7Yq4k7JtRYJ5a3rb5gdChzCn
 Guwg2S7IqXPa2ODsOgjgD9Sj15zlCEQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748967213;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wscJYNRjSEFGuGf1erPcaCpjr81e2p/DR0hzFRgvDDI=;
 b=vRHVwo2ESMeo6otmecrfe54Yt0pDe038UwsduRDxCtcx+z5Cqlgv56SPVeFgkuKC3dRCFr
 GlVdf4QTQ0KNeZBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 792CB13AAD
 for <ltp@lists.linux.it>; Tue,  3 Jun 2025 16:13:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6MBrHS0fP2irRQAAD6G6ig
 (envelope-from <mdoucha@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 03 Jun 2025 16:13:33 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  3 Jun 2025 18:13:25 +0200
Message-ID: <20250603161327.217374-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250603161327.217374-1-mdoucha@suse.cz>
References: <20250603161327.217374-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8349A21AAE
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCPT_COUNT_ONE(0.00)[1]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_NONE(0.00)[];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 2/2] open12: Fix O_APPEND test case
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

The original O_APPEND test case is guaranteed to succeed even if
O_APPEND doesn't work. Check the cursor position correctly.

Signed-off-by: Martin Doucha <mdoucha@suse.cz>
---

Changes since v1: None

 testcases/kernel/syscalls/open/open12.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/testcases/kernel/syscalls/open/open12.c b/testcases/kernel/syscalls/open/open12.c
index 45984cd0e..433eb700b 100644
--- a/testcases/kernel/syscalls/open/open12.c
+++ b/testcases/kernel/syscalls/open/open12.c
@@ -45,6 +45,7 @@ static void setup(void)
 static void test_append(void)
 {
 	off_t len1, len2;
+	struct stat statbuf;
 
 	tst_res(TINFO, "Testing O_APPEND");
 
@@ -54,14 +55,24 @@ static void test_append(void)
 		return;
 
 	len1 = SAFE_LSEEK(fd, 0, SEEK_CUR);
-	SAFE_WRITE(1, fd, TEST_FILE, strlen(TEST_FILE));
+
+	if (len1)
+		tst_res(TFAIL, "Initial cursor position is not zero");
+
+	SAFE_FSTAT(fd, &statbuf);
+	len1 = strlen(TEST_FILE);
+	SAFE_WRITE(1, fd, TEST_FILE, len1);
 	len2 = SAFE_LSEEK(fd, 0, SEEK_CUR);
 	SAFE_CLOSE(fd);
+	len1 += statbuf.st_size;
 
-	if (len2 > len1)
-		tst_res(TPASS, "O_APPEND works as expected");
-	else
-		tst_res(TFAIL, "O_APPEND did not move write cursor");
+	if (len2 != len1) {
+		tst_res(TFAIL, "Wrong cursor position after write: %ld != %ld",
+			(long)len2, (long)len1);
+		return;
+	}
+
+	tst_res(TPASS, "O_APPEND works as expected");
 }
 
 static void test_noatime(void)
-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
