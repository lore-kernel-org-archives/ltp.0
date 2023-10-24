Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45ED7C07545
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 09:33:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D76B3CF4F3
	for <ltp@archiver.kernel.org>; Tue, 24 Oct 2023 11:33:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 489F43CCD3D
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 11:33:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B03DD601BA6
 for <ltp@lists.linux.it>; Tue, 24 Oct 2023 11:33:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4673F1FD87;
 Tue, 24 Oct 2023 09:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698140001; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ahilqsyr34aypjt/QhYgtXq9Mqz9d3Qr7GdrM7vyV4k=;
 b=A7Vf/h2IFo4ALjRJ92tHdk2YjxG9xror+tVzcbBgjcjPUcZZN9C2wve9YGHqf5lgcixDtc
 SZbXg53yxtYlUQlK55T4OAP+1KqgvVccgWS5NenPUmsCdTc9gJA35qYJhopOFHQXaaAlbB
 agxPG8pjyWPrHGPS1aGb/UwysKakLvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698140001;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ahilqsyr34aypjt/QhYgtXq9Mqz9d3Qr7GdrM7vyV4k=;
 b=ZK7UCKmmHBdSzcKp7QqFlf37S+M85PAzpvhZ5wY66rkwY3UN2CAfButL7jOXiahmL69Y77
 AdHfT0zg0iGE/yDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 361C1134F5;
 Tue, 24 Oct 2023 09:33:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MPUtDWGPN2V+CAAAMHmgww
 (envelope-from <jack@suse.cz>); Tue, 24 Oct 2023 09:33:21 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id A5632A05BC; Tue, 24 Oct 2023 11:33:20 +0200 (CEST)
Date: Tue, 24 Oct 2023 11:33:20 +0200
From: Jan Kara <jack@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231024093320.wsusd5qtveqt64dt@quack3>
References: <20231016123320.9865-1-chrubis@suse.cz>
 <20231016123320.9865-5-chrubis@suse.cz> <87o7gpuxfl.fsf@suse.de>
 <ZTd4v-aY2jXkUgr0@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZTd4v-aY2jXkUgr0@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-9.91 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_SEVEN(0.00)[9];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.31)[96.76%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
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
Cc: mszeredi@redhat.com, brauner@kernel.org,
 Matthew Wilcox <willy@infradead.org>, viro@zeniv.linux.org.uk,
 linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue 24-10-23 09:56:47, Cyril Hrubis wrote:
> > > +	if (fd_in->type == TST_FD_PIPE_READ) {
> > > +		switch (fd_out->type) {
> > > +		case TST_FD_FILE:
> > > +		case TST_FD_PIPE_WRITE:
> > > +		case TST_FD_UNIX_SOCK:
> > > +		case TST_FD_INET_SOCK:
> > > +		case TST_FD_MEMFD:
> > > +			return;
> > > +		default:
> > > +		break;
> > > +		}
> > > +	}
> > > +
> > > +	if (fd_out->type == TST_FD_PIPE_WRITE) {
> > > +		switch (fd_in->type) {
> > > +		/* While these combinations succeeed */
> > > +		case TST_FD_FILE:
> > > +		case TST_FD_MEMFD:
> > > +			return;
> > > +		/* And this complains about socket not being connected */
> > > +		case TST_FD_INET_SOCK:
> > > +			return;
> > > +		default:
> > > +		break;
> > > +		}
> > > +	}
> > > +
> > > +	/* These produce EBADF instead of EINVAL */
> > > +	switch (fd_out->type) {
> > > +	case TST_FD_DIR:
> > > +	case TST_FD_DEV_ZERO:
> > > +	case TST_FD_PROC_MAPS:
> > > +	case TST_FD_INOTIFY:
> > > +	case TST_FD_PIPE_READ:
> > > +		exp_errno = EBADF;
> > > +	default:
> > > +	break;
> > > +	}
> > > +
> > > +	if (fd_in->type == TST_FD_PIPE_WRITE)
> > > +		exp_errno = EBADF;
> > > +
> > > +	if (fd_in->type == TST_FD_OPEN_TREE || fd_out->type == TST_FD_OPEN_TREE ||
> > > +	    fd_in->type == TST_FD_PATH || fd_out->type == TST_FD_PATH)
> > > +		exp_errno = EBADF;
> > 
> > This seems like something that could change due to checks changing
> > order.
> 
> I was hoping that kernel devs would look at the current state, which is
> documented in these conditions and tell me how shold we set the
> expectations. At least the open_tree() seems to differ from the rest in
> several cases, so maybe needs to be aligned with the rest.

Yeah, so the EINVAL vs EBADF vs EISDIR vs ESPIPE distinction is somewhat
arbitrary and as mentioned it very much depends on the order of checks we
do and that is not very consistent among different operations or over
longer time periods. So it would be good if tests could accept all errors
that make some sense. 

E.g. when we cannot seek (change file position) of the fd, ESPIPE is a
valid error return for any operation involving changing file position.
EISDIR is valid error for any directory fd when doing operation not expected
to work on directories. EINVAL and EBADF are quite generic and should be
accepted anytime fd is not suitable for the operation (generally we try to
return EBADF when the descriptor itself isn't suitable - e.g. O_PATH
descriptor, closed descriptor, ... - and return EINVAL when the open
*object* is not suitable but that is a very rough guideline people don't
always follow). EACCES / EPERM should be accepted error return when we
don't have enough permissions to perform operation on the fd. And so on.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
