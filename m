Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C14FC43334
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 08:32:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 464F53C9411
	for <ltp@archiver.kernel.org>; Tue, 21 Jun 2022 10:32:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 001993C2806
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 10:31:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 22C99600800
 for <ltp@lists.linux.it>; Tue, 21 Jun 2022 10:31:56 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 4EB3F1F917;
 Tue, 21 Jun 2022 08:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655800316; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q0XGmsA7Uu4DRioSOJa0UqHj8Psqe0llqp8FV1Nbx3I=;
 b=SFe3EYmtzXD9RCHzgwefm9lqgRgVCwntXJBRkdW5DYYljaIbJVAuUzhUgRTDERmelx/pXC
 QE3VORIUqxGghlMieyglDPZKFco6AIpn90xfHIqcZ1sWVXZBMtPXmU38hvtogXc+0WtklF
 3NYaa6TUDhJfMEVbje0ebxQP9+g61Kw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655800316;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q0XGmsA7Uu4DRioSOJa0UqHj8Psqe0llqp8FV1Nbx3I=;
 b=+BByoeG+WUij3fm9MbmS84ew+Rd/IzFxUpFf95ZEq5Z09LB+wsoqteq9PVEiOY4QhAMKcz
 6jHaN7iaiPX7xRCA==
Received: from quack3.suse.cz (unknown [10.100.224.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 3A44B2C141;
 Tue, 21 Jun 2022 08:31:56 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id DA008A062B; Tue, 21 Jun 2022 10:31:55 +0200 (CEST)
Date: Tue, 21 Jun 2022 10:31:55 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20220621083155.a6wdaf5oj7gmtzg6@quack3.lan>
References: <20220620132737.2015073-1-amir73il@gmail.com>
 <20220620132737.2015073-5-amir73il@gmail.com>
 <20220620152032.jbrhicuscem2f4kd@quack3.lan>
 <CAOQ4uxgmuS6qDVLQPqzNAoO2BtqcO55Mokcc70n2BukAhaH_Xw@mail.gmail.com>
 <20220620203545.hejk7faw3liw2kxw@quack3.lan>
 <CAOQ4uxg_F+BeuYou1CTM-UMURiFpW362=f7-FJD5MKXDJpw=4A@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxg_F+BeuYou1CTM-UMURiFpW362=f7-FJD5MKXDJpw=4A@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] syscalls/fanotify09: Add test cases for merge
 of ignore mask
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>,
 Matthew Bobrowski <repnop@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue 21-06-22 06:02:24, Amir Goldstein wrote:
> On Mon, Jun 20, 2022 at 11:35 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 20-06-22 19:59:48, Amir Goldstein wrote:
> > > On Mon, Jun 20, 2022 at 6:20 PM Jan Kara <jack@suse.cz> wrote:
> > > >
> > > > On Mon 20-06-22 16:27:37, Amir Goldstein wrote:
> > > > > 1. Verify that an ignore mask that does not survive modify event,
> > > > >    does survive a modify event on child, if parent is not watching
> > > > >    events on children.
> > > > >
> > > > > 2. Verify that an ignore mask on parent does not ignore close events
> > > > >    sent to mount mark, if parent is not watching events on children.
> > > > >
> > > > > The behavior of these corner cases of ignore mask on parent dir have
> > > > > always been undefined, so do not run the test for kernel < v5.19.
> > > > >
> > > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > >
> > > > Hum, I was looking into the testcase. What does generate a modify event
> > > > there and checks that ignore mask does not survive it?
> > >
> > > I think this does:
> > >
> > >         /*
> > >          * generate MODIFY event and no FAN_CLOSE_NOWRITE event.
> > >          */
> > >         SAFE_FILE_PRINTF(fname, "1");
> >
> > Yeah, I was looking at that but then I'm somewhat confused because this
> > gets called in .setup() hook while the notification groups get created only
> > in .test() hook that gets called later. What am I missing?
> 
> There is one in setup().
> The one with the comment above is from test_fanotify().

Bah, I must have been blind... Thanks for directing me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
