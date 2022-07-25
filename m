Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62AC4C43334
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 08:52:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D0B23C0E6F
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 10:52:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B21E03C0E6F
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 10:52:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8BDD12005D0
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 10:52:36 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 59063378DA;
 Mon, 25 Jul 2022 08:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658739156;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X3kCs4LtU1ddF3bWU4opilwIK3233apXGjPq+QPIECs=;
 b=CCWuNgdLJH1foUpm4nnhp6/EuMqCGVTP7vw0OWartnZREgctqH2KsJw6STPl//txZyPPCE
 d44MFdn5E2dK/dIcrVYsIsEnc0GCGTkhOjLDmmdpSPnqrRkIEDckmJaRO6FmL/Zq0JaqCm
 A2F5qf2wsC0R8f9gNT04lQW5mIjEcg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658739156;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X3kCs4LtU1ddF3bWU4opilwIK3233apXGjPq+QPIECs=;
 b=Eag04g5sVG2rFalPuWKWakaQEnYT3QtwEhInKLHXTmqEJp1CeD+qr9onbCfK798E20znSf
 1wehpWcekxevmtDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09EE713ABB;
 Mon, 25 Jul 2022 08:52:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dNWMANRZ3mLzfgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 25 Jul 2022 08:52:36 +0000
Date: Mon, 25 Jul 2022 10:52:34 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yt5Z0s6ymBfgUL4j@pevik>
References: <20220715062519.2480-1-chenhx.fnst@fujitsu.com>
 <YtGZZeUm2iB/uySr@pevik> <YtURQlBJhpnWoSCv@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YtURQlBJhpnWoSCv@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mount03: Convert to new API
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > @Richie @Li @Metan: There are checkpatch.pl warnings. Yes, kernel folks does not
> > like permission warnings. Do we want to follow? Or should we remove these from
> > our checkpatch.pl fork (we use constants in many places)?

> > $ make check-mount03
> > mount03.c:29: WARNING: Symbolic permissions 'S_IRUSR|S_IWUSR|S_IRGRP|S_IROTH' are not preferred. Consider using octal permissions '0644'.
> > mount03.c:30: WARNING: Symbolic permissions 'S_IRUSR|S_IXUSR|S_IXGRP|S_IXOTH' are not preferred. Consider using octal permissions '0511'.
> > mount03.c:50: WARNING: static char array declaration should probably be static const char
> > mount03.c:103: WARNING: Symbolic permissions 'S_IRWXU' are not preferred. Consider using octal permissions '0700'.
> > mount03.c:114: WARNING: Symbolic permissions 'S_IRWXU' are not preferred. Consider using octal permissions '0700'.
> > mount03.c:125: WARNING: Symbolic permissions 'S_IRWXU' are not preferred. Consider using octal permissions '0700'.
> > mount03.c:181: WARNING: Symbolic permissions 'S_IRWXU' are not preferred. Consider using octal permissions '0700'.
> > mount03.c:204: WARNING: Symbolic permissions 'S_IRWXU' are not preferred. Consider using octal permissions '0700'.

> To be honest I think Linus is right at this one, the single octal number
> is way more readable than the bitwise or of four constants, so I would
> be inclined to start following the kernel practice here.

Agree with the rule, numbers are indeed much readable and I'm for using it in
LTP source.

My concern was different: aren't these constants part of POSIX? See man from
<sys/stat.h> from 1997 [1]. There might be a test for these constants but
it has much lower priority than tests for new kernel functionality and CVE.

Kind regards,
Petr

[1] https://pubs.opengroup.org/onlinepubs/007908799/xsh/sysstat.h.html

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
