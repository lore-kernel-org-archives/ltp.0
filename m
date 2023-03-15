Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABD65C6FD1D
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 02:02:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF8F43CE648
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 03:01:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B1753CAD42
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 03:01:44 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C2A551A000BB
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 03:01:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B150D21997;
 Wed, 15 Mar 2023 02:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678845702;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LoOw5OPRhXtvtd0CeyDlYjyI0TCiOyp3LzrdMR7Ilj8=;
 b=euvD6rCH3WgIcqyWKs3Pi0DU6zsZYfiZ3ljbksIhfqtpMohf7qggcs8CLJ2VDb3bSLE0wK
 PbMH4FRE2YiLk4XddpSdbQE8FnJ47LsJzTFuRSKhkQ4nQSY9u2oO6AKCGVHWeM//Bv8Ywm
 uRGWgDHeTxWMPkeLfKsvqDqXB0L3Ldg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678845702;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LoOw5OPRhXtvtd0CeyDlYjyI0TCiOyp3LzrdMR7Ilj8=;
 b=Eq0Rs+hjHA2QcVj7u5d89OPaLyw+fST7c8D6T1w4heAuI+ErauzxRSvOtO8qNkAUqCW3uq
 VtWn0EZZUXrwpqBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90F2913A00;
 Wed, 15 Mar 2023 02:01:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lJL1IQYnEWTaagAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Mar 2023 02:01:42 +0000
Date: Wed, 15 Mar 2023 03:01:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230315020140.GA138022@pevik>
References: <20230309145917.26846-1-pvorel@suse.cz>
 <20230315005637.GB18639@localhost>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230315005637.GB18639@localhost>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ns_ifmove.c: Rewrite to new API
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

> On Thu, Mar 09, 2023 at 03:59:17PM +0100, Petr Vorel wrote:
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/kernel/containers/share/ns_ifmove.c | 98 ++++++-------------
> >  1 file changed, 28 insertions(+), 70 deletions(-)

> >  	int intf_index, pid, rtnetlink_socket;

> >  	if (argc != 3) {
> > -		tst_resm(TINFO, "%s <INTERFACE_NAME> <NAMESPACE_PID>",
> > -			 argv[0]);
> > +		printf("ns_ifmove <INTERFACE_NAME> <NAMESPACE_PID>\n");
> >  		return 1;
> >  	}

> should we use tst_res(TINFO) instead of printf?

NO. If you look into testcases/lib/, none of *.c tools use tst_res().
The only separation between API for tests and API for tools / library
than TST_NO_DEFAULT_MAIN.

Actually, unless SAFE_*() are useful to use (here SAFE_SOCKET() and
SAFE_IOCTL()), we prefer to not use tst_test.h at all (see tst_cgctl.c,
tst_device.c, ...)

I also think that tst_get_free_pids.c does not need TST_NO_DEFAULT_MAIN and
tst_test workarounds.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
