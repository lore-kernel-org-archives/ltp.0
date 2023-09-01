Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2275DCA0FE6
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 12:20:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C3EC3CBD86
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 14:20:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69B623CBB99
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:20:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ACF391000448
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:20:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C67A218E4;
 Fri,  1 Sep 2023 12:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1693570829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dIq0zjujEPgRVwfyLjRBDjbm5SsN/L6LBV/l9hJjdpg=;
 b=PovHEKb5Xap3CDwxUBhXio6+t4uVfnXTl6O/1PGM30e0tB2tpRFQSnSjTBeUYywjCLZOCF
 PdP+4uGoB4Rn7C+5zVsHRiqvbSK8C+Qyeuq95k6fFm36c+9NKTgPfKYXCOfWJS+bmKuUp4
 cU4BFgOVr3jBh7PVXxLfyIimtIhmoYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1693570829;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dIq0zjujEPgRVwfyLjRBDjbm5SsN/L6LBV/l9hJjdpg=;
 b=K04n6bNaSmpYLvXgYNSDqv5dGzBCMd2v3PRy4zqljNqFgiOzMDeDvqqXhjVJ7RYuuDDnWu
 KljBESlXCXdX/VDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 199D91358B;
 Fri,  1 Sep 2023 12:20:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mvolBQ3X8WTEHwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 01 Sep 2023 12:20:29 +0000
Date: Fri, 1 Sep 2023 14:21:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ZPHXMGNqT6WQUmyg@yuki>
References: <20230831104242.27156-1-andrea.cervesato@suse.de>
 <20230831104242.27156-2-andrea.cervesato@suse.de>
 <ZPCWWXXHG-oEB5qO@yuki>
 <ace7a77a-f187-45ed-91e5-c19b8d240a39@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ace7a77a-f187-45ed-91e5-c19b8d240a39@suse.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] Refactor getegid01 using new LTP API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >> +	TST_EXP_EQ_LI(gid, st_egid);
> > So the code here should really do:
> >
> > 	if (GID16_CHECK(st_egid))
> > 		TST_EXP_EQ_LI(gid, st_egid);
> > 	else
> > 		tst_res(TPASS, "getgid() passed");
> =

> Mmmh, this would make sense if GID16_CHECK only checked for 16bit =

> compatibility, because at the moment it's way different:
> =

> =

> #define GID16_CHECK(gid, sys_name, cleanup) \
> if (!GID_SIZE_CHECK(gid)) { \
>  =A0=A0 =A0tst_brkm(TBROK, cleanup, \
>  =A0=A0 =A0=A0=A0=A0 "gid %d of %s is too large for testing 16-bit versio=
n " \
>  =A0=A0 =A0=A0=A0=A0 "of %s()", gid, #gid, #sys_name); \
> }
> =

> Am I missing something?

It seems that I confused GID16_CHECK with GID_SIZE_CHECK(), so it should
have been:

	if (GID_SIZE_CHECK(st_egid))

> > Which skips the check on 16bit syscall in the case that the GID
> > overflows 16bit, however we still have to report at least single TPASS
> > otherwise the test will be failed by the test library.
> >
> >>   }
> >>   =

> >> -static void cleanup(void)
> >> -{
> >> -}
> >> +static struct tst_test test =3D {
> >> +	.test_all =3D run,
> >> +};
> >> -- =

> >> 2.35.3
> >>
> >>
> >> -- =

> >> Mailing list info: https://lists.linux.it/listinfo/ltp
> =

> Andrea
> =


-- =

Cyril Hrubis
chrubis@suse.cz

-- =

Mailing list info: https://lists.linux.it/listinfo/ltp
