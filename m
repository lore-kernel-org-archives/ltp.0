Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02AF6D6ACDC
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 10:30:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 547E93D04BB
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 11:30:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80F713CB780
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 11:30:14 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DF01C1A00A44
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 11:30:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5F4915BCFD;
 Thu, 18 Dec 2025 10:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766053808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cCbgeHDa3fDPyVYcK7NhSzOF5AI8HaGkPMhoMEknIJY=;
 b=rCN/i4jEV9r2Lce22im2pFUfrNsuqdZ8gWGecYIUn1tWJWokIXp4hs402RycsCTTCxbtq0
 iHkvVEwaBGT9r71ZYKnUR2ls/wVmzoSOmmvjrN0kwnBU/NHK8gG36MWXpxlI4iXubx8Pit
 94K/EMhCHzfW0A05SdXZ/mk0wIsa7Rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766053808;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cCbgeHDa3fDPyVYcK7NhSzOF5AI8HaGkPMhoMEknIJY=;
 b=/2L+ROA2eOutGZqzycbAcY/5ajV0D6PcNlIuC65uUqRVO2uAdWesTX9DNV8ts2ckxdyLuv
 VOvshTYRMwMgibAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="rCN/i4jE";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="/2L+ROA2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1766053808; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cCbgeHDa3fDPyVYcK7NhSzOF5AI8HaGkPMhoMEknIJY=;
 b=rCN/i4jEV9r2Lce22im2pFUfrNsuqdZ8gWGecYIUn1tWJWokIXp4hs402RycsCTTCxbtq0
 iHkvVEwaBGT9r71ZYKnUR2ls/wVmzoSOmmvjrN0kwnBU/NHK8gG36MWXpxlI4iXubx8Pit
 94K/EMhCHzfW0A05SdXZ/mk0wIsa7Rg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1766053808;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=cCbgeHDa3fDPyVYcK7NhSzOF5AI8HaGkPMhoMEknIJY=;
 b=/2L+ROA2eOutGZqzycbAcY/5ajV0D6PcNlIuC65uUqRVO2uAdWesTX9DNV8ts2ckxdyLuv
 VOvshTYRMwMgibAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2A3EC3EA63;
 Thu, 18 Dec 2025 10:30:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DyxWB7DXQ2nLWAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 18 Dec 2025 10:30:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 18 Dec 2025 11:30:07 +0100
MIME-Version: 1.0
Message-Id: <20251218-ci_enable_sphinx_doc-v3-1-9923a2de1b4e@suse.com>
X-B4-Tracking: v=1; b=H4sIAK7XQ2kC/x3MTQqAIBBA4avErBP8IbOuEiGpUw2EhUIE4d2Tl
 t/ivRcyJsIMY/NCwpsynbFCtQ34fYkbMgrVILnshBSGebIYF3egzddO8bHh9ExojYPpAzdOQU2
 vhCs9/3aaS/kA97L2HmYAAAA=
X-Change-ID: 20251218-ci_enable_sphinx_doc-166e987d08b3
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1766053808; l=4473;
 i=andrea.cervesato@suse.com; s=20251210; h=from:subject:message-id;
 bh=1FvpCjtwRMNziRWgcaQJbJvz3nMpfvm9FBPz+Lr8q74=;
 b=We/9ioyNG0eglRdyxIPJnC9fj61Jayxny5j6f0x0gAWJvfMIETpO21hrbWv37Hy0ThrDI73K+
 if7rOGq+M1MCU8DABMBx149eZWsqbQJQRglipm1di9ZFVFAov6JR5MI
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[user.email:url,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,user.name:url,suse.com:mid,suse.com:email,suse.de:dkim,safe.directory:url];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 5F4915BCFD
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] ci: enable doc testing for new patchwork patches
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

Acked-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .github/workflows/ci-patchwork-trigger.yml | 29 +++++++++++++++----------
 .github/workflows/ci-sphinx-doc.yml        | 35 ++++++++++++++++++++++++++++++
 2 files changed, 53 insertions(+), 11 deletions(-)

diff --git a/.github/workflows/ci-patchwork-trigger.yml b/.github/workflows/ci-patchwork-trigger.yml
index 0938aed5ad0df8af8e2e575283b56475ff219ff3..240bc9edc137dbc6eb3b4b0474dc7779809e7bb4 100644
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
+              };
             }
diff --git a/.github/workflows/ci-sphinx-doc.yml b/.github/workflows/ci-sphinx-doc.yml
index 457aa5a2355d1d93db243090ca31b1c634338b25..b225d32a6ba448fef2fb103cf7f891557be27a05 100644
--- a/.github/workflows/ci-sphinx-doc.yml
+++ b/.github/workflows/ci-sphinx-doc.yml
@@ -9,6 +9,16 @@ on:
     - master
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
 
@@ -26,11 +36,36 @@ jobs:
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
           make autotools && ./configure
 
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
+
       - name: Install sphinx dependencies
         run: |
           cd "$GITHUB_WORKSPACE/ltp/doc/"

---
base-commit: 89d95c6aec39356317338931652a857660873158
change-id: 20251218-ci_enable_sphinx_doc-166e987d08b3

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
