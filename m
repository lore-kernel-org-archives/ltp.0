Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4247DC369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 09:05:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B4BD33CB96E
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 11:04:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 084043CB96E
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 11:04:06 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1FF45600875
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 11:04:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EC2B11F6E6;
 Wed, 16 Apr 2025 09:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744794240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zJbEqcHSHGy8UIZyggfES2g60S+giRt2PbZZBRabmE=;
 b=KY0zBpPhDuJcwGJK/pnWPLSPNc1rOdwra17dwCGlBD8Z9Zx2aVdXEsgQIf0b8aPB8gfiCy
 iYBDwecrU5xeUXRaV23/2IHuahnwyygT4p/IyNv4Oz4yTwWZ9/1TgBLvmc3plArL0cvquh
 QHEzS/wSgWaEkGj0kGPggjYCntgmjRU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744794240;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zJbEqcHSHGy8UIZyggfES2g60S+giRt2PbZZBRabmE=;
 b=Ey8lO9klNscv6RkYO6GjCgdx7Tls+A55BQyL4MpRCvqf1U2rYFEQeFl/sqamg/qztWsrJC
 WkQhP/dEXmyoeLBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=akVGBoht;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=4RhBp+Wl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744794239; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zJbEqcHSHGy8UIZyggfES2g60S+giRt2PbZZBRabmE=;
 b=akVGBohttpucp3C8dp8ekG/yNk55ShPx+H/h0A+rxYS+t5n2Y24N+lYMRKJ0MicPcO3XqE
 xggUT076Qg6kwacezRb3zKEaRv+gdjHqh9z+MpJipgOCbl7tVr3xnlBDVUyS+/5mgGFwIo
 pax0pXVJsdvEUAgkAC7klcfbprrC/B4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744794239;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zJbEqcHSHGy8UIZyggfES2g60S+giRt2PbZZBRabmE=;
 b=4RhBp+Wl1+KJyaZc+D3k3+2GKq4XzoCDF9bi6P63ARYAndgV/SQdwbRrX8vwLZ+Q9miGiU
 dA4eM8TwgtPzk7CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C295913A39;
 Wed, 16 Apr 2025 09:03:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2OjjLX9y/2foagAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 16 Apr 2025 09:03:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 16 Apr 2025 11:04:00 +0200
MIME-Version: 1.0
Message-Id: <20250416-patchwork_ci-v8-3-503a29526f0a@suse.com>
References: <20250416-patchwork_ci-v8-0-503a29526f0a@suse.com>
In-Reply-To: <20250416-patchwork_ci-v8-0-503a29526f0a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744794239; l=2816;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=W7qFSB0K/AbzxzLV0CAmpXhHqJZjZ3jdF7AerJsAjiQ=;
 b=UtZ8nmULfpHyYM/36zw1m0K2OQ0pJUiGYm43wyyoYSYL78oMkci9H9x4fAuo2l6783vTpj2OO
 YHuE7gqWsNyDZHjzdXjiUtWCitDcVLBfEVZEdhvBU6TId8LPSWXAnmJ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: EC2B11F6E6
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.com:mid,suse.de:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 3/4] ci: add ci-patchwork-trigger workflow
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

Add ci-patchwork-trigger workflow that is meant to run every 15 minutes
during the week and every 45 minutes during the weekend, checking for
new untested LTP patches in the Mailing List and running the
ci-docker-build workflow for them.

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Acked-by: Cyril Hrubis <chrubis@suse.cz>
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
