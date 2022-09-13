Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68760C6FA82
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 13:08:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A60DB3CABCC
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 15:08:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0D8633CA9FE
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 15:08:23 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4C5A56012C3
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 15:08:22 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 513201F921;
 Tue, 13 Sep 2022 13:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663074500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qS0vBXLcq9reaiKn/obj7PbleE9XR44Vp/BPHRQHP8=;
 b=RDkcdSoSob/z2s42YAioqVOFyZ7tQazikQ7na4Wyrjr1CTICvJ7Tp9ll/JqisdeC9Nz1pa
 sVLHZOkZgcwqpol06RScvlzBxi1UtPenwR7yin15GTj6ec2KuJwK3q/9dMG+j6wiX6ivwW
 BB3FFvXQpkTji+CsPPWg/gX2rp7iXeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663074500;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2qS0vBXLcq9reaiKn/obj7PbleE9XR44Vp/BPHRQHP8=;
 b=nRB8ujgMdnwY8RciWcGQGMicKl7NCYfKYGFnCwHEfqLiLkDh7D9hiO9uWNeREGU8bmx/2d
 B85Fl49KQlj1x1Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E2FB2139B3;
 Tue, 13 Sep 2022 13:08:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rKfMNcOAIGNpFQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 13 Sep 2022 13:08:19 +0000
Date: Tue, 13 Sep 2022 15:08:18 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it,
 Li Wang <liwang@redhat.com>, Richard Palethorpe <rpalethorpe@suse.com>,
 Martin Doucha <mdoucha@suse.cz>, Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YyCAwhSvalgj2xrI@pevik>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-4-pvorel@suse.cz> <Yx9Fa69/ukgEJylz@yuki>
 <Yx+WwsY6xXV8t+62@pevik> <YyA7P/eci29BIMI5@yuki>
 <YyBNdpiOGeNjVFWs@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YyBNdpiOGeNjVFWs@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 03/10] tst_supported_fs: Print TCONF if no
 filesystem supported
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > Hi!
> > > > Shouldn't we rather than this add tst_res(TCONF, "...") messages to the
> > > > lib/tst_supported_fs_types.c so that we get consistent messages between
> > > > C and shell?

> > > Well, in v4 I add TCONF in tst_fs_is_supported_skiplist()
> > > (lib/tst_supported_fs_types.c), but you asked for TST_FS_UNSUPPORTED [1].

> > I guess that we misunderstand each other. I'm fine with the library
> > printing messages, what I didn't like was the tst_brk() which made the
> > whole program execution flow obscured.

> OK, instead of this from v4:
> > +	if (tst_fs_in_skiplist(fs_type, skiplist)) {
> > +		tst_brk(TCONF, "%s is not supported by the test",
> > +			fs_type);

> I'll add in v6:
> > +	if (tst_fs_in_skiplist(fs_type, skiplist)) {
> > +		tst_res(TCONF, "%s is not supported by the test",
> > +			fs_type);
> > +		return TST_FS_UNSUPPORTED;
> > +	}

> I'll add tst_res(TINFO, "%s is supported by the test", fs_name);
> from do_test_setup() tst_fs_is_supported_skiplist() and call
> tst_fs_is_supported_skiplist() in do_test_setup().

> But not sure if there can be a cleanup of duplicity of:
> if (!filesystems[0])
> 	tst_brk(TCONF, "There are no supported filesystems")

In order to unify the API I suggest to move the check above to
tst_get_supported_fs_types() in lib/tst_supported_fs_types.c.
This function is used only on lib/tst_test.c (and will be now in
testcases/lib/tst_supported_fs.c) and uses static array fs_types.
I see no point to add wrapper which would contain this check just to keep
tst_get_supported_fs_types() without tst_brk().
@Cyril WDYT?

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
