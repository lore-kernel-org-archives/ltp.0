Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5D6AC433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 12:24:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3A72C3C9592
	for <ltp@archiver.kernel.org>; Fri, 18 Mar 2022 13:24:19 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 935B53C9447
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 13:24:07 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E93161A010DF
 for <ltp@lists.linux.it>; Fri, 18 Mar 2022 13:24:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 180C41F37F;
 Fri, 18 Mar 2022 12:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647606246;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iGDTfr2K3aiQYLZHYYFBKteYW3Y9OOfm4mKqjS5twLg=;
 b=lAtRg9e6dfwChsdAQqEbo+06xqYXRsjWdUIFaaZK2Ud0fWH8pQJksfIXKeJ905BKaEo7sK
 iqYttyv4CBhffljJdfiJcWmchSNITfl3MtrOMt3H18+9ddnMwMrF8ty1mUg6XVCsnQH8rw
 riGfD5vllB0/MCJVi4r4O5cu8W4C0do=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647606246;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iGDTfr2K3aiQYLZHYYFBKteYW3Y9OOfm4mKqjS5twLg=;
 b=7AB+qwft7hIpj0fnq3dc0s5XGplZR78Kyzv928MVdJqOrEV9xlCZiS0qQvP/1I1hr2c/WU
 pW+DJ87+OYhA4iAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 923F112FC5;
 Fri, 18 Mar 2022 12:24:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Sx1qDuR5NGKHEAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 18 Mar 2022 12:24:04 +0000
Date: Fri, 18 Mar 2022 13:23:56 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YjR53Ote31J7bCaD@pevik>
References: <YjN+hsHidEX0ivoX@pevik> <6233F9CA.7060207@fujitsu.com>
 <6234004C.4030804@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6234004C.4030804@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] quotactl0{2, 3, 5,
 7}.c dependency problems on older kernels
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
Cc: "martin.doucha@suse.com" <martin.doucha@suse.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

...
> > Firstly, can you try mkfs.xfs -m reflink=0 way whether fix these  two
> > problems?

> You can also just increase dev_min_size to 512 to check whether fix this 
> logsize problem.

No, using .dev_min_size = 512 (and removing .dev_fs_opts "-m reflink=0") does
not help (fails as without any fix).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
