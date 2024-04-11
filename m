Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D5D0C04FF0
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:31:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02D253CF844
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:31:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E34863C0333
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:32 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 62C45208F79
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 552A35CD2C;
 Thu, 11 Apr 2024 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjdC7lbULd4JoqWLBXMc2mYzBEbmEAywIl7vs6BjW6M=;
 b=EBYFOnCGiZ5M0DLS+bbE6PAA4nOzzXMqnXhF/zKd7nz7oNtEjNDRtPr9ovUiwv8wNgGERS
 0LiUzJ9g74BV/wwOqaJtY3j6+/zMpo17rtoE6RmGSRBVSiflMuBkvAoTUwiVnQ/T9g1BoW
 m5ybi05sXc/SP5JQkaQLryQXrDwTvpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjdC7lbULd4JoqWLBXMc2mYzBEbmEAywIl7vs6BjW6M=;
 b=eY9ydzAByu71+YjuxrfYvKK0EA2MTVZhfT+SbVbuZ2zLsLtRoTCpOi9wu5mMz4OFf5KRlZ
 hrcufnocy2Gy8MBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EBYFOnCG;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=eY9ydzAB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjdC7lbULd4JoqWLBXMc2mYzBEbmEAywIl7vs6BjW6M=;
 b=EBYFOnCGiZ5M0DLS+bbE6PAA4nOzzXMqnXhF/zKd7nz7oNtEjNDRtPr9ovUiwv8wNgGERS
 0LiUzJ9g74BV/wwOqaJtY3j6+/zMpo17rtoE6RmGSRBVSiflMuBkvAoTUwiVnQ/T9g1BoW
 m5ybi05sXc/SP5JQkaQLryQXrDwTvpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cjdC7lbULd4JoqWLBXMc2mYzBEbmEAywIl7vs6BjW6M=;
 b=eY9ydzAByu71+YjuxrfYvKK0EA2MTVZhfT+SbVbuZ2zLsLtRoTCpOi9wu5mMz4OFf5KRlZ
 hrcufnocy2Gy8MBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3653F1386D;
 Thu, 11 Apr 2024 14:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KPFsCwf0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:31 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:04 +0200
Message-ID: <20240411143025.352507-11-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 552A35CD2C
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.93 / 50.00]; BAYES_HAM(-2.92)[99.64%];
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 10/31] creat06: Remove UCLINUX
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
 testcases/kernel/syscalls/creat/creat06.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/testcases/kernel/syscalls/creat/creat06.c b/testcases/kernel/syscalls/creat/creat06.c
index 5c82e4757..bd9835ea3 100644
--- a/testcases/kernel/syscalls/creat/creat06.c
+++ b/testcases/kernel/syscalls/creat/creat06.c
@@ -60,9 +60,7 @@
 static void setup(void);
 static void test6_setup(void);
 static void test6_cleanup(void);
-#if !defined(UCLINUX)
 static void bad_addr_setup(int);
-#endif
 
 static struct passwd *ltpuser;
 static char long_name[PATH_MAX+2];
@@ -78,9 +76,7 @@ static struct test_case_t {
 	{long_name, MODE1, ENAMETOOLONG, NULL, NULL},
 	{NO_DIR, MODE1, ENOENT, NULL, NULL},
 	{NOT_DIR, MODE1, ENOTDIR, NULL, NULL},
-#if !defined(UCLINUX)
 	{NULL, MODE1, EFAULT, bad_addr_setup, NULL},
-#endif
 	{TEST6_FILE, MODE1, EACCES, test6_setup, test6_cleanup},
 	{TEST7_FILE, MODE1, ELOOP, NULL, NULL},
 	{TEST8_FILE, MODE1, EROFS, NULL, NULL},
@@ -127,7 +123,6 @@ static void setup(void)
 	SAFE_SYMLINK("test_file_eloop2", TEST7_FILE);
 }
 
-#if !defined(UCLINUX)
 static void bad_addr_setup(int i)
 {
 	if (tcases[i].fname)
@@ -136,7 +131,6 @@ static void bad_addr_setup(int i)
 	tcases[i].fname = SAFE_MMAP(0, 1, PROT_NONE,
 	                            MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
 }
-#endif
 
 static void test6_setup(void)
 {
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
