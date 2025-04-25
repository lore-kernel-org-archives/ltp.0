Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF46C369C2
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 13:20:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA8313CB90F
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 15:20:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 125FB3CB7C1
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 15:20:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2AA0110009A7
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 15:20:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6771A2116C;
 Fri, 25 Apr 2025 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745587228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bWWG5wAD2yj5xrZClLx7DjP7AHdWZBceSX+xDCHso3w=;
 b=RlA1H0o3B1Lg0gjgIx+X1b4xAyDEpDaAOv2LlnFB+vpblrpAPcQAhkE4/cRLx/Qm6U3DUH
 /Eya075akCKVf4wJRakutPggUtLZu76XbEe/2SYPra94LK6c31AXk01ZheoKWqUnc1U9qY
 gFSTsgVUsD1QVqM1zo/zntJBzq8GMp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745587228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bWWG5wAD2yj5xrZClLx7DjP7AHdWZBceSX+xDCHso3w=;
 b=n3jFISJ7JEVVCv/l6LweLUz7Cst9mzRdkRtLl5LvUpFGrzPT5y1lWUKLo+h01/E9/mOj6G
 9ejl1BzI+y5ZyaDA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RlA1H0o3;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=n3jFISJ7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745587228; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bWWG5wAD2yj5xrZClLx7DjP7AHdWZBceSX+xDCHso3w=;
 b=RlA1H0o3B1Lg0gjgIx+X1b4xAyDEpDaAOv2LlnFB+vpblrpAPcQAhkE4/cRLx/Qm6U3DUH
 /Eya075akCKVf4wJRakutPggUtLZu76XbEe/2SYPra94LK6c31AXk01ZheoKWqUnc1U9qY
 gFSTsgVUsD1QVqM1zo/zntJBzq8GMp0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745587228;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bWWG5wAD2yj5xrZClLx7DjP7AHdWZBceSX+xDCHso3w=;
 b=n3jFISJ7JEVVCv/l6LweLUz7Cst9mzRdkRtLl5LvUpFGrzPT5y1lWUKLo+h01/E9/mOj6G
 9ejl1BzI+y5ZyaDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4D7581388F;
 Fri, 25 Apr 2025 13:20:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 9g9CERyMC2j3UQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 25 Apr 2025 13:20:28 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 25 Apr 2025 15:19:42 +0200
MIME-Version: 1.0
Message-Id: <20250425-ci_enable_sphinx_doc-v2-1-3322c6b9117a@suse.com>
X-B4-Tracking: v=1; b=H4sIAO2LC2gC/4WNQQ6CMBBFr0JmbU1bQIor72EIwXawk2hLOkowh
 LtbuYDL95L//gqMiZDhXKyQcCamGDLoQwHWD+GOglxm0FLXstK1sNRjGG4P7HnyFJbeRStK0za
 mLaWRiJCnU8KRlj177TJ74ldMn/1lVj/7JzgroYQ7oZbN6FRb1Rd+Mx5tfEK3bdsXT2g6n7cAA
 AA=
X-Change-ID: 20250425-ci_enable_sphinx_doc-3897893080ee
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745587228; l=4593;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=keSuoup/qqb00wsOm2qKjAkWO+nSWMPTEqvW7fJ+p+A=;
 b=lStz/phiaAVfu9siIqPkj5vHTgbEdbXb2HWXF45K1nPkhfknCK7S2Sspwcin1BZR4he3igVfL
 HkN+NGJDK6dAwi83jmR9bOaDMxRoCP5uAoBnpN2VRggZai95M5N5wT2
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 6771A2116C
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[user.name:url,suse.com:email,suse.com:mid,suse.de:dkim];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] ci: enable doc testing for new patchwork patches
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

Run documentation build in the ci-patchwork-trigger GitHub
workflow when new patchwork patches arrive in the ML.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
Changes in v2:
- run multiple workflows by taking an array for workflows to run
- Link to v1: https://lore.kernel.org/r/20250425-ci_enable_sphinx_doc-v1-1-d6e207fd1945@suse.com
---
 .github/workflows/ci-patchwork-trigger.yml | 29 +++++++++++++++----------
 .github/workflows/ci-sphinx-doc.yml        | 35 ++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/.github/workflows/ci-patchwork-trigger.yml b/.github/workflows/ci-patchwork-trigger.yml
