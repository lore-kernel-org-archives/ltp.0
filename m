Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13D16C3DA64
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 12:09:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B68E3D1F40
	for <ltp@archiver.kernel.org>; Thu,  1 Aug 2024 14:09:08 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5FF4F3D1073
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:08:51 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4A0FD602086
 for <ltp@lists.linux.it>; Thu,  1 Aug 2024 14:08:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 88FF61FB4D;
 Thu,  1 Aug 2024 12:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722514130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TO7QOD89YzOr9AiPnHH21yq6WGGs/tr8RnISGKNJbpU=;
 b=HOpmCjmh7ZPCjG7V1GJUlqC2z3VK5ac6lDYZoQ0l33zdF/C34UIY2OmdCFWsbUD+mZEPVk
 kdGXca7VqQiS3P5uIE7e3s85oe67fhI665nA1VPVDVcztLZ4gRYmwboAyAuhU151yRXNpp
 gA//loJ+mIj0DOyi9L2szyg7X4nUW5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722514130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TO7QOD89YzOr9AiPnHH21yq6WGGs/tr8RnISGKNJbpU=;
 b=EUnF0dodJWKFrNYwVz8QVEA/+VaqRF4RknrdpY3MBuZQcX9RjPLWcN6tPUeW+3i0U+ah0n
 KwJVgvXTmWSd+BAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1722514130; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TO7QOD89YzOr9AiPnHH21yq6WGGs/tr8RnISGKNJbpU=;
 b=HOpmCjmh7ZPCjG7V1GJUlqC2z3VK5ac6lDYZoQ0l33zdF/C34UIY2OmdCFWsbUD+mZEPVk
 kdGXca7VqQiS3P5uIE7e3s85oe67fhI665nA1VPVDVcztLZ4gRYmwboAyAuhU151yRXNpp
 gA//loJ+mIj0DOyi9L2szyg7X4nUW5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1722514130;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TO7QOD89YzOr9AiPnHH21yq6WGGs/tr8RnISGKNJbpU=;
 b=EUnF0dodJWKFrNYwVz8QVEA/+VaqRF4RknrdpY3MBuZQcX9RjPLWcN6tPUeW+3i0U+ah0n
 KwJVgvXTmWSd+BAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 60FF913ADB;
 Thu,  1 Aug 2024 12:08:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qBDOFNJ6q2aiVwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 01 Aug 2024 12:08:50 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 01 Aug 2024 14:08:40 +0200
MIME-Version: 1.0
Message-Id: <20240801-landlock-v5-3-663d7383b335@suse.com>
References: <20240801-landlock-v5-0-663d7383b335@suse.com>
In-Reply-To: <20240801-landlock-v5-0-663d7383b335@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989;
 i=andrea.cervesato@suse.com; h=from:subject:message-id;
 bh=cDKP9t45/813OOiOnGDBhLPvLSWYhnYP5FEzZem15aY=;
 b=owEB7QES/pANAwAIAcvMGrIgs+ZGAcsmYgBmq3rQYXDiJXN4MSIBoGm/GueI26j+J7ViBTCHQ
 78vsy8rGBmJAbMEAAEIAB0WIQT1ysFzUKRW0sIb39jLzBqyILPmRgUCZqt60AAKCRDLzBqyILPm
 Rqo4DACY0z2wm8syyM6AC2EHd77v0emJI4FMWWWazezJWfu+knzbjfXoBnXTUPGlY4BqoWxYMTB
 Wlq1CXg2KYlBkb6qZOOZMT6Wgp2g7TWsyXdilsbuXoQBg25aR2Kf9mBoffAuyAppfUJqBgRN7iB
 yFFwPGruVQSquo+Ja7qz2cKPU5jBZEQ7RyG1A1R6UlLby/RpC7yK6fi63BWY5f/BPBs8cQbHyXu
 egIscIfvti7Gi/bpJS7Dnk7FAMmQJJxiiTRzk37q9PwFmE4X5/fDMCgIzuELs+3ifoFHq06xIe9
 0yQyt3tHe9SfVokMkd9sA9iyiEzv3k+X7ulaF6//HPOQVIjDGazmODggNVF6oePgtODX09lHt4S
 gQIJtrQdMiYhpg7aXmTTQubZ+gFWtNx/XXced5GM0t/9OEKkjF+04AgfhW7RlP1rE3zVFuHhu3C
 u+JZJtQlNGRCmzrWDymPQZxI0Njov99W2crmih9+Qav4IP6C+l1xO/c28gH32glK0K0w4=
X-Developer-Key: i=andrea.cervesato@suse.com; a=openpgp;
 fpr=F5CAC17350A456D2C21BDFD8CBCC1AB220B3E646
X-Spamd-Result: default: False [-1.10 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 3/6] Disable kernel version check in landlock tests
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

From: Andrea Cervesato <andrea.cervesato@suse.com>

The reason why we remove kernel version check is that we use
verify_landlock_is_enabled() function in order to check if landlock is
present in the system. This is really helpful when landlock support has
been backported into old kernels.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 testcases/kernel/syscalls/landlock/landlock01.c | 1 -
 testcases/kernel/syscalls/landlock/landlock02.c | 1 -
 testcases/kernel/syscalls/landlock/landlock03.c | 1 -
 3 files changed, 3 deletions(-)

diff --git a/testcases/kernel/syscalls/landlock/landlock01.c b/testcases/kernel/syscalls/landlock/landlock01.c
index 0c50b55d8..db2ffe89b 100644
--- a/testcases/kernel/syscalls/landlock/landlock01.c
+++ b/testcases/kernel/syscalls/landlock/landlock01.c
@@ -75,7 +75,6 @@ static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
-	.min_kver = "5.13",
 	.needs_root = 1,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_SECURITY_LANDLOCK=y",
diff --git a/testcases/kernel/syscalls/landlock/landlock02.c b/testcases/kernel/syscalls/landlock/landlock02.c
index c29ff1e83..2b3e31f69 100644
--- a/testcases/kernel/syscalls/landlock/landlock02.c
+++ b/testcases/kernel/syscalls/landlock/landlock02.c
@@ -120,7 +120,6 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
-	.min_kver = "5.13",
 	.needs_root = 1,
 	.needs_kconfigs = (const char *[]) {
 		"CONFIG_SECURITY_LANDLOCK=y",
diff --git a/testcases/kernel/syscalls/landlock/landlock03.c b/testcases/kernel/syscalls/landlock/landlock03.c
index 9bf358d1c..5661b6b29 100644
--- a/testcases/kernel/syscalls/landlock/landlock03.c
+++ b/testcases/kernel/syscalls/landlock/landlock03.c
@@ -108,7 +108,6 @@ static struct tst_test test = {
 	.tcnt = ARRAY_SIZE(tcases),
 	.setup = setup,
 	.cleanup = cleanup,
-	.min_kver = "5.13",
 	.needs_tmpdir = 1,
 	.needs_root = 1,
 	.forks_child = 1,

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
