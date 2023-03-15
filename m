Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80914C6FD1D
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 04:39:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 858583CD500
	for <ltp@archiver.kernel.org>; Wed, 15 Mar 2023 05:39:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F78F3C54D5
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 05:39:02 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 89E1E6008E0
 for <ltp@lists.linux.it>; Wed, 15 Mar 2023 05:39:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C9A811F8CD;
 Wed, 15 Mar 2023 04:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678855140; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hjy4tN1qMzcHmRPjIOp2M2awCAYjCIbR11zXRUQ2QkU=;
 b=oAgHJbGBuSJo8fHUmGGKLjn8Qi1QtQmCZJG8wjnUfGQ6giksayKXm7FgXdUsfsdwmlYFo8
 8KoVt0PPcqFWVgs3pccwnPHHXe29qssf+sejSx3SeaXaLX/fotIvoD0EbmM1M6zin5WDY5
 bGcllMitZEaINhjRJCnvr+2BgPtHNds=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CED513A00;
 Wed, 15 Mar 2023 04:39:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ccBGAeRLEWQ4JwAAMHmgww
 (envelope-from <wegao@suse.com>); Wed, 15 Mar 2023 04:39:00 +0000
Date: Wed, 15 Mar 2023 00:38:57 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20230315043857.GA5336@localhost>
References: <20230309145917.26846-1-pvorel@suse.cz>
 <20230315005637.GB18639@localhost> <20230315020140.GA138022@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230315020140.GA138022@pevik>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Mar 15, 2023 at 03:01:40AM +0100, Petr Vorel wrote:
> > On Thu, Mar 09, 2023 at 03:59:17PM +0100, Petr Vorel wrote:
> > > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > > ---
> > >  testcases/kernel/containers/share/ns_ifmove.c | 98 ++++++-------------
> > >  1 file changed, 28 insertions(+), 70 deletions(-)
> 
> > >  	int intf_index, pid, rtnetlink_socket;
> 
> > >  	if (argc != 3) {
> > > -		tst_resm(TINFO, "%s <INTERFACE_NAME> <NAMESPACE_PID>",
> > > -			 argv[0]);
> > > +		printf("ns_ifmove <INTERFACE_NAME> <NAMESPACE_PID>\n");
> > >  		return 1;
> > >  	}
> 
> > should we use tst_res(TINFO) instead of printf?
> 
> NO. If you look into testcases/lib/, none of *.c tools use tst_res().
> The only separation between API for tests and API for tools / library
> than TST_NO_DEFAULT_MAIN.
Got it, this is lib API. Why ns_ifmove.c's parent directory name is 
"share" instead of "lib" or at least contain "lib" key word?

> 
> Actually, unless SAFE_*() are useful to use (here SAFE_SOCKET() and
> SAFE_IOCTL()), we prefer to not use tst_test.h at all (see tst_cgctl.c,
> tst_device.c, ...)

> 
> I also think that tst_get_free_pids.c does not need TST_NO_DEFAULT_MAIN and
> tst_test workarounds.
Is there possible split current tst_test.h to two files and remove 
TST_NO_DEFAULT_MAIN workaround? Such as tst_tools.h(include SAFE*) for lib api
and main.h for testcase.

> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
