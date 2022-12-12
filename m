Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E25BC4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 16:16:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1A303CBE73
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 17:16:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BD803CBE28
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 17:16:27 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E2E331A00143
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 17:16:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 15522337DC;
 Mon, 12 Dec 2022 16:16:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670861786; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pab4xSZr/F04Cg3N9vb05xgJ069sPniGWNygMqW9c0w=;
 b=AL6e8+ymN1psHcOzdyAgSDx7AjmMvYJv8GiLSKsrWgVORvQliqj364REk83Q4EUHbhuBia
 EMpVZX1CNHMFxkmNiiG36J9kHKnDzC6TRpIoXUHla8oNEosyLgx4vtdxyvsohM8k0MAK5X
 3WSBtEwHG3QA8nQbmt9mdPbXjSU+fKs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670861786;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pab4xSZr/F04Cg3N9vb05xgJ069sPniGWNygMqW9c0w=;
 b=Av9Pk6dBFhfcFEWzUSvEgjG6hRBWO2ghm/8dsb3kfNU5O1Fpw42xcuehbdxwis+yzpWV0d
 1aQJwmlMft4pK2Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 02827138F3;
 Mon, 12 Dec 2022 16:16:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +AnoOtlTl2PwfQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 12 Dec 2022 16:16:25 +0000
Date: Mon, 12 Dec 2022 17:16:13 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y5dTzSQcwpfyRlna@rei>
References: <20221212135524.1333-1-rpalethorpe@suse.com>
 <20221212135524.1333-3-rpalethorpe@suse.com>
 <Y5dSLjK2MlCHMPN7@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5dSLjK2MlCHMPN7@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] tst_fill_fs: Add alternate access pattern
 "flat"
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
> > Depending on the workload, the way in which a file system is filled
> > will be different. The system calls will also be different.
> 
> > This adds a fill mode which uses writev with uniform batches of
> > data. This simulates when the FS is filled by a program which batches
> > writes.
> ...
> 
> FYI this broke CI on Alpine.
> 
> > +++ b/lib/tst_fill_fs.c
> ...
> > +void fill_flat_vec(const char *path, int verbose)
> > +{
> > +	int dir = SAFE_OPEN(path, O_PATH | O_DIRECTORY | O_FSYNC);
> 
> Alpine has problem with O_FSYNC:
> 
> In file included from ../include/tst_test.h:110,
>                  from tst_fill_fs.c:13:
> tst_fill_fs.c: In function 'fill_flat_vec':
> tst_fill_fs.c:76:58: error: 'O_FSYNC' undeclared (first use in this function); did you mean 'O_ASYNC'?
>    76 |         int dir = SAFE_OPEN(path, O_PATH | O_DIRECTORY | O_FSYNC);
>       |                                                          ^~~~~~~
> ../include/tst_safe_macros.h:90:58: note: in definition of macro 'SAFE_OPEN'
>    90 |         safe_open(__FILE__, __LINE__, NULL, (pathname), (oflags), \
>       |                                                          ^~~~~~
> tst_fill_fs.c:76:58: note: each undeclared identifier is reported only once for each function it appears in
>    76 |         int dir = SAFE_OPEN(path, O_PATH | O_DIRECTORY | O_FSYNC);
>       |                                                          ^~~~~~~
> ../include/tst_safe_macros.h:90:58: note: in definition of macro 'SAFE_OPEN'
>    90 |         safe_open(__FILE__, __LINE__, NULL, (pathname), (oflags), \
>       |                                                          ^~~~~~
> make: *** [../include/mk/rules.mk:15: tst_fill_fs.o] Error 1
> 
> It actually does not have it in fcntl.h (and nowhere in the sources).

O_FSYNC originates from BSD it should be O_SYNC on Linux, but given that
this is only file descriptor passed to later openat() we can just remove
it instead since it does not make sense at all.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
