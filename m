Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A727C05027
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 07:22:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A1CBF3CB0EE
	for <ltp@archiver.kernel.org>; Thu,  9 Feb 2023 08:22:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4E3993C4D54
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 08:22:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D7687600A69
 for <ltp@lists.linux.it>; Thu,  9 Feb 2023 08:22:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE0A334DB3;
 Thu,  9 Feb 2023 07:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1675927334;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q1Re9JEwP18To0tSeHTal1lSUtHY9wtuN0RA52y/r2o=;
 b=skSsvFF8Lj+385Cb6yoUhayZGn79iAzTJsxqm2x5nyBmDzShfkugsu/Nx3V0BwHDchHE2t
 UzVSU0Umyt5wBzqI626tbKxbhCX/Xpgmk/vDGb1wdUK4Ig722FNlcqJQFNeMf3T+SmyUhR
 aatbIGJfBR/grBaZ04qe6Q7jOzVi4lw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1675927334;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Q1Re9JEwP18To0tSeHTal1lSUtHY9wtuN0RA52y/r2o=;
 b=78kHDQb2z03OvBG1cz3goKl5xEvB6Kl/z/ny415wfW0VR2FFS3deRatNFGh8igcECDUaQR
 o34bVOvrwcHtRsCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id ACA3D1339E;
 Thu,  9 Feb 2023 07:22:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dwL2KCaf5GPNeAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Feb 2023 07:22:14 +0000
Date: Thu, 9 Feb 2023 08:22:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Y+SfJFSGewYd9lBR@pevik>
References: <20230207131714.2500-1-pvorel@suse.cz>
 <20230207131714.2500-2-pvorel@suse.cz>
 <CAEemH2chcTe263-zqpSF2Gc2CVc8NC+G-KZsFMbwoxEKyjA01w@mail.gmail.com>
 <20230208135404.GB31469@pevik>
 <CAEemH2cg_ATrf35WwFOoA0oqVN6GTZgT4jaRzkNjae8D6SBLZw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cg_ATrf35WwFOoA0oqVN6GTZgT4jaRzkNjae8D6SBLZw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] ioctl01: Add default tty device
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

...
> > FYI I'm using S_ISCHR() in other patches, which check if device can be
> > used.
> > Implementing search looks like a good idea. Are useful files any /dev/tty*
> > (including /dev/tty, /dev/ttyACM0, /dev/ttyS0) or should I avoid any file
> > or include other paths?


> It seems not all char devices can be used here.
> The /dev/tty*Num* should be the first choice.
+1

I'd also use /dev/tty (in case there is no tty0).

> I tried some of them and only /dev/tty0-N works well,
> maybe we can just make use of them to avoid no tty0
> file failure should be enough. Because my only concern
> about the hard coding is that "/dev/tty0" is non-exist.

FYI On my system ioctl01 fail on /dev/ttyS0-N (EIO instead of other expected
errors). The rest /dev/tty, /dev/tty0-N, /dev/ttyACM0-N work.
/dev/ttyACM0-N are just on one of my system, let's not use it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
