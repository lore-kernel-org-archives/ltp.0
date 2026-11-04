Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64F0606A32D
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=2osZ8l7u;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oF+Tmmtm;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=2osZ8l7u;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=oF+Tmmtm
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F26B13CB3F5
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 11:51:30 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59D9C3C636C
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 11:51:15 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8B6A91A009B1
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 11:51:13 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 343FD21F35;
 Wed,  4 Nov 2026 10:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793789473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CJZsSQZQJwQxIEkqFq67tFg+ieza98lysWd73HRp9Uo=;
 b=2osZ8l7uraBJuD+4kQDXSxZGZKiLK1rgg/EcJKR03sTDqIbbVY8Nv89pNlFR6fXXWWtVtG
 7QNUC9QXmKCyjRrEGt/f9OJkRQtbROPOY3yZkvhkzgvWJZvJG7hWtzasPkDsvuKjMipJ2k
 CaCr8wsycX+QXd2c809H/aOJ31Xslvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793789473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CJZsSQZQJwQxIEkqFq67tFg+ieza98lysWd73HRp9Uo=;
 b=oF+TmmtmPFmXJ/YKBVvqbsgtmZWf8sPZTa5AXw9hmNYEB+WrGjrF7P2YwA9YBG/8L4VKS3
 oumf6NI4k2F2HNDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2osZ8l7u;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=oF+Tmmtm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793789473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CJZsSQZQJwQxIEkqFq67tFg+ieza98lysWd73HRp9Uo=;
 b=2osZ8l7uraBJuD+4kQDXSxZGZKiLK1rgg/EcJKR03sTDqIbbVY8Nv89pNlFR6fXXWWtVtG
 7QNUC9QXmKCyjRrEGt/f9OJkRQtbROPOY3yZkvhkzgvWJZvJG7hWtzasPkDsvuKjMipJ2k
 CaCr8wsycX+QXd2c809H/aOJ31Xslvs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793789473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CJZsSQZQJwQxIEkqFq67tFg+ieza98lysWd73HRp9Uo=;
 b=oF+TmmtmPFmXJ/YKBVvqbsgtmZWf8sPZTa5AXw9hmNYEB+WrGjrF7P2YwA9YBG/8L4VKS3
 oumf6NI4k2F2HNDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DB35B134F0;
 Wed,  4 Nov 2026 10:51:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id I32YKSAO62ooCwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Nov 2026 10:51:12 +0000
Date: Wed, 4 Nov 2026 11:51:11 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
Message-ID: <20261104105111.GA176379@pevik>
References: <20261021-build_system_optimize-v3-0-71a3c4c6f937@suse.com>
 <20261021-build_system_optimize-v3-3-71a3c4c6f937@suse.com>
 <aumw6SYfJJM1sojJ@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aumw6SYfJJM1sojJ@linux.dev>
X-Rspamd-Queue-Id: 343FD21F35
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.71 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.71
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Andrea,

> >  ifdef VERBOSE
> > -	@set -e; for dir in $(SUBDIRS); do \
> > -	    $(MAKE) -C $$dir -f "$(abs_srcdir)/$$dir/Makefile" $@; \
> > -	done
> > +	$(MAKE) -C "$(patsubst %-all,%,$@)" -f "$(abs_srcdir)/$(patsubst %-all,%,$@)/Makefile" all
> >  else
> > -	@set -e; for dir in $(SUBDIRS); do \
> > -	    $(MAKE) --no-print-directory -C $$dir -f "$(abs_srcdir)/$$dir/Makefile" $@; \
> > -	done
> > +	@$(MAKE) --no-print-directory -C "$(patsubst %-all,%,$@)" -f "$(abs_srcdir)/$(patsubst %-all,%,$@)/Makefile" all
> > +endif
> > +
> > +$(addsuffix -install,$(SUBDIRS)): trunk-install | $(SUBDIRS) $(MAKE_DEPS)
> > +ifdef VERBOSE
> > +	$(MAKE) -C "$(patsubst %-install,%,$@)" -f "$(abs_srcdir)/$(patsubst %-install,%,$@)/Makefile" install
> > +else
> > +	@$(MAKE) --no-print-directory -C "$(patsubst %-install,%,$@)" -f "$(abs_srcdir)/$(patsubst %-install,%,$@)/Makefile" install
> > +endif
> > +
> > +$(addsuffix -check,$(SUBDIRS)): trunk-check | $(SUBDIRS) $(MAKE_DEPS)
> > +ifdef VERBOSE
> > +	$(MAKE) -C "$(patsubst %-check,%,$@)" -f "$(abs_srcdir)/$(patsubst %-check,%,$@)/Makefile" check
> > +else
> > +	@$(MAKE) --no-print-directory -C "$(patsubst %-check,%,$@)" -f "$(abs_srcdir)/$(patsubst %-check,%,$@)/Makefile" check
> >  endif

> Maybe we could refactor those lines to something like this:

> ifdef VERBOSE
> Q :=
> SUBMAKE := $(MAKE)
> else
> Q := @
> SUBMAKE := $(MAKE) --no-print-directory
> endif

