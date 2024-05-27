Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72108C25B79
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 06:36:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CEF13D0350
	for <ltp@archiver.kernel.org>; Mon, 27 May 2024 08:36:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7ECB3D0323
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:33:58 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1DF99600694
 for <ltp@lists.linux.it>; Mon, 27 May 2024 08:33:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C3D2D21CB4;
 Mon, 27 May 2024 06:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716791637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKRlHlPi70KmkG4L1Zl6+of3HYBTYh4sCDiM6UQTgwU=;
 b=jfh45fVrM/iFsQX6VjkNOsalplCsvsMZYgQs0ixRLVZW4xTywDjNu76ZvJAANXeRuTCcri
 1liU1whP6faxG5+Tt0h9jjX9IOdwmvT70Ga+yCbLE3GYMi5rYpsg3M6DhStqEeOrUKyTsD
 FI3tBQJ3cqapln3MLc9irORp8hx3aEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716791637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKRlHlPi70KmkG4L1Zl6+of3HYBTYh4sCDiM6UQTgwU=;
 b=2b+Y1KZZ9vbgmlSjvPb/W/rJmaUnTOWY+jv5S9MS+rvvudF9r6ZilUPQIH1iYg1PMUYmr5
 DqbxlYlnw5D9cuAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1716791637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKRlHlPi70KmkG4L1Zl6+of3HYBTYh4sCDiM6UQTgwU=;
 b=jfh45fVrM/iFsQX6VjkNOsalplCsvsMZYgQs0ixRLVZW4xTywDjNu76ZvJAANXeRuTCcri
 1liU1whP6faxG5+Tt0h9jjX9IOdwmvT70Ga+yCbLE3GYMi5rYpsg3M6DhStqEeOrUKyTsD
 FI3tBQJ3cqapln3MLc9irORp8hx3aEo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1716791637;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKRlHlPi70KmkG4L1Zl6+of3HYBTYh4sCDiM6UQTgwU=;
 b=2b+Y1KZZ9vbgmlSjvPb/W/rJmaUnTOWY+jv5S9MS+rvvudF9r6ZilUPQIH1iYg1PMUYmr5
 DqbxlYlnw5D9cuAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ABBD413A6C;
 Mon, 27 May 2024 06:33:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cHPRJ1UpVGZAFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 27 May 2024 06:33:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 27 May 2024 08:33:43 +0200
Message-ID: <20240527063346.289771-13-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240527063346.289771-1-pvorel@suse.cz>
References: <20240527063346.289771-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 12/15] fcntl{34,36}: Remove kernel >= 3.15 check
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

Since 9e9654cf2 LTP supports kernel >= 4.4.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/kernel/syscalls/fcntl/fcntl34.c | 1 -
 testcases/kernel/syscalls/fcntl/fcntl36.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/testcases/kernel/syscalls/fcntl/fcntl34.c b/testcases/kernel/syscalls/fcntl/fcntl34.c
index 45e693fe6..7c3cea05f 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl34.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl34.c
@@ -125,7 +125,6 @@ static void test01(void)
 }
 
 static struct tst_test test = {
-	.min_kver = "3.15.0",
 	.needs_tmpdir = 1,
 	.test_all = test01,
 	.setup = setup
diff --git a/testcases/kernel/syscalls/fcntl/fcntl36.c b/testcases/kernel/syscalls/fcntl/fcntl36.c
index e84b7ed0c..fabdbe905 100644
--- a/testcases/kernel/syscalls/fcntl/fcntl36.c
+++ b/testcases/kernel/syscalls/fcntl/fcntl36.c
@@ -387,7 +387,6 @@ static void tests(unsigned int i)
 }
 
 static struct tst_test test = {
-	.min_kver = "3.15",
 	.needs_tmpdir = 1,
 	.test = tests,
 	.tcnt = ARRAY_SIZE(tcases),
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
