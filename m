Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E297ACD68E5
	for <ltp@archiver.kernel.org>; Tue, 10 Oct 2023 09:01:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 056E43CD7F4
	for <ltp@archiver.kernel.org>; Tue, 10 Oct 2023 11:01:36 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 563663C8905
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 11:01:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EF2FF1000929
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 11:01:23 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 9ABDC1F45E
 for <ltp@lists.linux.it>; Tue, 10 Oct 2023 09:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696928482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iDGothVHXlOOur2deBkK5f831Zp8/dkKykepQWG4Zs8=;
 b=mi0f8Wr4SBPap7v4FWEzhp+AncNYKMNGNiypSS0xehzbDHDtXKkggeZos4shzdXw7RXRF1
 mlVst0FQQCMRKP1zMr+gS2+MU6VnIu6SaPpTm1wNk/ikxMuXVQ9CEpBxWNYTxgNldr9R8F
 xINTWyGBkRAyvvGsSq2scmMPq2ltAdY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696928482;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iDGothVHXlOOur2deBkK5f831Zp8/dkKykepQWG4Zs8=;
 b=EOpjc5f957dplbaU44mZX3cLUBM4pyKAY32Ry7/Q4SD57PvkUJMX5H7uO1JdXWSoZAggvM
 NxnD9hDVglgSCpDQ==
Received: from g78 (unknown [10.163.25.62])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 4B99F2C390;
 Tue, 10 Oct 2023 09:01:22 +0000 (UTC)
References: <20231009102405.26471-1-rpalethorpe@suse.com>
 <20231009102405.26471-2-rpalethorpe@suse.com>
 <20231009115843.GA390277@pevik>
User-agent: mu4e 1.10.7; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 10 Oct 2023 09:59:42 +0100
Organization: Linux Private Site
In-reply-to: <20231009115843.GA390277@pevik>
Message-ID: <87wmvuzw9s.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] ci: Check for undefined variables in all
 scripts
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Updated with suggested changes and pushed, thanks!

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Thank you!
>
> Could you please before you commit also add license to the files:
> # SPDX-License-Identifier: GPL-2.0-or-later
>
> And maybe your/LTP copyright (whatever you prefer) into files you
> added?
>
> Kind regards,
> Petr


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
