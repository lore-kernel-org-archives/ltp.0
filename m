Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484ABC7114A
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 06:51:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EC393CB861
	for <ltp@archiver.kernel.org>; Tue, 17 Jun 2025 08:51:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D08103CA644
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 08:51:14 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 52D78140006D
 for <ltp@lists.linux.it>; Tue, 17 Jun 2025 08:51:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E3D2B21210;
 Tue, 17 Jun 2025 06:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750143073; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mKKe5itTzUdNmwYhBaGXHVm8vPSLkLVYeEe3BpVs95o=;
 b=ZmqJWTkU+IOA7CLsrs3ia+8Uo87sWyJ6q7cDnwCkn8xet6t4bjhrOG0wpAb8vic0HXMXYt
 0e2cul40r7Nj55UJNjay2vMLrf50yqzSm2KH3mVNg3/vwjiru+DqnEHLKSa142zYKJk/UP
 UY/E/MzF0Ks5JZ+9nOsZnmlZAXcDYFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750143073;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mKKe5itTzUdNmwYhBaGXHVm8vPSLkLVYeEe3BpVs95o=;
 b=z/OOUUDz3P3nfPEXgnrbUxWXw7Qf2Ne/mFWVY00UNxxtcdFYIva9WkOOBaKZu57jRoF2fs
 nQDRd7wNLmgzzbCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1750143072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mKKe5itTzUdNmwYhBaGXHVm8vPSLkLVYeEe3BpVs95o=;
 b=YRTAVSFcEX4IirEkqRQdCFDGN9VcqTl9Ljo7jiWcegT+aNabK2uyHkWgSaZXqmoScrJtrc
 0UlE94ucr5WgPtoJeJE3BWoLY4lmbj4lJk6fRr7FmneYAA5X83aoS35zz+lBh9vP+9iR9G
 2IiJhC+go6hWyRaBZXzBQqIWCLyV+0M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1750143072;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mKKe5itTzUdNmwYhBaGXHVm8vPSLkLVYeEe3BpVs95o=;
 b=FXZ2Lb0GR5WX35MRHCR/RvaR2SQoYJGR4OuO7OHyImuAXKHKHYrZABVdVy5RuqJ7K6nWLA
 p+aaoUA8UEjGnhDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B4F35139E2;
 Tue, 17 Jun 2025 06:51:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vYO1KWAQUWg5VwAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Tue, 17 Jun 2025 06:51:12 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 17 Jun 2025 08:51:07 +0200
MIME-Version: 1.0
Message-Id: <20250617-ci_docs_build_fix-v1-1-7d0654f0cd7d@suse.com>
X-B4-Tracking: v=1; b=H4sIAFoQUWgC/x2MQQqAIBAAvxJ7Tkghzb4SIaZrLYSFUgTS35OOM
 zBTIGMizDA2BRLelOmIFXjbgNtsXJGRrwyiE30nuWKOjD9cNstFuzeBHsaDCFpJO2jloXZnwqr
 /5zS/7wckWLJVYwAAAA==
X-Change-ID: 20250617-ci_docs_build_fix-1f2f976a897d
To: ltp@lists.linux.it
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750143072; l=873;
 i=andrea.cervesato@suse.com; s=20240812; h=from:subject:message-id;
 bh=+z3egFP3rmBQoQO5cmK+pUyuuIGeQ+ijEy5Bti1FP9o=;
 b=j0mz7fTsVPkdzAec+VcmDppIl3xNNcGJIi86mNI8paZBiMBlGe9Qi7+3uwu4bjUgZmUrPEoXt
 wINN0PyuJTrD7g0ji2/99KLgwQA3cmm0UdQtR/a3LJp6vVeySDWOz38
X-Developer-Key: i=andrea.cervesato@suse.com; a=ed25519;
 pk=RG/nLJ5snb1tLKGwSORQXBJ5XA4juT0WF2Pc/lq9meo=
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.com:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ci: revert "Run sphinx test only when files changed"
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

Revert 180bc2bb9 in order to build documentation when pushing
to the master branch.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 .github/workflows/ci-sphinx-doc.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/ci-sphinx-doc.yml b/.github/workflows/ci-sphinx-doc.yml
index e77c766871b98114417dc7d8d1cb108afe885735..457aa5a2355d1d93db243090ca31b1c634338b25 100644
--- a/.github/workflows/ci-sphinx-doc.yml
+++ b/.github/workflows/ci-sphinx-doc.yml
@@ -5,7 +5,8 @@ name: "Test building sphinx doc"
 
 on:
   push:
-    paths: ['doc/**']
+    branches:
+    - master
   pull_request:
     paths: ['doc/**']
 

---
base-commit: 2bce711e96004e619d51170302bf7ce9162f1231
change-id: 20250617-ci_docs_build_fix-1f2f976a897d

Best regards,
-- 
Andrea Cervesato <andrea.cervesato@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