index 0938aed5ad0df8af8e2e575283b56475ff219ff3..0f4581c1813eb0194226a95a1c3486abb98879ca 100644
--- a/.github/workflows/ci-patchwork-trigger.yml
+++ b/.github/workflows/ci-patchwork-trigger.yml
@@ -43,6 +43,11 @@ jobs:
               return;
             }
 
+            const workflows = [
+              'ci-docker-build.yml',
+              'ci-sphinx-doc.yml'
+            ];
+
             for (const data of lines) {
               const [series_id, series_mbox] = data.split('|');
               if (series_id.length === 0 || series_mbox.length === 0) {
@@ -50,16 +55,18 @@ jobs:
                 continue;
               }
 
-              const response = await github.rest.actions.createWorkflowDispatch({
-                owner: context.repo.owner,
-                repo: context.repo.repo,
-                ref: context.ref,
-                workflow_id: 'ci-docker-build.yml',
-                inputs: {
-                  SERIES_ID: series_id,
-                  SERIES_MBOX: series_mbox,
-                }
-              });
+              for (const workflow in workflows) {
+                const response = await github.rest.actions.createWorkflowDispatch({
+                  owner: context.repo.owner,
+                  repo: context.repo.repo,
+                  ref: context.ref,
+                  workflow_id: workflow,
+                  inputs: {
+                    SERIES_ID: series_id,
+                    SERIES_MBOX: series_mbox,
+                  }
+                });
 
-              console.log(response);
+                console.log(response);
+              }
             }
diff --git a/.github/workflows/ci-sphinx-doc.yml b/.github/workflows/ci-sphinx-doc.yml
index e77c766871b98114417dc7d8d1cb108afe885735..61a593d0aad50ed622a92bfa17681e19a6e2608e 100644
--- a/.github/workflows/ci-sphinx-doc.yml
+++ b/.github/workflows/ci-sphinx-doc.yml
@@ -8,6 +8,16 @@ on:
     paths: ['doc/**']
   pull_request:
     paths: ['doc/**']
+  workflow_dispatch:
+    inputs:
+      SERIES_ID:
+        description: LTP patch series ID
+        required: false
+        default: ''
+      SERIES_MBOX:
+        description: LTP patch series URL
+        required: false
+        default: ''
 
 permissions: {}
 
@@ -25,6 +35,20 @@ jobs:
           sudo apt update
           sudo apt install autoconf make python3-virtualenv
 
+      - name: Apply Patchwork series
+        if: inputs.SERIES_ID != '' && inputs.SERIES_MBOX != ''
+        env:
+          PATCHWORK_TOKEN: ${{ secrets.PATCHWORK_TOKEN }}
+        run: |
+          git config --global user.name 'GitHub CI'
+          git config --global user.email 'github@example.com'
+          git config --global --add safe.directory "$GITHUB_WORKSPACE"
+
+          git checkout -b review_patch_series_"${{ inputs.SERIES_ID }}"
+          curl -k "${{ inputs.SERIES_MBOX }}" | git am
+
+          ./ci/tools/patchwork.sh state "${{ inputs.SERIES_ID }}" "needs-review-ack"
+
       - name: Run configure
         run: |
           cd "$GITHUB_WORKSPACE/ltp/"
@@ -42,3 +66,14 @@ jobs:
           cd "$GITHUB_WORKSPACE/ltp/doc/"
           . .venv/bin/activate
           make
+
+      - name: Send results to Patchwork
+        if: always() && inputs.SERIES_ID != '' && inputs.SERIES_MBOX != ''
+        env:
+          PATCHWORK_TOKEN: ${{ secrets.PATCHWORK_TOKEN }}
+        run: |
+          ./ci/tools/patchwork.sh check \
+            "${{ inputs.SERIES_ID }}" \
+            "${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}" \
+            "${{ matrix.container }}" \
+            "${{ job.status }}"

---
base-commit: 037cb53e353abb571e52b52cbaa6b569ac28c50c
change-id: 20250425-ci_enable_sphinx_doc-3897893080ee

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
