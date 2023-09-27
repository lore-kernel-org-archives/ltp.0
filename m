Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2602BE82CD2
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 20:22:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A75D33CDC30
	for <ltp@archiver.kernel.org>; Wed, 27 Sep 2023 22:22:38 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 57F7A3CBA91
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 22:21:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D06B61A00EAC
 for <ltp@lists.linux.it>; Wed, 27 Sep 2023 22:21:27 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7DB181F895;
 Wed, 27 Sep 2023 20:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695846087; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HC0YnXdYz5UHo37NQ8HEGgaqFyeWC0V+sKw+ix4JSxc=;
 b=LMhFezTEcqX43u3z15yOM3h+42bXsHNajyPfDW5WF61fCjWOn1OEajYCdD2XhsLpNpI2fC
 0OsqmTU9lkeyYKMKJPem/IG5rxQS2+MadKTZe+fexd6W3ojSr4b3VXQQfdhp8407JVNIVJ
 47GNKmvmbGw2W5vr0JU/SesEdOolhwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695846087;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HC0YnXdYz5UHo37NQ8HEGgaqFyeWC0V+sKw+ix4JSxc=;
 b=BGSqhj/oixzQFWCw7B6FPcPrPuudtx2lu+94Uu+iaJVXa3XirgqM1gEHbBAFulw+jDO+j6
 EpnDFADRt/n2neAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0F39713479;
 Wed, 27 Sep 2023 20:21:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eAGyAceOFGWGewAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Sep 2023 20:21:27 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 27 Sep 2023 22:21:21 +0200
Message-Id: <20230927202121.300325-7-pvorel@suse.cz>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230927202121.300325-1-pvorel@suse.cz>
References: <20230927202121.300325-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 6/6] Remove Makefile.release
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
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
