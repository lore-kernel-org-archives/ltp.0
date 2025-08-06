Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC6B7C87FCB
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 11:47:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1DE613C8112
	for <ltp@archiver.kernel.org>; Wed,  6 Aug 2025 13:47:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FECA3C31D2
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 13:47:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 80E53100044E
 for <ltp@lists.linux.it>; Wed,  6 Aug 2025 13:47:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 74E6321B07;
 Wed,  6 Aug 2025 11:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754480824;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1nazq7tR0qGBnE6IX4ERhgrjkF4+txyEqToyOa2udMI=;
 b=uyTVZJxw5OeocQdoP3kWwcjqLuuWRRfeAMt2KyZoI/Rp0cAzMlmCEylIe2yQyLCIOw1l5e
 BtOCvkT5dTptKP9vQVh6WkwOEW6Q/K/zkyJ5yWz3FkjMt/+F+0YL+KOQyx6HLtQUHDNAkk
 IKDZAxOuTOdJ7pSa10aY9IXWqcMVLTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754480824;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1nazq7tR0qGBnE6IX4ERhgrjkF4+txyEqToyOa2udMI=;
 b=inJHGNES8pFJpcVzrMWZ692LENeF1mYvtkqiCfUv5X/cnqX5QZe7uToquFmZxkaweAbP0Q
 UP0pL4hQQxviyBDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uyTVZJxw;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=inJHGNES
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1754480824;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1nazq7tR0qGBnE6IX4ERhgrjkF4+txyEqToyOa2udMI=;
 b=uyTVZJxw5OeocQdoP3kWwcjqLuuWRRfeAMt2KyZoI/Rp0cAzMlmCEylIe2yQyLCIOw1l5e
 BtOCvkT5dTptKP9vQVh6WkwOEW6Q/K/zkyJ5yWz3FkjMt/+F+0YL+KOQyx6HLtQUHDNAkk
 IKDZAxOuTOdJ7pSa10aY9IXWqcMVLTo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1754480824;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1nazq7tR0qGBnE6IX4ERhgrjkF4+txyEqToyOa2udMI=;
 b=inJHGNES8pFJpcVzrMWZ692LENeF1mYvtkqiCfUv5X/cnqX5QZe7uToquFmZxkaweAbP0Q
 UP0pL4hQQxviyBDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4449913AA8;
 Wed,  6 Aug 2025 11:47:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FJzfDrhAk2i6TAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 06 Aug 2025 11:47:04 +0000
Date: Wed, 6 Aug 2025 13:47:02 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250806114702.GA431066@pevik>
References: <20250801100935.974351-1-pvorel@suse.cz>
 <20250801102047.GA974145@pevik>
 <CAEemH2eEqMMpueDY9s=Bv2JfQ-oAckA8Y8GFTaV04b5bsfPN+A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eEqMMpueDY9s=Bv2JfQ-oAckA8Y8GFTaV04b5bsfPN+A@mail.gmail.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 74E6321B07
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] Makefile: Add kernel modules related make
 targets
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, all,

..
> > We could allow to fail build with:
> > $ make modules FORCE=1

> > with these changes to include/mk/module.mk:

> > ifneq ($(SKIP),0)
> > MAKE_TARGETS := $(filter-out %.ko, $(MAKE_TARGETS))

> > ifeq ($(FORCE),1)
> > $(error Modules not built)


> This suggestion looks good, maybe we can also add a helpful error
> message showing how to fix it:

> ifeq ($(FORCE),1)
> $(error Kernel modules not built! \
> Check that kernel-devel/kernel-headers for
> $(LINUX_VERSION_MAJOR).$(LINUX_VERSION_PATCH) are installed, \
> and try again. You can build anyway by omitting FORCE=1.)

+1. I'll probably do this as a separate effort (or at least a separate commit).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
