Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80D1AC36010
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 11:44:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECD4B3CB5BE
	for <ltp@archiver.kernel.org>; Fri, 11 Apr 2025 13:44:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D8C4E3CB5BA
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 13:43:50 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 48F931A00A5F
 for <ltp@lists.linux.it>; Fri, 11 Apr 2025 13:43:49 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 789E91F766;
 Fri, 11 Apr 2025 11:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744371822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fH9kyCT9g4BWpyJPU+CDns+ULGCuzIZ3ZYUqoHzj0+0=;
 b=x8BMhnrlB/bdev/G1svApkWU0WPvKgHoD4djLbulVEiE8BOt+0egZgViX0K4NkeMLjbIZy
 hQYqp6zlWMl1vYSrt2lcuvsYKFMcGVf453lnTHIoqQ54fDtV3C/k5tggV2BY28s9BAHj6V
 t7FP+mrc+ZINIIFiW1A4IBhyAr2lQ58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744371822;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fH9kyCT9g4BWpyJPU+CDns+ULGCuzIZ3ZYUqoHzj0+0=;
 b=Eac0HTu1XUx4NkW9Ita60+M8QLYrRYX9eslB9mNSFAmUhTpOnHpj9SFJE5g/CDKqFW5MvQ
 ksgjSFmaE0cf9aAg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=x8BMhnrl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=Eac0HTu1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744371822; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fH9kyCT9g4BWpyJPU+CDns+ULGCuzIZ3ZYUqoHzj0+0=;
 b=x8BMhnrlB/bdev/G1svApkWU0WPvKgHoD4djLbulVEiE8BOt+0egZgViX0K4NkeMLjbIZy
 hQYqp6zlWMl1vYSrt2lcuvsYKFMcGVf453lnTHIoqQ54fDtV3C/k5tggV2BY28s9BAHj6V
 t7FP+mrc+ZINIIFiW1A4IBhyAr2lQ58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744371822;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fH9kyCT9g4BWpyJPU+CDns+ULGCuzIZ3ZYUqoHzj0+0=;
 b=Eac0HTu1XUx4NkW9Ita60+M8QLYrRYX9eslB9mNSFAmUhTpOnHpj9SFJE5g/CDKqFW5MvQ
 ksgjSFmaE0cf9aAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44FF613A67;
 Fri, 11 Apr 2025 11:43:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oG4oD24A+WcmVAAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Fri, 11 Apr 2025 11:43:42 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Fri, 11 Apr 2025 13:43:24 +0200
Message-ID: <20250411114326.526-5-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250411114326.526-1-andrea.cervesato@suse.de>
References: <20250411114326.526-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 789E91F766
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 4/4] ci: apply patchwork series in ci-docker-build
 workflow
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

Modify ci-docker-build workflow in order to apply untested new
patchwork patch-series inside the current branch and to send back
results in the patchwork instance.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .github/workflows/ci-docker-build.yml | 39 ++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
index 44dcca055..b476d993c 100644
--- a/.github/workflows/ci-docker-build.yml
+++ b/.github/workflows/ci-docker-build.yml
@@ -1,7 +1,19 @@
 # Copyright (c) 2021-2024 Petr Vorel <pvorel@suse.cz>
 
 name: "Test building in various distros in Docker"
-on: [push, pull_request]
+on:
+  push:
+  pull_request:
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
 
 permissions:
   contents: read # to fetch code (actions/checkout)
@@ -125,6 +137,20 @@ jobs:
     - name: Compiler version
       run: $CC --version
 
+    - name: Apply Patchwork series
+      if: inputs.SERIES_ID != '' && inputs.SERIES_MBOX != ''
+      env:
+        PATCHWORK_TOKEN: ${{ secrets.PATCHWORK_TOKEN }}
+      run: |
+        git config --global user.name 'GitHub CI'
+        git config --global user.email 'github@example.com'
+        git config --global --add safe.directory "$GITHUB_WORKSPACE"
+
+        git checkout -b review_patch_series_"${{ inputs.SERIES_ID }}"
+        curl -k "${{ inputs.SERIES_MBOX }}" | git am
+
+        ./ci/tools/patchwork.sh state "${{ inputs.SERIES_ID }}" "needs-review-ack"
+
     - name: ver_linux
       run: ./ver_linux
 
@@ -158,3 +184,14 @@ jobs:
       run: |
         if [ "$MAKE_INSTALL" = 1 ]; then INSTALL_OPT="-i"; fi
         ./build.sh -r install -o ${TREE:-in} $INSTALL_OPT
+
+    - name: Send results to Patchwork
+      if: always() && inputs.SERIES_ID != '' && inputs.SERIES_MBOX != ''
+      env:
+        PATCHWORK_TOKEN: ${{ secrets.PATCHWORK_TOKEN }}
+      run: |
+        ./ci/tools/patchwork.sh check \
+          "${{ inputs.SERIES_ID }}" \
+          "${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}" \
+          "${{ matrix.container }}" \
+          "${{ job.status }}"
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
