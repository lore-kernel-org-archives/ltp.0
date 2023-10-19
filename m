Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A90CDB465
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 11:08:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 907113C8494
	for <ltp@archiver.kernel.org>; Thu, 19 Oct 2023 13:08:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E800F3C8494
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 13:08:07 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0F77D2348A3
 for <ltp@lists.linux.it>; Thu, 19 Oct 2023 13:08:06 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1663C1F88B;
 Thu, 19 Oct 2023 11:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697713686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dU1UX3pLhTlUvHEi/5kh8aoXwt0qv2DSy2vntZUIrfc=;
 b=VE9LHi2pa1k2eNii0qP1X823U1mRWq3HLQ+3ENirqpCBTsiiqS9QH4q0zJ/HRPH/OPMUIS
 DrkW0YBTj2pYSOJaj0+IrhRpZxJTivcmnxHYsJnGLrrIlyTNNYX8Vq3RV1+B7hqaY0CLlS
 x8WwvEn307QFWNpATL8XlwqnnPsZZ3c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697713686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dU1UX3pLhTlUvHEi/5kh8aoXwt0qv2DSy2vntZUIrfc=;
 b=MVkK91wka7l3XyNazy1XmQcWrK0celI7e2He90swQfx0aQQs+sRZQov1KzK6+XR5YpvI5j
 2DwDXB93U09H0ZCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D041D1357F;
 Thu, 19 Oct 2023 11:08:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id w4+bLxUOMWUiEQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 19 Oct 2023 11:08:05 +0000
Date: Thu, 19 Oct 2023 13:08:01 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <20231019110801.GA51639@pevik>
References: <875y33vsks.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <875y33vsks.fsf@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-8.49 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-3.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 REPLY(-4.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-1.19)[89.10%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC] LTP open monthly meeting
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie,

> Hello,

> I propose a meeting once a month to discuss non-technical things such as
> patch review policy, overall direction and bike shed discussions. Anyone
> is welcome who is interested in that.

> Originally I thought just to include myself and some SUSE colleagues in
> an ad-hoc meeting to deal with Reviewed-by tag delegation. However I
> think the real problem is we have no LTP meeting in which to discuss
> these things and chat. The ML is not adequate for this IMO.

Good idea. Although we have ML, some things might be faster to discuss live.
I hope most of maintainers will have time for this.

> For me any time and day would be fine excluding 22:00 to 09:00
> UTC/GMT. Probably Monday to Friday would be best for most.

I'd also avoid weekend. On Mondays, Wednesdays and Fridays I could manage to
have it in the morning, but other days probably after lunch. I wonder if other
people would prefer the afternoon (after working hours).

NOTE: We should not clash with Thursday OATS monthly call which is _second_
Thursday in month, 14 UTC (or 15 UTC?).

And which platform would you use?

Kind regards,
Petr

> The agenda for the first meeting would be to discuss how to deal with
> the situation where someone reviews the V1 of a patch, but does not add
> their Reviewed-by tag in subsequent versions.

> After that just introductions, questions and anything someone would like
> to bring up.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
