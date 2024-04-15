Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A47E9C04FF9
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 09:18:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A59DC3CF9EF
	for <ltp@archiver.kernel.org>; Mon, 15 Apr 2024 11:18:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C924B3CC3F4
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 11:18:10 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 39BDE1A01143
 for <ltp@lists.linux.it>; Mon, 15 Apr 2024 11:18:09 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EAC4122B10;
 Mon, 15 Apr 2024 09:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713172689; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9yNkdPFBuhCu/AKiPi4RZxfg7TVu7XxcO+oqi734L6c=;
 b=GYzAY+lVYgxwfXtAeVrTfQJyboycprsyzjS8C73C4k1Lu/jAndC0sgC3F87t6YO+Pj7gIS
 LBmhOwhbh/Ih1bKHPBYVf4ruc5oZffsPoiqCITAWfhbGxmbNaNrCBE0HmAGuLtb50ysqrj
 TyFfeA6ru9vlkmuGKjMWUiJzudEAnp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713172689;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9yNkdPFBuhCu/AKiPi4RZxfg7TVu7XxcO+oqi734L6c=;
 b=i8IQgQtA8NIJKaQHg75Q/b6s8SiAYrMVE+FZIbw39R94KjKLC+aIDqJxTAO4R9+LCkiIdo
 x7FI0yKG50I5lcDg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1713172688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9yNkdPFBuhCu/AKiPi4RZxfg7TVu7XxcO+oqi734L6c=;
 b=XvysLDZXqKLCqY3fFP4QYvcH8g3yPPohPgMQXzGC6dLm7XNU/NPK/OcO0h+81gkFsF6oZm
 gqvobYVevpTz3S3fyPc5X68nSCqZEE+/G9wunVd5jIrI4elyu+qwG9R19OUTQdK1Cun7nF
 y3GyDY4x2nciTJPRM8+RcSLGnU5n78I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1713172688;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=9yNkdPFBuhCu/AKiPi4RZxfg7TVu7XxcO+oqi734L6c=;
 b=RIIDhWiGI13hBWxHf9WFcBfiaJzRVZR5bF7XA4h7B2TyPUUbdHU48ns7HMExoNDfWq2+RF
 ftzYOl/PtgxJP3Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E7871368B;
 Mon, 15 Apr 2024 09:18:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id T4BKINDwHGbkOgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Mon, 15 Apr 2024 09:18:08 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
To: ltp@lists.linux.it
Date: Mon, 15 Apr 2024 11:18:06 +0200
Message-Id: <20240415091806.18556-1-andrea.cervesato@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.75 / 50.00]; BAYES_HAM(-2.95)[99.77%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] doc: Add section for C API documentation
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

Added information about the C API documentation format and the way
it's supported in Sphinx.

Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
---
 doc/developers/documentation.rst | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/doc/developers/documentation.rst b/doc/developers/documentation.rst
index 5b112bcaf..30dacd384 100644
--- a/doc/developers/documentation.rst
+++ b/doc/developers/documentation.rst
@@ -47,3 +47,11 @@ To check documentation words spelling, we provide support for
 documentation can be tested via ``make spelling`` command. Output will be
 visible in the ``doc/build`` folder and, if any error will be found, a warning
 message will be shown.
+
+C API documentation
+~~~~~~~~~~~~~~~~~~~
+
+The C API documentation is written using
+`kernel-doc <https://return42.github.io/linuxdoc/linuxdoc-howto/kernel-doc-syntax.html>`_
+syntax which is supported by Sphinx via
+`linuxdoc <https://pypi.org/project/linuxdoc/>`_ extension.
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
