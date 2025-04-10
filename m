Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B8CCC3601E
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 18:22:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED9653CB355
	for <ltp@archiver.kernel.org>; Thu, 10 Apr 2025 20:22:34 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C3D33CB561
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 20:21:30 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C8D4E1A004A3
 for <ltp@lists.linux.it>; Thu, 10 Apr 2025 20:21:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 73EFC1F445;
 Thu, 10 Apr 2025 18:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744309275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J21mbwxXLNdCcjr/qo7J8DJdm1KZm5lX1Zc5d5dZX2I=;
 b=Mg5XWnNhxZcXDgqdrUxK++fADbUV/MfLBPlx8pnZb3b1pt145bRHVitFyO+GNOdkhVD4fq
 LKiSGY9kx8SJAS4Ccz8cZ5PcoxUe8OvBDzTuSXsxkAAGmkk46UPWe19zC5LZCxiryMerpp
 FErKOK4vDV7MUrqlIDs0QLwfxYqd8Xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744309275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J21mbwxXLNdCcjr/qo7J8DJdm1KZm5lX1Zc5d5dZX2I=;
 b=vZHFypdLleEo4WH4nW+mLcWlVDD7rowbSElDCpXdnfCNdiCxu80U7rkkHy8fOAApGnt2JG
 KtkzcrEOuBfJ6YBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1744309275; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J21mbwxXLNdCcjr/qo7J8DJdm1KZm5lX1Zc5d5dZX2I=;
 b=Mg5XWnNhxZcXDgqdrUxK++fADbUV/MfLBPlx8pnZb3b1pt145bRHVitFyO+GNOdkhVD4fq
 LKiSGY9kx8SJAS4Ccz8cZ5PcoxUe8OvBDzTuSXsxkAAGmkk46UPWe19zC5LZCxiryMerpp
 FErKOK4vDV7MUrqlIDs0QLwfxYqd8Xg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1744309275;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J21mbwxXLNdCcjr/qo7J8DJdm1KZm5lX1Zc5d5dZX2I=;
 b=vZHFypdLleEo4WH4nW+mLcWlVDD7rowbSElDCpXdnfCNdiCxu80U7rkkHy8fOAApGnt2JG
 KtkzcrEOuBfJ6YBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 215CB132D8;
 Thu, 10 Apr 2025 18:21:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YJwBAhsM+GfPQwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Thu, 10 Apr 2025 18:21:15 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 10 Apr 2025 20:21:13 +0200
MIME-Version: 1.0
Message-Id: <20250410-patchwork_ci-v2-4-288f4be835ff@suse.com>
References: <20250410-patchwork_ci-v2-0-288f4be835ff@suse.com>
In-Reply-To: <20250410-patchwork_ci-v2-0-288f4be835ff@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1744309273; l=2168;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=OD0vBeNi10FkkewJqJm8hKY7/GJNK2rgG/eWLztttDw=;
 b=Er/PQbjkDP6byecMzMH5QACjIAiz5ILE8gs52zaAjJN5076Wdwkf8BGnuY1SmU7dmPGiw2Urp
 jc43P2H22q1DAMASh1ZqIVQ9mz96t8btowcYW1JrBxjwsV93X1rmidk
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.com:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 4/4] ci: apply patchwork series in ci-docker-build
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
 .github/workflows/ci-docker-build.yml | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/ci-docker-build.yml b/.github/workflows/ci-docker-build.yml
index 44dcca055018a1fb06541a788e3152239aea2e66..aa88b1be83e440681d184f2d36b3ff5e51a0e1d0 100644
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
@@ -125,6 +137,10 @@ jobs:
     - name: Compiler version
       run: $CC --version
 
+    - name: Apply Patchwork series
+      if: inputs.SERIES_ID != '' && inputs.SERIES_MBOX != ''
+      run: ./ci/patchwork-ci.sh apply ${{ inputs.SERIES_ID }} ${{ inputs.SERIES_MBOX }}
+
     - name: ver_linux
       run: ./ver_linux
 
@@ -158,3 +174,14 @@ jobs:
       run: |
         if [ "$MAKE_INSTALL" = 1 ]; then INSTALL_OPT="-i"; fi
         ./build.sh -r install -o ${TREE:-in} $INSTALL_OPT
+
+    - name: Send results to Patchwork
+      if: always() && inputs.SERIES_ID != '' && inputs.SERIES_MBOX != '' && secrets.PATCHWORK_TOKEN != ''
+      env:
+        PATCHWORK_TOKEN: ${{ secrets.PATCHWORK_TOKEN }}
+      run: |
+        ./ci/patchwork-ci.sh check \
+          "${{ inputs.SERIES_ID }}" \
+          "${{ github.server_url }}/${{ github.repository }}/actions/runs/${{ github.run_id }}" \
+          "${{ matrix.container }}" \
+          "${{ job.status }}"

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
