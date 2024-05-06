Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA08AC25B10
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 21:27:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 28F763CDABE
	for <ltp@archiver.kernel.org>; Mon,  6 May 2024 23:27:53 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 022233C8960
 for <ltp@lists.linux.it>; Mon,  6 May 2024 23:27:38 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 15AE6607156
 for <ltp@lists.linux.it>; Mon,  6 May 2024 23:27:37 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E672B2293E;
 Mon,  6 May 2024 21:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715030857; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PQuB3HDowwevUMAMERiQns8BVPFRYvbq9qBAut6XkPw=;
 b=LBmIvV6OOxgr1besK/LBI1AAzuB7kjEttn0TrxiHb0JvoZzuxJBvtORIS5+G7rK6amPGmN
 9JD77sZvE0KT3yoMp6T1KtZ5Ft7HxCjgFk5S4ZWgMlRNQuOaeC6VD1Je6CtI0YdFZ3YYPZ
 BHK7UotvRGAHm0y0c/4kbc5JxWxWCzc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715030857;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PQuB3HDowwevUMAMERiQns8BVPFRYvbq9qBAut6XkPw=;
 b=TxC6fxH1CtrV//jcAYqjpsw1jZrUY1z1OfrM8pRqzWL7ewwTbFfolS04WVn5KSZtMiXwBE
 UwBTGxELyYUcRwDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=EQjTOaGJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=T5wkZIyW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715030856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PQuB3HDowwevUMAMERiQns8BVPFRYvbq9qBAut6XkPw=;
 b=EQjTOaGJ6V6M37yG5YBWhcDB6j1uQhIkVRbVQNGJI00Y+SdqCujnNOoXgP4Qv5t+WbkQS3
 1OrAjJ1pIXJAXtcMjD5kyZC0quEf1PjEl9wg/EWM7OkF2qKuhPy5iVdi+AO9wg3J2NLbK8
 Tu8BVMmG2r5eFuS1WAqWu6NnRBE5Bg4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715030856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=PQuB3HDowwevUMAMERiQns8BVPFRYvbq9qBAut6XkPw=;
 b=T5wkZIyWYymS1j0KUJfVMYIKaWFW8rNEGzTuVvFJBgRqfCafKwho+jt4iFxcPzTNN2ZXGa
 dUoKSu4WK9wGp0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A0E3213A25;
 Mon,  6 May 2024 21:27:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UORuJUhLOWb0dAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 06 May 2024 21:27:36 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon,  6 May 2024 23:27:34 +0200
Message-ID: <20240506212734.71279-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E672B2293E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ci: Add spinx related job
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

Because by default we don't build doc at all.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
Hi,

Tested: https://github.com/pevik/ltp/actions/runs/8976016156

NOTE: it'd be nice to add make install target
(I'm not sure how to get prefix, hopefully including
include/mk/config.mk could be enough).

Also, I'd rename (in a separate commit) .github/workflows/ci.yml
to .github/workflows/ci-docker-build.yml to make it more obvious.

Kind regards,
Petr

 .github/workflows/ci-sphinx-doc.yml | 35 +++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 .github/workflows/ci-sphinx-doc.yml

diff --git a/.github/workflows/ci-sphinx-doc.yml b/.github/workflows/ci-sphinx-doc.yml
new file mode 100644
index 000000000..4bde5cbc8
--- /dev/null
+++ b/.github/workflows/ci-sphinx-doc.yml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: GPL-2.0-or-later
+# Copyright (c) 2024 Petr Vorel <pvorel@suse.cz>
+
+name: "Test building sphinx doc"
+
+on: [push, pull_request]
+
+permissions: {}
+
+jobs:
+  sphinx:
+    runs-on: ubuntu-latest
+    steps:
+      - name: Checkout LTP
+        uses: actions/checkout@v2
+        with:
+          path: ltp
+
+      - name: Install spinx
+        run: |
+          sudo apt update
+          sudo apt install python3-sphinx python3-virtualenv
+
+      - name: Install spinx dependencies
+        run: |
+          cd "$GITHUB_WORKSPACE/ltp/doc/"
+          python3 -m virtualenv .venv
+          . .venv/bin/activate
+          pip install -r requirements.txt
+
+      - name: Build doc
+        run: |
+          cd "$GITHUB_WORKSPACE/ltp/doc/"
+          . .venv/bin/activate
+          make
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
