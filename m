Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4071AC433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 07:15:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 01B853C9F1D
	for <ltp@archiver.kernel.org>; Fri, 11 Feb 2022 08:15:23 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30AEE3C030D
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 08:15:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4F4571001364
 for <ltp@lists.linux.it>; Fri, 11 Feb 2022 08:15:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7524421128;
 Fri, 11 Feb 2022 07:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644563713;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EtYQMdg5kiFcNfKeXdT/NQYPdbgSJjqg0uLinsuOQG4=;
 b=gSAxUMvTM22QxoaStlp0WcB53WJD6umMPCBCD4+2Yv1P5qtjly4x/774/byBeegOvEAvZN
 cGB9ZzJy5n1f2pkiQQD/wWts3ZFWwkgZEWG7CR1TzpgV9NimN5AlR5Fo4us+B71zqcDiAt
 62BhHpqbYQgty3beWHrplk4Kdawkphg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644563713;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EtYQMdg5kiFcNfKeXdT/NQYPdbgSJjqg0uLinsuOQG4=;
 b=ZWqUuNkr4AhJw6enVKZsp4iSeEnvidoTNtiCygkduM7OXwwgteWoaF6I5/q4FeD1mOxabI
 LwxgG9RuEEN2DzCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 439F0139E9;
 Fri, 11 Feb 2022 07:15:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id AvgwDgENBmI0XAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 11 Feb 2022 07:15:13 +0000
Date: Fri, 11 Feb 2022 08:15:11 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YgYM/8GXX2i5/wRA@pevik>
References: <20220210162739.30159-1-pvorel@suse.cz>
 <20220210162739.30159-4-pvorel@suse.cz>
 <62060952.5040909@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <62060952.5040909@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/6] tst_test.sh: Add $TST_FORMAT_DEVICE and
 related vars
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,
> Hi Petr
> > +
> > +[source,sh]
> > +-------------------------------------------------------------------------------
> > +TST_FORMAT_DEVICE=1
> > +TST_DEV_FS_OPTS="-b 1024 -O quota"
> > +TST_DEV_EXTRA_OPTS="5m"
> > +TST_TESTFUNC=test
> > +
> > +test1()
> A small nit, I prefer to use test name directly if we don't have several
> sub test cases.
Sure. Originally I had more tests there, using lsblk.
But I'll probably extend these tests to your suggestion in different mail.

Kind regards,
Petr

> Best Regards
> Yang Xu
> > +{
> > +	tst_res TPASS "device formatted"
> > +}

> > +-------------------------------------------------------------------------------

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
