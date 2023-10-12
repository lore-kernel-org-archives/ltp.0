Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C74CDB46E
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 09:47:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79BFE3CD400
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 11:47:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8DF703C888B
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:47:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BA62A200C04
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 11:47:17 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A9B8F1F74B;
 Thu, 12 Oct 2023 09:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697104036;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KzqjMU0QwvTiZwSEgFz56H/8YthFQcVioH6xoUJAzjY=;
 b=uTeavfPQ9t4RM4eP2JFdC28uaQ/dqgBJEPBoVXaj+fHNVZ31RuqaUNhmb28ccW4RBO31si
 fYUdwX9jihJwAImBircvzT7d5jpEriTVwkENOw1u8t1p6CMDXPMJAbatKJ3gUAkI44OIQd
 ZsRVU6O9gF5mWgstBVlvH1BsVAYnmw4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697104036;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KzqjMU0QwvTiZwSEgFz56H/8YthFQcVioH6xoUJAzjY=;
 b=kYiWgTHLhiQifdZnUGQj5POxrhq2Pf/a9m1N5mtpyMnj+eSFzeoqRsP/ro6kFQMng1Vn74
 BELSesmk7oFRAnBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7D585139ED;
 Thu, 12 Oct 2023 09:47:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id bVB2HaTAJ2WceAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 12 Oct 2023 09:47:16 +0000
Date: Thu, 12 Oct 2023 11:47:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231012094715.GA609744@pevik>
References: <20231012094254.611488-1-pvorel@suse.cz>
 <ZSfAWoGD1ceYPYzW@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZSfAWoGD1ceYPYzW@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] README: Document gdb debugging
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

Hi Cyril,

...
> > +Debugging with gdb
> > +==================
> > +
> > +To get stack trace of a crashing test in gdb it's useful to
> > +[`set follow-fork-mode child`](https://ftp.gnu.org/old-gnu/Manuals/gdb/html_node/gdb_25.html).

> Maybe we should start with a sentence that actually describes how things
> are organized so that it's clear why this is needed. Maybe just:

> The new test library runs the actual test, i.e. the `test()` function in
> a forked process. To get the stack trace of a crashing test it's needed
> to [`set ....

+1, thank you.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
