Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CDACC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:33:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35F0C3CF85F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:33:34 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6103C3C0333
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:33 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 933F410103D1
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 19BE65CD1D;
 Thu, 11 Apr 2024 14:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R73LKd6TACt+py7Sg0XSIMZtADFvZkwmOltfHtgn1Qs=;
 b=hj8LWB5IyhlA5JaOGcweN6aDQr9jV8xiAR/nJcBAMkQhxX0h9zW+wsJdCmDDWwwYx5+xN/
 XkbRlzHi+IfiTEowpPYXhzvNj9RdRkm6TrBgdiZbckwxW/zBN+iFZg8tIzZzsmDbD7CCAw
 TygSGxsEXJNvYLxndQKBLa7uK8Hr9T4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R73LKd6TACt+py7Sg0XSIMZtADFvZkwmOltfHtgn1Qs=;
 b=sO44yX1m6LXfvXVn7LK8GUG9lzaybxe/3K2u02Pi5kMak5IzZYlcLJ2vaeuMwDVVdY6D0Z
 icqg8AhTvX8Y+EDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hj8LWB5I;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sO44yX1m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R73LKd6TACt+py7Sg0XSIMZtADFvZkwmOltfHtgn1Qs=;
 b=hj8LWB5IyhlA5JaOGcweN6aDQr9jV8xiAR/nJcBAMkQhxX0h9zW+wsJdCmDDWwwYx5+xN/
 XkbRlzHi+IfiTEowpPYXhzvNj9RdRkm6TrBgdiZbckwxW/zBN+iFZg8tIzZzsmDbD7CCAw
 TygSGxsEXJNvYLxndQKBLa7uK8Hr9T4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R73LKd6TACt+py7Sg0XSIMZtADFvZkwmOltfHtgn1Qs=;
 b=sO44yX1m6LXfvXVn7LK8GUG9lzaybxe/3K2u02Pi5kMak5IzZYlcLJ2vaeuMwDVVdY6D0Z
 icqg8AhTvX8Y+EDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F41241386E;
 Thu, 11 Apr 2024 14:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yAe6OQf0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:31 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:09 +0200
Message-ID: <20240411143025.352507-16-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 19BE65CD1D
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 15/31] mlockall: Remove UCLINUX
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/mlockall/mlockall01.c | 12 ------------
 testcases/kernel/syscalls/mlockall/mlockall02.c | 12 ------------
 testcases/kernel/syscalls/mlockall/mlockall03.c | 12 ------------
 3 files changed, 36 deletions(-)

diff --git a/testcases/kernel/syscalls/mlockall/mlockall01.c b/testcases/kernel/syscalls/mlockall/mlockall01.c
index fa43dad33..50cdfc256 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall01.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall01.c
@@ -75,8 +75,6 @@ void cleanup();
 char *TCID = "mlockall01";
 int TST_TOTAL = 3;
 
-#if !defined(UCLINUX)
-
 struct test_case_t {
 	int flag;
 	char *fdesc;
@@ -127,16 +125,6 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-#else
-
-int main(void)
-{
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
-}
-
-#endif
-
 /*
  * setup() - performs all ONE TIME setup for this test.
  */
diff --git a/testcases/kernel/syscalls/mlockall/mlockall02.c b/testcases/kernel/syscalls/mlockall/mlockall02.c
index 94d6e3270..6524cb4a8 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall02.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall02.c
@@ -99,8 +99,6 @@ struct test_case_t {
 	0, EINVAL, "Unknown flag"}
 };
 
-#if !defined(UCLINUX)
-
 int main(int ac, char **av)
 {
 	int lc, i;
@@ -258,13 +256,3 @@ void cleanup(void)
 {
 	return;
 }
-
-#else
-
-int main(void)
-{
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
-}
-
-#endif /* if !defined(UCLINUX) */
diff --git a/testcases/kernel/syscalls/mlockall/mlockall03.c b/testcases/kernel/syscalls/mlockall/mlockall03.c
index 7418dd64d..a505891fc 100644
--- a/testcases/kernel/syscalls/mlockall/mlockall03.c
+++ b/testcases/kernel/syscalls/mlockall/mlockall03.c
@@ -92,8 +92,6 @@ void cleanup();
 char *TCID = "mlockall03";
 int TST_TOTAL = 3;
 
-#if !defined(UCLINUX)
-
 char *ref_release = "2.6.8\0";
 
 struct test_case_t {
@@ -286,16 +284,6 @@ void cleanup_test(int i)
 	}
 }
 
-#else
-
-int main(void)
-{
-	tst_resm(TINFO, "test is not available on uClinux");
-	tst_exit();
-}
-
-#endif /* if !defined(UCLINUX) */
-
 /*
  * cleanup() - performs all ONE TIME cleanup for this test at
  *		completion or premature exit.
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
