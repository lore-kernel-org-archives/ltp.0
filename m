Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AEFC6FA82
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 20:12:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 046D93CAAF7
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 22:12:00 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 264D23CAA99
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 22:11:50 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6E060600719
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 22:11:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3387720734;
 Mon, 12 Sep 2022 20:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663013509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zSJrj73LKihIAlbREAQeSW9uTzI1bkZPTba4GQl+KsM=;
 b=HzgTNjrwke5B74iKpcmGoYeJqXGaeEnotYs4+4Aqc6Jp/jdRTmZahLkb/SMcrC8E6s4xU3
 nmde/5sDJWv48GpE9wmLI2Orc167oespBDc3z9yl3y1jElHVG02Ft0Bel04y3u5NOLvsi2
 OMh4RmzRT6+KZmuUIliqKZuaeNIdvdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663013509;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zSJrj73LKihIAlbREAQeSW9uTzI1bkZPTba4GQl+KsM=;
 b=IOfsg3OqMdcCStOkc+r0wrOr2k7cgvma37RUxiPs/Agm+Yqi9C+3j7KNpvJgXMV7c3mara
 yAncjITZHKsPTdAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EC8B6139E0;
 Mon, 12 Sep 2022 20:11:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MQIZN4SSH2M9PQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 12 Sep 2022 20:11:48 +0000
Date: Mon, 12 Sep 2022 22:11:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yx+SgnOEGq0hZ/Mr@pevik>
References: <20220912101948.4425-1-pvorel@suse.cz>
 <Yx82LL6AX/TxDbbQ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yx82LL6AX/TxDbbQ@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] doc/user-guide: LTP_RUNTIME_MUL is only for C
 API
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Not yet implemented in shell API.
> > + fix indent.

> > Fixes: 0f72d519a ("Introduce a concept of max runtime")

> Should we rather then add "Not yet implemented" instead of "only for C
> API" to the actual documentation too?
Sure, no problem.

Kind regards,
Petr

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  doc/user-guide.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)

> > diff --git a/doc/user-guide.txt b/doc/user-guide.txt
> > index 0dc0c958e..fdd74ca41 100644
> > --- a/doc/user-guide.txt
> > +++ b/doc/user-guide.txt
> > @@ -27,8 +27,8 @@ For running LTP network tests see `testcases/network/README.md`.
> >                            Variable is also used in shell tests, but ceiled to int.
> >  | 'LTP_RUNTIME_MUL'     | Multiplies maximal test iteration runtime. Tests
> >                            that run for more than a second or two are capped on
> > -			  runtime. You can scale the default runtime both up
> > -			  and down with this multiplier.
> > +                          runtime. You can scale the default runtime both up
> > +                          and down with this multiplier. NOTE: only for C API.
> >  | 'LTP_VIRT_OVERRIDE'   | Overrides virtual machine detection in the test
> >                            library. Setting it to empty string tell the library
> >                            that system is not a virtual machine. Other possible
> > -- 
> > 2.37.3

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
