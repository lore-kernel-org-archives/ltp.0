Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B44CC38A2D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 10:19:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B4603C96BB
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 12:19:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5B5483C60C9
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 12:19:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D617510005EB
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 12:19:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1FE18220BA;
 Mon, 24 Oct 2022 10:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666606742;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7JhSbfuXwadaTNRe6x+obVw+i59r4BAbQkTZkAgnWt8=;
 b=rE+2fGZk8gZgjEp4CIFP9YsNlsWah3YhG0FCI+sPeHkXFiVgQCSre8XDW615wgb93icWkk
 ezxBkbkFLFYvSwjd+vElszu4zB1gzc/MNVbRvPP7NJHFEDMj0QOHucq+59FGQqts3WF3+Y
 GjI5ETpkqjip2TRxItJmS22ohb4xRio=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666606742;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7JhSbfuXwadaTNRe6x+obVw+i59r4BAbQkTZkAgnWt8=;
 b=pnNueRzdMwri8gQxTlsXS8p/mpx0qlwkyssWr7He6s2z9+rV53o4tKPAo7ecQU3Fi2uloI
 C8Hb4suhfN2vy3Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C9D4213A79;
 Mon, 24 Oct 2022 10:19:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id vqbhLpVmVmN0DgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 24 Oct 2022 10:19:01 +0000
Date: Mon, 24 Oct 2022 12:18:59 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Akihiko Odaki <akihiko.odaki@daynix.com>, ltp@lists.linux.it,
 Yan Vugenfirer <yan@daynix.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>
Message-ID: <Y1Zmk9kheWANsZ9Z@pevik>
References: <20221020120741.212671-1-akihiko.odaki@daynix.com>
 <Y1GWOPpb+Z8hwhQd@pevik> <Y1I6u1a7RAS1wmZL@pevik>
 <34c0ff56-bed3-ade3-4936-6c96ecb8501d@daynix.com>
 <Y1Ze470vch74uGNg@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y1Ze470vch74uGNg@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] ftp/ftp01: Use tst_net.sh
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

Hi Akihiko,

...
> > I just modified this test because it is annoying to set up rsh just to fix
> > this test so I would rather not put more effort for further improvement.
> Understand, ack. Thanks for your work!

> > Personally I don't object to remove this test either.
> The fastest solution is to merge your fixed version.
> But there should be even more modifications:
> RHOST is obsolete, instead $(tst_ipaddr rhost) should be used.

> Therefore we should decide if this smoke test (and other FTP tests in LTP) is
> worth effort. If yes, I should force myself to create ftp_lib.sh and migrate
> everything to work similar way as ftp-upload-stress.sh.

Merged as it's some improvement. I'm not sure if I invest time to FTP in the
future, maybe we should really delete it.

The only significant change I did was to force running over SSH:
with RHOST="${RHOST:-localhost}"

In my case only first half of the tests is working (suppose just wrong setup),
but on netns everything si broken and you also tested it on SSH I dared to do
this change. I documented the proper fix above in case anybody cares.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
