Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B458BC00A8F
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 07:56:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25B863CCDFF
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 09:56:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 670C33CCCC7
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 09:56:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DCC1B14011AE
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 09:56:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 57B1B21B79;
 Tue, 24 Oct 2023 07:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698134175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ar1OnnUr2FhvbGPoXqbLyR03nliEnCcQms0fks4oEVw=;
 b=kHcHsGMKkL8BSJyqwZewanYZ8/lC5mTm+kY8FfuXWlwQx6HDvdyvkkgT9REBG9IToM7BsZ
 X1uk3HmgOFZN76Uuz+69+qZ9LLM4h0L07fLvbNQmIDXJBKNAJ5zZin0o8P/cenmxKz47KZ
 NJX8enVeH1p/vcROgTreQXxIU9XVzjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698134175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ar1OnnUr2FhvbGPoXqbLyR03nliEnCcQms0fks4oEVw=;
 b=AUJVJ/Ntvpv90bPUxoKp/ecczrrB6GDEaQ66lH1wZEFR6Hy1525yKFiPhLnI1DfrWqVPLU
 xw3R3Byupu6OjCAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4239E134F5;
 Tue, 24 Oct 2023 07:56:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QtTRDp94N2VNUgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 24 Oct 2023 07:56:15 +0000
Date: Tue, 24 Oct 2023 09:56:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <ZTd4v-aY2jXkUgr0@yuki>
References: <20231016123320.9865-1-chrubis@suse.cz>
 <20231016123320.9865-5-chrubis@suse.cz> <87o7gpuxfl.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87o7gpuxfl.fsf@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-7.69 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.09)[64.49%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 4/4] syscalls: splice07: New splice tst_fd
 iterator test
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
Cc: mszeredi@redhat.com, brauner@kernel.org, Jan Kara <jack@suse.cz>,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Yup, because there is nothing in the pipe (which you probably realise).
> 
> The question is, if we want to test actual splicing, should we fill the
> pipe in the lib?
>
> If so should that be an option that we set? TST_FD_FOREACH or
> TST_FD_FOREACH2 could take an opts struct for e.g. or even tst_test. I
> guess with TST_FD_FOREACH2 there is no need to do add anything now.

That would be much more complex. For splicing from a TCP socket I would
have to set up a TCP server, connect the socket there and feed the data
from a sever...

So maybe later on. I would like to avoid adding more complexity to the
patchset at this point and focus on testing errors for now.

> > +	if (fd_in->type == TST_FD_PIPE_READ) {
> > +		switch (fd_out->type) {
> > +		case TST_FD_FILE:
> > +		case TST_FD_PIPE_WRITE:
> > +		case TST_FD_UNIX_SOCK:
> > +		case TST_FD_INET_SOCK:
> > +		case TST_FD_MEMFD:
> > +			return;
> > +		default:
> > +		break;
> > +		}
> > +	}
> > +
> > +	if (fd_out->type == TST_FD_PIPE_WRITE) {
> > +		switch (fd_in->type) {
> > +		/* While these combinations succeeed */
> > +		case TST_FD_FILE:
> > +		case TST_FD_MEMFD:
> > +			return;
> > +		/* And this complains about socket not being connected */
> > +		case TST_FD_INET_SOCK:
> > +			return;
> > +		default:
> > +		break;
> > +		}
> > +	}
> > +
> > +	/* These produce EBADF instead of EINVAL */
> > +	switch (fd_out->type) {
> > +	case TST_FD_DIR:
> > +	case TST_FD_DEV_ZERO:
> > +	case TST_FD_PROC_MAPS:
> > +	case TST_FD_INOTIFY:
> > +	case TST_FD_PIPE_READ:
> > +		exp_errno = EBADF;
> > +	default:
> > +	break;
> > +	}
> > +
> > +	if (fd_in->type == TST_FD_PIPE_WRITE)
> > +		exp_errno = EBADF;
> > +
> > +	if (fd_in->type == TST_FD_OPEN_TREE || fd_out->type == TST_FD_OPEN_TREE ||
> > +	    fd_in->type == TST_FD_PATH || fd_out->type == TST_FD_PATH)
> > +		exp_errno = EBADF;
> 
> This seems like something that could change due to checks changing
> order.

I was hoping that kernel devs would look at the current state, which is
documented in these conditions and tell me how shold we set the
expectations. At least the open_tree() seems to differ from the rest in
several cases, so maybe needs to be aligned with the rest.

> This is a bit offtopic, but we maybe need errno sets, which would be
> useful for our other discussion on relaxing errno checking.

Indeed that is something we have to do either way.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
