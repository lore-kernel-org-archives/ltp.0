Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98543C433EF
	for <ltp@archiver.kernel.org>; Thu,  9 Dec 2021 23:09:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 793F93C7FEC
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 00:09:11 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE4793C1351
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 00:09:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 80676200C36
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 00:09:00 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 734DD1F37F;
 Thu,  9 Dec 2021 23:08:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639091339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pfTYHOzsQMjyIvgcJuk8FooGajK+j3qn8EUCESeA7dg=;
 b=1yYf52M+pVSUfNR7VKyIF01YMib6j3HGr08E6OP8zeFrvaRqwPKbPVRhGS1lgJJ8EA8H8+
 QERB3canhO/H6VUXCuXXJzdJKn6nutNWYLDGz0PXlmwEFC2Qpjzrc8FG84gWmuZGSnDO2H
 e09a4e+GgWxALSOXCPaGFvwsUU8HrWE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639091339;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=pfTYHOzsQMjyIvgcJuk8FooGajK+j3qn8EUCESeA7dg=;
 b=a87z540d9st4pIFv3TuVuNMl21E9XIzP5rhwgz9Bn+Rj7UxxPVEv0ReoJSOomXDRsElFVp
 WYmo+uvhB9tLdvBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 47B0713DAF;
 Thu,  9 Dec 2021 23:08:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id azNED4uMsmEYdAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Dec 2021 23:08:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Fri, 10 Dec 2021 00:08:54 +0100
Message-Id: <20211209230854.30755-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] github: Add action to update wiki
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
Cc: Smitop <se@smitop.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Suggested-by: Smitop <se@smitop.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

I have custom script for updating wiki, but I got fed up by running it.
I thought it'd be done with git remote hooks, but they're not supported.
Then I got hint from Smitop (most of the code is actually from him,
thanks!).

Tested on my fork:
https://github.com/pevik/ltp/runs/4477321979?check_suite_focus=true
https://github.com/pevik/ltp/wiki/Test-Writing-Guidelines#0-special-paragraph-for-testing

Next could be uploading metadata HTML and PDF to http://linux-test-project.github.io/.

Kind regards,
Petr

 .github/workflows/wiki-mirror.yml | 53 +++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)
 create mode 100644 .github/workflows/wiki-mirror.yml

diff --git a/.github/workflows/wiki-mirror.yml b/.github/workflows/wiki-mirror.yml
new file mode 100644
index 000000000..44a3e9ed7
--- /dev/null
+++ b/.github/workflows/wiki-mirror.yml
@@ -0,0 +1,53 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) Linux Test Project, 2021
+
+name: "Mirror doc to wiki"
+
+on:
+  push:
+    branches:
+      - master
+    paths:
+      - 'doc/**'
+
+jobs:
+  mirror:
+    runs-on: ubuntu-latest
+    steps:
+      - name: Checkout LTP
+        uses: actions/checkout@v2
+        with:
+          path: ltp
+
+      - name: Checkout LTP wiki
+        uses: actions/checkout@v2
+        with:
+          repository: "linux-test-project/ltp.wiki"
+          path: ltp.wiki
+
+      - name: Copy files, push
+        run: |
+          git config --global user.email "actions@github.com"
+          git config --global user.name "Wiki mirror"
+
+          dir="$GITHUB_WORKSPACE/ltp/doc/"
+          cd $dir
+          commit=$(git log --pretty=format:"%h (\"%s\")" -1 .)
+
+          cd $GITHUB_WORKSPACE/ltp.wiki
+
+          # Don't forget to update this list, keep it sorted
+          cp -v $dir/c-test-api.txt C-Test-API.asciidoc
+          cp -v $dir/c-test-tutorial-simple.txt C-Test-Case-Tutorial.asciidoc
+          cp -v $dir/library-api-writing-guidelines.txt LTP-Library-API-Writing-Guidelines.asciidoc
+          cp -v $dir/maintainer-patch-review-checklist.txt Maintainer-Patch-Review-Checklist.asciidoc
+          cp -v $dir/network-c-api.txt C-Test-Network-API.asciidoc
+          cp -v $dir/shell-test-api.txt Shell-Test-API.asciidoc
+          cp -v $dir/supported-kernel-libc-versions.txt Supported-kernel,-libc,-toolchain-versions.asciidoc
+          cp -v $dir/test-writing-guidelines.txt Test-Writing-Guidelines.asciidoc
+          cp -v $dir/user-guide.txt User-Guidelines.asciidoc
+
+          git add .
+          # only commit if there are changes
+          git diff-index --quiet HEAD -- || git commit -m "Update to $commit" .
+          git push
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
