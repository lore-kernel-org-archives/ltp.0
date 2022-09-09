Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38641ECAAA1
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 11:34:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 324383CAA2E
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 13:34:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB0383C07BD
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 13:33:57 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A6A00200C3B
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 13:33:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E9D2B1F38D;
 Fri,  9 Sep 2022 11:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662723235;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PMjVegkKdSxogakHF7Y9y8CAmtPKVnCldCrfx3tPYnk=;
 b=bDLOGh/5WJSoJIUoy2c98yDRE5ij8vpMXFnPYUj3zkrhG60vECM8sKxGfrMEu0i2oGZY3G
 o6NVFZjCbjHuhfCz5C7Fw7pcbqkJ8lT5xJxTCMF3trOZtLmNmcIM3PCMEQ1/5abD2pwzvp
 PrX6Yv3greq2Du9jXrEysdKfoL6uq4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662723235;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PMjVegkKdSxogakHF7Y9y8CAmtPKVnCldCrfx3tPYnk=;
 b=Xw40POCxZt4rIq5II90ybgjQo8/9SEsIeMbJZ0K7UMr9cTH3DPiN8zL+sMHvjGabOMAyR+
 E/tnSMhPv5r5cfBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FD5C13A93;
 Fri,  9 Sep 2022 11:33:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id m1ceH6MkG2OXFAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Sep 2022 11:33:55 +0000
Date: Fri, 9 Sep 2022 13:33:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YxskoojodIaNuI6G@pevik>
References: <20220902133710.1785-1-pvorel@suse.cz>
 <20220902133710.1785-5-pvorel@suse.cz> <YxsKz9j1mVHIhcfw@yuki>
 <Yxsbtrcv+FEMvBfH@pevik> <Yxsgg8f7vOFdXV3q@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yxsgg8f7vOFdXV3q@yuki>
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > > +++ b/lib/tst_supported_fs_types.c
> > > > @@ -134,6 +134,24 @@ enum tst_fs_impl tst_fs_is_supported(const char *fs_type)
> > > >  	return TST_FS_UNSUPPORTED;
> > > >  }

> > > > +enum tst_fs_impl tst_fs_is_supported_skiplist(const char *fs_type, const char
> > > > +					      *const *skiplist)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret = tst_fs_is_supported(fs_type);
> > > > +
> > > > +	if (!ret)
> > > > +		return ret;
> > > > +
> > > > +	if (tst_fs_in_skiplist(fs_type, skiplist)) {
> > > > +		tst_brk(TCONF, "%s is not supported by the test",
> > > > +			fs_type);

> > > I would expect to return TST_FS_UNSUPPORTED here. It's a bit hacky
> > > solution to exit a library call with tst_brk(TCONF, "");
> > Understand. There are 2 cases of not supported filesystems: 1) filesystem not
> > supported 2) filesystem skipped. Therefore I'd like to introduce
> > TST_FS_SKIPPED_BY_TEST (that would be 1 (therefore exit code
> > will have to be tested against the constants. That's IMHO better than
> > reinventing a wheel to detect this in testcases/lib/tst_supported_fs.c.

> > e.g.:

> > +++ b/include/tst_fs.h
> > @@ -171,7 +171,8 @@ int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
> >  int tst_prealloc_file(const char *path, size_t bs, size_t bcount);

> >  enum tst_fs_impl {
> > -       TST_FS_UNSUPPORTED = 0,
> > +       TST_FS_UNSUPPORTED = -2,
> > +       TST_FS_SKIPPED_BY_TEST = -1,

> Maybe just TST_FS_SKIPPED

> >         TST_FS_KERNEL = 1,
> >         TST_FS_FUSE = 2,
> >  };

> I wonder though if we really care about the difference between
> unsupported and skipped. Maybe just print TINFO message in case of the
> skipped filesystem and return zero in both cases? And maybe rename
> TST_FS_UNSUPPORTED to TST_FSNOT_USED.

I thought being precise why there is TCONF would help, but users will just read
previous TINFO messages.

Having just single "error" enum constant, I'm OK to keep TST_FS_UNSUPPORTED
(unless anybody really think renaming it to TST_FS_NOT_USED would be better).

So, there can be just single message "foo is not supported or skipped by
test" (in case of asking for particular fs support) and "no supported
filesystem" (in case of list of all supported fs).
I'd use tst_brk(TCONF, ...) here, because the binary exits 1 on "error", thus
here would be exit 32 on "error".

Thanks for your input!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
