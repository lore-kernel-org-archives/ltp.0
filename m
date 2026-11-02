Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DBE606A324
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 03:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F/zU69NG
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 016B73E2A26
	for <ltp@archiver.kernel.org>; Mon,  2 Nov 2026 04:39:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 601113E1FEB
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 04:39:27 +0100 (CET)
Received: from mta0.migadu.com (out-170.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::aa])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 98ED0100075F
 for <ltp@lists.linux.it>; Mon,  2 Nov 2026 04:39:25 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=aGEAP+QmcH4+E/i9ALfGo3F6e6WtYiQdADxLo8YZ1b4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793590764; v=1; x=1794195564;
 b=F/zU69NGym+FH6RZp/Daj/+4YiWqWmxbp3Jy80OMmXmPVFK6/xJi3A9wCncGOHdLw9/v7Hip
 suANEd1/W47rKKyIyc20yzPP55PFoQamGTxA38GyuafkaVr23WVuvUcBZ47DWzveJUr2QoBdCtS
 dlY/2t9Sm3/UD+BOsaC6sBkw=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id f3e07755182db74e;
 Mon, 02 Nov 2026 03:39:24 +0000
X-Mizu-Trace-ID: f3e07755182db74e
X-Migadu-Flow: FLOW_OUT
Date: Mon, 2 Nov 2026 11:39:17 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <augF5SbHd8Kk2KOG@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20261021-build_system_optimize-v3-0-71a3c4c6f937@suse.com>
 <20261021-build_system_optimize-v3-2-71a3c4c6f937@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261021-build_system_optimize-v3-2-71a3c4c6f937@suse.com>
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Oct 21, 2026 at 10:11:29AM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> When make is invoked directly in a trunk subdirectory (MAKELEVEL == 0),
> build shared prerequisites (libltp.a, libs, and libkerntest.a) once
> via MAKE_DEPS before launching parallel subdirectory builds.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  include/mk/generic_trunk_target.inc | 23 +++++++++++++++++++++++
>  1 file changed, 23 insertions(+)
> 
> diff --git a/include/mk/generic_trunk_target.inc b/include/mk/generic_trunk_target.inc
> index f9db7896a..aa8e500e1 100644
> --- a/include/mk/generic_trunk_target.inc
> +++ b/include/mk/generic_trunk_target.inc
> @@ -36,6 +36,29 @@ RECURSIVE_TARGETS		?= all install check
>  
>  $(eval $(get_make_dirs))
>  
> +ifeq ($(MAKELEVEL),0)
> +ifneq ($(filter $(abs_top_builddir)/testcases%,$(CURDIR)),)
> +MAKE_DEPS += $(abs_top_builddir)/lib/libltp.a $(abs_top_builddir)/libs-all
> +
> +$(abs_top_builddir)/lib/libltp.a:
> +	mkdir -m 00755 -p "$(abs_top_builddir)/lib"
> +	$(MAKE) -C "$(abs_top_builddir)/lib" -f "$(abs_top_srcdir)/lib/Makefile" all
> +
> +.PHONY: $(abs_top_builddir)/libs-all
> +$(abs_top_builddir)/libs-all: $(LTPLIBS_FILES)
> +	mkdir -m 00755 -p "$(abs_top_builddir)/libs"
> +	$(MAKE) -C "$(abs_top_builddir)/libs" -f "$(abs_top_srcdir)/libs/Makefile" all
> +endif
> +
> +ifneq ($(filter $(abs_top_builddir)/testcases/kernel/%,$(CURDIR)),)
> +MAKE_DEPS += $(abs_top_builddir)/testcases/kernel/lib/libkerntest.a
> +
> +$(abs_top_builddir)/testcases/kernel/lib/libkerntest.a:
> +	mkdir -m 00755 -p "$(abs_top_builddir)/testcases/kernel/lib"
> +	$(MAKE) -C "$(abs_top_builddir)/testcases/kernel/lib" -f "$(abs_top_srcdir)/testcases/kernel/lib/Makefile" all
> +endif
> +endif
> +
>  .PHONY: $(RECURSIVE_TARGETS) $(addprefix trunk-,$(RECURSIVE_TARGETS))
>  
>  $(SUBDIRS): %:

This code works but isn't elegant. How about refactoring it as follows:

-------------------

ifeq ($(MAKELEVEL),0)

ifneq ($(filter $(abs_top_builddir)/testcases%,$(CURDIR)),)

MAKE_DEPS += $(abs_top_builddir)/lib/libltp.a
MAKE_DEPS += $(abs_top_builddir)/libs-all

$(abs_top_builddir)/lib/libltp.a:
	$(MKDIR_P) "$(@D)"
	$(MAKE) -C "$(@D)" -f "$(abs_top_srcdir)/lib/Makefile" all

.PHONY: $(abs_top_builddir)/libs-all
$(abs_top_builddir)/libs-all: $(LTPLIBS_FILES)
	$(MKDIR_P) "$(@D)"
	$(MAKE) -C "$(@D)" -f "$(abs_top_srcdir)/libs/Makefile" all

endif

ifneq ($(filter $(abs_top_builddir)/testcases/kernel/%,$(CURDIR)),)

MAKE_DEPS += $(abs_top_builddir)/testcases/kernel/lib/libkerntest.a

$(abs_top_builddir)/testcases/kernel/lib/libkerntest.a:
	$(MKDIR_P) "$(@D)"
	$(MAKE) -C "$(@D)" -f "$(abs_top_srcdir)/testcases/kernel/lib/Makefile" all

endif

endif

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
