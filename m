Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D1DC433EF
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 13:58:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A20B13C6FEE
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 14:58:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 111103C03F6
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 14:57:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5F1DC1000DD5
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 14:57:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 76F26210FE;
 Thu,  6 Jan 2022 13:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641477475; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bULiHxb1CC5Aq7toOuDStfLRFfq8TIsmeyMJ9+IboGo=;
 b=Wy7NtYaLb3Cj4POeSq77cFBsa3KivoDvV2aRozgTWwnIlYg6dfa7fLG3T8Pl7ANCTIdIgb
 CUsHRszV/bTF6AtFlAMQg00yNOiVhHGzNL1oQq6RZCTqKTpvoBiIWQjMyZIW3WytqetzIa
 1WRthoB2/7lw/rM1h1P+sO4arz5YddU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641477475;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bULiHxb1CC5Aq7toOuDStfLRFfq8TIsmeyMJ9+IboGo=;
 b=lN9DABKMzvgMddzKZ6WkuTXyTRDVFPIeLrlLZS0/4ia8dkFPueYNpecDgersSssww+gTdr
 idGWNYbnr/ieL+Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6288E13AB5;
 Thu,  6 Jan 2022 13:57:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id FpH9FmP11mFhUwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 06 Jan 2022 13:57:55 +0000
Date: Thu, 6 Jan 2022 14:59:27 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Ydb1vzPzp9R2g2kk@yuki>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdbNdknOelj9H3ji@yuki> <YdbXdHGkhNhqIIJY@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YdbXdHGkhNhqIIJY@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] lib: Introduce LTP_KCONFIG_DISABLE
 environment variables
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > diff --git a/doc/user-guide.txt b/doc/user-guide.txt
> > > index 494652618..8d4435a28 100644
> > > --- a/doc/user-guide.txt
> > > +++ b/doc/user-guide.txt
> > > @@ -18,6 +18,9 @@ For running LTP network tests see `testcases/network/README.md`.
> > >  | 'LTP_SINGLE_FS_TYPE'  | Testing only - specifies filesystem instead all
> > >                            supported (for tests with '.all_filesystems').
> > >  | 'LTP_DEV_FS_TYPE'     | Filesystem used for testing (default: 'ext2').
> > > +| 'LTP_KCONFIG_DISABLE' | Switch for kernel config check functionality.
> > > +                          'y' or '1': disable kconfig check,
> > > +                          'n' or '0': enable kconfig check.
> 
> > Maybe it would be better named LTP_KCONFIG_SKIP or even
> > KCONFIG_SKIP_CHECK we do have KCONFIG_PATH so it would make sense to
> > keep the kernel config related variables prefixed with just KCONFIG_
> 
> > I think that the point made by Tim Bird was that the KCONFIG_PATH should
> > be standartized variable among testsuites, so it makes sense to have
> > KCONFIG_SKIP_CHECK as a standartized variable as well.
> 
> Is it too bad to have LTP_KCONFIG_SKIP_CHECK and LTP_KCONFIG_PATH ?
> Maybe we could change it even now.

Yes, the whole reason not to prefix it with LTP_ is to have a standard
among all the testsuites. The more variables are standartized the
better.

> TST_NO_CLEANUP (IMHO should be changed to LTP_NO_CLEANUP).

Unless we want to have a standard for that one as well. Really all we
need to is to create a page with the description of these variables and
agree on a common subset. It's that simple, but someone has to actually
do it.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
