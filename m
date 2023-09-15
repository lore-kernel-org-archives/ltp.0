Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90A9EEE6457
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 13:46:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 565493CE67B
	for <ltp@archiver.kernel.org>; Fri, 15 Sep 2023 15:46:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27F523C1BBF
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 15:46:13 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 031071A01198
 for <ltp@lists.linux.it>; Fri, 15 Sep 2023 15:46:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6637B218ED;
 Fri, 15 Sep 2023 13:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694785572;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pn+q2YbOX1EKQY5WkOKS7S515W+jWwPRshvqFsbvKBo=;
 b=vlORdHNBTjIXXFkfp07N9HjVX6rYZmgjrul+vEk3kUTFaIeii06L5X7rIlGcSZ7BDdHa/2
 NnOumzc06jZFiW0QrHcOBV7WYFIRX1YYwZ+RktzI9uv/i84MEi/jxGRGdiELDg5iKN7zHx
 jtIJE1eyccofwFCWAT5JFB46pCkSE94=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694785572;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Pn+q2YbOX1EKQY5WkOKS7S515W+jWwPRshvqFsbvKBo=;
 b=hCyRoMwyYmB3Na4tKRcxVSMBNAvCnClDDOiHh/Z0brOHLF6HynQBkyTEJY1oIfX33sKb/g
 6JPPO4OC8WEG2OAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 30CDB1358A;
 Fri, 15 Sep 2023 13:46:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id S4CCCiRgBGWvaAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 15 Sep 2023 13:46:12 +0000
Date: Fri, 15 Sep 2023 15:46:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, Richard Palethorpe <rpalethorpe@suse.com>,
 Li Wang <liwang@redhat.com>, Martin Doucha <martin.doucha@suse.com>,
 ltp@lists.linux.it
Message-ID: <20230915134610.GA23276@pevik>
References: <ZQF5J0UJ25_QLwcQ@yuki> <20230915070747.GA19381@pevik>
 <20230915120347.GA30377@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230915120347.GA30377@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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

> Hi Cyril, all,

> > > Hi!
> > > As usuall we are supposed the release LTP at the end of the month. In
> > > order to get at least two weeks of pre-release testing I would like to
> > > freeze the git starting next week. I will try to review and merge as
> > > much as possible till the end of this week. If there is anything that
> > > you think should go into the release let me know so that I can have a
> > > look.

> I also wonder if we could add LTP version patchset [1].

> Cyril raised concern to add -V (not sure why, maybe not to took -V for program
> specific getopt), instead he suggested to put this to -h or to both. [2]

> As I stated [3], I'm ok with both options. Unless anybody gives any input I'll
> send a patch which implements printing version in -h (i.e. not introduce -V).

I'm sorry, I didn't notice the LTP version patchset was already accepted. Thank you!

Kind regards,
Petr

> Kind regards,
> Petr

> [1] https://patchwork.ozlabs.org/project/ltp/list/?series=364651&state=*
> [2] https://lore.kernel.org/ltp/ZL-5kfsRIzh1ZkNd@yuki/
> [3] https://lore.kernel.org/ltp/20230725122325.GB12613@pevik/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
