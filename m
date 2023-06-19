Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF161EB64D9
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 16:33:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 151B03CC515
	for <ltp@archiver.kernel.org>; Mon, 19 Jun 2023 18:33:14 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE0CF3CB004
 for <ltp@lists.linux.it>; Mon, 19 Jun 2023 18:33:02 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E26E0200901
 for <ltp@lists.linux.it>; Mon, 19 Jun 2023 18:33:01 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E07071F86B;
 Mon, 19 Jun 2023 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687192380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NmfGtWpbtOtfEZ0yGUzV14Y9zQKkCXv+EwA/3zFr0iA=;
 b=1WZqyD1A/lGcAreZnzwHLxYMMHIgmPeqq/M78YObz4fDFIXAn86MkjWL6Rl4YNoXhG+Tus
 ySBtjzkyJoN5w6G9DHOoIfB3AnS3kl2lvKNMqwY0lQld4fcTD4J9rzC67L+yYt8vRnY0xJ
 SFADLTXNukrlXz0PZdnwIQUc1f1OMfw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687192380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=NmfGtWpbtOtfEZ0yGUzV14Y9zQKkCXv+EwA/3zFr0iA=;
 b=GQIdXtXxhyXy8IlF3xW05+raBYvDFHPTO5AsODa8cCqPqkdKnRAG6QCwkyCO8K1qLS7txu
 lF7lkOeaqrOMwbBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0A96138E8;
 Mon, 19 Jun 2023 16:33:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 4hUyITyDkGTcXQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 19 Jun 2023 16:33:00 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Mon, 19 Jun 2023 18:32:55 +0200
Message-Id: <20230619163255.234848-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] ci: Don't test doc generation on Debian oldstable
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

HTML generation with asciidoc is broken on Debian 11 bullseye
(the new Debian oldstable):

a2x: ERROR: "xsltproc" --stringparam toc.section.depth 1 --stringparam
callout.graphics 0 --stringparam navig.graphics 0 --stringparam
admon.textlabel 1 --stringparam admon.graphics 0 --stringparam
chunk.section.depth 0  --output "/__w/ltp/ltp/docparse/metadata.html"
"/etc/asciidoc/docbook-xsl/xhtml.xsl"
"/__w/ltp/ltp/docparse/metadata.xml" returned non-zero exit status 5

First reason is that docbook2x is needed to get required XSL (broken
dependency, which is fixed on newer Debian versions).

But even with it being installed, it still does not work on GitHub
Actions, due somehow special network, e.g. ping 8.8.8.8 does not work
(firewall?), code working in distro running via podman locally fails on CI:

$ cd metadata && make
error : Unknown IO error
warning: failed to load external entity "http://docbook.sourceforge.net/release/xsl/current/xhtml/docbook.xsl"
compilation error: file /etc/asciidoc/docbook-xsl/xhtml.xsl line 12 element import
xsl:import : unable to load http://docbook.sourceforge.net/release/xsl/current/xhtml/docbook.xsl

Because asciidoc is tested on other distros, simply remove the test.

Reported-by: Li Wang <liwang@redhat.com>
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 .github/workflows/ci.yml | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/.github/workflows/ci.yml b/.github/workflows/ci.yml
index d8e5dca86..d7e9f2dd0 100644
--- a/.github/workflows/ci.yml
+++ b/.github/workflows/ci.yml
@@ -1,4 +1,4 @@
-# Copyright (c) 2021 Petr Vorel <pvorel@suse.cz>
+# Copyright (c) 2021-2023 Petr Vorel <pvorel@suse.cz>
 
 name: "CI: docker based builds"
 on: [push, pull_request]
@@ -79,7 +79,6 @@ jobs:
           - container: "debian:oldstable"
             env:
               CC: clang
-              METADATA: asciidoc-pdf
 
           - container: "opensuse/leap"
             env:
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
