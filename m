Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CE5CECAAD3
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 11:14:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B61F83CAA06
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 13:14:36 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EB953C07BD
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 13:14:27 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 41F1B200E1E
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 13:14:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2859C22DFD;
 Fri,  9 Sep 2022 11:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662722064; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AV3IAtR5nHpg13Q9N1QiAUp4mQVUS/RDH9Fn2kmBfpU=;
 b=BBvuHwCV3ncGY+QgFsJsAsHjd4ikN9Ac8EzOAcZV+GBAw6Plq7fri8POqviOUwY/b3UQbd
 nDbnzHiLEgiQo7j2FKNO3DQn5ZjM1B7nkpEPKm67Oidmsy1+DFIncm+cKnKXeshV1u9+dQ
 E0BUg5iRebPP/vtHBM68MZAYgYSN3sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662722064;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AV3IAtR5nHpg13Q9N1QiAUp4mQVUS/RDH9Fn2kmBfpU=;
 b=wYzr91gtQkAeadCNulqzh2FiXaX7v8jYHGXBhIISA1o9tGACTy4EFIx708Ad2aKlfH7p3m
 AQqvV+UkDvhzESCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 12E0F139D5;
 Fri,  9 Sep 2022 11:14:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pMpAAxAgG2PgDAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 09 Sep 2022 11:14:24 +0000
Date: Fri, 9 Sep 2022 13:16:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yxsgg8f7vOFdXV3q@yuki>
References: <20220902133710.1785-1-pvorel@suse.cz>
 <20220902133710.1785-5-pvorel@suse.cz> <YxsKz9j1mVHIhcfw@yuki>
 <Yxsbtrcv+FEMvBfH@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yxsbtrcv+FEMvBfH@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/9] tst_supported_fs: Support skip list when
 query single fs
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > +++ b/lib/tst_supported_fs_types.c
> > > @@ -134,6 +134,24 @@ enum tst_fs_impl tst_fs_is_supported(const char *fs_type)
> > >  	return TST_FS_UNSUPPORTED;
> > >  }
> 
> > > +enum tst_fs_impl tst_fs_is_supported_skiplist(const char *fs_type, const char
> > > +					      *const *skiplist)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = tst_fs_is_supported(fs_type);
> > > +
> > > +	if (!ret)
> > > +		return ret;
> > > +
> > > +	if (tst_fs_in_skiplist(fs_type, skiplist)) {
> > > +		tst_brk(TCONF, "%s is not supported by the test",
> > > +			fs_type);
> 
> > I would expect to return TST_FS_UNSUPPORTED here. It's a bit hacky
> > solution to exit a library call with tst_brk(TCONF, "");
> Understand. There are 2 cases of not supported filesystems: 1) filesystem not
> supported 2) filesystem skipped. Therefore I'd like to introduce
> TST_FS_SKIPPED_BY_TEST (that would be 1 (therefore exit code
> will have to be tested against the constants. That's IMHO better than
> reinventing a wheel to detect this in testcases/lib/tst_supported_fs.c.
> 
> e.g.:
> 
> +++ b/include/tst_fs.h
> @@ -171,7 +171,8 @@ int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
>  int tst_prealloc_file(const char *path, size_t bs, size_t bcount);
>  
>  enum tst_fs_impl {
> -       TST_FS_UNSUPPORTED = 0,
> +       TST_FS_UNSUPPORTED = -2,
> +       TST_FS_SKIPPED_BY_TEST = -1,

Maybe just TST_FS_SKIPPED

>         TST_FS_KERNEL = 1,
>         TST_FS_FUSE = 2,
>  };

I wonder though if we really care about the difference between
unsupported and skipped. Maybe just print TINFO message in case of the
skipped filesystem and return zero in both cases? And maybe rename
TST_FS_UNSUPPORTED to TST_FSNOT_USED.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
