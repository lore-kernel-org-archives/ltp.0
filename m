Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF3F7C433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 17:58:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BB1BE3C953A
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 18:58:33 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D2113C1020
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 18:58:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C38921000F23
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 18:58:23 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0963C219AA;
 Fri, 14 Jan 2022 17:58:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642183103;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H/Uq6qKZVXiQGXjjOu8FImNr6O3UnniG31bJg2VSiBE=;
 b=20N4qrCxpXBQNiwuMiKaYOgncv+USnwQDugi7JyicEVrRRBtKDP3+0xLiTsEPPSxFtpVQd
 a3K6TiYuA5A42IgwDXMkrn4pXCTnCxknAlsX1ja294q6R5Q1SnBWVHoWLNV4b4DjZRRSVm
 gN3YV8lN4IFZ0kVrh+iGUYNgXTaVcQM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642183103;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H/Uq6qKZVXiQGXjjOu8FImNr6O3UnniG31bJg2VSiBE=;
 b=Z4QD6+SAQFAjtvkJ7EIY/w65v45NBavOzD62PjEoxmFUbSJySirNQgWsNH1CGWjQfH5Mv2
 6Y1pxbhWClfoedDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AC84513BB8;
 Fri, 14 Jan 2022 17:58:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BCbIJL654WFNGgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 14 Jan 2022 17:58:22 +0000
Date: Fri, 14 Jan 2022 18:58:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YeG5vON4dxf5qLlE@pevik>
References: <20220103151332.1989-1-pvorel@suse.cz>
 <20220103151332.1989-2-pvorel@suse.cz> <YdQpS0WPRvz4vZup@yuki>
 <YdXShIOue2pXGr0C@pevik> <YeGGeN9Z1q0gpAJi@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YeGGeN9Z1q0gpAJi@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] ustat0{1,
 2}: Mark failure on Btrfs with known-fail tag
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
> > I'd prefer to have it in metadata html/pdf and in known-bug section.
> > Thus I'd prefer:

> > 	.tags = (const struct tst_tag[]) {
> > 		{"known-fail", "ustat() is known to fail with EINVAL on Btrfs, see "
> > 			"https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/"
> > 		},
> > 		{}

> > But while this is obviously ok for test output:

> > $ ./ustat01 -h
> > ...
> > Tags
> > ----
> > known-fail: ustat() is known to fail with EINVAL on Btrfs, see https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/

> > It gets parsed as new line:

> >   "ustat01": {
> >    "tags": [
> >      [
> >       "known-fail",
> >       "ustat() is known to fail with EINVAL on Btrfs, see ",
> >       "https://lore.kernel.org/linux-btrfs/e7e867b8-b57a-7eb2-2432-1627bd3a88fb@toxicpanda.com/"
> >      ]
> >     ],
> >    "fname": "testcases/kernel/syscalls/ustat/ustat01.c"
> >   }

> > Unless you think it's useful to expect that tag values can have longer input and
> > thus testinfo.pl should use all array items (except the first which is key),
> > I'd go the easy way and put the link only to top level docparse section as you
> > suggested.

> I guess that the URL in the tag field is okay too. It makes the line
> slightly longer, but at the same time it's more descriptive.

> Anyway, can we please still consider this for the release?
I'll try to post tonight or on Monday with fix for testinfo.pl which use all
array items for value (not just the second).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
