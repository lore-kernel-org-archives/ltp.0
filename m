Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D637C433F5
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 15:49:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 922AA3C96A6
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 16:49:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 94E593C71B8
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 16:49:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1D3181400B85
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 16:49:24 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 47C6D1F3B5;
 Tue, 18 Jan 2022 15:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642520964;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E4PL0QuLADlxf6XX/djnW3xMCldV3xkLfnoMDS16YY8=;
 b=KU0ErZQ1evStDBUwuOxA944BBMgZCEPlyq4/npcg8/nLSzmu65l8K+4sa7NVdt7MoMYGlX
 Lzw7COC6ejZtvMqtDTme05VhfiqmPF1d+E6rPO5o/02oPuIxYZcjpaXTjUYGaQFnQEveN2
 xFXr9YrBjkamr2jU9vYniBbOEDFNPr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642520964;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E4PL0QuLADlxf6XX/djnW3xMCldV3xkLfnoMDS16YY8=;
 b=YRGZnFdBfaHDWQlXUlxfm8OqVkJBEWgfXs/uNeSiT2QJiqh3s/m6EWkOnVOQcicrnqvbZM
 9YFKCz4uNBtmW/Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20BA913AB7;
 Tue, 18 Jan 2022 15:49:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id c4OLBoTh5mEQbgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 18 Jan 2022 15:49:24 +0000
Date: Tue, 18 Jan 2022 16:49:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yebhgmc0e8hWtmPM@pevik>
References: <20220114125513.895-1-pvorel@suse.cz>
 <YebY7ut/d0sT80HQ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YebY7ut/d0sT80HQ@yuki>
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
> > Previously with --disable-metadata output didn't mention that metadata
> > are disabled and printed config which was not used. Now:

> > $ ./configure --disable-metadata
> > ...
> > METADATA
> > metadata disabled

> > $ ./configure
> > ...
> > METADATA
> > metadata generator: asciidoctor
> > HTML metadata: yes
> > PDF metadata: no

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  configure.ac | 7 +++++++
> >  1 file changed, 7 insertions(+)

> > diff --git a/configure.ac b/configure.ac
> > index 3c56d19224..5b9e3c1781 100644
> > --- a/configure.ac
> > +++ b/configure.ac
> > @@ -404,7 +404,14 @@ libtirpc: ${have_libtirpc:-no}
> >  glibc SUN-RPC: ${have_rpc_glibc:-no}

> >  METADATA
> > +EOF
> > +
> > +if test "x$enable_metadata" = xyes; then
> > +cat << EOF
> >  metadata generator: $with_metadata_generator
> >  HTML metadata: $with_metadata_html
> >  PDF metadata: $with_metadata_pdf

> Don't we stil have the same problem with "$enable_metadata_html" and
> "$enable_metadata_pdf" ?
Well, this patch was about configure output. I wouldn't print them at all if
metadata disabled. They're not used anyway in the code if metadata disabled.

> Also looking at m4/ltp-docparse.m4 shouldn't we just skip the
> autodetection if metadata are disabled and exit with all three wariables
> set to no?
Well, but that's how it is implemented:
$ ./configure --disable-metadata
...
configure: metadata generation disabled

And variables in config.log are:
METADATA_GENERATOR=''
WITH_METADATA='no'
WITH_METADATA_HTML='no'
WITH_METADATA_PDF='no'

It's a bit hard to write m4 macros when there is no return :).
It's hard to not fallback into many if/else levels.
I should have put some comments into the code.

Also, currently it's implemented that that we can disable both HTML and
PDF as: --disable-metadata-html --disable-metadata-pdf, maybe we could rethink
it.

> I think that we should rethink what the flags really do, I guess that
> for instance it would make sense for the $enable_metadata=no to just set
> both $enable_metadata_html and $enable_metadata_pdf to no and the rest
> of the m4/ltp-docparse.m4 should just check the later two.
Rethink the flags meaning or a functionality?

And how about flags names? What name would you suggest?
--disable-doc, --with-html-doc, --with-pdf-doc ?
Because we now have metadata (i.e. JSON output) mandatory.

I wonder what is needed to be fixed now and what's better to postpone after the
release?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
