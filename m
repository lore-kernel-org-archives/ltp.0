Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62533D462BF
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 15:13:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 589043D67AF
	for <ltp@archiver.kernel.org>; Wed, 13 Nov 2024 16:13:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 648423D677A
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 16:13:07 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BA91267982C
 for <ltp@lists.linux.it>; Wed, 13 Nov 2024 16:13:05 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2AA4221137;
 Wed, 13 Nov 2024 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731510785; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HW0lJisu/26d/NSD33H4kNKKznqNMB23euZ+AB5WbUM=;
 b=nnpGqsuVydZwQVQw/VZcsz2PsQEguY9fItTv1BuRCjDO9mDFXI0NOuEbLurCGbNwac3m9/
 Q0TB4oXUW+CQdqmWevTLjDaqGAmIhez8QUG68fOMKpYZVsS9McSBZDrKcpCam15GZU6FDL
 D027BuOITxdFVW45VdUK4+lFCQcDk6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731510785;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HW0lJisu/26d/NSD33H4kNKKznqNMB23euZ+AB5WbUM=;
 b=2Mus4lJL4Q7lEiIx9gubTBaenqHofbpML2sUmorZg+92eGWDKUFc+P/8DX3fBh/zlpO5HG
 uCp3n0S7nX7XxnDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731510784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HW0lJisu/26d/NSD33H4kNKKznqNMB23euZ+AB5WbUM=;
 b=MWKlilK5gA1E5zYFuiJGpfxt83y3NpxSgemKkYMzVTD/GqXVnUrIrQcrf6BiVHR9CXMI4i
 7fmLJnQ0O5f8z0hRtJVBVrsjm6sY7IF9FX1RzP7kiVb8NTJYunKQSURtgiY86FGnFY4L6x
 I39YlXwlL4PCwWCCbEr4pb0DLTyysGE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731510784;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HW0lJisu/26d/NSD33H4kNKKznqNMB23euZ+AB5WbUM=;
 b=VVZYlmBrByOPMpJ5fJALwVetWaMWgDVQbMqrvMD2Z4E6fIVr03q1sZmHKHv+w4si0PllqO
 mkphjIKGzDdnBoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 074C613301;
 Wed, 13 Nov 2024 15:13:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id w1FLAADCNGfcCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 13 Nov 2024 15:13:04 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 13 Nov 2024 16:12:58 +0100
Message-ID: <20241113151258.182353-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc: Update timeout related doc
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

.timeout was removed in bf9678782, replaced by .max_runtime
in 0f72d519a which
* added extra 30 sec safety margin (DEFAULT_TIMEOUT) scalable by $LTP_TIMEOUT_MUL
* .max_runtime is scalable by and $LTP_RUNTIME_MUL

Mention this in API comparison and in the user setup.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/developers/writing_tests.rst | 7 +++----
 doc/users/setup_tests.rst        | 4 +++-
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/doc/developers/writing_tests.rst b/doc/developers/writing_tests.rst
index 2293800a17..90619aebe4 100644
--- a/doc/developers/writing_tests.rst
+++ b/doc/developers/writing_tests.rst
@@ -396,7 +396,9 @@ LTP C And Shell Test API Comparison
       - TST_FORMAT_DEVICE
 
     * - .max_runtime
-      - \-
+      - TST_TIMEOUT (not exactly the same, a real timeout based on old .timeout
+        concept. .max_runtime has also an extra 30 sec safety margin for
+        teardown of the test.)
 
     * - .min_cpus
       - not applicable
@@ -506,9 +508,6 @@ LTP C And Shell Test API Comparison
     * - .test_variants
       - \-
 
-    * - .timeout
-      - TST_TIMEOUT
-
     * - .tst_hugepage
       - not applicable
 
diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
index c5f82e6277..24b1f6384d 100644
--- a/doc/users/setup_tests.rst
+++ b/doc/users/setup_tests.rst
@@ -51,7 +51,9 @@ users.
 
    * - LTP_TIMEOUT_MUL
      - Multiplies timeout, must be number >= 0.1 (> 1 is useful for slow
-       machines to avoid unexpected timeout).
+       machines to avoid unexpected timeout). It's mainly for shell API, which
+       does not have LTP_RUNTIME_MUL. In C API it scales the default 30 sec
+       safety margin, probably LTP_RUNTIME_MUL should be used instead.
 
    * - LTP_RUNTIME_MUL
      - Multiplies maximal test iteration runtime. Tests that run for more than a
-- 
2.47.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
