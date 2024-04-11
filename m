Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1011C4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:36:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 43BE33CF806
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:36:37 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84DE53CF828
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:34 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 93E391000C16
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 44F63375B0;
 Thu, 11 Apr 2024 14:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=arBRVNXcWZGabQNKK7WfgIx/uMDz7ozyLvE3GJ8knaY=;
 b=AksdatYJGa/z4Pg3ayrbe8EMufUapCP4JvYKvhTjrnY57CXe3/GEJWzfHzc4dsFquNxM/o
 wA2gktIC+doZZtMsWlSRNJbE2ldIxI8FgcQca4bbTmgBFc5t9F2AbzOrI03rGMbdqQfopK
 FF1A9Klkp70EMFrp6P4f7T+isFY98f4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=arBRVNXcWZGabQNKK7WfgIx/uMDz7ozyLvE3GJ8knaY=;
 b=tugoD5mns/VyHUCQgi0yLSW4aLyqrqVAEh1LHEwy+IW6/uccqRFiJ122CXMUZvDi0ToKSY
 63Nk9wuEx2WfRhCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AksdatYJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tugoD5mn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=arBRVNXcWZGabQNKK7WfgIx/uMDz7ozyLvE3GJ8knaY=;
 b=AksdatYJGa/z4Pg3ayrbe8EMufUapCP4JvYKvhTjrnY57CXe3/GEJWzfHzc4dsFquNxM/o
 wA2gktIC+doZZtMsWlSRNJbE2ldIxI8FgcQca4bbTmgBFc5t9F2AbzOrI03rGMbdqQfopK
 FF1A9Klkp70EMFrp6P4f7T+isFY98f4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=arBRVNXcWZGabQNKK7WfgIx/uMDz7ozyLvE3GJ8knaY=;
 b=tugoD5mns/VyHUCQgi0yLSW4aLyqrqVAEh1LHEwy+IW6/uccqRFiJ122CXMUZvDi0ToKSY
 63Nk9wuEx2WfRhCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 248981386D;
 Thu, 11 Apr 2024 14:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wAj5Bgj0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:32 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:10 +0200
Message-ID: <20240411143025.352507-17-pvorel@suse.cz>
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
X-Rspamd-Queue-Id: 44F63375B0
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 16/31] munmap: Remove UCLINUX
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
 testcases/kernel/syscalls/munmap/munmap01.c | 18 ++----------------
 testcases/kernel/syscalls/munmap/munmap02.c | 18 ------------------
 2 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/testcases/kernel/syscalls/munmap/munmap01.c b/testcases/kernel/syscalls/munmap/munmap01.c
index 7d10c0eac..dfd81fa2b 100644
--- a/testcases/kernel/syscalls/munmap/munmap01.c
+++ b/testcases/kernel/syscalls/munmap/munmap01.c
@@ -114,13 +114,7 @@ int main(int ac, char **av)
 				 TEST_ERRNO, strerror(TEST_ERRNO));
 			continue;
 		}
-#ifdef UCLINUX
-		/*
-		 * No SIGSEGV on uClinux since
-		 * MMU not implemented on uClinux
-		 */
-		tst_resm(TPASS, "call succedded");
-#else
+
 		/*
 		 * Check whether further reference is possible
 		 * to the unmapped memory region by writing
@@ -130,9 +124,7 @@ int main(int ac, char **av)
 		*addr = 50;
 
 		/* This message is printed if no SIGSEGV */
-		tst_resm(TFAIL, "process succeeds to refer unmapped "
-			 "memory region");
-#endif
+		tst_resm(TFAIL, "process succeeds to refer unmapped memory region");
 
 		cleanup();
 
@@ -195,14 +187,8 @@ void setup(void)
 	 * into the calling process's address space at the system choosen
 	 * with read/write permissions to the mapped region.
 	 */
-#ifdef UCLINUX
-	/* MAP_SHARED is not implemented on uClinux */
-	addr = mmap(0, map_len, PROT_READ | PROT_WRITE,
-		    MAP_FILE | MAP_PRIVATE, fildes, 0);
-#else
 	addr = mmap(0, map_len, PROT_READ | PROT_WRITE,
 		    MAP_FILE | MAP_SHARED, fildes, 0);
-#endif
 
 	/* check for the return value of mmap system call */
 	if (addr == (char *)MAP_FAILED) {
diff --git a/testcases/kernel/syscalls/munmap/munmap02.c b/testcases/kernel/syscalls/munmap/munmap02.c
index cd85d9436..311c0ea14 100644
--- a/testcases/kernel/syscalls/munmap/munmap02.c
+++ b/testcases/kernel/syscalls/munmap/munmap02.c
@@ -92,8 +92,6 @@ void setup();			/* Main setup function of test */
 void cleanup();			/* cleanup function for the test */
 void sig_handler();		/* signal catching function */
 
-#ifndef UCLINUX
-
 int main(int ac, char **av)
 {
 	int lc;
@@ -136,16 +134,6 @@ int main(int ac, char **av)
 	tst_exit();
 }
 
-#else
-
-int main(void)
-{
-	tst_resm(TINFO, "munmap02 test is not available on uClinux");
-	tst_exit();
-}
-
-#endif /* ifndef UCLINUX */
-
 /*
  * setup() - performs all ONE TIME setup for this test.
  * Setup signal handler to catch SIGSEGV.
@@ -199,14 +187,8 @@ void setup(void)
 	 * into the calling process's address space at the system choosen
 	 * with read/write permissions to the mapped region.
 	 */
-#ifdef UCLINUX
-	/* mmap() doesn't support MAP_SHARED on uClinux */
-	addr = mmap(0, map_len, PROT_READ | PROT_WRITE,
-		    MAP_FILE | MAP_PRIVATE, fildes, 0);
-#else
 	addr = mmap(0, map_len, PROT_READ | PROT_WRITE,
 		    MAP_FILE | MAP_SHARED, fildes, 0);
-#endif
 
 	/* check for the return value of mmap system call */
 	if (addr == (char *)MAP_FAILED) {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