> all:     $(addsuffix -all,$(SUBDIRS))
> install: $(addsuffix -install,$(SUBDIRS))
> check:   $(addsuffix -check,$(SUBDIRS))

> .PHONY: $(addsuffix -all,$(SUBDIRS)) $(addsuffix -install,$(SUBDIRS)) $(addsuffix -check,$(SUBDIRS))

> $(addsuffix -all,$(SUBDIRS)): %-all: trunk-all | $(SUBDIRS) $(MAKE_DEPS)
> 	$(Q)$(SUBMAKE) -C "$*" -f "$(abs_srcdir)/$*/Makefile" all

> $(addsuffix -install,$(SUBDIRS)): %-install: trunk-install | $(SUBDIRS) $(MAKE_DEPS)
> 	$(Q)$(SUBMAKE) -C "$*" -f "$(abs_srcdir)/$*/Makefile" install

> $(addsuffix -check,$(SUBDIRS)): %-check: trunk-check | $(SUBDIRS) $(MAKE_DEPS)
> 	$(Q)$(SUBMAKE) -C "$*" -f "$(abs_srcdir)/$*/Makefile" check

Very good point.
BTW similar cleanup with variable could be done in include/mk/rules.mk.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

I try to test the patch once github works again.
https://www.githubstatus.com/

Kind regards,
Petr

diff --git include/mk/generic_trunk_target.inc include/mk/generic_trunk_target.inc
index 6975507e81..8ed8ee89c0 100644
--- include/mk/generic_trunk_target.inc
+++ include/mk/generic_trunk_target.inc
@@ -78,11 +78,14 @@ endif
 
 install: trunk-install
 
-# Print out CURDIR to check for a recursion issue.
-ifeq ($(strip $(SUBDIRS)),)
-	$(warning CURDIR is: $(CURDIR))
-	$(error SUBDIRS empty -- did you want generic_leaf_target instead?)
+ifdef VERBOSE
+Q :=
+SUBMAKE := $(MAKE)
 else
+Q := @
+SUBMAKE := $(MAKE) --no-print-directory
+endif
+
 # Recurse into subdirectories in parallel instead of using a serial shell loop.
 # Each subdirectory is mapped to a phony target (<dir>-all, <dir>-install, etc.).
 # GNU Make can then schedule sibling directories concurrently under -jN.
@@ -94,27 +97,14 @@ check:   $(addsuffix -check,$(SUBDIRS))
 
 # For each target (e.g. 'open-all'), strip the suffix to get the directory name,
 # build trunk-local targets first, and ensure the subdirectory exists.
-$(addsuffix -all,$(SUBDIRS)): trunk-all | $(SUBDIRS) $(MAKE_DEPS)
-ifdef VERBOSE
-	$(MAKE) -C "$(patsubst %-all,%,$@)" -f "$(abs_srcdir)/$(patsubst %-all,%,$@)/Makefile" all
-else
-	@$(MAKE) --no-print-directory -C "$(patsubst %-all,%,$@)" -f "$(abs_srcdir)/$(patsubst %-all,%,$@)/Makefile" all
-endif
+$(addsuffix -all,$(SUBDIRS)): %-all: trunk-all | $(SUBDIRS) $(MAKE_DEPS)
+	$(Q)$(SUBMAKE) -C "$*" -f "$(abs_srcdir)/$*/Makefile" all
 
-$(addsuffix -install,$(SUBDIRS)): trunk-install | $(SUBDIRS) $(MAKE_DEPS)
-ifdef VERBOSE
-	$(MAKE) -C "$(patsubst %-install,%,$@)" -f "$(abs_srcdir)/$(patsubst %-install,%,$@)/Makefile" install
-else
-	@$(MAKE) --no-print-directory -C "$(patsubst %-install,%,$@)" -f "$(abs_srcdir)/$(patsubst %-install,%,$@)/Makefile" install
-endif
+$(addsuffix -install,$(SUBDIRS)): %-install: trunk-install | $(SUBDIRS) $(MAKE_DEPS)
+	$(Q)$(SUBMAKE) -C "$*" -f "$(abs_srcdir)/$*/Makefile" install
 
-$(addsuffix -check,$(SUBDIRS)): trunk-check | $(SUBDIRS) $(MAKE_DEPS)
-ifdef VERBOSE
-	$(MAKE) -C "$(patsubst %-check,%,$@)" -f "$(abs_srcdir)/$(patsubst %-check,%,$@)/Makefile" check
-else
-	@$(MAKE) --no-print-directory -C "$(patsubst %-check,%,$@)" -f "$(abs_srcdir)/$(patsubst %-check,%,$@)/Makefile" check
-endif
-endif
+$(addsuffix -check,$(SUBDIRS)): %-check: trunk-check | $(SUBDIRS) $(MAKE_DEPS)
+	$(Q)$(SUBMAKE) -C "$*" -f "$(abs_srcdir)/$*/Makefile" check
 
 check: trunk-check
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
