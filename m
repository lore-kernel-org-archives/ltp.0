Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FF9606A336
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=xRqzwe5X
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 194673C719E
	for <ltp@archiver.kernel.org>; Tue,  3 Nov 2026 11:01:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 325B53C701B
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 11:01:25 +0100 (CET)
Received: from mta0.migadu.com (out-59.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::3b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7DDCF100095F
 for <ltp@lists.linux.it>; Tue,  3 Nov 2026 11:01:23 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=wC1CAn0nFynEt3o/jYZqCYGI6go4sU6erIGnVo9/PxI=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793700083; v=1; x=1794304883;
 b=xRqzwe5XOadfBLIU/z67JeEf7cYTcyz8tZGyC/GABPxd1IX7ccVaWNlU+TvBrDcUtOOKv0jm
 2xr05wNSLMU7r/l0KRzsf6KylQEPTs43GW9Sb42dSwQwY9acNbjdXHKld4wAUY991CcGKah+I/Q
 6HAmpmixf3wM0Tu85uAQYc+o=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id d6aea1eb5bbeeb15;
 Tue, 03 Nov 2026 10:01:23 +0000
X-Mizu-Trace-ID: d6aea1eb5bbeeb15
X-Migadu-Flow: FLOW_OUT
Date: Tue, 3 Nov 2026 18:01:13 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aumw6SYfJJM1sojJ@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20261021-build_system_optimize-v3-0-71a3c4c6f937@suse.com>
 <20261021-build_system_optimize-v3-3-71a3c4c6f937@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261021-build_system_optimize-v3-3-71a3c4c6f937@suse.com>
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] build: Parallelize subdirectory recursion
 in generic_trunk_target
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

>  ifdef VERBOSE
> -	@set -e; for dir in $(SUBDIRS); do \
> -	    $(MAKE) -C $$dir -f "$(abs_srcdir)/$$dir/Makefile" $@; \
> -	done
> +	$(MAKE) -C "$(patsubst %-all,%,$@)" -f "$(abs_srcdir)/$(patsubst %-all,%,$@)/Makefile" all
>  else
> -	@set -e; for dir in $(SUBDIRS); do \
> -	    $(MAKE) --no-print-directory -C $$dir -f "$(abs_srcdir)/$$dir/Makefile" $@; \
> -	done
> +	@$(MAKE) --no-print-directory -C "$(patsubst %-all,%,$@)" -f "$(abs_srcdir)/$(patsubst %-all,%,$@)/Makefile" all
> +endif
> +
> +$(addsuffix -install,$(SUBDIRS)): trunk-install | $(SUBDIRS) $(MAKE_DEPS)
> +ifdef VERBOSE
> +	$(MAKE) -C "$(patsubst %-install,%,$@)" -f "$(abs_srcdir)/$(patsubst %-install,%,$@)/Makefile" install
> +else
> +	@$(MAKE) --no-print-directory -C "$(patsubst %-install,%,$@)" -f "$(abs_srcdir)/$(patsubst %-install,%,$@)/Makefile" install
> +endif
> +
> +$(addsuffix -check,$(SUBDIRS)): trunk-check | $(SUBDIRS) $(MAKE_DEPS)
> +ifdef VERBOSE
> +	$(MAKE) -C "$(patsubst %-check,%,$@)" -f "$(abs_srcdir)/$(patsubst %-check,%,$@)/Makefile" check
> +else
> +	@$(MAKE) --no-print-directory -C "$(patsubst %-check,%,$@)" -f "$(abs_srcdir)/$(patsubst %-check,%,$@)/Makefile" check
>  endif

Maybe we could refactor those lines to something like this:

ifdef VERBOSE
Q :=
SUBMAKE := $(MAKE)
else
Q := @
SUBMAKE := $(MAKE) --no-print-directory
endif

all:     $(addsuffix -all,$(SUBDIRS))
install: $(addsuffix -install,$(SUBDIRS))
check:   $(addsuffix -check,$(SUBDIRS))

.PHONY: $(addsuffix -all,$(SUBDIRS)) $(addsuffix -install,$(SUBDIRS)) $(addsuffix -check,$(SUBDIRS))

$(addsuffix -all,$(SUBDIRS)): %-all: trunk-all | $(SUBDIRS) $(MAKE_DEPS)
	$(Q)$(SUBMAKE) -C "$*" -f "$(abs_srcdir)/$*/Makefile" all

$(addsuffix -install,$(SUBDIRS)): %-install: trunk-install | $(SUBDIRS) $(MAKE_DEPS)
	$(Q)$(SUBMAKE) -C "$*" -f "$(abs_srcdir)/$*/Makefile" install

$(addsuffix -check,$(SUBDIRS)): %-check: trunk-check | $(SUBDIRS) $(MAKE_DEPS)
	$(Q)$(SUBMAKE) -C "$*" -f "$(abs_srcdir)/$*/Makefile" check


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
