Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8DC1C636D4
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 15:58:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7EDAB3CC3D5
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 16:57:58 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6135C3C1424
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 16:57:47 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 82701140020B
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 16:57:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 711AC1FFC8;
 Wed, 15 Feb 2023 15:57:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676476665;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIYOV9KBUj6c1bvs/8GiRFBJb/7nBSvAAfcZDksugxg=;
 b=q5s88IBtR1Eae9aKgSZvrksidGTnQ88QB7gdMni7pcKot6K81d5dPxdJSDxuCXirHZz2mT
 iYNpezZgkWft1Av+L+MR9IuUjEJTqe4BlxLomQk1aDIK2vhvqLtDVVxnB6nYiVKKO8xj77
 lOCqV2OnIqxFz1lZgmPyjYvhs64RzVg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676476665;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fIYOV9KBUj6c1bvs/8GiRFBJb/7nBSvAAfcZDksugxg=;
 b=fRRTOa+yQE5wo8uP2ID01qAI39OI5C15PC2ypv3MIF9eMM+fQKkbhth352LPvvd6jWXsP4
 f3v1IaawiY2A8XCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 19AC2134BA;
 Wed, 15 Feb 2023 15:57:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7n4WA/kA7WPeMQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Feb 2023 15:57:45 +0000
Date: Wed, 15 Feb 2023 16:57:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Message-ID: <Y+0A96W9OlFk3oM5@pevik>
References: <20230215144225.25008-1-mdoucha@suse.cz> <Y+z4MNO+jwydz1w8@pevik>
 <abf5eb48-d63d-1b5f-4047-1a8c210a48a1@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <abf5eb48-d63d-1b5f-4047-1a8c210a48a1@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cve-2015-3290: Fix tst_syscall() return value
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi all,

> On 15/02/2023 15:20, Petr Vorel wrote:
> > Hi all,

> > > The modify_ldt() syscall returns 32-bit signed integer value. Recent =
changes
> > > in tst_syscall() caused the value to be interpreted as unsigned on ol=
der
> > > kernels/glibc, which breaks the cve-2015-3290 test. Add explicit type=
 cast
> > > to fix it.
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > This is caused by e5d2a05a9 ("regen.sh: Use intptr_t for tst_syscall re=
turn")
> > which changed returning tst_ret from int to intptr_t (which is also int=
 for 32
> > bit archs, but long for 64 bit archs). This commit is also needed, thus=
 I don't
> > suggest to revert it, but I wonder how many other tests it broke.

> I sent the tst_syscall return patch. I did some testing with what systems=
 I
> had available when working on it and, at the time, didn't see any
> regressions,
> including for cve-2015-3290.

> However this was with fairly recent kernels and libcs, and according to
> Martin
> the test failed for them on an older combination.

FYI I was able to reproduce it on VM with SLE15-SP2 kernel (based on 5.3.18,
with many patches) and glibc 2.26-13.62.1 (obviously older supported system=
s are
also affected). Hopefully that's all (need to check).

Kind regards,
Petr

> I shared the test suite[0] I tested the patch with, containing all the us=
es
> I found.
> It might be worthwhile to run it on a system where we now know one of the
> tests
> was affected ? Hopefully, none more, but having a result would be better.

> Best regards,
> T=E9o

> [0]: https://lists.linux.it/pipermail/ltp/2022-November/031640.html


> > Kind regards,
> > Petr

> > > Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> > > ---
> > >   testcases/cve/cve-2015-3290.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > diff --git a/testcases/cve/cve-2015-3290.c b/testcases/cve/cve-2015-3=
290.c
> > > index f61d2809b..a2a8fcedd 100644
> > > --- a/testcases/cve/cve-2015-3290.c
> > > +++ b/testcases/cve/cve-2015-3290.c
> > > @@ -195,7 +195,8 @@ static void set_ldt(void)
> > >   		.useable	 =3D 0
> > >   	};
> > > -	TEST(tst_syscall(__NR_modify_ldt, 1, &data_desc, sizeof(data_desc))=
);
> > > +	TEST((int)tst_syscall(__NR_modify_ldt, 1, &data_desc,
> > > +		sizeof(data_desc)));
> > >   	if (TST_RET =3D=3D -EINVAL) {
> > >   		tst_brk(TCONF | TRERRNO,
> > >   			"modify_ldt: 16-bit data segments are probably disabled");

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
