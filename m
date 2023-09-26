Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 117D2E7D27B
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 10:50:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78F9E3CDC94
	for <ltp@archiver.kernel.org>; Tue, 26 Sep 2023 12:50:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BE2323CC757
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 12:50:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 224F2140012C
 for <ltp@lists.linux.it>; Tue, 26 Sep 2023 12:50:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 550F31F7AB;
 Tue, 26 Sep 2023 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695725413;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VbaLKZ0b13+dl/T5pB/DyGq6pG0wITRbjBHT/sHztDQ=;
 b=KMa9Jytd/elZVt5juNgw1obLq46TUWaXrLlPPFrJMPNQ/DOWhbnHXdgzqPC/Xrib4pb1tq
 yL6UezMQmYp6xhANKAS8nE59yfbelb9P2QTnPlxSYyXhSdExCZkvEd41CaplRC3ODz28c1
 HCJGCLvuiTG4ez+R1Roe+B49/n7uERI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695725413;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VbaLKZ0b13+dl/T5pB/DyGq6pG0wITRbjBHT/sHztDQ=;
 b=FJkZef9/S4ll4TN2A79pw9fdlhg/Oq2iQUHL5L1YlMuKIDtLi+uLuh1HEoKeChOFtAfAYD
 wzm4dHGEyK/ByvDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B137613434;
 Tue, 26 Sep 2023 10:50:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7LoNKmS3EmVjWwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 26 Sep 2023 10:50:12 +0000
Date: Tue, 26 Sep 2023 12:50:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: automated-testing@lists.yoctoproject.org
Message-ID: <20230926105011.GA133737@pevik>
References: <ZQF5J0UJ25_QLwcQ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQF5J0UJ25_QLwcQ@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
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
Cc: Khem Raj <raj.khem@gmail.com>, Richard Palethorpe <rpalethorpe@suse.com>,
 Mike Frysinger <vapier@gentoo.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi testing community,

> Hi!
> As usuall we are supposed the release LTP at the end of the month. In
> order to get at least two weeks of pre-release testing I would like to
> freeze the git starting next week. I will try to review and merge as
> much as possible till the end of this week. If there is anything that
> you think should go into the release let me know so that I can have a
> look.

FYI we plan to release LTP this week on Friday. It's not much time left, but if
you have time, please try to do some LTP pre-release testing on your favourite
distro.

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
