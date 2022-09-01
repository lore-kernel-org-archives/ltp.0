Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCFA4ECAAD3
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 11:39:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E61B03CA82F
	for <ltp@archiver.kernel.org>; Thu,  1 Sep 2022 13:39:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28CEB3CA71E
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 13:39:40 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A4E361000D12
 for <ltp@lists.linux.it>; Thu,  1 Sep 2022 13:39:39 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9B0D41FFB7;
 Thu,  1 Sep 2022 11:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1662032378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hUnVIJKYTn9Ey2xMEM0nsTHN2GF42AK2JPNLH6SLaq0=;
 b=x0RIsO6t3UXae9r057olD6dVU8YA5m3NR88UU3iFJCBvAgn3thpwYBhWcIl/q9/HfZbOJy
 IcRL0Rh4WHobJmYcFTVVpG5sG+QzuOlp5/FIAUv46I9JAstVeJMbiHoC1CEH5/2QvjRhAl
 VaT9g3fjBlONS7MPOLk48YvedIqRKu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1662032378;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hUnVIJKYTn9Ey2xMEM0nsTHN2GF42AK2JPNLH6SLaq0=;
 b=jUHNCun/XIwdE2oD1Ydd7g2q7uHbs5RgdGw16YWUeWRs23A9Ne71o0jBNkl8BvzdvH/g3+
 AkojSdv6StC1LXAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5E4CC13A89;
 Thu,  1 Sep 2022 11:39:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7UGdFfqZEGNNDAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 01 Sep 2022 11:39:38 +0000
Date: Thu, 1 Sep 2022 13:39:36 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>, ltp@lists.linux.it
Message-ID: <YxCZ+Eb6amtmTtlZ@pevik>
References: <20220714060722.18894-1-akumar@suse.de>
 <YxBSF1ZgU5wSlpi+@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YxBSF1ZgU5wSlpi+@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open04.c: convert to new LTP API
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

Hi Avinesh,

> I suggest to merge with these fixes:
...
> * use TST_EXP_FAIL() - the same result as TST_EXP_FAIL2() with shorter code
I'm sorry I was completely wrong, TST_EXP_FAIL2() is correct here (I forget it
is about >0 return value, not about parameters).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
