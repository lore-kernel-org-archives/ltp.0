Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C365C43334
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 11:31:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 087003C8D0C
	for <ltp@archiver.kernel.org>; Tue, 19 Jul 2022 13:31:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2BC8C3C899B
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 13:31:15 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9CEFE602212
 for <ltp@lists.linux.it>; Tue, 19 Jul 2022 13:31:14 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D5FE03510A;
 Tue, 19 Jul 2022 11:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658230273; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1xABTAzmOu7g+nnuwHZTt10Uprl/DrtC9BzPu3qlPPs=;
 b=YQtU13Pcwz4ECASadD0j8C6OwkZmjbSoIEDdNJpWJtYDsSFE11Kk1eQF9hSvsiPPuBf0bO
 z4t6yx8gUWWriIGwkXWNG5+pN4B10CmEDqa4ozRzqXF1ECaMyhwbhJcYf74smWRBg8jumL
 z0PrcrNLedbpnE4EOCEMu8ay5mmM4Tg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658230273;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1xABTAzmOu7g+nnuwHZTt10Uprl/DrtC9BzPu3qlPPs=;
 b=PcOam/0znAwjxx8zSQ83j6gg1+Kpw8exKHAFYdS4IV04Vq3wQj0ZySQxmy8Dy7pHsfalte
 MYmSx7gt9f1GBpDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B968013A72;
 Tue, 19 Jul 2022 11:31:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id v5E5KwGW1mJkIgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 19 Jul 2022 11:31:13 +0000
Date: Tue, 19 Jul 2022 13:32:27 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <YtaWS2mPXf/Xzhlb@rei>
References: <20220719073911.21651-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220719073911.21651-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] readahead01.c: turn comment into docparse and
 reword
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with fixes, thanks.

> diff --git a/testcases/kernel/syscalls/readahead/readahead01.c b/testcases/kernel/syscalls/readahead/readahead01.c
> index 4355457e9..ac762aa3e 100644
> --- a/testcases/kernel/syscalls/readahead/readahead01.c
> +++ b/testcases/kernel/syscalls/readahead/readahead01.c
> @@ -3,8 +3,13 @@
>   * Copyright (C) 2012 Linux Test Project, Inc.
>   */
>  
> -/*
> - * errno tests for readahead() syscall
> +/*\
> + * [Description]
> + *
> + * Verify that readahead() syscall fails with
> + * - EBADF when fd is not a valid file descriptor or is not open for reading.
> + * - EINVAL when fd does not refer to a file type to which readahead()
> + * can be applied.

This does not render as a list unless there is empty line between the
"Verify that..." and the rest.

I've also added colon (:) after the "... with" as we usually do.

Please always check the resulting html pages to check if the end result
is rendered properly.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
