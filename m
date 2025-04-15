Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7A3C369BA
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 16:40:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E925D3CB931
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 18:40:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BBED3CB921
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 18:39:46 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8F20A1A007A2
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 18:39:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 59CD81F766;
 Tue, 15 Apr 2025 16:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744735181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zJbEqcHSHGy8UIZyggfES2g60S+giRt2PbZZBRabmE=;
 b=TjZPkbLvyJ+GpQ24sskErtKPHMmhBw9UalGYyuLbtoxDKKmXYjUeNZwce+TFvZE+dY7aac
 Pfe+rEKyCAH8id76qVkJlt73KN00Df6BymV7Ono9P52mieK39We/1szs+88YwHA8T+/PJb
 8tlghxeja2m7vaUJVjtq4c7SqO62xsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744735181;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zJbEqcHSHGy8UIZyggfES2g60S+giRt2PbZZBRabmE=;
 b=co7jj3cplwJ4/YaV8ykZSDfB0f/PNfUKjMd4QsiQKiZj+RugRmYqkgQq/vLQESE3TeeEsJ
 0O0lCUlxoG3IWaCg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TjZPkbLv;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=co7jj3cp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744735181; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zJbEqcHSHGy8UIZyggfES2g60S+giRt2PbZZBRabmE=;
 b=TjZPkbLvyJ+GpQ24sskErtKPHMmhBw9UalGYyuLbtoxDKKmXYjUeNZwce+TFvZE+dY7aac
 Pfe+rEKyCAH8id76qVkJlt73KN00Df6BymV7Ono9P52mieK39We/1szs+88YwHA8T+/PJb
 8tlghxeja2m7vaUJVjtq4c7SqO62xsg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744735181;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+zJbEqcHSHGy8UIZyggfES2g60S+giRt2PbZZBRabmE=;
 b=co7jj3cplwJ4/YaV8ykZSDfB0f/PNfUKjMd4QsiQKiZj+RugRmYqkgQq/vLQESE3TeeEsJ
 0O0lCUlxoG3IWaCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2694213A9F;
 Tue, 15 Apr 2025 16:39:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6LeyB82L/meEZQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 15 Apr 2025 16:39:41 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 15 Apr 2025 18:39:39 +0200
MIME-Version: 1.0
Message-Id: <20250415-patchwork_ci-v7-3-bc0b9adca971@suse.com>
References: <20250415-patchwork_ci-v7-0-bc0b9adca971@suse.com>
In-Reply-To: <20250415-patchwork_ci-v7-0-bc0b9adca971@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744735180; l=2816;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=W7qFSB0K/AbzxzLV0CAmpXhHqJZjZ3jdF7AerJsAjiQ=;
 b=t5d3vhNSTiaig64BCtFLA49z4KzgKYWX3KQfCOqHJCKDpvAwBp1ppGFsfXbjp+sXeRn3iWvln
 QSFAsUcZvD2ALblUbaiA0WtRmbyMPnWhE7cemh8fguGrQwD2CZ3Kda+
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 59CD81F766
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_THREE(0.00)[4];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, suse.com:email, suse.com:mid,
 suse.cz:email]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v7 3/4] ci: add ci-patchwork-trigger workflow
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
