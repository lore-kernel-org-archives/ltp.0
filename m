Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1657EC5475B
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 14:24:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 680B03D0035
	for <ltp@archiver.kernel.org>; Wed,  6 Mar 2024 15:24:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C4F0C3CBE41
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 15:24:00 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F3F19603225
 for <ltp@lists.linux.it>; Wed,  6 Mar 2024 15:23:59 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EC9536B3FC;
 Wed,  6 Mar 2024 14:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709735039; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6hieCeL4UloMZWliT8zm1gyuINgFLHQWpwecF6gdh8=;
 b=sw/hYVv9ToUSaN15HuE1CWpTQGCqpjiN8m1dPyUa5zKc7aqM0j2XsXpbeW+jpnLFDYli+j
 Wyc9YCt76k/9+v4P2Kv7BAkbOL2D2lEtuwMP095cg1kuye9eml5ZKgRtZaFGpA0QQg8Z9B
 lHh7MX/tgI1SxtfNEdhjJDGGJ/Ych7s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709735039;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6hieCeL4UloMZWliT8zm1gyuINgFLHQWpwecF6gdh8=;
 b=0yojmiTQ5w3/P3M6jqUfZ3Mz0itJDvDqvDD1QmpBgSgzXVK0vRXOXYaEMSaCvaTcDMWKwy
 0lepX9s6WfQPC2Dg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1709735038; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6hieCeL4UloMZWliT8zm1gyuINgFLHQWpwecF6gdh8=;
 b=wSv9cGoMcMkSCB7rQeQknVnDeYwMx0QzzreRH8qze3sVJDQRoWCzk/vpM1YZgIkShyuXn+
 AxA/ElZmw2Lox5NQP0oGILMgv2gH12pjqAQ8TLX96sos19gvUmR0J6VbRLLaKNX8Oq3uiS
 DK3DIy3CQx3KlBfa/iWSz1GFC9tTY60=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1709735038;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6hieCeL4UloMZWliT8zm1gyuINgFLHQWpwecF6gdh8=;
 b=V3ux+2/1cA3K+4WCHL8/tMtgzJwv6X6kQ21tsQfUeVKrF6TWsMQH7ihDwWvIyTrewpXHXE
 9Dx7RjAxezIZw8Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D5FB813A67;
 Wed,  6 Mar 2024 14:23:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E5h7M3586GUMRAAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 06 Mar 2024 14:23:58 +0000
From: Avinesh Kumar <akumar@suse.de>
To: ltp@lists.linux.it
Date: Wed, 06 Mar 2024 15:23:58 +0100
Message-ID: <1943239.7Z3S40VBb9@localhost>
Organization: SUSE
In-Reply-To: <20240227085641.33715-1-xuyang2018.jy@fujitsu.com>
References: <20240227085641.33715-1-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 HAS_ORG_HEADER(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; CTE_CASE(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.01)[50.06%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] iopl01: Convert docs to docparse
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Reviewed-by: Avinesh Kumar <akumar@suse.de>
for both the patches.

@pvorel,
Can you please also fix below typos when you merge this.

On Tuesday, February 27, 2024 9:56:40 AM CET Yang Xu via ltp wrote:
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/iopl/iopl01.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/iopl/iopl01.c
> b/testcases/kernel/syscalls/iopl/iopl01.c index 70e2a7ff1..8eadc03c9 100644
> --- a/testcases/kernel/syscalls/iopl/iopl01.c
> +++ b/testcases/kernel/syscalls/iopl/iopl01.c
> @@ -1,17 +1,18 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - *  Copyright (c) Linux Test Project, 2020
> - *  Copyright (c) Wipro Technologies Ltd, 2002
> + * Copyright (c) Linux Test Project, 2020
> + * Copyright (c) Wipro Technologies Ltd, 2002
> + * Author: Subhab Biswas <subhabrata.biswas@wipro.com>
>   */
> 
> -/*
> +/*\
> + * [Description]
> + *
>   * This is a basic test for iopl(2) system call.
>   *
>   * Test the system call for possible privelege levels.
s/privelege/privilege
>   * As the privelge level for a normal process is 0, start by
s/privelge/privilege
>   * setting/changing the level to 0.
> - *
> - * Author: Subhab Biswas <subhabrata.biswas@wipro.com>
>   */
> 
>  #include <errno.h>


Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
