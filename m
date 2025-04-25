Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53C77C369C2
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 12:59:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DDDD93CB887
	for <ltp@archiver.kernel.org>; Fri, 25 Apr 2025 14:59:30 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C05333CB803
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 14:59:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 190FA1A000F9
 for <ltp@lists.linux.it>; Fri, 25 Apr 2025 14:59:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 877F421168;
 Fri, 25 Apr 2025 12:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745585951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CgOyIWqArxGUf201zIm/bRHdC+06oLCdne2bTTGmJwg=;
 b=pb+6dmcBb1pmtA5sDNBHS5mJpbgZe4y2iH679JHSCKuyimu5mK5d5vSbvlCzieGPbqWmF4
 5I7HEwvpO9eT0JbGKNDZMdlK8m/WRSHV5+ocz+repTS1rM7yHBq51A+NH6ECMn2xt5Qgep
 WdR4NlSvO5e3wvfORHxO41ZHnhIVkgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745585951;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CgOyIWqArxGUf201zIm/bRHdC+06oLCdne2bTTGmJwg=;
 b=8HL+U+N1twGuiXOrWsqVQ2P/0Olvg0D/MhVhK5dhcHRgp2AG884YCeL7erkGRqlfGdh8xH
 Gtr3G2Jdowj9t+BQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1745585951; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CgOyIWqArxGUf201zIm/bRHdC+06oLCdne2bTTGmJwg=;
 b=pb+6dmcBb1pmtA5sDNBHS5mJpbgZe4y2iH679JHSCKuyimu5mK5d5vSbvlCzieGPbqWmF4
 5I7HEwvpO9eT0JbGKNDZMdlK8m/WRSHV5+ocz+repTS1rM7yHBq51A+NH6ECMn2xt5Qgep
 WdR4NlSvO5e3wvfORHxO41ZHnhIVkgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1745585951;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CgOyIWqArxGUf201zIm/bRHdC+06oLCdne2bTTGmJwg=;
 b=8HL+U+N1twGuiXOrWsqVQ2P/0Olvg0D/MhVhK5dhcHRgp2AG884YCeL7erkGRqlfGdh8xH
 Gtr3G2Jdowj9t+BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 61EEB1388F;
 Fri, 25 Apr 2025 12:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xlw9Fh+HC2gtTAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 25 Apr 2025 12:59:11 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 25 Apr 2025 14:58:41 +0200
MIME-Version: 1.0
Message-Id: <20250425-ci_enable_sphinx_doc-v1-1-d6e207fd1945@suse.com>
X-B4-Tracking: v=1; b=H4sIAACHC2gC/x3MQQqAIBRF0a3EHyeYJVlbiZDSV30IC4UIor0nD
 c/g3ocSIiNRXzwUcXHiI2RUZUFum8IKwT6blFRaNkoLxxZhmnfYdG4cbusPJ2rTtaarpZEA5fS
 MWPj+t8P4vh/ACZhBZgAAAA==
X-Change-ID: 20250425-ci_enable_sphinx_doc-3897893080ee
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1745585951; l=3474;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=IHzO6GdneM4DAzixEtr+6wk+5pYFZL2iw9qZb2GUMK8=;
 b=x3DYM/L+P0MaOxHSG0JXrvPzONcyq7PRKJvfP8R5Xh0VTh/QzvQxw/Ky9K/8HaJzTNcdbnGnJ
 ocY3/ApNpx2DlRTjsAlvNIMobg+C6dl4K2CY2umh/lS9vDqybzOX7ZJ
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ci: enable doc testing for new patchwork patches
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
 .github/workflows/ci-patchwork-trigger.yml | 13 +++++++++++
 .github/workflows/ci-sphinx-doc.yml        | 35 ++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/.github/workflows/ci-patchwork-trigger.yml b/.github/workflows/ci-patchwork-trigger.yml
index 0938aed5ad0df8af8e2e575283b56475ff219ff3..96f70d086cacbe0c519c846e80b69e8570dc31ec 100644
--- a/.github/workflows/ci-patchwork-trigger.yml
+++ b/.github/workflows/ci-patchwork-trigger.yml
@@ -62,4 +62,17 @@ jobs:
               });
 
               console.log(response);
+
+              const response = await github.rest.actions.createWorkflowDispatch({
+                owner: context.repo.owner,
+                repo: context.repo.repo,
+                ref: context.ref,
+                workflow_id: 'ci-sphinx-doc.yml',
+                inputs: {
+                  SERIES_ID: series_id,
+                  SERIES_MBOX: series_mbox,
+                }
+              });
+
+              console.log(response);
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
