Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87D20ECAAD3
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 14:22:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 968C33CAA10
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 16:22:29 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C40E3C8CC0
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:22:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 99FC6201004
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 16:22:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DF8C62218D;
 Fri,  9 Sep 2022 14:22:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662733337;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dYIOZSJ4n0gkDEWnGhlnsz17TSJ9oelkpBqpnoYKEy0=;
 b=rp0EObf2YABnYjV68s6fnhKVfcozYCNhF1gsDEkwCwFbiMCjGa3DWqzfpNPccbB0M/Aom5
 kDABFKx9NF2VkanaSl6vivuZAmks+MAqCXwvw9tCf5PONYEI4AcrIpsI1vTkgliTCsAC/b
 w51wwhv+PxSPSfYqilSSspSOtm9Qqjc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662733337;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dYIOZSJ4n0gkDEWnGhlnsz17TSJ9oelkpBqpnoYKEy0=;
 b=nt0nwETMU0f7LkXDV4L60IwP/h7uA35A3Hg6z2WOcpfQu09hHQQY0Jb6wo/bzw2UugXyLE
 WhYK8k+NZzBiRdCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6A28E13A93;
 Fri,  9 Sep 2022 14:22:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7Z1lFxlMG2O9WQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Sep 2022 14:22:17 +0000
Date: Fri, 9 Sep 2022 16:22:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YxtMFw25BfJaEsji@pevik>
References: <20220902133710.1785-1-pvorel@suse.cz>
 <20220902133710.1785-5-pvorel@suse.cz> <YxsKz9j1mVHIhcfw@yuki>
 <Yxsbtrcv+FEMvBfH@pevik> <Yxsgg8f7vOFdXV3q@yuki>
 <YxskoojodIaNuI6G@pevik>
 <70df29e7-0097-c698-b6ba-e3f87da3893f@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <70df29e7-0097-c698-b6ba-e3f87da3893f@suse.cz>
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
Cc: ltp@lists.linux.it, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> On 09. 09. 22 13:33, Petr Vorel wrote:
> > > Hi!
> > > > > > +++ b/lib/tst_supported_fs_types.c
> > > > > > @@ -134,6 +134,24 @@ enum tst_fs_impl tst_fs_is_supported(const char *fs_type)
> > > > > >   	return TST_FS_UNSUPPORTED;
> > > > > >   }

> > > > > > +enum tst_fs_impl tst_fs_is_supported_skiplist(const char *fs_type, const char
> > > > > > +					      *const *skiplist)
> > > > > > +{
> > > > > > +	int ret;
> > > > > > +
> > > > > > +	ret = tst_fs_is_supported(fs_type);
> > > > > > +
> > > > > > +	if (!ret)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	if (tst_fs_in_skiplist(fs_type, skiplist)) {
> > > > > > +		tst_brk(TCONF, "%s is not supported by the test",
> > > > > > +			fs_type);

> > > > > I would expect to return TST_FS_UNSUPPORTED here. It's a bit hacky
> > > > > solution to exit a library call with tst_brk(TCONF, "");

> I agree with that. Return a status code from tst_fs_is_supported_skiplist()
> and raise TCONF somewhere higher in the call chain.

Martin, thanks for your input! Done in v5 (just sent).

> > > > +++ b/include/tst_fs.h
> > > > @@ -171,7 +171,8 @@ int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
> > > >   int tst_prealloc_file(const char *path, size_t bs, size_t bcount);

> > > >   enum tst_fs_impl {
> > > > -       TST_FS_UNSUPPORTED = 0,
> > > > +       TST_FS_UNSUPPORTED = -2,
> > > > +       TST_FS_SKIPPED_BY_TEST = -1,

> > > Maybe just TST_FS_SKIPPED

> > > >          TST_FS_KERNEL = 1,
> > > >          TST_FS_FUSE = 2,
> > > >   };

> > > I wonder though if we really care about the difference between
> > > unsupported and skipped. Maybe just print TINFO message in case of the
> > > skipped filesystem and return zero in both cases? And maybe rename
> > > TST_FS_UNSUPPORTED to TST_FSNOT_USED.

> > I thought being precise why there is TCONF would help, but users will just read
> > previous TINFO messages.

> > Having just single "error" enum constant, I'm OK to keep TST_FS_UNSUPPORTED
> > (unless anybody really think renaming it to TST_FS_NOT_USED would be better).

> I'd like to see why exactly a filesystem was skipped so I prefer two enum
> values. Though I'd name them TST_FS_UNAVAILABLE (missing mkfs or kernel
> support) and TST_FS_UNSUPPORTED (disabled by test skiplist).

OK, this is not in v5. I don't mind to send v6 on Monday, if we agree this
is wanted. Implementation detail: should I use for -2 and -1 for these two values?
(code < 0 would be error, code > 0 would be OK, 0 itself skipped)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
