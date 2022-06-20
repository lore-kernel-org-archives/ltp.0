Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B2CC43334
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 20:36:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B390E3C9357
	for <ltp@archiver.kernel.org>; Mon, 20 Jun 2022 22:36:01 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B9273C075E
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 22:35:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 470CB1400345
 for <ltp@lists.linux.it>; Mon, 20 Jun 2022 22:35:49 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id 30D4821FD7;
 Mon, 20 Jun 2022 20:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655757349; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aCfGW3g2aeFSpzq9KI/ficVNsamlEFMX6CXuTmqyEuM=;
 b=UxM5OaUZrHBzpx0QWyf0khe2ucrxH3u9vxA6wep9+VqXNEuIjhfu6GYY4+atPOKAjP7A26
 npTiLE+JhjBvgaTYaa6GveN/Se6/Jzox+LuiuKyx96CZqVcanEr0N3q2609PxPirn//mvH
 /wk8h1ZhkO1kvGXvgUA0nzKk9GaKD54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655757349;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aCfGW3g2aeFSpzq9KI/ficVNsamlEFMX6CXuTmqyEuM=;
 b=4LRhCHC3wvg19VvQexpMpF221WBJG3q0wBb7FanVobvbp0sUGilDkc33yFlXJ/205XNziQ
 uG79onjKxwGgc1Bw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 019CE2C141;
 Mon, 20 Jun 2022 20:35:49 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id A3FB6A0636; Mon, 20 Jun 2022 22:35:45 +0200 (CEST)
Date: Mon, 20 Jun 2022 22:35:45 +0200
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <20220620203545.hejk7faw3liw2kxw@quack3.lan>
References: <20220620132737.2015073-1-amir73il@gmail.com>
 <20220620132737.2015073-5-amir73il@gmail.com>
 <20220620152032.jbrhicuscem2f4kd@quack3.lan>
 <CAOQ4uxgmuS6qDVLQPqzNAoO2BtqcO55Mokcc70n2BukAhaH_Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxgmuS6qDVLQPqzNAoO2BtqcO55Mokcc70n2BukAhaH_Xw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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

On Mon 20-06-22 19:59:48, Amir Goldstein wrote:
> On Mon, Jun 20, 2022 at 6:20 PM Jan Kara <jack@suse.cz> wrote:
> >
> > On Mon 20-06-22 16:27:37, Amir Goldstein wrote:
> > > 1. Verify that an ignore mask that does not survive modify event,
> > >    does survive a modify event on child, if parent is not watching
> > >    events on children.
> > >
> > > 2. Verify that an ignore mask on parent does not ignore close events
> > >    sent to mount mark, if parent is not watching events on children.
> > >
> > > The behavior of these corner cases of ignore mask on parent dir have
> > > always been undefined, so do not run the test for kernel < v5.19.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> >
> > Hum, I was looking into the testcase. What does generate a modify event
> > there and checks that ignore mask does not survive it?
> 
> I think this does:
> 
>         /*
>          * generate MODIFY event and no FAN_CLOSE_NOWRITE event.
>          */
>         SAFE_FILE_PRINTF(fname, "1");

Yeah, I was looking at that but then I'm somewhat confused because this
gets called in .setup() hook while the notification groups get created only
in .test() hook that gets called later. What am I missing?

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
