Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24889C4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:36:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 925433CF848
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:36:15 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 735873CF820
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:34 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 863EE10009BB
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1734B5CD1D;
 Thu, 11 Apr 2024 14:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ui8B3IQRYg5c8fE7/ytrR6yPSCmsmDULcTZDV2FEeRs=;
 b=nC4gQMUztai8Rv0zsURGPfoBovB8I+8iwhLahb1bb3cnCJxp0cof2RTD3TcL/m1aE2q6PP
 cYdSWsjx9YVcUOf4jyL8g5L3exhjrG8cfq5ubhB0pqlHgh8RYFQuxIDE/AT91+lioWrVi3
 oEliuqedm0ZK3wWs0hptnjPZE4irGaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845833;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ui8B3IQRYg5c8fE7/ytrR6yPSCmsmDULcTZDV2FEeRs=;
 b=hhcmXny1XgbmcP3azI8ThaKar2Gi5bXGaABoDiVLJk+21mAyJd4Q9GJSTauSNMSJ0eBQkk
 6Y/0h4Lrf/tAWEBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845833; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ui8B3IQRYg5c8fE7/ytrR6yPSCmsmDULcTZDV2FEeRs=;
 b=nC4gQMUztai8Rv0zsURGPfoBovB8I+8iwhLahb1bb3cnCJxp0cof2RTD3TcL/m1aE2q6PP
 cYdSWsjx9YVcUOf4jyL8g5L3exhjrG8cfq5ubhB0pqlHgh8RYFQuxIDE/AT91+lioWrVi3
 oEliuqedm0ZK3wWs0hptnjPZE4irGaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845833;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ui8B3IQRYg5c8fE7/ytrR6yPSCmsmDULcTZDV2FEeRs=;
 b=hhcmXny1XgbmcP3azI8ThaKar2Gi5bXGaABoDiVLJk+21mAyJd4Q9GJSTauSNMSJ0eBQkk
 6Y/0h4Lrf/tAWEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EFB441386D;
 Thu, 11 Apr 2024 14:30:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kERlOQj0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:32 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:16 +0200
Message-ID: <20240411143025.352507-23-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 22/31] sock*: Remove UCLINUX
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
 testcases/kernel/syscalls/socketpair/socketpair01.c | 2 --
 testcases/kernel/syscalls/sockioctl/sockioctl01.c   | 2 --
 2 files changed, 4 deletions(-)

diff --git a/testcases/kernel/syscalls/socketpair/socketpair01.c b/testcases/kernel/syscalls/socketpair/socketpair01.c
index 675eb535d..5d9610b12 100644
--- a/testcases/kernel/syscalls/socketpair/socketpair01.c
+++ b/testcases/kernel/syscalls/socketpair/socketpair01.c
@@ -34,10 +34,8 @@ struct test_case_t {
 	{PF_INET, 75, 0, fds, -1, EINVAL, "invalid type"},
 	{PF_UNIX, SOCK_DGRAM, 0, fds, 0, 0, "UNIX domain dgram"},
 	{PF_INET, SOCK_RAW, 0, fds, -1, EPROTONOSUPPORT, "raw open as non-root"},
-#ifndef UCLINUX
 	{PF_UNIX, SOCK_STREAM, 0, 0, -1, EFAULT, "bad aligned pointer"},
 	{PF_UNIX, SOCK_STREAM, 0, (int *)7, -1, EFAULT, "bad unaligned pointer"},
-#endif
 	{PF_INET, SOCK_DGRAM, 17, fds, -1, EOPNOTSUPP, "UDP socket"},
 	{PF_INET, SOCK_DGRAM, 6, fds, -1, EPROTONOSUPPORT, "TCP dgram"},
 	{PF_INET, SOCK_STREAM, 6, fds, -1, EOPNOTSUPP, "TCP socket"},
diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
index ff3738f32..e81ec20a5 100644
--- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
+++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
@@ -87,13 +87,11 @@ struct test_case_t {
 		    (struct sockaddr *)&fsin1, sizeof(fsin1), -1,
 		    EINVAL, setup0, cleanup0, "not a socket"}
 	,
-#if !defined(UCLINUX)
 	{
 	PF_INET, SOCK_STREAM, 0, SIOCATMARK, 0,
 		    (struct sockaddr *)&fsin1, sizeof(fsin1), -1,
 		    EFAULT, setup1, cleanup1, "invalid option buffer"}
 	,
-#endif
 	{
 	PF_INET, SOCK_DGRAM, 0, SIOCATMARK, &optval,
 		    (struct sockaddr *)&fsin1, sizeof(fsin1), -1,
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
