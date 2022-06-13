Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2414C43334
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 15:23:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EAD83C9451
	for <ltp@archiver.kernel.org>; Mon, 13 Jun 2022 17:23:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E5223C0058
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 17:23:19 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 484071400199
 for <ltp@lists.linux.it>; Mon, 13 Jun 2022 17:23:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 79E4121BC5;
 Mon, 13 Jun 2022 15:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1655133797;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2frNH0LkmlVDH4zamDFVKQtp6ZZ7OKTWWwr2GODFhiE=;
 b=EKDegtl+tYW1WuZBjAcS2u6aHPx6r1N4LsIlENEw4eb2IuTt9Rj/wwqktO5WELtUEgx13N
 iJ9xgF38ZU4yafq4G1yEi6eomp6rtod4Up5QtiaGYVmR7xBRdOphQ0AQ+t0uSZys84HU2l
 qWY98F42DeOaYBiJsJxjk/4U/5X69TY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1655133797;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2frNH0LkmlVDH4zamDFVKQtp6ZZ7OKTWWwr2GODFhiE=;
 b=ALRWu2leWWB17puq81UAuZCaEN1GwuQeQ4sh53Ns625n+Q/I7TN02Ncc5EoqdZEYGmtHLs
 E9/JqJTd+moiIdBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2124313443;
 Mon, 13 Jun 2022 15:23:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yIReBWVWp2KSWQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 13 Jun 2022 15:23:17 +0000
Date: Mon, 13 Jun 2022 17:23:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <YqdWY1C/xBi3/tgG@pevik>
References: <20220613143826.1328830-1-amir73il@gmail.com>
 <20220613143826.1328830-2-amir73il@gmail.com>
 <CAOQ4uxjfuQ5oj8V8weD+-ChvXZ9nXy=MB285dAn1zQKV6dn2cA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAOQ4uxjfuQ5oj8V8weD+-ChvXZ9nXy=MB285dAn1zQKV6dn2cA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] syscalls/inotify12: Introduce test for
 inotify mask flags
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
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 LTP List <ltp@lists.linux.it>, Richard Palethorpe <rpalethorpe@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

> > diff --git a/testcases/kernel/syscalls/inotify/inotify12.c b/testcases/kernel/syscalls/inotify/inotify12.c
...
> > +static struct tst_test test = {
> > +       .timeout = 10,

> OOPS should be changed to .max_runtime = 10

> > +       .needs_tmpdir = 1,
> > +       .cleanup = cleanup,
> > +       .test = verify_inotify,
> > +       .tcnt = ARRAY_SIZE(tcases),
> > +       .tags = (const struct tst_tag[]) {
> > +               {"linux-git", "a32e697cda27"},
> > +               {}

> Missing }

> Sorry, I hadn't notice this build failure before posting.

No big deal, we can fix this before merge.

And we have to try again to decide how to quickly merge tests for rc kernel.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
