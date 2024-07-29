Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65676C3DA61
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 21:53:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 170BB3D1D7D
	for <ltp@archiver.kernel.org>; Mon, 29 Jul 2024 23:53:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D1C043D0CBC
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 23:53:07 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3A5FA6018B3
 for <ltp@lists.linux.it>; Mon, 29 Jul 2024 23:53:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0080321A76;
 Mon, 29 Jul 2024 21:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722289986;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1JjMToBAkPHYbJVzWBQHMlpsJOCFgY2ownCT8UlZ0fs=;
 b=qO2QcItC3autVWp3+NDQeA4NxwUwRXGvXQl5GlUl7dfOaGX2z/U2fFzLQSP3u7xEF0ehEN
 GqkJrghN8c5z6VyUyZl0Gr2HGUvqrrdbApSwATqdgvFyxk/I2ZccSXhnhf+wsnUtjB15IC
 R/hEwpiDE19amcFu7WJVh9SufSbXx60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722289986;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1JjMToBAkPHYbJVzWBQHMlpsJOCFgY2ownCT8UlZ0fs=;
 b=vZM+zKigS2IgpfJeCHGVGwB9ZsulpMlgV4X3v60sGxm4Ozgw+uj2EeRBpqZnSS+iB5cCdk
 KwZqhNcr/QFyWiAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1722289986;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1JjMToBAkPHYbJVzWBQHMlpsJOCFgY2ownCT8UlZ0fs=;
 b=qO2QcItC3autVWp3+NDQeA4NxwUwRXGvXQl5GlUl7dfOaGX2z/U2fFzLQSP3u7xEF0ehEN
 GqkJrghN8c5z6VyUyZl0Gr2HGUvqrrdbApSwATqdgvFyxk/I2ZccSXhnhf+wsnUtjB15IC
 R/hEwpiDE19amcFu7WJVh9SufSbXx60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1722289986;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1JjMToBAkPHYbJVzWBQHMlpsJOCFgY2ownCT8UlZ0fs=;
 b=vZM+zKigS2IgpfJeCHGVGwB9ZsulpMlgV4X3v60sGxm4Ozgw+uj2EeRBpqZnSS+iB5cCdk
 KwZqhNcr/QFyWiAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D93021368A;
 Mon, 29 Jul 2024 21:53:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id QvkMNEEPqGYoXwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 29 Jul 2024 21:53:05 +0000
Date: Mon, 29 Jul 2024 23:53:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20240729215305.GB1299602@pevik>
References: <20240726-ioctl_ficlone-v4-1-710ed71bee70@suse.com>
 <ZqO8WHD-vJ7y9eLx@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZqO8WHD-vJ7y9eLx@yuki>
X-Spamd-Result: default: False [-3.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto,suse.com:email]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] Add ioctl_ficlone04 test
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

> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2024 Andrea Cervesato andrea.cervesato@suse.com
nit: ve usually put email into < > (e.g. <andrea.cervesato@suse.com>)
> > + */

...
> > +static void test_bad_fd(struct tst_fd *fd_src, struct tst_fd *fd_dst)
> > +{
> > +	if (fd_src->type == TST_FD_FILE && fd_src->type == fd_dst->type) {
> > +		tst_res(TCONF, "Skipping file: SUCCESS");

> Maybe just a TINFO here.

+1

Reviewed-by: Petr Vorel <pvorel@suse.cz>

FYI with 2 extra errno (ENOTTY, EFAULT) it would run also on 4.4 kernel (the
oldest still supported - SLE12-SP3) one with this result:

passed   360
failed   0
broken   0
skipped  121
warnings 0

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
