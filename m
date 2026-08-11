Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D06C5AC67
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 09:04:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A04F73D07E0
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 11:04:12 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 851093D06FC
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 11:03:54 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 58BD510006B2
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 11:03:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7D58181B07;
 Tue, 11 Aug 2026 09:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786439029;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mcN+VvPJ6Iwo3ztUicYYZ+ZolTzgpJNVBAn+cqRYvHI=;
 b=lj7MN7OFmhOxsnYPakJ3rVrP4vhLOkQ74gFUSQS4PbaesX9ZzlwjL0W+6SwL6a+GuW5SO9
 vc3ILhaXZwRqDnJDm/vRsvrIWOqdNcJ4jMJz3/90pVfrAsY9Zt73mxdFemSsNdGR4Xm+jo
 6hfpOIsS42UjeznJNWBRfVEiGXiZZbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786439029;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mcN+VvPJ6Iwo3ztUicYYZ+ZolTzgpJNVBAn+cqRYvHI=;
 b=W/1E6MpGONyOYT3Mypsr5A5WWHNzTgpy6mFXKENnDPIK7feLBPyrGMxVbwAJSHbUp8XKTf
 gyQitCJ7IihfgtBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=vtnqNZSA;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EvC9oQYh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786439025;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mcN+VvPJ6Iwo3ztUicYYZ+ZolTzgpJNVBAn+cqRYvHI=;
 b=vtnqNZSA5fvLMGP5eCNtEXeWL9xvZGXoY5iO/MTmHHHsChx84vEOwbjdUcdt3BX2p6H2iW
 LpHwDrZ05us9CYl1HFqB2YGwflc/YPihuAnhiwp8/0NTPANgnVhiHjQnVqOdNADBX+PpRY
 ocSbOFfkNZm7+1cra+M0SJxCX+ywdCM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786439025;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mcN+VvPJ6Iwo3ztUicYYZ+ZolTzgpJNVBAn+cqRYvHI=;
 b=EvC9oQYhJt5SDk6kSrsiXHMefkQ1d6y/GhZrmm1JO8ut2cDumdDGBnxC8wUBLjDOPNIixC
 hibu4rgcFCzJeKAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E1F4779B6;
 Tue, 11 Aug 2026 09:03:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id SZICB3HlemqDYwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 11 Aug 2026 09:03:45 +0000
Date: Tue, 11 Aug 2026 11:03:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <avinesh.kumar@suse.com>
Message-ID: <20260811090339.GB1676037@pevik>
References: <20260806074713.158271-1-avinesh.kumar@suse.com>
 <20260810103134.GA918586@pevik>
 <aa02bbd8-c908-4f34-82c5-acd7a361ce94@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aa02bbd8-c908-4f34-82c5-acd7a361ce94@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 7D58181B07
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.cz:replyto,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,wooledge.org:url];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] nfs_lib: Skip NFS versions disabled on server
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

Hi Avinesh,

> Hi Petr,

> Thanks for your review.

> > Thanks for handling this!

> > LGTM? few notes below.
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > ...

> > > -get_socket_type()
> > > +get_socket_type_raw()
> > very nit: slightly confusing type, because there is a "raw" socket SOCK_RAW.
> > I guess any network programmer seeing this will think of that socket, e.g.:
> > socket(PF_INET, SOCK_RAW, ...);
> > socket(PF_NETLINK, SOCK_RAW, NETLINK_ROUTE);

> > But of course it can stay.

> How about get_socket_type_bare() ?
+1

...
> > +			tst_res TINFO "NFSv$v disabled on server, skipping"
> > +			tst_res TCONF "NFSv$v disabled on server, skipping"

> > > +		fi
> > > +
> > > +		n=$(( n + 1 ))
> > > +	done
> > > +
> > > +	[ -z "$new_version" ] && \
> > > +		tst_brk TCONF "none of the requested NFS versions ($VERSION) are enabled on server"
> > nit: I would expect this would quit the test on system with
> > set -o errexit (equivalent of set -e), but magically it works.
> > FYI normally it's better if any test line exit with 0 => use || (or if ...; then
> > ... fi) instead &&  i.e.

> > [ ... ] || tst_brk TCONF

> > But because it works it can stay.
> +1. I will switch to below for consistency.
> 	[ "$new_version" ] || \
> 		tst_brk TCONF ...

Thank you!

> > > +
> > > +	VERSION="${new_version# }"
> > > +	SOCKET_TYPE="${new_socket_type# }"

> > Fortunately removing leading space works also on dash, although at least some
> > string operations aren't part of POSIX [1].

> > If this is ever problematic, we can fix it with:

> > 	[ "$new_version" ] && new_version="$new_version $v" || new_version="$v"
> > 	[ "$new_socket_type" ] && new_socket_type="$new_socket_type $type" || new_socket_type="$type"

> > But because removing leading space is not needed, because later code for t in
> > $SOCKET_TYPE; do will handle that, I'd remove this part entirely.
> Actually we need to remove the leading space, otherwise we break
> nfsstat01 where $VERSION is being used as whole scalar value.
> case $VERSION in

Thanks for info.

> I can switch to the solution you suggested here.

I checked LTP sources and we use in old scripts often ${...#...}. I was probably
just too careful about portability.

Kind regards,
Petr

> > FYI: (no leading/trailing space in parameters, no $t having just empty space:
> > SOCKET_TYPE=' udp tcp  '; for t in $SOCKET_TYPE; do echo "'$t'"; done
> > 'udp'
> > 'tcp'

> > [1] https://mywiki.wooledge.org/Bashism#Parameter_Expansions

> > Kind regards,
> > Petr

> Regards,
> Avinesh

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
