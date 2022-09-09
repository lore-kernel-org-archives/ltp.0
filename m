Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C88AECAAD3
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 10:56:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E37CC3CAA9F
	for <ltp@archiver.kernel.org>; Fri,  9 Sep 2022 12:56:33 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F2543CA9EA
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 12:56:24 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id F286A1A01454
 for <ltp@lists.linux.it>; Fri,  9 Sep 2022 12:56:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 289EC1F8E8;
 Fri,  9 Sep 2022 10:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662720952;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5k1MMdy6xZFjxCfGr0KR81iMRVyGG886CEjYkvwlM0=;
 b=X5ZspjostaVKfqc8QeFSu7sSU5XIHtTo67FtfCY57bHqXGN/7CVB+YcgqdxOLD27iZM5K9
 PwxyyXmsNTyfPtGS2zGmA5oeW+TnVsl34HtM3qXAzNFR9CjXoCa/7T1+N1BSKrkzNMhCfF
 RmM9tqf8/7Bg4uZFJGG6glhmP22v2ek=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662720952;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I5k1MMdy6xZFjxCfGr0KR81iMRVyGG886CEjYkvwlM0=;
 b=DW5Bembmcn7JVHOz5+IQWknmr3u1HjfBRVaSViWxj82Fm7RPdDYfysi3fleUxvSuBHAVSG
 1ry5Lvwi38qvgmBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DE3AE139D5;
 Fri,  9 Sep 2022 10:55:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id R5GEM7cbG2NaBQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 09 Sep 2022 10:55:51 +0000
Date: Fri, 9 Sep 2022 12:55:50 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yxsbtrcv+FEMvBfH@pevik>
References: <20220902133710.1785-1-pvorel@suse.cz>
 <20220902133710.1785-5-pvorel@suse.cz> <YxsKz9j1mVHIhcfw@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxsKz9j1mVHIhcfw@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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

Hi all,

> > +++ b/lib/tst_supported_fs_types.c
> > @@ -134,6 +134,24 @@ enum tst_fs_impl tst_fs_is_supported(const char *fs_type)
> >  	return TST_FS_UNSUPPORTED;
> >  }

> > +enum tst_fs_impl tst_fs_is_supported_skiplist(const char *fs_type, const char
> > +					      *const *skiplist)
> > +{
> > +	int ret;
> > +
> > +	ret = tst_fs_is_supported(fs_type);
> > +
> > +	if (!ret)
> > +		return ret;
> > +
> > +	if (tst_fs_in_skiplist(fs_type, skiplist)) {
> > +		tst_brk(TCONF, "%s is not supported by the test",
> > +			fs_type);

> I would expect to return TST_FS_UNSUPPORTED here. It's a bit hacky
> solution to exit a library call with tst_brk(TCONF, "");
Understand. There are 2 cases of not supported filesystems: 1) filesystem not
supported 2) filesystem skipped. Therefore I'd like to introduce
TST_FS_SKIPPED_BY_TEST (that would be 1 (therefore exit code
will have to be tested against the constants. That's IMHO better than
reinventing a wheel to detect this in testcases/lib/tst_supported_fs.c.

e.g.:

+++ b/include/tst_fs.h
@@ -171,7 +171,8 @@ int tst_fill_file(const char *path, char pattern, size_t bs, size_t bcount);
 int tst_prealloc_file(const char *path, size_t bs, size_t bcount);
 
 enum tst_fs_impl {
-       TST_FS_UNSUPPORTED = 0,
+       TST_FS_UNSUPPORTED = -2,
+       TST_FS_SKIPPED_BY_TEST = -1,
        TST_FS_KERNEL = 1,
        TST_FS_FUSE = 2,
 };

I also wonder if testcases/lib/tst_supported_fs.c should print TCONF in case of
error or just exit 0 or 1 (that's done now).

check for all filesystems (tst_supported_fs without params) is run in:
* zram01.sh - it handles no suitable filesystem, but the check could be based
  on tst_supported_fs return code
* generate_lvm_runfile.sh - does handle no suitable filesystem, but with
  'set -e' and trap - adding TCONF info would make things more clear
* prepare_lvm.sh (in prepare_lvm()) - does *not* handle no suitable filesystem.
  Although it's unlikely there is no supported filesystem it'd be better to
  print the message (it'd be more clear when testing with $LTP_SINGLE_FS_TYPE)

check for particular filesystem (tst_supported_fs foo) is run in:
* prepare_lvm.sh (in create_volume) - it check for unsupported filesystem and
  just quietly skip creating LVM. IMHO have here TCONF message would not harm.

=> Unless anybody objects I'll add TCONF messages in v5.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
