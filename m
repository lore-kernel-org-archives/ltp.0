Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42369C54EE9
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 13:12:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62C333CACAA
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 15:12:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A54B43CAC18
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 15:12:22 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B24B3200B76
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 15:12:21 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1250521AD6;
 Fri, 16 Sep 2022 13:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663333941;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rCP9aQEpzFp926/2mnMG1RaHgcC9Mr08+rUjj02Kvak=;
 b=u0eGwEyS7mJx8YipZrkplJEtWia/zDnAyDbZ7HLE93BYP33r1HMwiEbBzFhjtgB64dDTkO
 lafyXmDM6kRR07rAgMGPAlcJuG829KS11MTqChKZrsgKTl/qUN7KstjJZ0f7MUr6xc/xFD
 qjTVfiLajwEJ9/Se1c4g+u5QDQOgBQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663333941;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rCP9aQEpzFp926/2mnMG1RaHgcC9Mr08+rUjj02Kvak=;
 b=QBd27ovGdpMPFEdTJkxW1CIPgELKe1MwQ20b2W4EusP0IV+5oKWWhwuM6+zxw5AO1ag+DY
 2Zo+0aJVc2xdaRCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C38821346B;
 Fri, 16 Sep 2022 13:12:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9QZxKzR2JGOOOgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Sep 2022 13:12:20 +0000
Date: Fri, 16 Sep 2022 15:12:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YyR2Mh258FmVnwoR@pevik>
References: <20220915093639.2261-1-pvorel@suse.cz>
 <20220915093639.2261-9-pvorel@suse.cz> <YyR1xD+Ks8ZntZxZ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyR1xD+Ks8ZntZxZ@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 8/8] df01.sh: Convert to TST_ALL_FILESYSTEMS=1
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > +TST_ALL_FILESYSTEMS=1
> >  TST_CNT=12
> >  TST_SETUP=setup
> >  TST_TESTFUNC=test
> > -TST_OPTS="f:"
> > -TST_USAGE=usage
> > -TST_PARSE_ARGS=parse_args
> >  TST_NEEDS_ROOT=1
> > -TST_MOUNT_DEVICE=1

> Just looking at this made me realize that for C API ALL_FILESYTEMST does
> not imply TST_MOUNT_DEVICE since these functionalities are orthogonal. I
> think that it would be better if we had the C API and shell API as close
> as possible, hence ALL_FILESYSTEMS should imply only NEEDS_DEVICE and
> the MOUNT_DEVICE would stay here.

OK, I'll keep MOUNT_DEVICE=1 here and we can change it later for both.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
