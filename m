Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F867C87FCF
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 06:17:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89FBB3C9256
	for <ltp@archiver.kernel.org>; Thu,  7 Aug 2025 08:17:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7E7CC3C1FEE
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 08:17:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3D1B460054A
 for <ltp@lists.linux.it>; Thu,  7 Aug 2025 08:17:14 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2B2591F807;
 Thu,  7 Aug 2025 06:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754547432;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qz1r92eDoVxCy62Zn1wQs/HPBd9anv0fj3tVig72x24=;
 b=QTc69VBiDCTJJWDDe5W6q/ingZHErrENDComcvUNonCS09G5swLIVfzsru7aQ0EvDIrCt2
 yy2zQTDXYCdFcQpeSM/ialRehegHo6EefjvVH8SF/4N9rw52wFW5YpZUVzZ3aQ+uaVBrJt
 mKpYeT7g+OH0MAZQ5lV2jeWp1CBeOxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754547432;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qz1r92eDoVxCy62Zn1wQs/HPBd9anv0fj3tVig72x24=;
 b=Ogs4e32vw7DKY+Mjidd7F0FDZjIFFWPouhcppNIHj+knxB5gTzeKczIEF4CYXz8LRV+Fr/
 xyUCttLgndAoXnDw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754547432;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qz1r92eDoVxCy62Zn1wQs/HPBd9anv0fj3tVig72x24=;
 b=QTc69VBiDCTJJWDDe5W6q/ingZHErrENDComcvUNonCS09G5swLIVfzsru7aQ0EvDIrCt2
 yy2zQTDXYCdFcQpeSM/ialRehegHo6EefjvVH8SF/4N9rw52wFW5YpZUVzZ3aQ+uaVBrJt
 mKpYeT7g+OH0MAZQ5lV2jeWp1CBeOxc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754547432;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Qz1r92eDoVxCy62Zn1wQs/HPBd9anv0fj3tVig72x24=;
 b=Ogs4e32vw7DKY+Mjidd7F0FDZjIFFWPouhcppNIHj+knxB5gTzeKczIEF4CYXz8LRV+Fr/
 xyUCttLgndAoXnDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C8968136DC;
 Thu,  7 Aug 2025 06:17:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eTJ4LudElGhcAQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 07 Aug 2025 06:17:11 +0000
Date: Thu, 7 Aug 2025 08:17:06 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250807061706.GB331644@pevik>
References: <20250806211420.445452-1-pvorel@suse.cz>
 <20250806211420.445452-2-pvorel@suse.cz>
 <CAEemH2cG1+_UD02Hp5oSNXkhirNjn6drH=eL-4X55ZOqi8P8BA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cG1+_UD02Hp5oSNXkhirNjn6drH=eL-4X55ZOqi8P8BA@mail.gmail.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] modules.mk: Add FORCE_MODULES=1 to fail on
 error
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
Cc: Ricardo B =?utf-8?B?LiBNYXJsacOocmU=?= <rbm@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

> >  # doesn't find the module (i.e. it wasn't built either due to kernel-devel
> >  # missing or module build failure).
> > +ifneq ($(FORCE_MODULES),1)
> >  %.ko: %.c .dep_modules ;
> > +endif

> Unfortunately, this wouldn't work as expected, the module's build process
> only skipped silently with `make modules FORCE_MODULES=1`.

Good catch, thank you. It's because '-' in
-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
must be changed to get make fail.

It should be fixed by patch below, I'll send v4 shortly.
In the mean time you can use make-modules.v4 in my fork:
https://github.com/pevik/ltp/tree/refs/heads/make-modules.v4

Kind regards,
Petr

diff --git include/mk/module.mk include/mk/module.mk
index 65054ae502..3e97f01289 100644
--- include/mk/module.mk
+++ include/mk/module.mk
@@ -30,6 +30,7 @@ SKIP ?= $(shell \
 endif
 endif
 
+$(info skip: $(SKIP), FORCE_MODULES: $(FORCE_MODULES))
 ifneq ($(SKIP),0)
 MAKE_TARGETS := $(filter-out %.ko, $(MAKE_TARGETS))
 ifeq ($(FORCE_MODULES),1)
@@ -58,12 +59,14 @@ MODULE_SOURCES := $(patsubst %.ko,%.c,$(filter %.ko, $(MAKE_TARGETS)))
 # kernel internal API changes. The user-space test will return TCONF, if it
 # doesn't find the module (i.e. it wasn't built either due to kernel-devel
 # missing or module build failure).
-ifneq ($(FORCE_MODULES),1)
 %.ko: %.c .dep_modules ;
-endif
 
 .dep_modules: $(MODULE_SOURCES)
 	@echo "Building modules: $(MODULE_SOURCES)"
+ifneq ($(FORCE_MODULES),1)
 	-$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
+else
+	$(MAKE) -C $(LINUX_DIR) M=$(abs_srcdir)
+endif
 	rm -rf *.mod.c *.o *.ko.unsigned modules.order .tmp* .*.ko .*.cmd Module.symvers
 	@touch .dep_modules

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
