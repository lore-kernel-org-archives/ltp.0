Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E789C6FA83
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 20:30:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BD7F63CAAB7
	for <ltp@archiver.kernel.org>; Mon, 12 Sep 2022 22:30:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 01D233CAA99
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 22:29:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B8706600847
 for <ltp@lists.linux.it>; Mon, 12 Sep 2022 22:29:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EB08833ECC;
 Mon, 12 Sep 2022 20:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663014596;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+EUZmn23iSUjeEb+RwMk/7ZjLXNfgMWQ8PL+Qu4EG90=;
 b=ahWPQePA8l+LTaDB4xEdHOylkT3jZ8LDCWKh/8EOXWW172KfMdVz7m+/2DFCx0u4kj9fy2
 YmNrFdsG/33p+x5dHkMJkdbr6FSe86wnm9RNeavKsU8+2GreynT0vIxTPdPbv3kvQcWMoJ
 1jFXawRFEq1EGSJ7HKv8cmAKl7HS0NI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663014596;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+EUZmn23iSUjeEb+RwMk/7ZjLXNfgMWQ8PL+Qu4EG90=;
 b=P+9pPOZeQtJR8XQf9S0EJSoX5iQFNNG2+YDPTrVIxCQapOWCmRBpOCIHNHMK8qTHVY0cKp
 dJC3/GanS7c9/iAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B1C62139E0;
 Mon, 12 Sep 2022 20:29:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rGzmKcSWH2PUQQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 12 Sep 2022 20:29:56 +0000
Date: Mon, 12 Sep 2022 22:29:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yx+WwsY6xXV8t+62@pevik>
References: <20220909141840.18327-1-pvorel@suse.cz>
 <20220909141840.18327-4-pvorel@suse.cz> <Yx9Fa69/ukgEJylz@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yx9Fa69/ukgEJylz@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > Although this is unlikely, it can happen.
> > This means 32 (TCONF) instead of 0 exit code when searching for all
> > filesystems and 32 instead of 1 when searching for a particular
> > filesystem.

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > New in v5

> > NOTE:

> > Although this will later leads to duplicating message (see below) it's
> > IMHO better because LVM scripts and zram01.sh use this helper directly.

> > Tests added in later commits which demonstrates TCONF:

> Shouldn't we rather than this add tst_res(TCONF, "...") messages to the
> lib/tst_supported_fs_types.c so that we get consistent messages between
> C and shell?

Well, in v4 I add TCONF in tst_fs_is_supported_skiplist()
(lib/tst_supported_fs_types.c), but you asked for TST_FS_UNSUPPORTED [1].

This function is used only in testcases/lib/tst_supported_fs.c, i.e. in shell.
C API handles skip list in do_test_setup() (lib/tst_test.c). I don't like this
inconsistency either, but not sure now how to put common code to
lib/tst_supported_fs_types.c (new function).

There is also inconsistency in "There are no supported filesystems"
(run_tcases_per_fs in lib/tst_test.c) and "There are no supported filesystems or
all skipped" in testcases/lib/tst_supported_fs.c. I'm not sure if it's worth to
add function tst_loop_per_fs (or macro in kernel style TST_FOR_EACH_FS()), so
that check and TCONF would be on single place.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/YxsKz9j1mVHIhcfw@yuki/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
