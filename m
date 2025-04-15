Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CB24C369AB
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 10:01:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 875643CB891
	for <ltp@archiver.kernel.org>; Tue, 15 Apr 2025 12:01:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF5923CB88C
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 12:00:09 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C4046600043
 for <ltp@lists.linux.it>; Tue, 15 Apr 2025 12:00:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C2CD021169;
 Tue, 15 Apr 2025 10:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744711204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y1OsDKFRnbfkKL9dykQ5Xs6VgDSmWoMO3s3q2FTWhoc=;
 b=bNIcXkFdYBBF5M0sF+sqFagQvHD5apB20gLWt7V8URU9o1CZycpGWktIKWh+vL3daL2EtF
 uYVhaeJUWjJ/2ihUqeHGI3buQazJi4CazFlvhORYC6mMTcwLS8vAJqcCDeLIiTu1QBHpPy
 FNPzKLbyUlkdgIuZeonsGCmPZAVR/Co=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744711204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y1OsDKFRnbfkKL9dykQ5Xs6VgDSmWoMO3s3q2FTWhoc=;
 b=T1HUBfHcuXxitc6kDjy5mxwULvcavNnk/kLU9GXwCxeH0wuSNP8gtui7mF81Do5aE9Ku8l
 pm/oOQXp6nSJ6cAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744711203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y1OsDKFRnbfkKL9dykQ5Xs6VgDSmWoMO3s3q2FTWhoc=;
 b=b2+OqO7Pgo6Jw36fJEGjhsiSD89+5WDJy3EZDBhWs6a5XTQJMqBoBhjEDBHE9SKyVaRXXr
 nyma7aKrhtfNHcjakLMYFa44TgB4Q70Txv0EykuUuPMwQkn3eMytc2woFxDTrfEx63ANPv
 eUreDkprDAEQ6ZKOhjXiy815depxksU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744711203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y1OsDKFRnbfkKL9dykQ5Xs6VgDSmWoMO3s3q2FTWhoc=;
 b=U8jv0pyVu1nkBWXyU5F9P4htlf0oqR5LfIz2aq4FM+uyo1lHx0r3aPE32w9H5aQUAjzLP9
 GXfrz4qO/RwEWeDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8217139A1;
 Tue, 15 Apr 2025 10:00:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wI9bJyMu/me6YQAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 15 Apr 2025 10:00:03 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 15 Apr 2025 12:00:04 +0200
MIME-Version: 1.0
Message-Id: <20250415-patchwork_ci-v6-4-81e6d4184af5@suse.com>
References: <20250415-patchwork_ci-v6-0-81e6d4184af5@suse.com>
In-Reply-To: <20250415-patchwork_ci-v6-0-81e6d4184af5@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744711202; l=2543;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=3a9763f/un4nVDcG+C1Na0po3w81JNDJPBekwR2y13c=;
 b=6I/aJ4Q7OrhWzXxQQKICFTqyz59mndzMlP42dpQDzpAnmTeAhdJk7IZNX4Qn2jdSLvOpYYTeM
 2CsEO0hn0ckAekyA7u8Cyp53OEaNXv9sVvzk3siNJ9hFk6gT03dN8Di
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 suse.com:email, suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v6 4/4] ci: apply patchwork series in ci-docker-build
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
