Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A6F4C636D4
	for <ltp@archiver.kernel.org>; Mon, 13 Feb 2023 23:25:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA5163CC9EC
	for <ltp@archiver.kernel.org>; Tue, 14 Feb 2023 00:25:52 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 139FD3C03AE
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 00:25:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 27D9C1400441
 for <ltp@lists.linux.it>; Tue, 14 Feb 2023 00:25:40 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D07A92062F;
 Mon, 13 Feb 2023 23:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676330739;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vMl2+VJTPwJFftrwwenz4SuP20RVubFuM/OWjrHiNcM=;
 b=aJvObz2C4nOjdlTub3AZ2KFl2GRB+BZbeSKLU0jy2b0j28jJrLaMD9/BzXcwltowQfQXjU
 wDDE4tRuu7F6VFO08xWRkF1vAMmvMqWGc1VuRJgqgMRtaNn6VF2wwIlAc9ETUdshlbiDvk
 bDQq603E1927KET1OyVZcy0xD9Ol4qY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676330739;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vMl2+VJTPwJFftrwwenz4SuP20RVubFuM/OWjrHiNcM=;
 b=I2W+scNnB+z0bllzYJldyQqFLYUk2mNUcK9I2x9En4EUe+JFmCJMbido+MzwWEmgTW2D0O
 x5xFSJwuPBaB5KBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A49A8138E6;
 Mon, 13 Feb 2023 23:25:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id quLiJfPG6mOsfAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Feb 2023 23:25:39 +0000
Date: Tue, 14 Feb 2023 00:25:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y+rG8tz20m0Nrr4c@pevik>
References: <20230207131714.2500-1-pvorel@suse.cz>
 <20230207131714.2500-2-pvorel@suse.cz>
 <CAEemH2chcTe263-zqpSF2Gc2CVc8NC+G-KZsFMbwoxEKyjA01w@mail.gmail.com>
 <20230208135404.GB31469@pevik> <87zg9ho7hg.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87zg9ho7hg.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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


> Petr Vorel <pvorel@suse.cz> writes:

> > Hi Li,

> >> > +#define        DEFAULT_TTY_DEVICE      "/dev/tty0"

> >> Hidden the device path parameter is a good idea.

> >> But maybe can we add a function to find available char devices
> >instead

> There is already something like this built into the kernel; you can
> create a PTY on demand with /dev/ptmx.

> See the kernel/pty tests.

Thanks for a tip! According to man ptmx(4) the file /dev/ptmx creates
pseudoterminal (PTYs) in /dev/pts directory (e.g. /dev/pts/0).

> >> of using the tty0 as default? In that function, we do the S_ISCHR() check
> >> and return the valid path of it. Then the rest test (e.g. ioctl02) can make
> >> use of it but not set the specified device as well. WDYT?

> > FYI I'm using S_ISCHR() in other patches, which check if device can be used.
> > Implementing search looks like a good idea. Are useful files any /dev/tty*
> > (including /dev/tty, /dev/ttyACM0, /dev/ttyS0) or should I avoid any file
> > or include other paths?
BTW /dev/ttySN are UART serial port TTY (it was familiar to me, although I
nowadays use /dev/ttyUSB0 :)).

> These are real serial devices except /dev/tty which could be a real
> device or a pty IIUC. Same goes for /dev/hvc[0-9] and possibly some
> others.

> I'm going to put the patch set to changes requested because /dev/tty0 is
> the current virtual console. It seems the test just overwrites the
> permissions and starts sending ioctls to it.

Sure.

> I don't know if this is safe and probably it's no different from
> creating a pty.

Kernel doc [1] mentions more about the devices. I suppose it does not
matter for ioctl01 purpose, which TTY device we use, so I'll use
your suggestion.

Kind regards,
Petr

[1] https://www.kernel.org/doc/html/latest/admin-guide/devices.html

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
