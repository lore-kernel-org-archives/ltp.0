Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F56CC35274
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 04:40:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57C263CF39C
	for <ltp@archiver.kernel.org>; Mon, 18 Dec 2023 05:40:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 56DAD3C81E3
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 05:40:03 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 434792000A7
 for <ltp@lists.linux.it>; Mon, 18 Dec 2023 05:40:02 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C9C2221EDB;
 Mon, 18 Dec 2023 04:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702874401;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tH25O1AwVLjk0RFYUtDaAF/tmdNHk8vuKSul+LU5v0Q=;
 b=nlq3V8Hx7EmBMb1DgtDSqQrbYVkd9fXOWdueZiu/tEvaMVbTgOtTNipq52pK/0nzirvdfk
 BE+nuf9zpwzshLyTaJFWjZaFGt2HtkXVoxIIlWaRi0Av2e2PNjnPkaXak5120e/VfWHUws
 dee6z9xhphgCcKRkFGSxcEg65GV395Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702874401;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tH25O1AwVLjk0RFYUtDaAF/tmdNHk8vuKSul+LU5v0Q=;
 b=8OywudSOqZks6IaX42aZTvONl4lwic/S3WFLNFKh9RSBUusswlSpnHNLGicF6DoAngSU8N
 wRAXBuo+9tBzTBAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1702874401;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tH25O1AwVLjk0RFYUtDaAF/tmdNHk8vuKSul+LU5v0Q=;
 b=nlq3V8Hx7EmBMb1DgtDSqQrbYVkd9fXOWdueZiu/tEvaMVbTgOtTNipq52pK/0nzirvdfk
 BE+nuf9zpwzshLyTaJFWjZaFGt2HtkXVoxIIlWaRi0Av2e2PNjnPkaXak5120e/VfWHUws
 dee6z9xhphgCcKRkFGSxcEg65GV395Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1702874401;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tH25O1AwVLjk0RFYUtDaAF/tmdNHk8vuKSul+LU5v0Q=;
 b=8OywudSOqZks6IaX42aZTvONl4lwic/S3WFLNFKh9RSBUusswlSpnHNLGicF6DoAngSU8N
 wRAXBuo+9tBzTBAg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B93D138EE;
 Mon, 18 Dec 2023 04:40:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id ibAMJCHNf2VlSgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 18 Dec 2023 04:40:01 +0000
Date: Mon, 18 Dec 2023 05:39:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20231218043959.GB160518@pevik>
References: <20231214063311.2325-1-wegao@suse.com>
 <20231214071321.9863-1-wegao@suse.com>
 <20231214071321.9863-2-wegao@suse.com>
 <20231215185749.GA58273@pevik>
 <CAEemH2dxjRqz4aqJR8C95fAzE4M9XeScEwa-d3bRSO6EyW-EjA@mail.gmail.com>
 <CAEemH2ehQ6CPakouwECeWQGSvSOe1rhA=HKnk1Uig81Cj7tzTg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2ehQ6CPakouwECeWQGSvSOe1rhA=HKnk1Uig81Cj7tzTg@mail.gmail.com>
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[21.86%]
Authentication-Results: smtp-out1.suse.de;
	none
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] tst_memutils.c: Add tst_print_meminfo
 function
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

> Li Wang <liwang@redhat.com> wrote:

> >> > +++ b/lib/safe_macros.c

> >> We don't want to add anything to the legacy API (otherwise it would go to
> >> lib/safe_file_ops.c), please add this to lib/tst_safe_macros.c.

> >> BTW I'm slightly confused, what would be the best place for this,
> >> lib/tst_safe_macros.c is being used nowadays for everything. But there is
> >> also



> >> include/tst_safe_file_ops.h, which does not have C file
> >> (lib/tst_safe_file_ops.c) because it internally use lib/tst_safe_macros.c.


> > No, basically it does not use the lib/tst_safe_macros.c.

> > From what I understand, 'tst_safe_file_ops.h' is just a header for
> > collecting
> > all the file operations for Linux, it doesn't touch other subcomponent ops.

> > 'tst_safe_file_ops.h' defines macros for all functions in
> > 'safe_file_ops_fn.h'
> > and archived them in 'safe_file_ops.c' lib.

> > Something like this combination:

> > tst_safe_file_ops.h:
> >     safe_file_ops_fn.h
> >     safe_file_ops.c


> The reason to split them into two headers is for backward compatibility.

> Technically we should declare 'safe_file_ops_fn.h' functions in one header
> 'tst_safe_file_ops.h' but you know we have 'old_safe_file_ops.h'.

> tst_safe_file_ops.h:
>     safe_file_ops_fn.h
>     safe_file_ops.c

> old_safe_file_ops.h:
>     safe_file_ops_fn.h
>     safe_file_ops.c

> In the future, the ideal cleanup direction is just to have:

> tst_safe_file_ops.h
> tst_safe_file_ops.c

Yep, the problem that Cyril originally implemented new API via legacy to
support both APIs (good and needed solution) and now we add only into new API
(also good solution) + that approach specific (and thus small) C sources
initially and later more generic (and longer) makes library a bit inconsistent.
I know, it will be solved once we get rid of the legacy API, but that will take
time.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
