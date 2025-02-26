Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0258BC021B8
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 14:31:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DC9863C9D01
	for <ltp@archiver.kernel.org>; Wed, 26 Feb 2025 15:31:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BAA673C9AAE
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 15:31:22 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C714C200909
 for <ltp@lists.linux.it>; Wed, 26 Feb 2025 15:31:21 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 853FD1F387;
 Wed, 26 Feb 2025 14:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740580280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hwGPWqxoxWrUhKtQSh1tXrjsSNnP+VDuLf0TjPEgnSo=;
 b=f7bui4IQQzs2ItV8EiK9yhBFM4ZvRleO7rfWYfV/9lzFsTXfSS6zPR1OPu7D5EXJwKx1za
 9HcdCtl0+8a2+Ne4SPmW7S1v0PP9QNSDbhnF22Hsd7zqfSWTy0TXizlY9+iI7W9suaXAdu
 ohI3lBeDdFZquPmg9i4jR3BmMtV8jDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740580280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hwGPWqxoxWrUhKtQSh1tXrjsSNnP+VDuLf0TjPEgnSo=;
 b=N6tMOLEpQp/9TrqMXZImk05uIqETZRBAF7QpiEHXR4j+Xs2Cts7lBfmSCsqEa1EZaIyhII
 sk5qHWqTpv2KbyAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=f7bui4IQ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=N6tMOLEp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1740580280; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hwGPWqxoxWrUhKtQSh1tXrjsSNnP+VDuLf0TjPEgnSo=;
 b=f7bui4IQQzs2ItV8EiK9yhBFM4ZvRleO7rfWYfV/9lzFsTXfSS6zPR1OPu7D5EXJwKx1za
 9HcdCtl0+8a2+Ne4SPmW7S1v0PP9QNSDbhnF22Hsd7zqfSWTy0TXizlY9+iI7W9suaXAdu
 ohI3lBeDdFZquPmg9i4jR3BmMtV8jDk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1740580280;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hwGPWqxoxWrUhKtQSh1tXrjsSNnP+VDuLf0TjPEgnSo=;
 b=N6tMOLEpQp/9TrqMXZImk05uIqETZRBAF7QpiEHXR4j+Xs2Cts7lBfmSCsqEa1EZaIyhII
 sk5qHWqTpv2KbyAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D373B1377F;
 Wed, 26 Feb 2025 14:31:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lqP5KLclv2edRQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 26 Feb 2025 14:31:19 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 26 Feb 2025 15:31:11 +0100
Message-ID: <20250226143113.3016480-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
X-Rspamd-Queue-Id: 853FD1F387
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim, suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/3] setup_tests: Sort variables alphabetically
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

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/users/setup_tests.rst | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/doc/users/setup_tests.rst b/doc/users/setup_tests.rst
index 2766ed719c..ddcf00f027 100644
--- a/doc/users/setup_tests.rst
+++ b/doc/users/setup_tests.rst
@@ -42,18 +42,11 @@ users.
      - Path to the block device to be used. C Language: ``.needs_device = 1``.
        Shell language: ``TST_NEEDS_DEVICE=1``.
 
-   * - LTP_SINGLE_FS_TYPE
-     - Testing only - specifies filesystem instead all supported
-       (for tests with ``.all_filesystems``).
-
    * - LTP_DEV_FS_TYPE
      - Filesystem used for testing (default: ``ext2``).
 
-   * - LTP_TIMEOUT_MUL
-     - Multiplies timeout, must be number >= 0.1 (> 1 is useful for slow
-       machines to avoid unexpected timeout). It's mainly for shell API, which
-       does not have LTP_RUNTIME_MUL. In C API it scales the default 30 sec
-       safety margin, probably LTP_RUNTIME_MUL should be used instead.
+   * - LTP_IMA_LOAD_POLICY
+     - Load IMA example policy, see :master:`testcases/kernel/security/integrity/ima/README.md`.
 
    * - LTP_RUNTIME_MUL
      - Multiplies maximal test iteration runtime. Tests that run for more than a
@@ -61,8 +54,15 @@ users.
        both up and down with this multiplier. This is not yet implemented in the
        shell API.
 
-   * - LTP_IMA_LOAD_POLICY
-     - Load IMA example policy, see :master:`testcases/kernel/security/integrity/ima/README.md`.
+   * - LTP_SINGLE_FS_TYPE
+     - Testing only - specifies filesystem instead all supported
+       (for tests with ``.all_filesystems``).
+
+   * - LTP_TIMEOUT_MUL
+     - Multiplies timeout, must be number >= 0.1 (> 1 is useful for slow
+       machines to avoid unexpected timeout). It's mainly for shell API, which
+       does not have LTP_RUNTIME_MUL. In C API it scales the default 30 sec
+       safety margin, probably LTP_RUNTIME_MUL should be used instead.
 
    * - LTP_VIRT_OVERRIDE
      - Overrides virtual machine detection in the test library. Setting it to
-- 
2.47.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
