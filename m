Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4496C7EE31
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 15:24:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A50E73CDDD6
	for <ltp@archiver.kernel.org>; Tue, 28 Feb 2023 16:24:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E0FE3C30A8
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 16:24:28 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 78D591400963
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 16:24:28 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id CCE791FDBE
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 15:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1677597867;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNJLo/0tTKk4FYR+pK/VjLpL1m93ESufDnbxHlV1S1M=;
 b=ieg57jGzUSS2jnY5smcUF3KFemyOiYP4yF7YZwwk4FuimHCqHsHwJEFtGSs1xTsIZYJOYM
 WYzloxLOrwUX+OYBLQVlheZsjEMcQGnhYZdSwZ9X4Ru0dUatplnvQYKkYt3ygJPKufHvZy
 4TIDajTyBou/aZfaiyTkKoZhQ/640D0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1677597867;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mNJLo/0tTKk4FYR+pK/VjLpL1m93ESufDnbxHlV1S1M=;
 b=RvKZg5SokqipLmmoFML0bVS9NhJIjKmtE+7hPbrPQkSWkXDt4c42fXCs6FTKrOmk2QcU2e
 W314yAVPQOgzPoDA==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id A8C0E2C141
 for <ltp@lists.linux.it>; Tue, 28 Feb 2023 15:24:27 +0000 (UTC)
References: <20230216085107.7068-1-andrea.cervesato@suse.com>
User-agent: mu4e 1.8.13; emacs 28.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Andrea Cervesato via ltp <ltp@lists.linux.it>
Date: Tue, 28 Feb 2023 15:22:48 +0000
Organization: Linux Private Site
In-reply-to: <20230216085107.7068-1-andrea.cervesato@suse.com>
Message-ID: <87y1ohsthw.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 0/6] Refactor mqns testing suite
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

I have too many questions to merge this with fixups, please see coments
on 03 and 04, but also check the other tests for similar issues.

Andrea Cervesato via ltp <ltp@lists.linux.it> writes:

> Refactoring mqns testing suite and removing libclone dependency.
>
> Andrea Cervesato (6):
>   Refactor mqns_01 using new LTP API
>   Refactor mqns_02 using new LTP API
>   Refactor mqns_03 using new LTP API
>   Refactor mqns_04 using new LTP API
>   Remove deprecated header files from mqns suite
>   Remove libclone dependency from mqns suite
>
>  runtest/containers                            |  13 +-
>  testcases/kernel/containers/mqns/Makefile     |  27 +-
>  testcases/kernel/containers/mqns/mqns.h       |  11 -
>  testcases/kernel/containers/mqns/mqns_01.c    | 180 ++++-------
>  testcases/kernel/containers/mqns/mqns_02.c    | 241 +++++---------
>  testcases/kernel/containers/mqns/mqns_03.c    | 298 +++++++-----------
>  testcases/kernel/containers/mqns/mqns_04.c    | 273 +++++++---------
>  .../kernel/containers/mqns/mqns_helper.h      |  53 ----
>  8 files changed, 392 insertions(+), 704 deletions(-)
>  delete mode 100644 testcases/kernel/containers/mqns/mqns.h
>  delete mode 100644 testcases/kernel/containers/mqns/mqns_helper.h
>
> -- 
> 2.35.3


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
