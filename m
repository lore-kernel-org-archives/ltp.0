Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0496FC433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 17:52:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DD103C9B54
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 18:52:40 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 193E73C071A
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 18:52:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5C99C200BA4
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 18:52:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 70037210F5;
 Tue,  8 Feb 2022 17:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644342749;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WeJLDsmwLBlgdDHrpgR7mXME7NYOqNvS43pMsRTmpOY=;
 b=bWaH5rteTbJV6hyArp9RZtJQVbiYgm95bQ54/MEP/saaAoUzUDXL5wYQcEBhKPkPVqx8f0
 qcoPsxbITqKRgdDLJBkRgRv/9ktJguNzvjgtqLPcK7Z6is7hd/YotL2fnbG2hTQyuo7kjE
 +S0ujyJ8vyefrUq3D4S7Kl5rXcluDMw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644342749;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WeJLDsmwLBlgdDHrpgR7mXME7NYOqNvS43pMsRTmpOY=;
 b=JLm6iD4XcN0YbN6k11XfyL6Kh4iiwFIQQ+JCuQ4WlDp7a7UfzicaIMTyIid27M24HiuxLM
 K8bAqrndysFlvJDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A28B13CDC;
 Tue,  8 Feb 2022 17:52:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id JgwvEN2tAmIncAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 08 Feb 2022 17:52:29 +0000
Date: Tue, 8 Feb 2022 18:52:27 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YgKt20FFsWmNLPT/@pevik>
References: <20220126145141.13825-1-pvorel@suse.cz>
 <20220126145141.13825-2-pvorel@suse.cz> <YgJv2+y6v/+Tpb1N@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgJv2+y6v/+Tpb1N@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_test.sh: Print environment variables in
 help
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

> Hi!
> > diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> > index 30614974c3..a7fd7b19c6 100644
> > --- a/testcases/lib/tst_test.sh
> > +++ b/testcases/lib/tst_test.sh
> > @@ -448,12 +448,30 @@ tst_usage()
> >  	if [ -n "$TST_USAGE" ]; then
> >  		$TST_USAGE
> >  	else
> > -		echo "usage: $0"
> > -		echo "OPTIONS"
> > +		cat << EOF
> > +usage: $0
> > +
> > +Options
> > +-------
> > +EOF

> I think that the cat EOF syntax inside of else branch is a bit
> confusing, especially sice it prints just three lines of text...

Good point, I'll replace it with echo.


> But other than that:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

How about dropping this?
echo "usage: $0"

(as a separate commit, I'd sent v2)

Because we don't support it in C API, is it really required to have it in shell.

I mean it's useful to show which options are mandatory or which cannot be
combined together etc. But in reality most of shell tests does not add it and
thus they are missing "OPTIONS" line (sure, I can add usage to them if you
think it's useful).

OTOH some tests have really complex setup, i.e.
testcases/network/netstress/netstress.c, that adding a support for usage string
would help them.

If you notice there were extra new lines (\n) to separate client and server side
to make help at least a bit readable, but Andrea removed them in 98af9ecf9e
("tst_test: Complete help message adding option before desc"):

git show --word-diff 98af9ecf9e334c07251f2f464191635f161a1603 testcases/network/netstress/netstress.c

These extra lines would not be needed when sort of usage added to C API.
I can add it, but I'm aware it's so minor, that I'm wasting a time of all of us.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
