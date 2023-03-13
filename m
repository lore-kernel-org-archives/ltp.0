Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2096C6FD1C
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 20:54:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0DDC63CD5B4
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 21:54:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FFAA3C1047
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 21:53:58 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CB8386008A5
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 21:53:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1B0D61F45A;
 Mon, 13 Mar 2023 20:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678740835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FlgNmkeOSgZuQRTqlIo6L4LIzKRH/RHMVoflv2aw1FQ=;
 b=gjKKUS0N9FxCULSXAutv0JB8SKPYmhx9dDEs2yYnoxZTJ4YjEpUCXDDTRSpe0dnt6B/vjQ
 8hSRU+Kk3EY+7tBs6QSTou/eHUwVuZNmFI450YJqrk8GQaDx+KweKfKo7aXjGXScpXJ5iU
 5aPCD9rCmEj/d2j+Rh01Sq0gRCbPCTA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678740835;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FlgNmkeOSgZuQRTqlIo6L4LIzKRH/RHMVoflv2aw1FQ=;
 b=v3EsHSgUxyZhpHGevrcfAcX0VrtE5jNHoIwpZi8y7UYml8Azw+Y1xwdOOHG38U992QCDza
 7XgTnJU/mJGl4TAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D689613582;
 Mon, 13 Mar 2023 20:53:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tzA6MmKND2QtGAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Mar 2023 20:53:54 +0000
Date: Mon, 13 Mar 2023 21:53:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Bird, Tim" <Tim.Bird@sony.com>
Message-ID: <20230313205353.GA11805@pevik>
References: <20230309145917.26846-1-pvorel@suse.cz>
 <BYAPR13MB2503F6AE85D17F078B806C0AFDBA9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <20230310073406.GB2216@pevik> <20230310114747.GA5055@pevik>
 <BYAPR13MB2503C9BF7ED9D78FAD55E6FEFDBA9@BYAPR13MB2503.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR13MB2503C9BF7ED9D78FAD55E6FEFDBA9@BYAPR13MB2503.namprd13.prod.outlook.com>
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>,
 Matus Marhefka <mmarhefk@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> > -----Original Message-----
> > From: Petr Vorel <pvorel@suse.cz>

> > Hi all,

> > > Hi Tim,

> > > > > +++ b/testcases/kernel/containers/share/ns_ifmove.c
> > > > > @@ -1,43 +1,31 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-or-later

> > > > I don't see "or later" anywhere in the license header that was removed.

> > > > Is this the correct SPDX license identifier?
> > > > Maybe it should be 'GPL-2.0-only'
> > > Good catch, thank you!

> > FYI I contacted Matus Marhefka privately and got his ack:

> > 	I am not on that mailing list anymore. Anyway, feel free to re-license any
> > 	of my tests to GPL-v2+, you have my agreement :)

> > => going to use the original version.

> Sounds good.  You may want to note this authorization to change the
> license, in the commit message for this patch.

Hi Tim,

Make sense, I'll do. Thanks for paying attention to license, it's important.

Kind regards,
Petr

>   -- Tim

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
