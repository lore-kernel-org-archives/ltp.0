Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE48C4332F
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 14:44:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A06B43C84AC
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 15:44:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A2AC3C217C
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 15:44:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 133F41A008B0
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 15:44:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E8FE3763D4;
 Tue, 20 Dec 2022 14:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1671547453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=VNhMpqg1pZ/FkweF57ObCN9tFOM4iuYZdWlEzLBFZnE=;
 b=lIe0ve1e2+mO5rqYkbh4bvEdC31eKg/v7yUbhkD8WMGt9Pz7Ns2DpRnAadVVreclM6R488
 Kl5kW6FQs2xabjhxAYPWUCShfJdLrq2jVuLP4UwC3PEsImnX0iEzXzmwjvMp76rvk/I5f3
 OK0UIOvNXqTY0cCMDggBRD7WZsMn5DI=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9C95C13254;
 Tue, 20 Dec 2022 14:44:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ocBKIz3KoWMROQAAMHmgww
 (envelope-from <andrea.cervesato@suse.com>); Tue, 20 Dec 2022 14:44:13 +0000
To: ltp@lists.linux.it
Date: Tue, 20 Dec 2022 15:42:32 +0100
Message-Id: <20221220144232.27950-1-andrea.cervesato@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] Add runltp-ng to upstream
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

runltp-ng is the next generation runner for Linux Testing Project and it
will replace the current obsolete runltp script in the next future.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
Acked-by: Petr Vorel <pvorel@suse.cz>
---
Use https protocol

 .gitmodules     | 3 +++
 tools/runltp-ng | 1 +
 2 files changed, 4 insertions(+)
 create mode 160000 tools/runltp-ng

diff --git a/.gitmodules b/.gitmodules
index a3c34af4b..d1d558b9e 100644
--- a/.gitmodules
+++ b/.gitmodules
@@ -4,3 +4,6 @@
 [submodule "tools/sparse/sparse-src"]
 	path = tools/sparse/sparse-src
 	url = git://git.kernel.org/pub/scm/devel/sparse/sparse.git
+[submodule "tools/runltp-ng"]
+	path = tools/runltp-ng
+	url = https://github.com/linux-test-project/runltp-ng.git
diff --git a/tools/runltp-ng b/tools/runltp-ng
new file mode 160000
index 000000000..39792805b
--- /dev/null
+++ b/tools/runltp-ng
@@ -0,0 +1 @@
+Subproject commit 39792805b3c2c30bde665b01550994aeecff6071
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
