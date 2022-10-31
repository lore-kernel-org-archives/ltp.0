Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9229DC38A02
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 12:59:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AAF73CAAD8
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 13:59:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0178C3C08D9
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 13:59:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9B0A510005F1
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 13:59:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EA5C722586;
 Mon, 31 Oct 2022 12:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667221157;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j52Wdq1cT6ytWopb8QDr5D9iQJd1YZn9WHpThHXR13M=;
 b=YQVy1NZyxn7zGoRx6yfKBN6Duu6TAAPBY9TmXnUicXCJWMbMC4j/1TAXIEGq5JK8Mn0ne0
 s8r4JMELo1/Y/35WWle5Xf9MgvyO3jt7UVp8IINbGk3XwWFhn3f7krz/PTxjHhkvHnvjr7
 ojNNefpi8+rEKgxPM6WsbxTfk1aKUgk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667221157;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=j52Wdq1cT6ytWopb8QDr5D9iQJd1YZn9WHpThHXR13M=;
 b=mcNBC4sdP1rqlphQrh/1FThlFCGW2YiaoaVGvSs89MlLRTmM0rhJN12ocfdUS8By81ejYC
 KqiUpFHvzeE66YDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CCA0813AAD;
 Mon, 31 Oct 2022 12:59:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id m9BYMKXGX2OPTQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 31 Oct 2022 12:59:17 +0000
Date: Mon, 31 Oct 2022 13:59:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Y1/GpPKVzWUAV1DK@pevik>
References: <20221031113046.9218-1-andrea.cervesato@suse.com>
 <20221031113046.9218-3-andrea.cervesato@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221031113046.9218-3-andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Rewrite utsname testing suite
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

Hi Andrea,

> +#define _GNU_SOURCE
> +
> +#include "tst_test.h"
> +#include "utsname.h"
> +
> +#define HLEN 100
Could this definition be in utsname.h?
Also, although getconf HOST_NAME_MAX returns 64 on my machine, maybe using from
HOST_NAME_MAX would be safer (that can be up to 255).
Also maybe HOSTLEN (readability)?

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
