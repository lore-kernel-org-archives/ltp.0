Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33759C433EF
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 16:06:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B2D033C948F
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 18:06:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F39F53C8F82
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 18:05:49 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6BD4A10005A0
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 18:05:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BD9A01F895;
 Mon, 13 Jun 2022 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655136348;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZW302WPZ/im3La6j5oscAa2aDVFM9Z1OekTYKMqChfg=;
 b=yngpcgAo5YbIU0RPM6H+FxliUFsiYLYLRjEGdBzGBHWc77GmVmxLBGKpiO1wqqv4YZWVxV
 5tuUGzXuqj3g5LorS/UV1DUSAvYpyxiId2Fp+HJCUzqrL6GgFju4buqvc5lCv8cEOUsMOf
 N7SnP1XLv2t/ewvOrIMdGEyLzNTOtMQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655136348;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZW302WPZ/im3La6j5oscAa2aDVFM9Z1OekTYKMqChfg=;
 b=RzkLVSn+Piym9dl13Q9kp9Zm6ENAdw56b0RNKiTxTTdWAqYlbrUoFwt2xhTL1AiKPaFRKb
 DZbAUzovNlb2BkCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72587134CF;
 Mon, 13 Jun 2022 16:05:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id p2fKGVxgp2KlaQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Jun 2022 16:05:48 +0000
Date: Mon, 13 Jun 2022 18:05:46 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YqdgWvHoiqeANzCi@pevik>
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-2-amir73il@gmail.com>
 <CAOQ4uxjfuQ5oj8V8weD+-ChvXZ9nXy=MB285dAn1zQKV6dn2cA@mail.gmail.com>
 <YqdWY1C/xBi3/tgG@pevik>
 <CAOQ4uxh6aJq+uMsFOBBeG+S3OTGABP2qmb7oDXOATa35A83H3g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxh6aJq+uMsFOBBeG+S3OTGABP2qmb7oDXOATa35A83H3g@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] syscalls/inotify12: Introduce test for
 inotify mask flags
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On Mon, Jun 13, 2022 at 6:23 PM Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Amir,

> > > > diff --git a/testcases/kernel/syscalls/inotify/inotify12.c b/testcases/kernel/syscalls/inotify/inotify12.c
> > ...
> > > > +static struct tst_test test = {
> > > > +       .timeout = 10,

> > > OOPS should be changed to .max_runtime = 10

> > > > +       .needs_tmpdir = 1,
> > > > +       .cleanup = cleanup,
> > > > +       .test = verify_inotify,
> > > > +       .tcnt = ARRAY_SIZE(tcases),
> > > > +       .tags = (const struct tst_tag[]) {
> > > > +               {"linux-git", "a32e697cda27"},
> > > > +               {}

> > > Missing }

> > > Sorry, I hadn't notice this build failure before posting.

> > No big deal, we can fix this before merge.

> > And we have to try again to decide how to quickly merge tests for rc kernel.

> Right.. forgot about that.
> FWIW, the specific fix of test inotify12 is already in stable kernels
> (v5.10.121, ...)
Correct, I have searched for this before. That means we merge this one very
soon. I'm just waiting if Jan has some comments.

Kind regards,
Petr

> Thanks,
> Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
