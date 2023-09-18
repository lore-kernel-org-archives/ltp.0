Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA836C46CA1
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 08:25:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7A0E3CE4EB
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 10:25:44 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D48293CAEBC
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 10:25:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C964C618FE8
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 10:25:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B749E1F8C1;
 Mon, 18 Sep 2023 08:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695025508; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sfPCa1VIDMAhvoMEqYwJWHP1E8r7eRbXxjDzFuNsLW8=;
 b=WluL/BLRWWdihD0a5P8jnJuahJ4dlVKk6U4xMLeY06DfZItDvbGXirzcDUEBDYpyWYIdML
 MVhMIRY0Jx5hjEE7R9/VYaAa5FxX5ZZs61sZsgZ3Fwo0fHfOhAUivl4ldLwVN6cBtD8oH8
 5X6lTsafiNnF0MX4r2H129JDYhTdKXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695025508;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sfPCa1VIDMAhvoMEqYwJWHP1E8r7eRbXxjDzFuNsLW8=;
 b=m2gR0eGKWn2lFle150qPgJXscK3LOFW7zDNXzyf4YP1Jd/Kg6ivb8tdIgFWXSWpeShRzXd
 iNSu7j0YcaKdolBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8E8311358A;
 Mon, 18 Sep 2023 08:25:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mBOLHmQJCGWZdAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 18 Sep 2023 08:25:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 18 Sep 2023 10:25:05 +0200
Message-Id: <20230918082506.17464-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918082506.17464-1-andrea.cervesato@suse.de>
References: <20230918082506.17464-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 1/2] Replace runltp-ng with kirk framework
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

Kirk application is the runltp-ng successor and it aims to merge
multiple Linux testing frameworks in one tool, providing support
for remote testing via Qemu, SSH, LTX, parallel execution and much
more.

This patch deprecates runltp-ng, which is not replaced by kirk. All
runltp-ng features are present in kirk and even more.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .gitmodules | 3 +++
 tools/kirk  | 1 +
 2 files changed, 4 insertions(+)
 create mode 160000 tools/kirk

diff --git a/.gitmodules b/.gitmodules
index d1d558b9e..c389186c9 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -7,3 +7,6 @@
 [submodule "tools/runltp-ng"]
 	path = tools/runltp-ng
 	url = https://github.com/linux-test-project/runltp-ng.git
+[submodule "tools/kirk"]
+	path = tools/kirk
+	url = https://github.com/linux-test-project/kirk.git
diff --git a/tools/kirk b/tools/kirk
new file mode 160000
index 000000000..c7419dd6f
--- /dev/null
+++ b/tools/kirk
@@ -0,0 +1 @@
+Subproject commit c7419dd6f73d90f3f02aa17d30270e895e30c88e
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
