Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84EE2C369B4
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 10:00:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EF553C2EFA
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 12:00:33 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A31193CB887
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 12:00:05 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7B9E91000DF9
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 12:00:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9DA6121166;
 Tue, 15 Apr 2025 10:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744711203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyRneAE72AGpXdJMNy5szrqnPkN4P1wu+5FgMvUMACQ=;
 b=cZ+bALxJOezWrC2rBGTq5VuziXYxbz7mswstvpJXe5sVG5EdUmzoO/V28wONz0X6N9cypQ
 W4d13Y6Nnt6aqX/QQhhj9Zvsn9H/rRNGdimagZqO8bHFYszE38zHLQ795sj8SV6nxVyaDR
 gGSPElNfQa08iLinEWR1GNbPeTxXhrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744711203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyRneAE72AGpXdJMNy5szrqnPkN4P1wu+5FgMvUMACQ=;
 b=KlHiglB7fuW24CwrlyN/HGl5BTQwNYMs3WHI9B9lJ4DxY/Vqy2gQL/REbIrmJBG9xPI3Gu
 XgrTYfjwEu3dntDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cZ+bALxJ;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KlHiglB7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744711203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyRneAE72AGpXdJMNy5szrqnPkN4P1wu+5FgMvUMACQ=;
 b=cZ+bALxJOezWrC2rBGTq5VuziXYxbz7mswstvpJXe5sVG5EdUmzoO/V28wONz0X6N9cypQ
 W4d13Y6Nnt6aqX/QQhhj9Zvsn9H/rRNGdimagZqO8bHFYszE38zHLQ795sj8SV6nxVyaDR
 gGSPElNfQa08iLinEWR1GNbPeTxXhrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744711203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tyRneAE72AGpXdJMNy5szrqnPkN4P1wu+5FgMvUMACQ=;
 b=KlHiglB7fuW24CwrlyN/HGl5BTQwNYMs3WHI9B9lJ4DxY/Vqy2gQL/REbIrmJBG9xPI3Gu
 XgrTYfjwEu3dntDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 833B913ABB;
 Tue, 15 Apr 2025 10:00:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SABEHiMu/me6YQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 15 Apr 2025 10:00:03 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 15 Apr 2025 12:00:03 +0200
MIME-Version: 1.0
Message-Id: <20250415-patchwork_ci-v6-3-81e6d4184af5@suse.com>
References: <20250415-patchwork_ci-v6-0-81e6d4184af5@suse.com>
In-Reply-To: <20250415-patchwork_ci-v6-0-81e6d4184af5@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744711202; l=2674;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=MQi5jR8EoVFgpgy0vTroknKw8JCNmN3xj6OrEmUzFtw=;
 b=WggE3SwMI6LWr/mbo4Nb50tzuhuvoAfj9NgmVCpJ13eKs2ZiRuR67BUGclhpOnRzhSLoNtHRV
 zr2pBsT4fvDBB72tUbWEcSDU0SEkuEkUjyFs2MmYjGH/Ke5n6bYGjsC
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 9DA6121166
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid,patchwork-ci.sh:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 3/4] ci: add ci-patchwork-trigger workflow
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

Add ci-patchwork-trigger workflow that is meant to run every 30 minutes,
checking for new untested LTP patches in the Mailing List and running
the ci-docker-build workflow on them.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .github/workflows/ci-patchwork-trigger.yml | 65 ++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/.github/workflows/ci-patchwork-trigger.yml b/.github/workflows/ci-patchwork-trigger.yml
new file mode 100644
index 0000000000000000000000000000000000000000..0938aed5ad0df8af8e2e575283b56475ff219ff3
--- /dev/null
+++ b/.github/workflows/ci-patchwork-trigger.yml
@@ -0,0 +1,65 @@
+# Copyright (c) 2025 Andrea Cervesato <andrea.cervesato@suse.com>
+
+name: "Patchwork checker"
+on:
+  push:
+  schedule:
+    - cron: '*/15 * * * 1-5'
+    - cron: '*/45 * * * 6,0'
+
+env:
+  PATCHWORK_CI_FILE: patchwork-ci-output.txt
+
+jobs:
+  checker:
+    if: ${{ github.repository == 'linux-test-project/ltp' }}
+    runs-on: ubuntu-latest
+    steps:
+      - name: Git checkout
+        uses: actions/checkout@v1
+
+      - name: Verify new patches
+        id: verify
+        run: |
+          ./ci/tools/patchwork.sh verify > "$PATCHWORK_CI_FILE"
+          cat "$PATCHWORK_CI_FILE"
+
+      - name: Run tests
+        if: success()
+        uses: actions/github-script@v7
+        with:
+          script: |
+            const fs = require('fs');
+
+            const output = fs.readFileSync(process.env.PATCHWORK_CI_FILE, 'utf8');
+            if (output.length === 0) {
+              console.log("'patchwork-ci.sh verify' output is empty");
+              return;
+            }
+
+            const lines = output.split('\n');
+            if (lines.length === 0) {
+              console.log("No new patch-series found");
+              return;
+            }
+
+            for (const data of lines) {
+              const [series_id, series_mbox] = data.split('|');
+              if (series_id.length === 0 || series_mbox.length === 0) {
+                console.log(`Malformed data: ${data}`);
+                continue;
+              }
+
+              const response = await github.rest.actions.createWorkflowDispatch({
+                owner: context.repo.owner,
+                repo: context.repo.repo,
+                ref: context.ref,
+                workflow_id: 'ci-docker-build.yml',
+                inputs: {
+                  SERIES_ID: series_id,
+                  SERIES_MBOX: series_mbox,
+                }
+              });
+
+              console.log(response);
+            }

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
