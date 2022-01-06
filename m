Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 801C4C433F5
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 11:50:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BCE03C0F6A
	for <ltp@archiver.kernel.org>; Thu,  6 Jan 2022 12:50:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE1793C08F2
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 12:50:16 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8C63E1401121
 for <ltp@lists.linux.it>; Thu,  6 Jan 2022 12:50:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B628F212CA;
 Thu,  6 Jan 2022 11:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641469814;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Kpfvf1MxeNA3ERmUGI0pKPnVWRiTWpEUrxg820VvEY=;
 b=HCYeorE/sda7CPF+0FMZQaPoMTbVzOKWl1UrwwmjFFXB4SiTH4PZN+fwCdyHCnIhWM0FnT
 l/uOlNowAV3Da/UzrABDmk1fEP8C/5zuSWPtpavp2o/IojutOqaBo2myBiZd0zsJDZwa0U
 H3+wtN8u2uidLsbVuGgHhcwLTF+MG9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641469814;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Kpfvf1MxeNA3ERmUGI0pKPnVWRiTWpEUrxg820VvEY=;
 b=3wInCZTt7hxnUy58JlxGbrrH30JyfUkElgRCKoLqvHRDDtFvVMRd7PQjtpwURJZw9a1xNy
 nNsqV2GGeg00K8Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8921D13C0D;
 Thu,  6 Jan 2022 11:50:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oknjH3bX1mHQIwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 06 Jan 2022 11:50:14 +0000
Date: Thu, 6 Jan 2022 12:50:12 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YdbXdHGkhNhqIIJY@pevik>
References: <YdWsZpTjnBLszubC@pevik>
 <1641461121-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1641461121-2212-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <YdbNdknOelj9H3ji@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YdbNdknOelj9H3ji@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu, Cyril,

> Hi!
> > diff --git a/doc/user-guide.txt b/doc/user-guide.txt
> > index 494652618..8d4435a28 100644
> > --- a/doc/user-guide.txt
> > +++ b/doc/user-guide.txt
> > @@ -18,6 +18,9 @@ For running LTP network tests see `testcases/network/README.md`.
> >  | 'LTP_SINGLE_FS_TYPE'  | Testing only - specifies filesystem instead all
> >                            supported (for tests with '.all_filesystems').
> >  | 'LTP_DEV_FS_TYPE'     | Filesystem used for testing (default: 'ext2').
> > +| 'LTP_KCONFIG_DISABLE' | Switch for kernel config check functionality.
> > +                          'y' or '1': disable kconfig check,
> > +                          'n' or '0': enable kconfig check.

> Maybe it would be better named LTP_KCONFIG_SKIP or even
> KCONFIG_SKIP_CHECK we do have KCONFIG_PATH so it would make sense to
> keep the kernel config related variables prefixed with just KCONFIG_

> I think that the point made by Tim Bird was that the KCONFIG_PATH should
> be standartized variable among testsuites, so it makes sense to have
> KCONFIG_SKIP_CHECK as a standartized variable as well.

Is it too bad to have LTP_KCONFIG_SKIP_CHECK and LTP_KCONFIG_PATH ?
Maybe we could change it even now.

OK, we have few exceptions to LTP_ prefix LTPROOT (I'd keep it for historical
reasons), TMPDIR (IMHO make sense), TST_NO_CLEANUP (IMHO should be changed to
LTP_NO_CLEANUP).

> [CC: Tim should we start tracking common env variables like this somewhere?]
+1

> > +	if (tst_kconfig_disabled()) {
> > +		tst_res(TINFO, "Kernel config check functionality has been disabled.");

> I would try to make more clear what has happened here, something as:

> "Skipping kernel config check as requested"
+1

> Or something along these lines.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
