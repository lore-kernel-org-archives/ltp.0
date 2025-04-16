Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4950DC369B1
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 09:05:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D201B3CB968
	for <ltp@archiver.kernel.org>; Wed, 16 Apr 2025 11:05:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA0B83CB96A
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 11:04:10 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3A84F1000996
 for <ltp@lists.linux.it>; Wed, 16 Apr 2025 11:04:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 28B272119A;
 Wed, 16 Apr 2025 09:04:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744794240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cx0g+CM29NmXJ+cXLWtJ3xZGLOwxY7OOFDii4xy6m2Q=;
 b=I0WXwG1aJ41Ww1jlP4B/nVNvlnTxqEzgs49oeBnJ8jjFiGaJkD8Vku8QNnRcTShORlYgkN
 3yXqgmdCg4wOGYzcbfcihBahWYs2NAOSIv3oPjGFDF7c0vnaPGRLee5tAWOfJtrq3qKPa7
 7wwwNxU4hQCFrFa7TMWECLw70Sqd2vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744794240;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cx0g+CM29NmXJ+cXLWtJ3xZGLOwxY7OOFDii4xy6m2Q=;
 b=KkufUQAONN0TCWmJGhAqDM/CFwVVxLw/QWEagp3xf66UINTlwxoHjTyl1jaQprZzOUd1Tj
 1aKyw9AraFaMd1BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=I0WXwG1a;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KkufUQAO
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744794240; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cx0g+CM29NmXJ+cXLWtJ3xZGLOwxY7OOFDii4xy6m2Q=;
 b=I0WXwG1aJ41Ww1jlP4B/nVNvlnTxqEzgs49oeBnJ8jjFiGaJkD8Vku8QNnRcTShORlYgkN
 3yXqgmdCg4wOGYzcbfcihBahWYs2NAOSIv3oPjGFDF7c0vnaPGRLee5tAWOfJtrq3qKPa7
 7wwwNxU4hQCFrFa7TMWECLw70Sqd2vg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744794240;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cx0g+CM29NmXJ+cXLWtJ3xZGLOwxY7OOFDii4xy6m2Q=;
 b=KkufUQAONN0TCWmJGhAqDM/CFwVVxLw/QWEagp3xf66UINTlwxoHjTyl1jaQprZzOUd1Tj
 1aKyw9AraFaMd1BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0129813976;
 Wed, 16 Apr 2025 09:03:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UCE2On9y/2foagAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 16 Apr 2025 09:03:59 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 16 Apr 2025 11:04:01 +0200
MIME-Version: 1.0
Message-Id: <20250416-patchwork_ci-v8-4-503a29526f0a@suse.com>
References: <20250416-patchwork_ci-v8-0-503a29526f0a@suse.com>
In-Reply-To: <20250416-patchwork_ci-v8-0-503a29526f0a@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744794239; l=2630;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=zh34Jh8b5Ap0B58mebrIoN0H5JqoAQNg28FizzT6u0I=;
 b=nVuAaeDm8sRk39Y8Dy5AXObVzSJ3byvH4FDxnT86fLlYMx0nW7t1Eth1g6mCChnjTtLCRR+r7
 uqizUp+EKUCA8NdoIR/M10QYzxrvVirVhBiW1G+rQkYAJr3ligoiU6D
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Rspamd-Queue-Id: 28B272119A
X-Rspamd-Action: no action
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email,suse.de:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v8 4/4] ci: apply patchwork series in ci-docker-build
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

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .github/workflows/ci-docker-build.yml | 39 ++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
index 44dcca055018a1fb06541a788e3152239aea2e66..b476d993c50a3369efdaa9a72787a7f006cfe0b9 100644
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
