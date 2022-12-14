Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B243C4332F
	for <ltp@archiver.kernel.org>; Wed, 14 Dec 2022 20:37:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A3C3D3CBD66
	for <ltp@archiver.kernel.org>; Wed, 14 Dec 2022 21:37:46 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6B413CB893
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 21:37:37 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 08C5F6008F4
 for <ltp@lists.linux.it>; Wed, 14 Dec 2022 21:37:36 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A5CF520329;
 Wed, 14 Dec 2022 20:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671050254;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=joaIVjKlCWkKP0fmCBXMvW2EZaW0rUqxHuXmISqXW8k=;
 b=YfE/ZOYhMeCcNwvlg04vjCrp/1di4dCorVOgNH2a1kSI730z3Z51MkM1I/BmcTFNz8ynyt
 7h0wNNWTHVKoKpSri0on5SchUif9om6QqpoZUaWsT1M9ap3g9IWCP/bKZo/neS3iaVKFEN
 +dRmDJi0bmS+BzqegJTbdfYjVZh0WzI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671050254;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=joaIVjKlCWkKP0fmCBXMvW2EZaW0rUqxHuXmISqXW8k=;
 b=03t6oX2KhS3FHdCmzAOYGFfL+0lsoq4yW3l5KXFNDAV+7P14W6z4PH4s5wER7aCURUKjnJ
 moDthTVXa4qF8oDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 67B50138F6;
 Wed, 14 Dec 2022 20:37:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kZvlFg40mmPyYQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 14 Dec 2022 20:37:34 +0000
Date: Wed, 14 Dec 2022 21:37:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y5o0DF5paB5iox5p@pevik>
References: <20221213003553.3693243-1-zijunzhao@google.com>
 <87359jshpc.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87359jshpc.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] signalfd01.c: put the right round bracket to the
 right place in tst_resm
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

Hi all,

> Hello,

> The patch is perfect, but you need to add your Signed-off-by git trailer
> to the commit (or just respond this e-mail with it).

I added Zijun's mail and merged. Thanks for the fix!

I dared to slightly modify the commit message and added
Fixes: 3306ad4398 ("m4: clean up ltp-signalfd.m4")

Kind regards,
Petr


> zijunzhao via ltp <ltp@lists.linux.it> writes:

> > ---
> >  testcases/kernel/syscalls/signalfd/signalfd01.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)

> > diff --git a/testcases/kernel/syscalls/signalfd/signalfd01.c b/testcases/kernel/syscalls/signalfd/signalfd01.c
> > index 3df941785..c6a7c3a58 100644
> > --- a/testcases/kernel/syscalls/signalfd/signalfd01.c
> > +++ b/testcases/kernel/syscalls/signalfd/signalfd01.c
> > @@ -249,8 +249,7 @@ void do_test2(int fd, uint32_t sig)
> >  		goto out;
> >  	} else {
> >  		tst_resm(TFAIL, "got unexpected signal: signal=%d : %s",
> > -			 fdsi.ssi_signo),
> > -			 strsignal(fdsi.ssi_signo);
> > +			 fdsi.ssi_signo, strsignal(fdsi.ssi_signo));
> >  		goto out;
> >  	}

> > -- 
> > 2.39.0.rc1.256.g54fd8350bd-goog

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
