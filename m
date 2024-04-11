Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 513B6C4345F
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 14:38:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DABED3CF820
	for <ltp@archiver.kernel.org>; Thu, 11 Apr 2024 16:38:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 016063CF832
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:35 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 931CC1A05C9C
 for <ltp@lists.linux.it>; Thu, 11 Apr 2024 16:30:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1C954375A8;
 Thu, 11 Apr 2024 14:30:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIw/fDYXWZAL78pMJbS9anG1GRvFWT3Lf9kw153tY/U=;
 b=w+8l8lVyJL/eJxDTlK1oqIn6pKl65+3nAlHHCXZWycaHncMfDhT7dHg+G/RXxTGJD/6YD5
 AF/v1h8CVHZ4W77DQGdohux/jzhLMYytO9vWsddRX479kgB8+2WIHk3/84N2lLS2Zn0x93
 J6xT0H3aExUiiZXFU2p4txcXmc54qDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIw/fDYXWZAL78pMJbS9anG1GRvFWT3Lf9kw153tY/U=;
 b=FkbsrKoJOL6FwDJgidB2hKTO1q3/TJc0omOC4/OfxccI8fmSzJrbMSqUMqBYxX3ylHH2vc
 re5/u8EcSKV3WBAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=w+8l8lVy;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=FkbsrKoJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1712845835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIw/fDYXWZAL78pMJbS9anG1GRvFWT3Lf9kw153tY/U=;
 b=w+8l8lVyJL/eJxDTlK1oqIn6pKl65+3nAlHHCXZWycaHncMfDhT7dHg+G/RXxTGJD/6YD5
 AF/v1h8CVHZ4W77DQGdohux/jzhLMYytO9vWsddRX479kgB8+2WIHk3/84N2lLS2Zn0x93
 J6xT0H3aExUiiZXFU2p4txcXmc54qDg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1712845835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIw/fDYXWZAL78pMJbS9anG1GRvFWT3Lf9kw153tY/U=;
 b=FkbsrKoJOL6FwDJgidB2hKTO1q3/TJc0omOC4/OfxccI8fmSzJrbMSqUMqBYxX3ylHH2vc
 re5/u8EcSKV3WBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E25A91386E;
 Thu, 11 Apr 2024 14:30:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cHzANAr0F2ZZRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 11 Apr 2024 14:30:34 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 11 Apr 2024 16:30:25 +0200
Message-ID: <20240411143025.352507-32-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411143025.352507-1-pvorel@suse.cz>
References: <20240411143025.352507-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1C954375A8
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 31/31] doc: UCLINUX has been removed
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
 doc/maintainers/patch_review.rst                   | 4 ----
 doc/old/Maintainer-Patch-Review-Checklist.asciidoc | 3 ---
 2 files changed, 7 deletions(-)

diff --git a/doc/maintainers/patch_review.rst b/doc/maintainers/patch_review.rst
index 3ff8122a8..0561ffd9d 100644
--- a/doc/maintainers/patch_review.rst
+++ b/doc/maintainers/patch_review.rst
@@ -152,10 +152,6 @@ C tests
 * Docparse documentation
 * If a test is a regression test it should include ``.tags`` in the
   ``struct tst_test`` definition
-* When rewriting old tests, `uClinux <https://en.wikipedia.org/wiki/%CE%9CClinux>`_
-  support should be removed (project has been discontinued).
-  E.g. remove ``#ifdef UCLINUX``, replace ``FORK_OR_VFORK()`` with simple
-  ``fork()`` or ``SAFE_FORK()``.
 
 Shell tests
 ~~~~~~~~~~~
diff --git a/doc/old/Maintainer-Patch-Review-Checklist.asciidoc b/doc/old/Maintainer-Patch-Review-Checklist.asciidoc
index 9cd8606f9..8977b7585 100644
--- a/doc/old/Maintainer-Patch-Review-Checklist.asciidoc
+++ b/doc/old/Maintainer-Patch-Review-Checklist.asciidoc
@@ -127,9 +127,6 @@ New test should
 * Docparse documentation
 * If a test is a regression test it should include tags
   (more in https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#2238-test-tags[Test tags])
-* When rewriting old tests, https://en.wikipedia.org/wiki/%CE%9CClinux[uClinux]
-  support should be removed (project has been discontinued).
-  E.g. remove `#ifdef UCLINUX`, replace `tst_fork()` with simple `fork()` or `SAFE_FORK()`.
 
 ### Shell tests
 * Use new https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#23-writing-a-testcase-in-shell[shell API]
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
