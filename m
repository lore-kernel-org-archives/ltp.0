Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C39C46CA1
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 11:07:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EB9BD3CE4FC
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 13:07:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 332973CA601
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:07:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9421D1B6229C
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:07:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F37991FE01;
 Mon, 18 Sep 2023 11:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1695035259; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z+Riv4dmsiSaiUGCdabU1g/40oqBN+HQH/jYfsjpA90=;
 b=u7ZHXHoChPYCbEASlwyGcaKiG8hw2Th1a8kOD3qu6vI8l8wGkjXWSi5WPNgPWAnYFchItE
 1smVefaRaH0k+jUtvW+eWyByppBqokU8cMQosUzBYdFRXHs0vmT9ixPkoCiXbubsk2heks
 yQONQ0FxDfiZVY+znha9l75cPK2GMeo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1695035259;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z+Riv4dmsiSaiUGCdabU1g/40oqBN+HQH/jYfsjpA90=;
 b=YLWJuKtmdQVH1RHB2cCVyw4m/T2QZJy3oYquMTe3JK+ga5vjYATmMlJ5lxGXaE1nuoJzWN
 /N1yA0myOQJPw5Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D2CC213480;
 Mon, 18 Sep 2023 11:07:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iFwqMnovCGWSTAAAMHmgww
 (envelope-from <andrea.cervesato@suse.de>); Mon, 18 Sep 2023 11:07:38 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 18 Sep 2023 13:07:36 +0200
Message-Id: <20230918110737.1922-2-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230918110737.1922-1-andrea.cervesato@suse.de>
References: <20230918110737.1922-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 1/2] Replace runltp-ng with kirk framework
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

This patch removes runltp-ng, which is now replaced by kirk. All
runltp-ng features are present in kirk and even more.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .gitmodules     | 6 +++---
 tools/kirk      | 1 +
 tools/runltp-ng | 1 -
 3 files changed, 4 insertions(+), 4 deletions(-)
 create mode 160000 tools/kirk
 delete mode 160000 tools/runltp-ng

diff --git a/.gitmodules b/.gitmodules
index d1d558b9e..088023039 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -4,6 +4,6 @@
 [submodule "tools/sparse/sparse-src"]
 	path = tools/sparse/sparse-src
 	url = git://git.kernel.org/pub/scm/devel/sparse/sparse.git
-[submodule "tools/runltp-ng"]
-	path = tools/runltp-ng
-	url = https://github.com/linux-test-project/runltp-ng.git
+[submodule "tools/kirk"]
+	path = tools/kirk
+	url = https://github.com/linux-test-project/kirk.git
diff --git a/tools/kirk b/tools/kirk
new file mode 160000
index 000000000..b9e4d1bd3
--- /dev/null
+++ b/tools/kirk
@@ -0,0 +1 @@
+Subproject commit b9e4d1bd3898b25d315706863f182cfeda8aab81
diff --git a/tools/runltp-ng b/tools/runltp-ng
deleted file mode 160000
index e842511ed..000000000
--- a/tools/runltp-ng
+++ /dev/null
@@ -1 +0,0 @@
-Subproject commit e842511ed2c680e3b2ea6dec790913a41d5ed937
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
