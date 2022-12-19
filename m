Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFEDC4332F
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 23:58:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF56A3CBB29
	for <ltp@archiver.kernel.org>; Tue, 20 Dec 2022 00:58:35 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F23D3C1351
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 00:58:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 65D20200261
 for <ltp@lists.linux.it>; Tue, 20 Dec 2022 00:58:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 183F438054;
 Mon, 19 Dec 2022 23:58:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671494305;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ShnW0gEYKdspUx4ZmoxhspP2mrRkAjl76gU03v3I92I=;
 b=a2RHyMVy6ZoQLFqtWiZAuoN0zl+hxNmWok3bgkCxSD2NmYzWvyA/lIfOexxsbWrwsBr6DV
 XhgbnJGvV93uZovq2JBCzJtM5k+zp4sLC5R69IrSTSpGV8oC6XbgQAnPayEnaVCdjg0mdj
 w/pTQBpxpKV2xQtbEHsZZFW1wTwiWTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671494305;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ShnW0gEYKdspUx4ZmoxhspP2mrRkAjl76gU03v3I92I=;
 b=81OKJAaYSDhzPz7N8uWozsTJc9u9J0XWPK0/8E5plKPzpUC+Nd/r+grDOhuiWa+pC8Zscc
 8dTreoNPB74tYtCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E80A713498;
 Mon, 19 Dec 2022 23:58:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9i5oN6D6oGPdcQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 19 Dec 2022 23:58:24 +0000
Date: Tue, 20 Dec 2022 00:58:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y6D6n/OJ9U6aebhg@pevik>
References: <20221216170922.21752-1-mdoucha@suse.cz>
 <98573ca81db1625d7b2f639aabeae1d9@suse.de>
 <53c35db794540b736389a7c18275cd79@suse.de> <87mt7jtq7y.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87mt7jtq7y.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add test for CVE 2022-4378
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
Cc: pvorel <pvorel@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie,

> Hello,

> pvorel <pvorel@suse.de> writes:

> > On 2022-12-19 11:07, pvorel wrote:
> >> Hi Martin,

> >>> diff --git a/testcases/cve/cve-2022-4378.c
> >>> b/testcases/cve/cve-2022-4378.c
> >>> new file mode 100644
> >>> index 000000000..e1c5df325
> >>> --- /dev/null
> >>> +++ b/testcases/cve/cve-2022-4378.c
> >>> @@ -0,0 +1,108 @@
> >>> +// SPDX-License-Identifier: GPL-2.0-or-later
> >>> +/*
> >>> + * Copyright (C) 2022 SUSE LLC <mdoucha@suse.cz>
> >>> + */
> >>> +
> >>> +/*\
> >> nit: you used /*\ docparse start comment, but without any [...] mark,
> >> thus nothing shows in generated docs.
> >> There should have been either normal C comment /* or docparse [...]
> >> mark.

> > I'm sorry, I was wrong, the text *appear* in generated docs, just
> > without any header.

> Perhaps make-check could validate the docparse string?

+1, I was already thinking about it.

It would not help in the case below, but it's definitely worth
(error in JSON will be caught by CI, but why not to catch it early?)

> > Just the text contains too much details (given we have link to git
> > commit in the table below):

> > ... fixed in:

> > commit bce9332220bd677d83b19d21502776ad555a0e73 Author: Linus Torvalds
> > <torvalds@linux-foundation.org> Date: Mon Dec 5 12:09:06 2022 -0800

> I think it is fine to even copy and paste the whole commit message. If
> we list the wrong Git commit this may make it easier to see as well.

I'd just use the format for "Fixes:":

$ git log --pretty=format:"%h (\"%s\")" -1
bce9332220bd ("proc: proc_skip_spaces() shouldn't think it is working on C strings")


Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
