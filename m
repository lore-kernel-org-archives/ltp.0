Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4EA1C38A2D
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 20:48:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57DCD3CA7AF
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 22:47:59 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECC313C5FB7
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 22:47:48 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3921B600072
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 22:47:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 61FC421E5D;
 Wed, 26 Oct 2022 20:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666817266;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GkFuhU7bffJTnhK1DHxDALgIQrbZmptLINTVvgVx1eo=;
 b=BKIu58pGYPyU+c7BEvYic31zBksuU09KcOfk5znFyg9x3Rop21LSq7AtxlAZUZRSuafWzJ
 Ez56FipZsSUIk2cLl14HscseSfWXkCNEYdq53mKy3kQQOxsiJ5dFSy3YkRN/SK1F29QVlV
 0arr5a0xuFyxho5FLIsT6wTHaJdxMu0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666817266;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GkFuhU7bffJTnhK1DHxDALgIQrbZmptLINTVvgVx1eo=;
 b=RB7m4ISehtF2TsIboib8tUAMq8lk/bo7m63qMbuVa02rz4ArXVeq0RIxv/sl310JdXznSO
 AOG28ycSBFyUdaBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EE65813A6E;
 Wed, 26 Oct 2022 20:47:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Y13bNvGcWWNSMwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 26 Oct 2022 20:47:45 +0000
Date: Wed, 26 Oct 2022 22:47:39 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Message-ID: <Y1mc6xRJPJwSv/Oe@pevik>
References: <20221020120741.212671-1-akihiko.odaki@daynix.com>
 <Y1GWOPpb+Z8hwhQd@pevik> <Y1I6u1a7RAS1wmZL@pevik>
 <34c0ff56-bed3-ade3-4936-6c96ecb8501d@daynix.com>
 <Y1Ze470vch74uGNg@pevik> <Y1Zmk9kheWANsZ9Z@pevik>
 <5be433f9-a459-883d-53cf-c702f2b8ae5d@daynix.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5be433f9-a459-883d-53cf-c702f2b8ae5d@daynix.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] ftp/ftp01: Use tst_net.sh
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
Cc: Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Akihiko,

> Hi,

> Thanks for suggestions, improvements, and merging.

> This test assumes FTP is set up and running and that defeats the purpose of
> netns. It is certainly possible to say the FTP test functionality is covered
> with testcases/network/stress/ftp and this test can be removed, but for now,
> the fixes allows me to execute net.tcp_cmds tests without explicitly
> excluding this.

Thanks a lot for confirming that it works with my additional changes.

IMHO ftp can be tested via, that's actually done in ftp-upload-stress.sh.

Kind regards,
Petr

> Regards,
> Akihiko Odaki

> On 2022/10/24 19:18, Petr Vorel wrote:
> > Hi Akihiko,

> > ...
> > > > I just modified this test because it is annoying to set up rsh just to fix
> > > > this test so I would rather not put more effort for further improvement.
> > > Understand, ack. Thanks for your work!

> > > > Personally I don't object to remove this test either.
> > > The fastest solution is to merge your fixed version.
> > > But there should be even more modifications:
> > > RHOST is obsolete, instead $(tst_ipaddr rhost) should be used.

> > > Therefore we should decide if this smoke test (and other FTP tests in LTP) is
> > > worth effort. If yes, I should force myself to create ftp_lib.sh and migrate
> > > everything to work similar way as ftp-upload-stress.sh.

> > Merged as it's some improvement. I'm not sure if I invest time to FTP in the
> > future, maybe we should really delete it.

> > The only significant change I did was to force running over SSH:
> > with RHOST="${RHOST:-localhost}"

> > In my case only first half of the tests is working (suppose just wrong setup),
> > but on netns everything si broken and you also tested it on SSH I dared to do
> > this change. I documented the proper fix above in case anybody cares.

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
