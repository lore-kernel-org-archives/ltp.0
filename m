Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBD6C4332F
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 14:12:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D538B3CD26D
	for <ltp@archiver.kernel.org>; Mon, 14 Nov 2022 15:12:50 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FEFE3CD214
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 15:12:40 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9DD7020093A
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 15:12:38 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 4DFB61FF7A
 for <ltp@lists.linux.it>; Mon, 14 Nov 2022 14:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1668435158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ac0Mdtev9B/50YOrG7+fNlzCeUq0V7pkGHb8Q3Xp8XQ=;
 b=q2MWrukQywEYQJYB5kjWf07md2kCvuXv6q4FvW0Tpk+Ccm+sC2deqnsa7pB7NYuNqbomue
 mv0eMKkpndrdiAnlepI6rVRzssPalGovJ5KT4TruCmZ9GAPTI5mkREZiyMKnCbQV/R9SoI
 9kn3yQAdqbSt2WAZqFcKqr8dJMz7lVY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1668435158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ac0Mdtev9B/50YOrG7+fNlzCeUq0V7pkGHb8Q3Xp8XQ=;
 b=OXTe+GiwCqd6UfryNAUAUiCM2LfQEwXq9sJGlUkf/F4ITJO1IKdSOzQWAF/WYVV2sBNR0I
 pRiM5nYwhiI5OYCQ==
Received: from g78 (unknown [10.163.17.14])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id EF23A2C142;
 Mon, 14 Nov 2022 14:12:37 +0000 (UTC)
References: <20221110145429.8158-1-pvorel@suse.cz> <8735alu4bp.fsf@suse.de>
 <Y3JGoc2V7VjR0q9Z@pevik>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 14 Nov 2022 14:11:04 +0000
Organization: Linux Private Site
In-reply-to: <Y3JGoc2V7VjR0q9Z@pevik>
Message-ID: <87tu31sjze.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] README.md: Document IRC
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>> Hello,
>
>> Petr Vorel <pvorel@suse.cz> writes:
>
>> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
>> > ---
>> > changes v1->v2
>> > * s/on/at/
>
>> > Kind regards,
>> > Petr
>
>> >  README.md | 3 +++
>> >  1 file changed, 3 insertions(+)
>
>> > diff --git a/README.md b/README.md
>> > index d45d1ee44..89b2640c1 100644
>> > --- a/README.md
>> > +++ b/README.md
>> > @@ -22,6 +22,9 @@ http://lists.linux.it/listinfo/ltp
>> >  LTP mailing list is archived at:
>> >  https://lore.kernel.org/ltp/
>
>> > +IRC
>> > +#ltp at https://libera.chat/[irc.libera.chat]
>
> Hi Richie,
>
>> Won't the # make it a top level heading?
> Well, that would be if there was a separate line between those two lines.
>
>> https://daringfireball.net/projects/markdown/syntax#header
>
> Thus this would work. But I put asciidoc syntax (used in our wiki),
> instead of markdown.
>
> Therefore the correct syntax for README.md is:
>
> IRC #ltp at: [https://libera.chat/](irc.libera.chat)
>
> Kind regards,
> Petr

Well, either way:

Acked-by: Richard Palethorpe <rpalethorpe@suse.com>


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
