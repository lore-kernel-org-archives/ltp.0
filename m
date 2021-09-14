Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA392C433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 10:01:49 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 488CA60F8F
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 10:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 488CA60F8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B1A83C89C6
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 12:01:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0ABCA3C1D75
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 12:01:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1C084600E5A
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 12:01:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 67766220D0;
 Tue, 14 Sep 2021 10:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631613697; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oKinG/oG8lbtxEZSYPoYAH5//D2XftK9WidLhFMnWbM=;
 b=i9LLmS68yb8pX5p40ZitniTfgOaaObB3qwQxSAU0jkBZb5z3kVWDrSeJNIAgJYUMYPF5iC
 No9HT8m4wsL/FH1fomBZ5RT6abdz7LCsh6BS/yJqcN20ncWuMvhxCnPxycXi0oZPSPymC9
 ElprM42i5a8jdFx9D03VyMPjSR4DRZA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631613697;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=oKinG/oG8lbtxEZSYPoYAH5//D2XftK9WidLhFMnWbM=;
 b=iEKR5gQNr0X4WO+FLNSEQgxMaTkAf5zL93gPsZsApwN+vehHTatXByM0qvR+1SGPYJQqvR
 EZzvgZPlfUWuZKDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DA7E13E55;
 Tue, 14 Sep 2021 10:01:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8s/uEgFzQGH8VgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 14 Sep 2021 10:01:37 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Tue, 14 Sep 2021 12:01:58 +0200
Message-ID: <20210914100158.744-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] scripts/checkpatch.pl: Ignore TST_* in constant checks
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
Message-ID: <20210914100158.jelJtwcplhoxif2q8lF2e_otkm7Rvgx9NrZLyf3B5NE@z>

The checkpatch.pl thinks that TST_RET etc are constants because it
treats everything that is uppercase as a constant and hence complains at
following code:

	if (TST_RET != tc->exp_errno)
		tst_res(TFAIL, "...");

In this case both sides of the comparsion are variables and the code
is as it should be.

So this commit disables the check for 'yoda comparsion' for constants if
the identifier on the left starts with TST_.

Reported-by: Martin Doucha <mdoucha@suse.cz>
Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
---
 scripts/checkpatch.pl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 88cb294dc..87572b2f4 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5462,7 +5462,9 @@ sub process {
 			my $comp = $3;
 			my $to = $4;
 			my $newcomp = $comp;
-			if ($lead !~ /(?:$Operators|\.)\s*$/ &&
+
+			if ($const !~ /^\QTST_/ &&
+			    $lead !~ /(?:$Operators|\.)\s*$/ &&
 			    $to !~ /^(?:Constant|[A-Z_][A-Z0-9_]*)$/ &&
 			    WARN("CONSTANT_COMPARISON",
 				 "Comparisons should place the constant on the right side of the test\n" . $herecurr) &&
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
