Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85071C433EF
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 06:48:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 951DC3C9F6D
	for <ltp@archiver.kernel.org>; Tue, 26 Jul 2022 08:48:32 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 67E903C06A9
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 08:48:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 54C39140004E
 for <ltp@lists.linux.it>; Tue, 26 Jul 2022 08:48:20 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A0C0F1F9CE;
 Tue, 26 Jul 2022 06:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658818100;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7HuhhNsUF7xIwslnH0hevUzAFv6dXuzq9+tpjhC2S5A=;
 b=PWN8i1ku+20zKetV6B9ZnP5r0QLvwEyrg997OFBu/vMau3Oix2CkMRtNFZxv7xH8FUaF/S
 qJvLuiTI2EfPBGXIcwIn6GW80mK+CnZ3f59XURkZ45PXZl+Dkp+/TfQ708n7fynxXWIVpp
 ISbFhQAp0YOieH1KLpnUo2SSBPOhTMg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658818100;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7HuhhNsUF7xIwslnH0hevUzAFv6dXuzq9+tpjhC2S5A=;
 b=UZ+NJOD1R/1e3evTYdIsGFt0BCtCeXIpOTSg+mqkTk3YKLvSBXdM9PvrzPO63CbDho7qj8
 68soWdEjxibZOmCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8303B13A7C;
 Tue, 26 Jul 2022 06:48:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id m7ItHjSO32LJWAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Jul 2022 06:48:20 +0000
Date: Tue, 26 Jul 2022 08:48:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Yt+OMvGzUh//+0vk@pevik>
References: <20220616140717.23708-1-andrea.cervesato@suse.com>
 <20220616140717.23708-2-andrea.cervesato@suse.com>
 <YqumDWnqP35qT0t0@pevik> <YqunUfT847rSDkLY@pevik>
 <aeddb36f-69db-0fae-cec4-df3956e2e6db@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aeddb36f-69db-0fae-cec4-df3956e2e6db@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/7] Add more safe macros for mqueue API
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

Hi Andrea,

> Hi!

> On 6/16/22 23:57, Petr Vorel wrote:
> > Hi Andrea,

> > ...
> > > > +static inline int safe_mq_close(const char *file, const int lineno,
> > > > +				mqd_t __mqdes)
> > > > +{
> > > > +	int rval;
> > > > +
> > > > +	rval = mq_close(__mqdes);
> > > > +
> > > > +	if (rval == -1) {
> > > > +		tst_brk_(file, lineno, TBROK | TERRNO,
> > > > +			"mq_close(%d) failed", __mqdes);
> > > > +	}
> > > How about check for invalid return value?
> > > 	} else if (rval < 0) {
> > > 		tst_brk_(file, lineno, TBROK | TERRNO,
> > > 			"Invalid mq_close(%d) return value %d", __mqdes, rval);
> > > 	}
> > Also safe_mq_open() could have check for invalid return value.

> It's already like that, Isn't it?

No it's not. But looking for v3 of this patchset (v3) you have added it.
Thanks!

Kind regards,
Petr

> > Kind regards,
> > Petr

> Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
