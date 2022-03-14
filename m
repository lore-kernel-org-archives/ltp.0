Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85534C433F5
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 14:14:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 36DBE3CA29E
	for <ltp@archiver.kernel.org>; Mon, 14 Mar 2022 15:14:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A6C83C9F42
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 15:14:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 21B4B200A11
 for <ltp@lists.linux.it>; Mon, 14 Mar 2022 15:14:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3A0091F37E;
 Mon, 14 Mar 2022 14:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647267243;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HrglDhmMastwrzZgSQvea/dwr6bRBKWN+aYBSsZRkuQ=;
 b=GCnpTD0juqZmYOaW+0EB36VOkjHdHwT2SSRbxXJSmG9zeU/sey418wspR18YHAcCG5n2X6
 0/dCQy2CjXKBTP5poNdstlMnSuvy762dqI6SO9o/AIvrun9jRkZPbB/ve716jPUjR7VC0S
 BrjOr5qjPWs/fAV2uFDHkVoWStc2QMs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647267243;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HrglDhmMastwrzZgSQvea/dwr6bRBKWN+aYBSsZRkuQ=;
 b=oCIGk28qRjd1SVWrWEKxG+iZ9mL7RQnyF5ZSy/wpzgUPx3dilSmqMofeMVUDFEzMODJWhx
 pwJQAfJemsWrm3BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CC6013B34;
 Mon, 14 Mar 2022 14:14:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id /55VAatNL2IRcgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 14 Mar 2022 14:14:03 +0000
Date: Mon, 14 Mar 2022 15:14:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yi9Nqfdfv+B9P8lG@pevik>
References: <20220126145141.13825-1-pvorel@suse.cz>
 <20220126145141.13825-2-pvorel@suse.cz> <YgJv2+y6v/+Tpb1N@yuki>
 <YgKt20FFsWmNLPT/@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YgKt20FFsWmNLPT/@pevik>
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

Hi Cyril, Li,

> > Hi!
> > > diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
> > > index 30614974c3..a7fd7b19c6 100644
> > > --- a/testcases/lib/tst_test.sh
> > > +++ b/testcases/lib/tst_test.sh
> > > @@ -448,12 +448,30 @@ tst_usage()
> > >  	if [ -n "$TST_USAGE" ]; then
> > >  		$TST_USAGE
> > >  	else
> > > -		echo "usage: $0"
> > > -		echo "OPTIONS"
> > > +		cat << EOF
> > > +usage: $0
> > > +
> > > +Options
> > > +-------
> > > +EOF

> > I think that the cat EOF syntax inside of else branch is a bit
> > confusing, especially sice it prints just three lines of text...

> Good point, I'll replace it with echo.

FYI merged with replaced echo.


> > But other than that:

> > Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> How about dropping this?
> echo "usage: $0"

> (as a separate commit, I'd sent v2)

> Because we don't support it in C API, is it really required to have it in shell.

> I mean it's useful to show which options are mandatory or which cannot be
> combined together etc. But in reality most of shell tests does not add it and
> thus they are missing "OPTIONS" line (sure, I can add usage to them if you
> think it's useful).

> OTOH some tests have really complex setup, i.e.
> testcases/network/netstress/netstress.c, that adding a support for usage string
> would help them.

> If you notice there were extra new lines (\n) to separate client and server side
> to make help at least a bit readable, but Andrea removed them in 98af9ecf9e
> ("tst_test: Complete help message adding option before desc"):

> git show --word-diff 98af9ecf9e334c07251f2f464191635f161a1603 testcases/network/netstress/netstress.c

> These extra lines would not be needed when sort of usage added to C API.
> I can add it, but I'm aware it's so minor, that I'm wasting a time of all of us.

FYI I'll probably add options string for shell and might add support for C API
to have help (would be useful for netstress.c).

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
