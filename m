Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 653EAC433F5
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 07:55:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 739F93C8F33
	for <ltp@archiver.kernel.org>; Wed,  1 Dec 2021 08:55:43 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 41E343C02F7
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 08:55:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A34482010E3
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 08:55:33 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 94C26212CB
 for <ltp@lists.linux.it>; Wed,  1 Dec 2021 07:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1638345332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=60HHRTlKipyplTpfvUpIgE3xXu4o+tcppCfhiXR0W9Y=;
 b=lpdowZK6RQzBd70sV3zEjGfSwYWiyFCgPz5593gocCI81irtWK7pPArDdlWZSzeJxVr4qy
 JbF1QMBA/BA1aDTWqxwwhadYxA1iq88qkPe2fqSM4SLstR+JhJjbmTte+CeXGw4CUgzu4S
 uyGpgqNQOYTneHMGa+Zu6/pV0NMwzbc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1638345332;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=60HHRTlKipyplTpfvUpIgE3xXu4o+tcppCfhiXR0W9Y=;
 b=u2305fvQBiO7bBOohTsb+Kk+y4SjfWMm3iHW5sjQOBwQCAVTugw7y+fESeHHAq/JnAbHLg
 aoGnJp2ttesP9xBA==
Received: from g78 (unknown [10.163.24.38])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 665A4A3B81;
 Wed,  1 Dec 2021 07:55:32 +0000 (UTC)
References: <20211130114527.5942-1-chrubis@suse.cz> <87ilw9lour.fsf@suse.de>
 <YaY0wB2ABtq7ypBW@yuki>
User-agent: mu4e 1.6.9; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 01 Dec 2021 07:21:37 +0000
In-reply-to: <YaY0wB2ABtq7ypBW@yuki>
Message-ID: <87y254daj0.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sparse: Skip TCID and TST_TOTAL
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

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> > Since these are part of the old library API.
>> >
>> > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
>> > ---
>> >  tools/sparse/sparse-ltp.c | 3 +++
>> >  1 file changed, 3 insertions(+)
>> >
>> > diff --git a/tools/sparse/sparse-ltp.c b/tools/sparse/sparse-ltp.c
>> > index b1677d336..1a3b4089a 100644
>> > --- a/tools/sparse/sparse-ltp.c
>> > +++ b/tools/sparse/sparse-ltp.c
>> > @@ -98,6 +98,9 @@ static void check_symbol_visibility(const struct symbol *const sym)
>> >  	if (!(mod & MOD_TOPLEVEL))
>> >  		return;
>> >  
>> > +	if (!strcmp(name, "TCID") || !strcmp(name, "TST_TOTAL"))
>> > +		return;
>> 
>> Would it be better to print a warning that old library crap has been
>> detected?
>
> I guess so.
>
>> My expectation is that 'make check' will produce a lot of noise if ran
>> on tests which haven't even been converted to the new library. Also it's
>> possible someone may forget to remove TCID etc.
>
> Well we may as well print the warnings only if new library test is
> detected. But I guess that is not an easy task since we would have to
> look at the include directives even before we attempt to parse the
> file..

Some checks may require detecting the type of translation unit in an
initial pass. At which point we will probably get this for free.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
