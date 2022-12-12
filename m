Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C113C4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 16:09:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4DAFC3CBE6D
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 17:09:31 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 409F03CBE28
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 17:09:21 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C2D70600348
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 17:09:20 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 18EB41FDE2;
 Mon, 12 Dec 2022 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670861360;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rvxVMvu3UovR7LM06xE8BLb1wkJvEVLhI2yuelEdHKI=;
 b=DZWOgSelNBEXpQrlVa6wWRq3sbvgO48I9LDPfcmJ725qZfPwsEfZycKvzap/+6mYKy8MgR
 W8BxAljjOwB66Ko8wedR3w46NfCA90IgIYlnBC/DSs4xBiZJclUG4SIsAeKilyYPDpgt9Q
 SXCu1HxsFlfFhE1Nafvd4uWg5NnJUpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670861360;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rvxVMvu3UovR7LM06xE8BLb1wkJvEVLhI2yuelEdHKI=;
 b=5smgtjRhSfIF6UYd9uoye6j5VFCjoIke+p19d5j/YMgAxDxKTDaTDa/HZeCY4+nrBdue1x
 oSqlTfJe8dU5vjDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8F48138F3;
 Mon, 12 Dec 2022 16:09:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GIqANy9Sl2NmegAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 12 Dec 2022 16:09:19 +0000
Date: Mon, 12 Dec 2022 17:09:18 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <Y5dSLjK2MlCHMPN7@pevik>
References: <20221212135524.1333-1-rpalethorpe@suse.com>
 <20221212135524.1333-3-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221212135524.1333-3-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie,

> Depending on the workload, the way in which a file system is filled
> will be different. The system calls will also be different.

> This adds a fill mode which uses writev with uniform batches of
> data. This simulates when the FS is filled by a program which batches
> writes.
...

FYI this broke CI on Alpine.

> +++ b/lib/tst_fill_fs.c
...
> +void fill_flat_vec(const char *path, int verbose)
> +{
> +	int dir = SAFE_OPEN(path, O_PATH | O_DIRECTORY | O_FSYNC);

Alpine has problem with O_FSYNC:

In file included from ../include/tst_test.h:110,
                 from tst_fill_fs.c:13:
tst_fill_fs.c: In function 'fill_flat_vec':
tst_fill_fs.c:76:58: error: 'O_FSYNC' undeclared (first use in this function); did you mean 'O_ASYNC'?
   76 |         int dir = SAFE_OPEN(path, O_PATH | O_DIRECTORY | O_FSYNC);
      |                                                          ^~~~~~~
../include/tst_safe_macros.h:90:58: note: in definition of macro 'SAFE_OPEN'
   90 |         safe_open(__FILE__, __LINE__, NULL, (pathname), (oflags), \
      |                                                          ^~~~~~
tst_fill_fs.c:76:58: note: each undeclared identifier is reported only once for each function it appears in
   76 |         int dir = SAFE_OPEN(path, O_PATH | O_DIRECTORY | O_FSYNC);
      |                                                          ^~~~~~~
../include/tst_safe_macros.h:90:58: note: in definition of macro 'SAFE_OPEN'
   90 |         safe_open(__FILE__, __LINE__, NULL, (pathname), (oflags), \
      |                                                          ^~~~~~
make: *** [../include/mk/rules.mk:15: tst_fill_fs.o] Error 1

It actually does not have it in fcntl.h (and nowhere in the sources).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
