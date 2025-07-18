Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2435AC83F17
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 09:05:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C61F3CC3C7
	for <ltp@archiver.kernel.org>; Fri, 18 Jul 2025 11:05:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C330A3C9AFA
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 11:05:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 427FD1000798
 for <ltp@lists.linux.it>; Fri, 18 Jul 2025 11:05:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CD5D01F38A;
 Fri, 18 Jul 2025 09:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752829527; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gaOfNFS60saKZKDwkZFcZo7uU6yvGvc9NBNfgZrvlN0=;
 b=FYIpKeyJPyApU836Y9ds71Jo8hOUHODfEgPy3lnjsqkcEU5QZ4SU6XBba6XKVc7KgY9Uf+
 n3vBO8aSDtRGYvlRz3AKChR5Sj4hdIOhX92cxD/h5l3MvJi0oBfqGGykrFzKCj3Ftitf62
 NbU1UHxXACzG7Ghz8AOzTApVrfskYdM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752829527;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gaOfNFS60saKZKDwkZFcZo7uU6yvGvc9NBNfgZrvlN0=;
 b=xOV8i2JQHe031qjvlKQtiR7I3XeZ+T9rKWLsVsKew8Pl0oi9ney5l98qzwjPYHgkCIlgze
 laooxwJO+x3ROzCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kcTJ5jWr;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=30uylH1U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1752829526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gaOfNFS60saKZKDwkZFcZo7uU6yvGvc9NBNfgZrvlN0=;
 b=kcTJ5jWriwC2iS3ZZe0BJg3x3O/alWCk2ozMEr/PaTNFZo3VEwYgIzB9Y1MB1r4C87fzTP
 QYDLFemJcqiIZZx5V2pH0oXpmzY5cEvxmJJ4DVq7S37Az4UwAmpxbISZrEuQgOe+vrjLmD
 3P0eUkJJHHu8UH1F2wm6BFralun5gbk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1752829526;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gaOfNFS60saKZKDwkZFcZo7uU6yvGvc9NBNfgZrvlN0=;
 b=30uylH1UHQ7in5CWgti9Yz6P+ValElDf2ltslAZ7gtO8qhAQNxarZW0tweYSSnP75DoFXq
 xN/d3DdJQaVHxfAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 48A57138D2;
 Fri, 18 Jul 2025 09:05:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rrqoClYOemgcUwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 18 Jul 2025 09:05:26 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 18 Jul 2025 11:05:23 +0200
Message-ID: <20250718090523.1411073-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: CD5D01F38A
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] getrlimit03: Simplify TCONF code
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

ENOSYS checks added in fac783b5d6 and d071de02e8 are verbose, use
tst_syscall() to handle ENOSYS.

Also check for __NR_getrlimit caused TCONF message being printed more
times (RLIM_NLIMITS => 16 on x86_64), which is also fixed by using
tst_syscall().

Because it should be safe to not use specific errno variables remove
errno_l and errno_ul.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi all,

@Tiezhu can you please test this patch?
@Li Hope I did not overlook anything.

Kind regards,
Petr

 .../kernel/syscalls/getrlimit/getrlimit03.c   | 23 ++++---------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/testcases/kernel/syscalls/getrlimit/getrlimit03.c b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
index 846ef3ced6..a2dd0ca79c 100644
--- a/testcases/kernel/syscalls/getrlimit/getrlimit03.c
+++ b/testcases/kernel/syscalls/getrlimit/getrlimit03.c
@@ -77,7 +77,7 @@ struct rlimit_ulong {
 
 static int getrlimit_ulong(int resource, struct rlimit_ulong *rlim)
 {
-	return syscall(__NR_getrlimit_ulong, resource, rlim);
+	return tst_syscall(__NR_getrlimit_ulong, resource, rlim);
 }
 
 const long RLIM_INFINITY_L = LONG_MAX;
@@ -90,7 +90,7 @@ struct rlimit_long {
 
 static int getrlimit_long(int resource, struct rlimit_long *rlim)
 {
-	return syscall(__NR_getrlimit, resource, rlim);
+	return tst_syscall(__NR_getrlimit, resource, rlim);
 }
 #endif
 
@@ -147,12 +147,10 @@ static void run(unsigned int resource)
 
 	struct rlimit_ulong rlim_ul;
 	int ret_ul;
-	int errno_ul;
 
 #ifdef SIGNED_GETRLIMIT
 	struct rlimit_long rlim_l;
 	int ret_l;
-	int errno_l;
 #endif
 
 	errno = 0;
@@ -161,15 +159,8 @@ static void run(unsigned int resource)
 
 	errno = 0;
 	ret_ul = getrlimit_ulong(resource, &rlim_ul);
-	errno_ul = errno;
-	if (errno_ul == ENOSYS) {
-		tst_res(TCONF | TERRNO,
-			"%s not implemented", __NR_getrlimit_ulong_str);
-		test.tcnt = 1;
-		return;
-	}
 
-	if (compare_retval(resource, ret_u64, errno_u64, ret_ul, errno_ul,
+	if (compare_retval(resource, ret_u64, errno_u64, ret_ul, errno,
 			   __NR_getrlimit_ulong_str) ||
 	    compare_u64_ulong(resource, rlim_u64.rlim_cur, rlim_ul.rlim_cur,
 			      "rlim_cur") ||
@@ -183,14 +174,8 @@ static void run(unsigned int resource)
 #ifdef SIGNED_GETRLIMIT
 	errno = 0;
 	ret_l = getrlimit_long(resource, &rlim_l);
-	errno_l = errno;
-	if (errno_l == ENOSYS) {
-		tst_res(TCONF | TERRNO,
-			"__NR_getrlimit(%d) not implemented", __NR_getrlimit);
-		return;
-	}
 
-	if (compare_retval(resource, ret_u64, errno_u64, ret_l, errno_l,
+	if (compare_retval(resource, ret_u64, errno_u64, ret_l, errno,
 			   "__NR_getrlimit") ||
 	    compare_u64_long(resource, rlim_u64.rlim_cur, rlim_l.rlim_cur,
 			     "rlim_cur") ||
-- 
2.50.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
