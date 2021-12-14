Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45BC2C433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 10:34:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 449CB3C8C69
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 11:34:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51B113C04BA
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 11:34:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 62F67601AF9
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 11:34:15 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 41BA71F3C3;
 Tue, 14 Dec 2021 10:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639478055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y/Ujqb88TiAPFOtBIteV/7hEjjComcCg13j5JLiZlgc=;
 b=o+CA1/NFgIufoUFC8zMunYdCWUsdfbIEDtbxQWZISZyVI1b8j+zp4zThqAD4gie8Y2IaAD
 Fc+19LSt3XdMaps5hQSOHb0IRGf1ARs9s5J/oKO6eoVDqIApiGEFg8BS7Ndvsm9rRvBL7y
 VXCsVbm4R2cKEJMMA3zUTvl040WZwh8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639478055;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Y/Ujqb88TiAPFOtBIteV/7hEjjComcCg13j5JLiZlgc=;
 b=sh6avoCiSxYPoYDMX3NBKaIx1roFNtlV0urrQ5IA5F2+WK/rSOsFlKa6I3mRijsD8335xk
 s1Q1NKdGi1oE3XCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2F1D913C31;
 Tue, 14 Dec 2021 10:34:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OIORCidzuGGyUQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 14 Dec 2021 10:34:15 +0000
Date: Tue, 14 Dec 2021 11:35:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YbhzexvHiyLKSAu6@yuki>
References: <20211213193419.13414-1-pvorel@suse.cz>
 <CAEemH2dp55yFvaXhq_5e77k6QBnY0aFU5fhz4TjW82bkbwwDiA@mail.gmail.com>
 <YbhV9VIv/8o97O6r@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YbhV9VIv/8o97O6r@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] lib: Add support for debugging
 .all_filesystems
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > My only concern is that the variable name is too long and not easy
> > to remember/understand usage. Can we find a better name?
> >     LTP_ONE_FS_TYPE
> >     LTP_ASGD_FD_TYPE
> >     LTP_FS_TYPE_DEBUG
> Yes, it's too long. LTP_FS_TYPE_DEBUG sounds best to me, but no strong opinion
> about it.

Not sure about the "DEBUG" in the name. I would go for a variation of
the first name "LTP_SINGLE_FS_TYPE" or "LTP_LIMIT_FS_TYPE"

> If we agree we want this, we can consider to use some switch instead or print
> this variable in help output (-h), with other variables from
> https://github.com/linux-test-project/ltp/wiki/User-Guidelines.

Printing the variables on -h does sounds reasonabe.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
