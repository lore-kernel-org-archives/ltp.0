Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B02AECE79C2
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 10:41:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 12FF23CE317
	for <ltp@archiver.kernel.org>; Wed, 20 Sep 2023 12:41:53 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27CAE3CA4C4
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 12:41:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3431A1A0BC2E
 for <ltp@lists.linux.it>; Wed, 20 Sep 2023 12:41:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 104442211B;
 Wed, 20 Sep 2023 10:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695206501; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HC0YnXdYz5UHo37NQ8HEGgaqFyeWC0V+sKw+ix4JSxc=;
 b=2JH56xeaVZXQbLD6afPSqT3fLcBtfGrOVKfR309jdt2FiTaslsRmRJRVcgjSEKev8zq2xo
 /Km2tNEfxSMKNRfLMBz9YLDtIAC1QCYY8Od08GXtdhDsV/XjG/ESLLY+9bknh8keO1YRsI
 WYpfEASJW81jEmi39d4/oZiQAx+mlQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695206501;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=HC0YnXdYz5UHo37NQ8HEGgaqFyeWC0V+sKw+ix4JSxc=;
 b=00bh+beDCreeC+WiC7TruRUE5bnb+yBFEMbM8496/HmCUkz6IPJH1ij0L6kTTlcQ5HSAQq
 q2qd1FiCrdPQUACg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D6246132C7;
 Wed, 20 Sep 2023 10:41:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HfMTM2TMCmUHIAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 20 Sep 2023 10:41:40 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 20 Sep 2023 12:41:38 +0200
Message-Id: <20230920104138.348848-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] Remove Makefile.release
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

We now prefer to do local clone instead of make distclean.

Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 Makefile.release | 46 ----------------------------------------------
 1 file changed, 46 deletions(-)
 delete mode 100644 Makefile.release

diff --git a/Makefile.release b/Makefile.release
deleted file mode 100644
index c81925de5..000000000
--- a/Makefile.release
+++ /dev/null
@@ -1,46 +0,0 @@
-#
-#    Release Makefile for LTP.
-#
-#    Copyright (C) 2010, Copyrights-are-for-losers, Inc.
-#
-#    This program is free software; you can redistribute it and/or modify
-#    it under the terms of the GNU General Public License as published by
-#    the Free Software Foundation; either version 2 of the License, or
-#    (at your option) any later version.
-#
-#    This program is distributed in the hope that it will be useful,
-#    but WITHOUT ANY WARRANTY; without even the implied warranty of
-#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-#    GNU General Public License for more details.
-#
-#    You should have received a copy of the GNU General Public License along
-#    with this program; if not, write to the Free Software Foundation, Inc.,
-#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
-#
-# Invoke like:
-#
-#	make -f Makefile.release release TARBALL_VERSION=FOO
-#
-# Cheers.
-#
-
-top_srcdir	?= $(CURDIR)
-
-include $(top_srcdir)/include/mk/env_pre.mk
-include $(top_srcdir)/include/mk/automake.mk
-
-TARBALL_PREFIX	?= ltp
-
-ifneq ($(wildcard $(top_srcdir)/Version),)
-TARBALL_VERSION	?= $(shell $(top_srcdir)/Version)
-endif
-
-TARBALL_VERSION	?= $(error you must either make Version via make $$PWD/Version or specify an LTP version via TARBALL_VERSION)
-
-TARBALL		:= $(TARBALL_PREFIX)-$(TARBALL_VERSION).tgz
-
-clean:
-	$(MAKE) -f Makefile $@
-
-release: | autotools distclean
-	tar -cvz --exclude "$(TARBALL)" -f $(TARBALL) .
-- 
2.40.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
