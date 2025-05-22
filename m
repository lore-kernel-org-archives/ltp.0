Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE08C54E90
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 19:26:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40F3B3CC8AE
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 21:26:33 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB5BE3C006A
 for <ltp@lists.linux.it>; Thu, 22 May 2025 21:26:17 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A82CC600964
 for <ltp@lists.linux.it>; Thu, 22 May 2025 21:26:16 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A0CED1F894;
 Thu, 22 May 2025 19:26:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747941975;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iE+TgaoxqnE1up7axCyyAAaZvmsFEQ7bwcrk3cF5Tj4=;
 b=kkQShylpzVB0GOMBZmDXNeB/jL0wGyGQWmOzk+hNiOQDCAo199LVGZXFy7/jM0YGcLrdGs
 z+nILUI83e7Dbx4PPoizU4G2o9dCegVzGauImkqTsnB/yicPaoqirQh31NvdKfVqVb5Shn
 cQpowOHjHLhv3cOVL21C1PCbMG9bkg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747941975;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iE+TgaoxqnE1up7axCyyAAaZvmsFEQ7bwcrk3cF5Tj4=;
 b=8eC+Un/DclYufpd4ZMUatrYGhA28Zt0lgxYce1W7rcnWpOr+n8kOOUmBpxcpzmAZwJRsEu
 /CogK3WGCuuRQ6Bg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747941975;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iE+TgaoxqnE1up7axCyyAAaZvmsFEQ7bwcrk3cF5Tj4=;
 b=kkQShylpzVB0GOMBZmDXNeB/jL0wGyGQWmOzk+hNiOQDCAo199LVGZXFy7/jM0YGcLrdGs
 z+nILUI83e7Dbx4PPoizU4G2o9dCegVzGauImkqTsnB/yicPaoqirQh31NvdKfVqVb5Shn
 cQpowOHjHLhv3cOVL21C1PCbMG9bkg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747941975;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iE+TgaoxqnE1up7axCyyAAaZvmsFEQ7bwcrk3cF5Tj4=;
 b=8eC+Un/DclYufpd4ZMUatrYGhA28Zt0lgxYce1W7rcnWpOr+n8kOOUmBpxcpzmAZwJRsEu
 /CogK3WGCuuRQ6Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 314E513433;
 Thu, 22 May 2025 19:26:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cbYoCVd6L2gSagAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 22 May 2025 19:26:15 +0000
Date: Thu, 22 May 2025 21:26:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250522192612.GA26060@pevik>
References: <20250521095302.13845-1-chrubis@suse.cz>
 <20250522173111.GA19708@pevik> <aC9jOhqDkRwGp9-T@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aC9jOhqDkRwGp9-T@rei>
X-Spamd-Result: default: False [-0.50 / 50.00]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[6];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: LTP_SINGLE_FS_TYPE fix fuse blacklist
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

> Hi!
> > > The case of LTP_SINGLE_FS_TYPE did not proplerly used the fuse
> > > filesystem blacklist and we enabled fuse filesystem even for tests that
> > > explicitly stated in the tst_test structure that they do not work with
> > > fuse.

> > > Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> > > CC: Jan Polensky <japo@linux.ibm.com>
> > > ---
> > >  lib/tst_supported_fs_types.c | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)

> > > diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> > > index bbbb8df19..3a394283c 100644
> > > --- a/lib/tst_supported_fs_types.c
> > > +++ b/lib/tst_supported_fs_types.c
> > > @@ -158,8 +158,10 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)
> > >  	only_fs = getenv("LTP_SINGLE_FS_TYPE");

> > >  	if (only_fs) {
> > > +		enum tst_fs_impl ret;
> > >  		tst_res(TINFO, "WARNING: testing only %s", only_fs);
> > > -		if (tst_fs_is_supported(only_fs))
> > > +		ret = tst_fs_is_supported(only_fs);
> > > +		if (ret == TST_FS_KERNEL || (ret == TST_FS_FUSE && !skip_fuse))
> > >  			fs_types[0] = only_fs;

> > Is it really good thing to do?
> > Because LTP_SINGLE_FS_TYPE forces whatever filesystems, it ignores
> > .skip_filesystems. E.g. creat09.c don't want to be tested on ntfs (and others
> > but we can force it):

> Ah, right, we have to apply the skiplist as well, so on the top of that
> we need, I will send a v2.

> diff --git a/lib/tst_supported_fs_types.c b/lib/tst_supported_fs_types.c
> index 3a394283c..736e68dec 100644
> --- a/lib/tst_supported_fs_types.c
> +++ b/lib/tst_supported_fs_types.c
> @@ -159,10 +159,16 @@ const char **tst_get_supported_fs_types(const char *const *skiplist)

>         if (only_fs) {
>                 enum tst_fs_impl ret;
> +
>                 tst_res(TINFO, "WARNING: testing only %s", only_fs);
> +
> +               if (tst_fs_in_skiplist(only_fs, skiplist))
> +                       return fs_types;
> +
>                 ret = tst_fs_is_supported(only_fs);
>                 if (ret == TST_FS_KERNEL || (ret == TST_FS_FUSE && !skip_fuse))
>                         fs_types[0] = only_fs;
> +
>                 return fs_types;
>         }

+1 for this.


> > Could we clearly define what we expect from LTP_SINGLE_FS_TYPE?
> > FYI I put links to the discussion in the ticket
> > https://github.com/linux-test-project/ltp/issues/1242

> > I understand the wish to use LTP_SINGLE_FS_TYPE for a proper testing.  If that
> > requires to respect .skip_filesystems, but
> > 1) it should be done for all filesystems
> > 2) we should have another variable to allow to force the user defined
> > filesystem, e.g.
> > LTP_SINGLE_FS_TYPE=ntfs LTP_SINGLE_FS_TYPE_FORCE_FS=1

> What about LTP_FORCE_SINGLE_FS_TYPE=ntfs that would do the same as
> LTP_SINGLE_FS_TYPE=ntfs but would disable the skiplist?

+1, it should go to the release.

But please update also doc doc/users/setup_tests.rst + -h help in lib/tst_test.c
and testcases/lib/tst_test.sh (variable will of course affect both).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
