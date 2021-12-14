Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07781C433F5
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 16:58:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 31D623C8C50
	for <ltp@archiver.kernel.org>; Tue, 14 Dec 2021 17:58:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 229213C0148
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 17:57:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B25F01001524
 for <ltp@lists.linux.it>; Tue, 14 Dec 2021 17:57:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 060591F381;
 Tue, 14 Dec 2021 16:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639501077;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7FC62ryYroHKDCd2QqVJ8TkbGXT310/DlpgPZreEl4Q=;
 b=KaTYP3fmCJJumqT/hXqEKJ2rneJXhO9EKujTU3AWyu1NHeu1QkMwc/cNZ9LaM/5F8+oxno
 kRDP4ZJHTHf6UCv7JEIu5knjKwD7jCOGP6Vu5yViA4A8U+nstfdlqZoNdENHgS5qL6rP7z
 xgpZWWK/upIbDi3CpVDwIuSWozhbM3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639501077;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7FC62ryYroHKDCd2QqVJ8TkbGXT310/DlpgPZreEl4Q=;
 b=grfQWERcFhjcbVMgwnIVgk/j7KTyHqPrqEftCOPhoh/SfKz+m1K70rinSQw8qNdqgmmV01
 yP0gHrngc8DpYSBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DC73F13A1D;
 Tue, 14 Dec 2021 16:57:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RDjXMxTNuGE6EgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 14 Dec 2021 16:57:56 +0000
Date: Tue, 14 Dec 2021 17:57:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Tim.Bird@sony.com, ltp@lists.linux.it
Message-ID: <YbjNExvj1vjnjb93@pevik>
References: <20211214144309.6704-1-pvorel@suse.cz>
 <20211214144309.6704-3-pvorel@suse.cz>
 <BYAPR13MB25037C7B8DE0850EFB25DDE5FD759@BYAPR13MB2503.namprd13.prod.outlook.com>
 <YbjKkic5F0j4c3bD@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YbjKkic5F0j4c3bD@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] tst_test: Print environment variables on -h
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

> Hi Tim,

> > > +	fprintf(stderr, "LTP_TIMEOUT_MUL      Multiply timeout (must be number >= 1)\n");

> > I think this should this be: "Timeout multiplier (must be a number >=1, should be an integer)

> Also makes sense, thanks!
Although it does not have to be integer.
=> "Timeout multiplier (must be a number >=1"

For C API it's used any value:
./open01
tst_test.c:1409: TINFO: Timeout per run is 0h 05m 00s

LTP_TIMEOUT_MUL=1.15 ./open01
tst_test.c:1409: TINFO: Timeout per run is 0h 05m 45s

For shell API:
./zram02.sh
zram02 1 TINFO: timeout per run is 0h 5m 0s
zram02 1 TINFO: timeout per run is 0h 7m 30s

LTP_TIMEOUT_MUL=1.15 ./zram02.sh
zram02 1 TINFO: ceiling LTP_TIMEOUT_MUL to 2
zram02 1 TINFO: timeout per run is 0h 10m 0s
zram02 1 TINFO: timeout per run is 0h 15m 0s

Doc [1] explain it: Variable is also used in shell tests, but ceiled to int.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/User-Guidelines

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
