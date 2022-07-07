Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C22C43334
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 13:03:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BC8933CA195
	for <ltp@archiver.kernel.org>; Thu,  7 Jul 2022 15:03:41 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69ABA3C96AC
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 15:03:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C2B4B1A01148
 for <ltp@lists.linux.it>; Thu,  7 Jul 2022 15:03:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C62B51FE32;
 Thu,  7 Jul 2022 13:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1657199010;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iypJE5fH6JcGwdAmjYVaJh/P9L39AfWhyEbaJxoTtqM=;
 b=SXhkMnvdU0k4Y5HxpLHv5+NLTLEbAT74uu5NGo2C0rmXm6XPCfLPR9xTsh9GBr94BWO5Eh
 uv6/gEaVvUdTVKp/JMPMpQQ7lH3XSl2gvIyD6P56DTUvIk4dP65ro6bKTc/phWMtmAkDTr
 HfpbQY7mzMf6WX4BsNlO6psdHIFM2Zo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1657199010;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iypJE5fH6JcGwdAmjYVaJh/P9L39AfWhyEbaJxoTtqM=;
 b=StFh4dC8kTv+NAyS6gVQZJCrWWHWQXd7yEnhkU9qudlnTJMfZ/kW4DPEVQsqkO133F7W9X
 jotzuvy8awPMptDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9488A13461;
 Thu,  7 Jul 2022 13:03:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dZRtIqLZxmI+BQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 07 Jul 2022 13:03:30 +0000
Date: Thu, 7 Jul 2022 15:03:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YsbZoAFmXc7i12aG@pevik>
References: <20220617131659.27868-1-pvorel@suse.cz>
 <YrA+LFaA664fHpZA@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YrA+LFaA664fHpZA@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ci/ubuntu: impish -> jammy
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

Hi Cyril,

> Hi!
> > Ubuntu 21.10 impish EOL in 2027-04 (next month).
>                                 ^
> 			     2022-06
> > Replace it with the latest stable release (EOL 2027-04).

> Other than that:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks, merged.

> > Reported-by: Andrea Cervesato <andrea.cervesato@suse.com>
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> > Hi,

> > It's also a question whether use 20.04 LTS focal instead of 18.04 LTS
> > bionic. I guess we'd like to cover everything: bleeding edge, used
> > distros and very old and still used distros. bionic EOL next year
> > (2023-04).

> I would keep that till the EOL
Sure, np. Hope I don't forget :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
