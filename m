Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51260606A324
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 04:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=pVQYHcDA
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A99AA3E2B3B
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 05:53:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A2B7B3E1FDA
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 05:53:38 +0100 (CET)
Received: from mta0.migadu.com (out-231.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::e7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 749601400518
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 05:53:36 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=/ZBRSwVAjh3uLKk5HVMvWe5HiPV8XBtiAvbQPsHRH3M=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793595215; v=1; x=1794200015;
 b=pVQYHcDAbwVsZQcB54PGfDmHO5omH4ZC6VHwxVakcs113wci2rnYBNCdfecEgXsD0vd7Z5MJ
 bwP3nQaLeTG1d8ZqYYPaVTfQPy1rqKV7zFvGpmPfThKutSXN86k8PCUoUPnqZTw6BAv5X1W9mDi
 0P7CJ0bJbJYa2m1MHSzrKKqI=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 9dda9fc0e01383bb;
 Mon, 02 Nov 2026 04:53:35 +0000
X-Mizu-Trace-ID: 9dda9fc0e01383bb
X-Migadu-Flow: FLOW_OUT
Date: Mon, 2 Nov 2026 12:53:33 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
Message-ID: <augXTY2GNZtRrGWP@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20261021-build_system_optimize-v3-0-71a3c4c6f937@suse.com>
 <20261021-build_system_optimize-v3-2-71a3c4c6f937@suse.com>
 <augF5SbHd8Kk2KOG@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <augF5SbHd8Kk2KOG@linux.dev>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] build: Build shared libs once on subtree
 make
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> ifeq ($(MAKELEVEL),0)
> 
> ifneq ($(filter $(abs_top_builddir)/testcases%,$(CURDIR)),)
> 
> MAKE_DEPS += $(abs_top_builddir)/lib/libltp.a
> MAKE_DEPS += $(abs_top_builddir)/libs-all
> 
> $(abs_top_builddir)/lib/libltp.a:
> 	$(MKDIR_P) "$(@D)"

Sorry, LTP doesn't define MKDIR_P, then just:

mkdir -m 00755 -p "$(@D)"

> 	$(MAKE) -C "$(@D)" -f "$(abs_top_srcdir)/lib/Makefile" all
> 
> .PHONY: $(abs_top_builddir)/libs-all
> $(abs_top_builddir)/libs-all: $(LTPLIBS_FILES)
> 	$(MKDIR_P) "$(@D)"

mkdir -m 00755 -p "$(@D)"

> 	$(MAKE) -C "$(@D)" -f "$(abs_top_srcdir)/libs/Makefile" all
> 
> endif
> 
> ifneq ($(filter $(abs_top_builddir)/testcases/kernel/%,$(CURDIR)),)
> 
> MAKE_DEPS += $(abs_top_builddir)/testcases/kernel/lib/libkerntest.a
> 
> $(abs_top_builddir)/testcases/kernel/lib/libkerntest.a:
> 	$(MKDIR_P) "$(@D)"

mkdir -m 00755 -p "$(@D)"

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
