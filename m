Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7683ECAAD5
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 11:15:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F40C3CAACE
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 13:15:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CD0B3C0475
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 13:15:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7F4CC600697
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 13:15:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 570F61FFD3;
 Mon, 12 Sep 2022 11:15:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662981307;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pq9DB7f1ZW70eaQa2jKpoo48FCTq3wlKIpS0D44pDNs=;
 b=oxzzpGi5vvhTuTnt8AD15YwOnyy++a0r8WK/iGgy5RF2yIr6PcTsBq9iPIWPzpBHfpUcVD
 ESwHec721R/QtqUYMlAK9goclk0jx9UODnQqBiUzFy1UAdO+FSdRMf/JUkbKD2wyF+ZQFZ
 +iXRQuiZOp1fl5IM5LABs47Ln/b4sEY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662981307;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pq9DB7f1ZW70eaQa2jKpoo48FCTq3wlKIpS0D44pDNs=;
 b=JI1Tp+8D/aF70TaE6JC/Ua+T+IITrvVxqfrGvpEAD4byssmL7d7UUwzZ8NRF78C0EFI2Rq
 pHPivyhufWWOLIDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 17B0B139E0;
 Mon, 12 Sep 2022 11:15:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id hQb1A7sUH2NvcwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 12 Sep 2022 11:15:07 +0000
Date: Mon, 12 Sep 2022 13:15:05 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yx8UubeRfFbztSUW@pevik>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-3-pvorel@suse.cz> <Yx8EDrF0P9fhbC3O@yuki>
 <Yx8GIUos8bZNja1D@pevik> <Yx8I0ponDUIFC8le@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yx8I0ponDUIFC8le@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 02/10] shell API/tests: Require root for
 format/mount tests
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
> > > > Although the warning is quite obvious:
> > > > tst_device.c:101: TINFO: Not allowed to open /dev/loop-control. Are you root?: EACCES (13)
> > > > tst_device.c:140: TINFO: No free devices found
> > > > TBROK: Failed to acquire device

> > > > It's safer to expect root to get valid result.

> > > Another option would actually be to make the TST_NEED_DEVICE flag imply
> > > TST_NEEDS_ROOT flag, but I do not think that we have that for the C
> > > library either.
> > No, it does not imply in C API either. Yes, that would make sense for both API.
> > But I'd keep it as it is now and I'll do this change after the release,
> > Because I have other small fixes on API I'd like to post before the release.

> > BTW I always wondered why it was not done from the start, I thought there is a
> > reason for that (i.e. some special user with approved permissions).

> Well technically you can be added into whatever group is set to
> /dev/loop-control e.g. disk group and then you can create devices
> without a need to be a root.

> So the most correct solution would be checking if we can access
> /dev/loop-control if tst_test.needs_device is set and if not we would
> imply needs_root. However this would need to be rethinked properly so
> that we do not end up creating something complex and not really
> required.
Agree. I wonder if anybody tests with this setup.
I guess people just test with root (which is the reason why some tests have to
switch to nobody).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
