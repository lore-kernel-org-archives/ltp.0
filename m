Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D48ECAAD8
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 12:10:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C212A3CACB5
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 14:10:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F3E693C278D
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 14:09:51 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4A3C8100170F
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 14:09:50 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3ED5533852;
 Fri, 16 Sep 2022 12:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663330190;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6NoZhSR0cgQ+BmUxSo4cByW0kR7NteSbrFQZVNYYPc=;
 b=XwR0B3RsVeLF7y1xKrZ+ynn4elJswMTKwJCTCKYlrUeHtUQmatsr6aMK5qf0JHSZmZ1FbI
 n1hy9YiQsgiOpoO8YpvZniEQk6skKVONPpH8IY/RcIB5nhJfGRId+czyBFqm7oHTJuNOiL
 sUqZQ5zNWD9EYmCnR0fRDdpXlHHpsW8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663330190;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g6NoZhSR0cgQ+BmUxSo4cByW0kR7NteSbrFQZVNYYPc=;
 b=h2Xgn5eEctT5QUVO1ii0HMW57b1B82Es18PnN3HyIokMxMLWHiBGBK/lx/Q+CujPF6p2Sr
 0WG99O5KOxAZjxCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8EB21332E;
 Fri, 16 Sep 2022 12:09:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jRptNo1nJGN2IAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Sep 2022 12:09:49 +0000
Date: Fri, 16 Sep 2022 14:09:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YyRnjASQiGnww/ld@pevik>
References: <20220915093639.2261-1-pvorel@suse.cz>
 <20220915093639.2261-4-pvorel@suse.cz> <YyRhxDnUoIDG0OCa@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyRhxDnUoIDG0OCa@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 3/8] tst_supported_fs: Support skip list when
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
> > And use this feature in zram01.sh.

> This looks like an leftover.

> > Also print TINFO if test it supported by the test, quit with TCONF
> > otherwise (code from do_test_setup() tst_test.c).

> > Acked-by: Richard Palethorpe <rpalethorpe@suse.com>
> > Reviewed-by: Li Wang <liwang@redhat.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/lib/tst_supported_fs.c | 11 ++++++++---
> >  1 file changed, 8 insertions(+), 3 deletions(-)

> > diff --git a/testcases/lib/tst_supported_fs.c b/testcases/lib/tst_supported_fs.c
> > index 2b42d5bb3..e2261244d 100644
> > --- a/testcases/lib/tst_supported_fs.c
> > +++ b/testcases/lib/tst_supported_fs.c
> > @@ -80,14 +80,19 @@ int main(int argc, char *argv[])
> >  		return 2;
> >  	}

> > -	if (optind < argc)
> > -		return !tst_fs_is_supported(argv[optind]);
> > +	if (optind < argc) {
> > +		if (tst_fs_in_skiplist(argv[optind], (const char * const*)skiplist))
> > +			tst_brk(TCONF, "%s is not supported by the test", argv[optind]);

> > +		tst_res(TINFO, "%s is supported by the test", argv[optind]);
> > +
> > +		return 0;
> > +	}

> So we now do not check if filesystem is supported just check against the
> skiplist?

Good catch, before there was check for mkfs.foo even for single filesystem
(via. tst_fs_is_supported()). Now I removed it when checking single filesystem
(It's still being checked for all filesystems in code below:
filesystems = tst_get_supported_fs_types((const char * const*)skiplist); ).

FYI skip list without mkfs is needed for $TST_SKIP_FILESYSTEMS used without
TST_ALL_FILESYSTEMS=1, i.e. in tst_test.sh:


    if [ "$TST_ALL_FILESYSTEMS" != 1 ]; then
        if ! tst_supported_fs -s "$TST_SKIP_FILESYSTEMS" $TST_FS_TYPE > /dev/null; then
            tst_brk TCONF "$TST_FS_TYPE is not supported"
        fi
    fi

> I guess that it would make sense if -s option was present, but
> shouldn't we check for mkfs and kernel support without -s if filesystem
> was specified?

This would solve problem for prepare_lvm.sh, where code:
if ! tst_supported_fs $fsname; then
checks just for mkfs.foo (no skip list). The problem is with certain
inconsistency of mkfs check: because when checking skip list for all
filesystems, both mkfs and skip list are being addressed (i.e. check for mkfs
even -s is passed). Also it might be useful in the future to check both skip
list and mkfs even for single filesystem.

Shouldn't there be an getopt option to decide?
e.g. by default both skip list and mkfs (no matter if -s is passed) and with
option (e.g. -o) check only for a list? This is not needed when checking all
filesystems, only for testing single filesystem, so I wonder if I should
implement it for all filesystems mode.

But as this is not needed I'm ok to implement what you suggest:
tst_supported_fs -s skiplist foo would check only if the used filesystem is not
filtered by skip list (used in tst_test.sh).

tst_supported_fs foo would check only for mkfs.foo (used in prepare_lvm.sh).

What do you prefer?

Kind regards,
Petr


> >  	filesystems = tst_get_supported_fs_types((const char * const*)skiplist);

> >  	if (!filesystems[0])
> > -		tst_brk(TCONF, "There are no supported filesystems");
> > +		tst_brk(TCONF, "There are no supported filesystems or all skipped");

> >  	for (i = 0; filesystems[i]; i++)
> >  		printf("%s\n", filesystems[i]);
> > -- 
> > 2.37.3

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
