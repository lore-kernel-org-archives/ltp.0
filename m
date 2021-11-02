Return-Path: <SRS0=DF5p=PV=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7C4C433F5
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 14:55:07 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E9F7D604D2
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 14:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E9F7D604D2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 049513C7182
	for <ltp@archiver.kernel.org>; Tue,  2 Nov 2021 15:55:04 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BF3C3C6268
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 15:54:54 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6982E10009BD
 for <ltp@lists.linux.it>; Tue,  2 Nov 2021 15:54:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 544AC1FD4C;
 Tue,  2 Nov 2021 14:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635864892;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gwFF0tmDNMiToi6bWtXbJb7OKFLRf9VgPnow8NyC9N4=;
 b=EB/Oz11sZuj48zPAv/e36FTeAuP8SFte4fx/2bC57/765pOhBjPXcDqhz661rywYigOtFp
 IBfrvKyPaMRVqmJ7AGZob/jcD2S2pLhjOcwKxMKYW3cok5Q5k/pKvzcS9GY61FPTa7R2yd
 QJVmCeh4hbgdjfESUxjUcLb8QfEcqKY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635864892;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gwFF0tmDNMiToi6bWtXbJb7OKFLRf9VgPnow8NyC9N4=;
 b=ovx58RQPM52vM6q/sZXY/x+215qi0LkfBtnucGPKIAoNOoiT0RKL2SPNgmNewG3kcLqNwn
 N234tiM0bXOW+iDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 20BEF13C30;
 Tue,  2 Nov 2021 14:54:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AGnHBDxRgWHKOgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 02 Nov 2021 14:54:52 +0000
Date: Tue, 2 Nov 2021 15:54:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YYFROnbswkA6knMN@pevik>
References: <20211101145342.7166-1-chrubis@suse.cz>
 <20211101145342.7166-2-chrubis@suse.cz> <871r3yq0hm.fsf@suse.de>
 <YYEfNvjosOzWzKRJ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YYEfNvjosOzWzKRJ@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] docparse: Implement #define and #include
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

Hi Cyril, Richie,

> Hi!
> > > +static void macro_get_string(FILE *f, char *buf, char *buf_end)
> > > +{
> > > +	int c;
> > > +
> > > +	for (;;) {
> > > +		c = fgetc(f);
> > > +
> > > +		switch (c) {
> > > +		case '"':

> > Luckily there are no instances of '#define MACRO "...\"...\"..."' in LTP
> > AFAICT. Also there don't appear to be any '#define MACRO "..." \\n' that
> > we would care about.
Good catch!

Unless you send v3 feel free to add
Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Well I can fix that and add a test to to be sure.
Thanks!

...
> > > +static void macro_get_val(FILE *f, char *buf, size_t buf_len)
> > > +{
> > > +	int c, prev = 0;
> > > +	char *buf_end = buf + buf_len - 1;
> > > +
> > > +	c = fgetc(f);
> > > +	if (c == '"') {

> > I guess this could be whitespace unless scanf slurps any trailing
> > whitespace?

> The scanf does not slurp any trainling whitespaces, so this should be
> fixed by:

> 	while (isspace(c = fgetc(f)));

> With that we get slightly better output, so I will add that before
> applying.
+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
