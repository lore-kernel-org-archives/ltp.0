Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262FAC76196
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 08:11:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02C9C3CCB16
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 10:11:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4AEEB3CB238
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 10:11:36 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 697F4100034B
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 10:11:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AB892219CB;
 Tue, 28 Mar 2023 08:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679991094;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8gOH9yszeT6k7GwAXmz7mvWsr5h2z0hQkaksklWwyAs=;
 b=FRQ7p7g51+PVDO72HiuNV1Y0gCT/fGXoBXhd2Tzsf9nkJVPPqJX7/yX6kXcmnIgHuKozX8
 tIGC8l9HH4KMMIcBymdzzxHr9KyCaqYufntPLvjeU4GvHnlv6SKjHjUP3f6TY7qLSlycES
 6fElouUUtVv75Xhs+B8q86XEBMH/bIM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679991094;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8gOH9yszeT6k7GwAXmz7mvWsr5h2z0hQkaksklWwyAs=;
 b=GfPF3DWrRbkheOi2KRjSD8CRbWFopbnGu2pqcNsdkBgsrIWhyn7MKFhd6b595uMdt9xrYt
 LAEeupcrooqCb+Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E65C1390D;
 Tue, 28 Mar 2023 08:11:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3HLxHDahImTqGQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 28 Mar 2023 08:11:34 +0000
Date: Tue, 28 Mar 2023 10:11:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230328081133.GA743322@pevik>
References: <20230323121330.92244-1-paulson@zilogic.com>
 <20230327105110.GA667966@pevik>
 <CAEemH2eTt9P2FWhsS2VASCbLwcOvV4ESrRKLuxWS7HwTNGjSrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eTt9P2FWhsS2VASCbLwcOvV4ESrRKLuxWS7HwTNGjSrQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Added test for mmap() with MAP_SHARED_VALIDATE.
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
Cc: ltp@lists.linux.it, paulson <lpaulsonraja@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

...
> > FYI we have various helpers in include/tst_test_macros.h, e.g. TST_EXP_FAIL()
> > for expected failures where return is just classical syscalls result
> > (0 for pass, -1 for error) or TST_EXP_FD() for file descriptors.

> > But these cannot be used here, because mmap returns pointer to void.
> > We might want to write helpers which use TEST_VOID() instead of TEST(),
> > after tests for mmap() are rewritten to new API, they could use it.

> Sounds good, but we can do this in later refactoring work on mmap tests.
> Now I'm slightly OK with not using TEST_ macros for everything:).

Sure (it will not block this effort, definitely for separate effort with low
priority).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
