Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9635DC4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:34:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25D393CF85E
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:34:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEB863CF800
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:33 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E9C4B61336D
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:32 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EB8F55CD1B;
 Thu, 11 Apr 2024 14:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845832; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VeVa9ORNdn9IIXGsiD8nSITdraXB5pDrv8eh9gx1CV0=;
 b=O8oGLizd3qX/KDFefsqoIFBcsZaOfVCizHJ42dVQEzjcg2AXf12xkDkze1yjvYOerOZ2f0
 eV+GkF5VvYJJEEZHF7gn6Ft4yb/3YnN6JZDCtal6xtu/SNtZMZT+tfycm64w13Qblu0lKW
 FyghtiW8imM3RUBXqzXC5wCjafpGSyM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845832;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VeVa9ORNdn9IIXGsiD8nSITdraXB5pDrv8eh9gx1CV0=;
 b=OMRwJ7mWKRVP8nGFpJFQn8fnVqMnnnJ9Le0BOyJr0ITF0kC5IhxyvLdyTNkuST54YuB/cG
 Pl4ecqWF9B698oCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VeVa9ORNdn9IIXGsiD8nSITdraXB5pDrv8eh9gx1CV0=;
 b=Kp4tU6xTVOj3VAYy5cvd+TmreJv0RWN0Muqyo0IIZdV/f1W2G1380dTCXImrmverWA6bJx
 kzxIYDv2DWeF3AsazRF5oC+mhAoTrraF+cqWEolp/FBiNcTQZmBC65zh08Jvn7ohuNPPfp
 wRjO6O7VaaopdaqyiY53DLzlM9ebgpY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VeVa9ORNdn9IIXGsiD8nSITdraXB5pDrv8eh9gx1CV0=;
 b=WXfY+xndO421kkgFpuDPtH5TIoKnBMjuoIqAD8Oty5rC5tnBblh+bxw3N3bWRBMn9FHYVT
 j9Cl9zbmjHIGrZAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5C2E1386D;
 Thu, 11 Apr 2024 14:30:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EJ7JMgf0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:31 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:08 +0200
Message-ID: <20240411143025.352507-15-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.78 / 50.00]; BAYES_HAM(-2.98)[99.90%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 14/31] madvise02: Remove UCLINUX
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

skip is now off by default for all cases.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/madvise/madvise02.c | 25 ++++++++-----------
 1 file changed, 11 insertions(+), 14 deletions(-)

diff --git a/testcases/kernel/syscalls/madvise/madvise02.c b/testcases/kernel/syscalls/madvise/madvise02.c
index 90c0431c5..793bda98d 100644
--- a/testcases/kernel/syscalls/madvise/madvise02.c
+++ b/testcases/kernel/syscalls/madvise/madvise02.c
@@ -65,17 +65,17 @@ static struct tcase {
 	int exp_errno;
 	int skip;
 } tcases[] = {
-	{MADV_NORMAL,      "MADV_NORMAL",      &nonalign, EINVAL, 0},
-	{1212,             "MADV_NORMAL",      &file1,    EINVAL, 0},
-	{MADV_REMOVE,      "MADV_REMOVE",      &file1,    EINVAL, 0},
-	{MADV_DONTNEED,    "MADV_DONTNEED",    &file1,    EINVAL, 1},
-	{MADV_MERGEABLE,   "MADV_MERGEABLE",   &file1,    EINVAL, 0},
-	{MADV_UNMERGEABLE, "MADV_UNMERGEABLE", &file1,    EINVAL, 0},
-	{MADV_NORMAL,      "MADV_NORMAL",      &file2,    ENOMEM, 0},
-	{MADV_WILLNEED,    "MADV_WILLNEED",    &file2,    ENOMEM, 0},
-	{MADV_WILLNEED,    "MADV_WILLNEED",    &tmp_addr,  EBADF, 0},
-	{MADV_FREE,        "MADV_FREE",        &file1,    EINVAL, 0},
-	{MADV_WIPEONFORK,  "MADV_WIPEONFORK",  &file1,    EINVAL, 0},
+	{MADV_NORMAL,      "MADV_NORMAL",      &nonalign, EINVAL},
+	{1212,             "MADV_NORMAL",      &file1,    EINVAL},
+	{MADV_REMOVE,      "MADV_REMOVE",      &file1,    EINVAL},
+	{MADV_DONTNEED,    "MADV_DONTNEED",    &file1,    EINVAL},
+	{MADV_MERGEABLE,   "MADV_MERGEABLE",   &file1,    EINVAL},
+	{MADV_UNMERGEABLE, "MADV_UNMERGEABLE", &file1,    EINVAL},
+	{MADV_NORMAL,      "MADV_NORMAL",      &file2,    ENOMEM},
+	{MADV_WILLNEED,    "MADV_WILLNEED",    &file2,    ENOMEM},
+	{MADV_WILLNEED,    "MADV_WILLNEED",    &tmp_addr,  EBADF},
+	{MADV_FREE,        "MADV_FREE",        &file1,    EINVAL},
+	{MADV_WIPEONFORK,  "MADV_WIPEONFORK",  &file1,    EINVAL},
 	{MADV_WIPEONFORK,  "MADV_WIPEONFORK shared_anon", &shared_anon, EINVAL, 0},
 	{MADV_WIPEONFORK,  "MADV_WIPEONFORK private file backed", &file3, EINVAL, 0},
 };
@@ -89,11 +89,8 @@ static void tcases_filter(void)
 
 		switch (tc->advice) {
 		case MADV_DONTNEED:
-#if !defined(UCLINUX)
 			if (mlock(file1, st.st_size) < 0)
 				tst_brk(TBROK | TERRNO, "mlock failed");
-			tc->skip = 0;
-#endif /* if !defined(UCLINUX) */
 		break;
 		case MADV_MERGEABLE:
 		case MADV_UNMERGEABLE:
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
