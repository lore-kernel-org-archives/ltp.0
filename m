Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 128C8C54E58
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 16:23:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 889643D003F
	for <ltp@archiver.kernel.org>; Wed, 20 Mar 2024 17:23:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1715B3CFC01
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:20:49 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=andrea.cervesato@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7B26C1001197
 for <ltp@lists.linux.it>; Wed, 20 Mar 2024 17:20:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 377A75BF35;
 Wed, 20 Mar 2024 16:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710951647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1dkt8YX+TMv5z1xXSNuz74AcCbSvGz0JwFu4zkjpe4=;
 b=f+ru530t87J5214kre3aQQnPXSs8zgASRwy3q+xWWXaWIoNmVrIrShlcl04wPpavq1YqGU
 oksLnfKzRpT9wD2mni1ZxqDivHNAay8Ld/qyqWGVXjfZ+K7IEsrqDRI0RQX1j9Y/aYw95b
 Po87U+7r9lI+86uhMqJ4Tmng9KBUa/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710951647;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1dkt8YX+TMv5z1xXSNuz74AcCbSvGz0JwFu4zkjpe4=;
 b=99o8lkIZ//fxhDo3zoiHGd5w9qZy0UC70nFC9EBefa8yh886fnYxmW8hdBczoPmvXDw1VE
 rLhymTgIK80DUrBg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1710951647; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1dkt8YX+TMv5z1xXSNuz74AcCbSvGz0JwFu4zkjpe4=;
 b=f+ru530t87J5214kre3aQQnPXSs8zgASRwy3q+xWWXaWIoNmVrIrShlcl04wPpavq1YqGU
 oksLnfKzRpT9wD2mni1ZxqDivHNAay8Ld/qyqWGVXjfZ+K7IEsrqDRI0RQX1j9Y/aYw95b
 Po87U+7r9lI+86uhMqJ4Tmng9KBUa/Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1710951647;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1dkt8YX+TMv5z1xXSNuz74AcCbSvGz0JwFu4zkjpe4=;
 b=99o8lkIZ//fxhDo3zoiHGd5w9qZy0UC70nFC9EBefa8yh886fnYxmW8hdBczoPmvXDw1VE
 rLhymTgIK80DUrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21544136D6;
 Wed, 20 Mar 2024 16:20:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4G/gBt8M+2U/ZgAAD6G6ig
 (envelope-from <andrea.cervesato@suse.de>); Wed, 20 Mar 2024 16:20:47 +0000
From: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 20 Mar 2024 17:20:54 +0100
MIME-Version: 1.0
Message-Id: <20240320-new_website-v1-10-79b603c8aea1@suse.com>
References: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
In-Reply-To: <20240320-new_website-v1-0-79b603c8aea1@suse.com>
To: ltp@lists.linux.it
X-Mailer: b4 0.13.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=f+ru530t;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=99o8lkIZ
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[31.82%]
X-Rspamd-Queue-Id: 377A75BF35
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 10/10] Introduce kernel-doc API support
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

kernel-doc API support is introduced by linuxdoc package that includes
Linux kernel tools used to generate the documentation.
With this patch we fully support the kernel documentation format that
can be found here:

https://return42.github.io/linuxdoc/linuxdoc-howto/kernel-doc-syntax.html
---
 doc_new/conf.py                          | 3 +--
 doc_new/developers/api_c_tests.rst       | 3 +++
 doc_new/developers/api_kvm_tests.rst     | 3 +++
 doc_new/developers/api_network_tests.rst | 3 +++
 doc_new/requirements.txt                 | 1 +
 5 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/doc_new/conf.py b/doc_new/conf.py
index b333ebf2a..44122b761 100644
--- a/doc_new/conf.py
+++ b/doc_new/conf.py
@@ -14,8 +14,7 @@ release = '1.0'
 # -- General configuration ---------------------------------------------------
 # https://www.sphinx-doc.org/en/master/usage/configuration.html#general-configuration
 
-extensions = []
-
+extensions = ['linuxdoc.rstKernelDoc']
 
 # -- Options for HTML output -------------------------------------------------
 # https://www.sphinx-doc.org/en/master/usage/configuration.html#options-for-html-output
diff --git a/doc_new/developers/api_c_tests.rst b/doc_new/developers/api_c_tests.rst
index c03f9caf1..adee17f16 100644
--- a/doc_new/developers/api_c_tests.rst
+++ b/doc_new/developers/api_c_tests.rst
@@ -1,4 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
+.. Include headers in this file with:
+.. .. kernel-doc:: ../../include/tst_test.h
+
 Developing using C API
 ======================
diff --git a/doc_new/developers/api_kvm_tests.rst b/doc_new/developers/api_kvm_tests.rst
index 1ef7ec452..5ec3fc3a4 100644
--- a/doc_new/developers/api_kvm_tests.rst
+++ b/doc_new/developers/api_kvm_tests.rst
@@ -1,4 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
+.. Include headers in this file with:
+.. .. kernel-doc:: ../../include/tst_test.h
+
 Developing using KVM API
 ========================
diff --git a/doc_new/developers/api_network_tests.rst b/doc_new/developers/api_network_tests.rst
index 4fe45f5f6..3e487d7f2 100644
--- a/doc_new/developers/api_network_tests.rst
+++ b/doc_new/developers/api_network_tests.rst
@@ -1,4 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0-or-later
 
+.. Include headers in this file with:
+.. .. kernel-doc:: ../../include/tst_test.h
+
 Developing using network API
 ============================
diff --git a/doc_new/requirements.txt b/doc_new/requirements.txt
index 59709ec72..720e6870e 100644
--- a/doc_new/requirements.txt
+++ b/doc_new/requirements.txt
@@ -1 +1,2 @@
 sphinx-rtd-theme==2.0.0
+linuxdoc==20231020

-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
