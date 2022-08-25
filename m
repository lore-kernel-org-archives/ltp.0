Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A65D2ECAA25
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 16:24:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD4AD3CA441
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 18:24:46 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 769F63C010E
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 18:24:37 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id D4FC810005CC
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 18:24:36 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 2347F5BF9A;
 Thu, 25 Aug 2022 16:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661444676;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q0XScGcV4pMVLCTuOYiv2WQVlms8SpmdgvBM+5eu9v8=;
 b=gt0zTj1KqWUzit8YVBfQoQwD+SbrkWibtCe6lnFqPSufGEDniIy65yda2oJF4lzFnE5spy
 L1bmlbPc8Qq8bnT8zF5aZjyVDMABKlAD19sF4U2MlSsLVQhIkL0kvqy26WGaawSFli9NAG
 zqyq1R9F/7Obba2Kx4qdAe/M4p1ffOQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661444676;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q0XScGcV4pMVLCTuOYiv2WQVlms8SpmdgvBM+5eu9v8=;
 b=Rro5vHXMaCfzKmibGr0CVDy4Ejp/3cJ+1RxkVEbzip9uepmz5B32TY7VpG3MBMCc9e1F7/
 Wu7tEKeXZpNCPYCg==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D955A2C141;
 Thu, 25 Aug 2022 16:24:35 +0000 (UTC)
References: <20220824215421.90947-1-luke.nowakowskikrijger@canonical.com>
 <YwdWKb/Imzwk5F1V@pevik>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 25 Aug 2022 17:22:19 +0100
In-reply-to: <YwdWKb/Imzwk5F1V@pevik>
Message-ID: <87wnaw1ebh.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] API/cgroup: Add rdma controller
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
Cc: ltp@lists.linux.it,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Luke,
>
>> There is a test reporting "TBROK: 'rdma' controller is unknown
>> to LTP" so lets add the controller.
>
> Out of curiosity: which test?
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> Kind regards,
> Petr

I'm not sure, I think it was one of the shell tests which tries to mount
all the controllers. Anyway, merged thanks!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
