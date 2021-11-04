Return-Path: <SRS0=esfC=PX=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E77AC433EF
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 16:06:48 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 605AC604DC
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 16:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 605AC604DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CCB853C737F
	for <ltp@archiver.kernel.org>; Thu,  4 Nov 2021 17:06:45 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 020423C6A5E
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 17:06:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CFA2B20076D
 for <ltp@lists.linux.it>; Thu,  4 Nov 2021 17:06:35 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E140E218B5;
 Thu,  4 Nov 2021 16:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636041994;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q/xW3Y0Yq2v9x+V4CboFieE/MaKeF1tjq84TRUWbhBg=;
 b=gP5OSZ4d47G0+di7Pa/v0XUYijTsbAZnP1R2aiVDp6jWDf9oLJfrQvVEFxPRxsxVSISqmy
 LjocZodXAPP+w0vL6Fuf2I+pSJnfzFuhJetsKS71O2ua2KxCDNlsdJ9RFZVrEbdzgU3w41
 3M47aWcY1Erc2TMzPfGvIzhYxINtOPE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636041994;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q/xW3Y0Yq2v9x+V4CboFieE/MaKeF1tjq84TRUWbhBg=;
 b=OFD2B4DKQxy0m1lI/JW2cd6zuyxTprRPvz6+dWSlWajzE55jNI5DhtHup6yh3BT7ePMPhu
 V06WF3mKaKTu+KBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA5BE13DA2;
 Thu,  4 Nov 2021 16:06:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2VhRDwkFhGE9AwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 04 Nov 2021 16:06:33 +0000
Date: Thu, 4 Nov 2021 17:06:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YYQE+v9ACqVwOc9m@pevik>
References: <20211103120233.20728-1-chrubis@suse.cz>
 <20211103120233.20728-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211103120233.20728-3-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/7] docparse: Add tests
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> diff --git a/docparse/tests/Makefile b/docparse/tests/Makefile
> new file mode 100644
> index 000000000..b5c8c4668
> --- /dev/null
> +++ b/docparse/tests/Makefile
> @@ -0,0 +1,4 @@
> +all:
> +
> +test:
> +	@./test.sh
How about
1) Run test as default (all: test)?
2) Propagate test target into docparse/Makefile
3) Run docparse testing as part of make test
4) Be more verbose about running docparse tests

These are in patch below.

Also part of lib/newlib_tests/runtest.sh could be put into separate file, which
could be reused in docparse/tests/test.sh (color etc), but that should be postponed
to later to not blocking this patchset.

Kind regards,
Petr

diff --git Makefile Makefile
index 4e37362f9..9ead7b205 100644
--- Makefile
+++ Makefile
@@ -210,6 +210,7 @@ ifneq ($(build),$(host))
 	$(error running tests on cross-compile build not supported)
 endif
 	$(call _test)
+	$(MAKE) test-docparse
 
 test-c: lib-all
 ifneq ($(build),$(host))
@@ -223,6 +224,9 @@ ifneq ($(build),$(host))
 endif
 	$(call _test,-s)
 
+test-docparse:
+	$(MAKE) -C docparse/tests test
+
 ## Help
 .PHONY: help
 help:
diff --git docparse/Makefile docparse/Makefile
index e2defad38..7764d1dc1 100644
--- docparse/Makefile
+++ docparse/Makefile
@@ -74,4 +74,9 @@ metadata.pdf: txt
 	$(METADATA_GENERATOR_CMD) $(METADATA_GENERATOR_PARAMS) $(METADATA_GENERATOR_PARAMS_PDF)
 endif
 
+.PHONY: test
+
+test: metadata.json
+	$(MAKE) -C tests $@
+
 include $(top_srcdir)/include/mk/generic_leaf_target.mk
diff --git docparse/tests/Makefile docparse/tests/Makefile
index b5c8c4668..69131ffad 100644
--- docparse/tests/Makefile
+++ docparse/tests/Makefile
@@ -1,4 +1,5 @@
-all:
+all: test
 
 test:
+	$(info Testing docparse)
 	@./test.sh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
