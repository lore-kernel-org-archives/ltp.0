Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E679C433EF
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 16:05:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0993B3C968A
	for <ltp@archiver.kernel.org>; Tue, 18 Jan 2022 17:05:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F168F3C6F6F
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 17:05:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 759BD6007AC
 for <ltp@lists.linux.it>; Tue, 18 Jan 2022 17:05:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9066C2177B;
 Tue, 18 Jan 2022 16:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642521935; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=liPvLSlB3ev8sCT0Yy4dUtv7a+hVL1H0sdym09j8aDk=;
 b=jlez7Ijfs7VsUYIbxtzbf0PdkTdN9lRIsQ6I1X/uVB017keht3fX9kH6JCtiIYlccddJGE
 nW3tplT17f4cmNpZQKH1flm2iwbnQx/OwJyn4zWOk0yD0Sg8YU4oBc1otxUl81PHs8dyKf
 UtouAYjxCR8NiPpGZofCLxi0hcVvE6w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642521935;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=liPvLSlB3ev8sCT0Yy4dUtv7a+hVL1H0sdym09j8aDk=;
 b=d/0AE6bDDRyI1r9M0y7ZyZ5SSnt9qxPqZs812v9heQ9WaZPOiUsVlNIy+nv8EV1inmdtzE
 RTl5zUg/IdjNJqAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7608713DCD;
 Tue, 18 Jan 2022 16:05:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id D4PSGk/l5mGFdgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 18 Jan 2022 16:05:35 +0000
Date: Tue, 18 Jan 2022 17:07:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YebltjyJfw4CQnVK@yuki>
References: <20220114125513.895-1-pvorel@suse.cz> <YebY7ut/d0sT80HQ@yuki>
 <Yebhgmc0e8hWtmPM@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yebhgmc0e8hWtmPM@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > Don't we stil have the same problem with "$enable_metadata_html" and
> > "$enable_metadata_pdf" ?
> Well, this patch was about configure output. I wouldn't print them at all if
> metadata disabled. They're not used anyway in the code if metadata disabled.

I guess that I'm still confused by the configure script, because we do
use enable_metadata_html and enable_metadata_pdf but I do not get how
the enable_metadata works, we do not seem to use it for anything but
perl module check in there.

What I would have expected there would be:

diff --git a/m4/ltp-docparse.m4 b/m4/ltp-docparse.m4
index 88d2e08e4..6f0bef1c9 100644
--- a/m4/ltp-docparse.m4
+++ b/m4/ltp-docparse.m4
@@ -35,7 +35,12 @@ with_metadata=no
 with_metadata_html=no
 with_metadata_pdf=no

-if test "x$enable_metadata" = xyes && test "x$enable_metadata_html" = xyes -o "x$enable_metadata_pdf" = xyes; then
+if test "x$enable_metadata" != xyes; then
+       enable_metadata_html=no
+       enable_metadata_pdf=no
+fi
+
+if test "x$enable_metadata_html" = xyes -o "x$enable_metadata_pdf" = xyes; then
        AX_PROG_PERL_MODULES(Cwd File::Basename JSON LWP::Simple)
 fi

And that would cause both with_metadata_html and with_metadata_pdf to be
set to 'no' and the configure summary would be correct to begin with.

> > I think that we should rethink what the flags really do, I guess that
> > for instance it would make sense for the $enable_metadata=no to just set
> > both $enable_metadata_html and $enable_metadata_pdf to no and the rest
> > of the m4/ltp-docparse.m4 should just check the later two.
> Rethink the flags meaning or a functionality?
> 
> And how about flags names? What name would you suggest?
> --disable-doc, --with-html-doc, --with-pdf-doc ?
> Because we now have metadata (i.e. JSON output) mandatory.

I guess that I would call this 'autodoc' or 'docparse' or something
that describes that it's generated documentation.

> I wonder what is needed to be fixed now and what's better to postpone after the
> release?

Depends on the size of the patch, if it's small enough, like the one I
posted above it should be okay.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
