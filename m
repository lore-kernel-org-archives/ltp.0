Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0641BC433F5
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 16:47:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EDFFD3C9673
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 17:47:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B814D3C03FE
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 17:47:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A3E021400BCD
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 17:47:33 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A0C75218E3;
 Tue, 18 Jan 2022 16:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642524452;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zUJPEChEFgpzIxJba/dLNQKU57gNdqF2BYYE1RcPIuk=;
 b=btTNNi4eBdy/1dZgsrHfHit4EjodiV2JWvG9KhUG2h4t+MkOXhxmy9wnvkCyoBb3Hj080o
 O2aSvJAGoRX54U8ju/al8Ls4oipkcdBOwdhM2klUNMDtMl6etXFUWmh2XKHp31hgGi3yHM
 o71LA72J9Ni6cmTZjXhHTryr81k79VA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642524452;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zUJPEChEFgpzIxJba/dLNQKU57gNdqF2BYYE1RcPIuk=;
 b=VkYxNWGoWrAfuoVobJb1niYKtIT/crxZoLxsz+yGI7SVyXMDwxyLslfABCbvh/loZqVQdE
 c3r0YDmhHZmgUlBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B79613DCD;
 Tue, 18 Jan 2022 16:47:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HHinHCTv5mF1DgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 18 Jan 2022 16:47:32 +0000
Date: Tue, 18 Jan 2022 17:47:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YebvIXALFEQRFai2@pevik>
References: <20220114125513.895-1-pvorel@suse.cz> <YebY7ut/d0sT80HQ@yuki>
 <Yebhgmc0e8hWtmPM@pevik> <YebltjyJfw4CQnVK@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YebltjyJfw4CQnVK@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] configure.ac: Fix summary for disabled
 metadata
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

Hi Cyril,

> Hi!
> > > Don't we stil have the same problem with "$enable_metadata_html" and
> > > "$enable_metadata_pdf" ?
> > Well, this patch was about configure output. I wouldn't print them at all if
> > metadata disabled. They're not used anyway in the code if metadata disabled.

> I guess that I'm still confused by the configure script, because we do
> use enable_metadata_html and enable_metadata_pdf but I do not get how
> the enable_metadata works, we do not seem to use it for anything but
> perl module check in there.

> What I would have expected there would be:

> diff --git a/m4/ltp-docparse.m4 b/m4/ltp-docparse.m4
> index 88d2e08e4..6f0bef1c9 100644
> --- a/m4/ltp-docparse.m4
> +++ b/m4/ltp-docparse.m4
> @@ -35,7 +35,12 @@ with_metadata=no
>  with_metadata_html=no
>  with_metadata_pdf=no

> -if test "x$enable_metadata" = xyes && test "x$enable_metadata_html" = xyes -o "x$enable_metadata_pdf" = xyes; then
> +if test "x$enable_metadata" != xyes; then
> +       enable_metadata_html=no
> +       enable_metadata_pdf=no
> +fi
> +
> +if test "x$enable_metadata_html" = xyes -o "x$enable_metadata_pdf" = xyes; then
>         AX_PROG_PERL_MODULES(Cwd File::Basename JSON LWP::Simple)
>  fi

+1 to this code. Thanks!

> And that would cause both with_metadata_html and with_metadata_pdf to be
> set to 'no' and the configure summary would be correct to begin with.

$ ./configure --disable-metadata
METADATA
metadata generator: detect
HTML metadata: no
PDF metadata: no

$ ./configure --disable-metadata-pdf --disable-metadata-html
METADATA
metadata generator: detect
HTML metadata: no
PDF metadata: no

$ ./configure --disable-metadata-html
METADATA
metadata generator: detect
HTML metadata: no
PDF metadata: no

$ ./configure --disable-metadata-pdf
METADATA
metadata generator: asciidoctor
HTML metadata: yes
PDF metadata: no

Well, everything works as expected (not a surprise), but not sure if "detect" is
not confusing people.  I's still prefer just saying there are no metadata generated.
But that's the presentation in configure summary. Also no strong feeling about it :).
You can merge this patch with my ack, that's an improvement anyway.

> > > I think that we should rethink what the flags really do, I guess that
> > > for instance it would make sense for the $enable_metadata=no to just set
> > > both $enable_metadata_html and $enable_metadata_pdf to no and the rest
> > > of the m4/ltp-docparse.m4 should just check the later two.
> > Rethink the flags meaning or a functionality?

> > And how about flags names? What name would you suggest?
> > --disable-doc, --with-html-doc, --with-pdf-doc ?
> > Because we now have metadata (i.e. JSON output) mandatory.

> I guess that I would call this 'autodoc' or 'docparse' or something
> that describes that it's generated documentation.
Again, isn't it "docparse" or "autodoc" confusing for users?

I'd prefer to have just "doc", but agree, doc are documentation files in doc/,
which we don't transform to html/pdf (we could in the future, but that's a
different story).

I mean if we change flag, which requires user to notice and distros update
packaging recipes it should be really an improvement. Maybe
--metadata-doc{,-html,-pdf} ?

> > I wonder what is needed to be fixed now and what's better to postpone after the
> > release?

> Depends on the size of the patch, if it's small enough, like the one I
> posted above it should be okay.

Patch like this is OK. Also simple rename of flags would work. I thought you
wanted a bigger rewrite.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
