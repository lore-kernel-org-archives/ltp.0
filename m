Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 431F6C433EF
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 09:04:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 714C83C9624
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 10:04:22 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B056C3C31A2
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 10:04:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1D2C160070C
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 10:04:12 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1860E212C8;
 Mon, 17 Jan 2022 09:04:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642410252;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eG4T/bx/dGCe4NvSx/Gw0LuGzfNEplf3dCGM2EbkVFs=;
 b=0AntgVtUBG8YZpJuBz+dzh+TgoREvabxu3KKPcKC7A8AQGGtiWMFidxc1MKwj4a61TFm9G
 YK16WqDDK0Ws1ziWXQDlVBPsgV1hH9yCxGvflqILIx3iFOmMbt1MUzhZzq+wsspNrhRyw1
 yvAdv1sHllh4bFLRSowWs8B10tr0l20=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642410252;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eG4T/bx/dGCe4NvSx/Gw0LuGzfNEplf3dCGM2EbkVFs=;
 b=Pj8yN34gsmEx8qIuVCnqueJVZ+MQLceXsKqUMdOtCWEvTaIC3czogJYkUdvA+aORYyBge5
 tSDFBIAFQotiU8CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DCD3C134DA;
 Mon, 17 Jan 2022 09:04:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id mpn6Mgsx5WHBLgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 17 Jan 2022 09:04:11 +0000
Date: Mon, 17 Jan 2022 10:04:10 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YeUxCq4rsLX98E3d@pevik>
References: <20220114210034.16177-1-pvorel@suse.cz>
 <CAEemH2ddzfJ48prJTejCBq-=u4O-w0ENR27A_DjUo_OsqShCow@mail.gmail.com>
 <CAEemH2cMpFUz1nzq6DDfe+S-bYam3fYvb8ci=hfXHkjbfxbkeQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2cMpFUz1nzq6DDfe+S-bYam3fYvb8ci=hfXHkjbfxbkeQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] utime03.c: Fix filesystem name
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Cyril,

> > > +++ b/testcases/kernel/syscalls/utime/utime03.c
> > > @@ -93,7 +93,7 @@ static struct tst_test test = {
> > >         .mntpoint = MNTPOINT,
> > >         .all_filesystems = 1,
> > >         .skip_filesystems = (const char *const[]) {
> > > -               "v9",
> > > +               "9p",

> > I'm wondering does it really take effect with whatever "v9" or "9p"?
> > Because the fs_type_whitelist[] does not include any of them.
+1. Do we want to add 9p to fs_type_whitelist[]? I suppose not, because (despite
of the name containing "whitelist" it's the list of filesystems actually being
tested - this is a bit confusing to me).

> Unless removing the .all_filesystems as well otherwise, it is impossible
> has a chance to test on 9p.
Yep. I forgot that .skip_filesystems works also on single fs.
So correct entry in .skip_filesystems is kind of documentation in case of
.all_filesystems being removed. I guess we should just remove the entry.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
