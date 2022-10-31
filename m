Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D705FECAAA1
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 21:41:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C3453CAC1E
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 22:41:17 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5E9193CA9F0
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 22:41:06 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 83185100042E
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 22:41:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC9471F45B;
 Mon, 31 Oct 2022 21:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667252465;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IEq0uRBJESmhP/AGQtBpWSaJ7uLa5lhhlpTu3kVM8xs=;
 b=JzFAXB24mXC0TJXwYG3FTZE+ES6HnAEM08yDXzhldX0pDHTIYHy07VsMmJpBn49N560xdS
 mfWFH/80CT6VBh4hdEWifY7fRXcK2lbSyXUHO4kB0lFCHVAEY71YMU1+eIIa1PrYWe3YNl
 E0iTAhgdqWCHhAqKAfy2SPmX6RKHg2o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667252465;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IEq0uRBJESmhP/AGQtBpWSaJ7uLa5lhhlpTu3kVM8xs=;
 b=lnYTKoIbe4B6rJhUlUa92ox1i/oZ3iC3oMdAEWXFbZUtLF8u6bYAjoupqux479zMO1pFGa
 bOE4W04JKNMIw7CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9FE2D13451;
 Mon, 31 Oct 2022 21:41:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iL8PDPBAYGOrQAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 31 Oct 2022 21:41:04 +0000
Date: Mon, 31 Oct 2022 22:40:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y2BA6UBSrVQS6HiI@pevik>
References: <20221027140954.4094-1-akumar@suse.de>
 <87tu3kb098.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87tu3kb098.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsuid02: using -1 as invalid fsuid for
 setfsuid()
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

> Hello,

> Avinesh Kumar <akumar@suse.de> writes:

> > a uid which does not have an entry in the /etc/passwd
> > file is not really an invalid fsuid for setfsuid(), so changing
> > the test to use -1 as an invalid fsuid.
> > And second setfsuid(-1) call is to verify that preceding call has
> > actually failed and there is no change in the fsuid.

> I think the original test is flawed and testing what using -1 does is
> not very interesting as the kernel uses standard boilerplate to deal
> with this.

> AFAICT we don't test what happens if a non-root user tries to set the
> fsuid to a uid that is not the euid, ruid or saved uid or 0/-1.

> Possibly that is something for a new test though.

Ah, sorry, I overlooked this, merged now.

Kind regards,
Petr


> > Signed-off-by: Avinesh Kumar <akumar@suse.de>
> > ---
> >  testcases/kernel/syscalls/setfsuid/setfsuid02.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)

> > diff --git a/testcases/kernel/syscalls/setfsuid/setfsuid02.c b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
> > index 850f17834..f5aa1c004 100644
> > --- a/testcases/kernel/syscalls/setfsuid/setfsuid02.c
> > +++ b/testcases/kernel/syscalls/setfsuid/setfsuid02.c
> > @@ -21,9 +21,7 @@ static void run(void)
> >  	uid_t invalid_uid, current_uid;

> >  	current_uid = geteuid();
> > -	invalid_uid = 1;
> > -	while (getpwuid(invalid_uid))
> > -		invalid_uid++;
> > +	invalid_uid = -1;

> >  	UID16_CHECK(invalid_uid, setfsuid);

> > -- 
> > 2.38.0

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
