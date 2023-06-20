Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C1C2EB64D7
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 12:59:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 646F13CE0EF
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 14:59:34 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA5233C9BB9
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 14:59:23 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A94066000E1
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 14:59:22 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2EFF061204;
 Tue, 20 Jun 2023 12:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06C88C433C0;
 Tue, 20 Jun 2023 12:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687265959;
 bh=AjvxSQTscyF/REX+a6idysWfWDZ6aFa3ywCcqZeBy2E=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sbfNy14UKTQByft7pqTV6GELmis5Dc+cHSbC8DhG729LpYfg87G810gQvupm1vhAc
 CYSQfXtB0InoDAyClYo7NsB9yPfHbmtEiHhPRWFyRQ5+O0CZBQLF6WWKNcMy5X2k4j
 tac88xv7KuxJaY9i3+96eB0SIgvooFE8VRc8n/bTl4OjLQdEjrcBcXlAq482azRXXV
 9iQ447rQFlryLoDT53uJvP6QXGF74xw8qBehWW1+L5Y3ig9pd0Kb22L/b9pcroKSEZ
 Q9k4B53Ji68jmNRMIy1JXudA9xBgqncIGX0A8frDCYFBIHjAu0aszqMxNUwcbHDlYD
 0anrH1VVQnE3g==
Message-ID: <73902738-8b8f-afad-ed69-88d0a438a094@kernel.org>
Date: Tue, 20 Jun 2023 21:59:17 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20230620120159.320052-1-pvorel@suse.cz>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20230620120159.320052-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/3] ioprio minor cleanup
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
Cc: Niklas Cassel <niklas.cassel@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 6/20/23 21:01, Petr Vorel wrote:
> Further minor ioprio cleanup. NOTE, docparse markers /*\ [Description]
> in the second commit allow test to be included in our automatically
> generated documentation [1].
> 
> Kind regards,
> Petr
> 
> [1] https://github.com/linux-test-project/ltp/releases/download/20230516/metadata.20230516.html

Looks good. Thanks Petr !

For the series:

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

> 
> Petr Vorel (3):
>   ioprio: Move fallback constants and structs to LAPI header
>   ioprio: Add docparse markers
>   utils: Remove unused ioprio.h
> 
>  include/lapi/ioprio.h                         | 47 +++++++++++++++++++
>  testcases/kernel/syscalls/ioprio/ioprio.h     | 42 ++---------------
>  .../kernel/syscalls/ioprio/ioprio_get01.c     |  9 ++--
>  .../kernel/syscalls/ioprio/ioprio_set01.c     |  9 ++--
>  .../kernel/syscalls/ioprio/ioprio_set02.c     |  9 ++--
>  .../kernel/syscalls/ioprio/ioprio_set03.c     |  9 ++--
>  testcases/kernel/syscalls/utils/ioprio.h      | 46 ------------------
>  7 files changed, 71 insertions(+), 100 deletions(-)
>  create mode 100644 include/lapi/ioprio.h
>  delete mode 100644 testcases/kernel/syscalls/utils/ioprio.h
> 

-- 
Damien Le Moal
Western Digital Research


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
