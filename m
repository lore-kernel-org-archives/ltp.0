Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AFA8CDB46E
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 10:00:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E13E3CD3F7
	for <ltp@archiver.kernel.org>; Thu, 12 Oct 2023 12:00:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B3DA3C8882
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 12:00:24 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 4A5591A0C24C
 for <ltp@lists.linux.it>; Thu, 12 Oct 2023 12:00:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 992012183F;
 Thu, 12 Oct 2023 10:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697104823;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DxZRKLYlUhfeOgjAlVgCc8vBcicGky+u8pV6ovWSxpQ=;
 b=UjoPBEmYeaBiKl/QAMzIODkB900lD+2YvRB0vL4EUHoFTGWPHo3TkLlQU72mPgg3g+UvVS
 k0Ftro4ASlsvT2N8ZMnBxti+t/46f6dES12KyKDRxwMf46x+ckVsXOYrwc5ccYtuhYJ3aW
 +Z821QwHHiA+wS6Edr9JbOeHMOA2Vk8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697104823;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DxZRKLYlUhfeOgjAlVgCc8vBcicGky+u8pV6ovWSxpQ=;
 b=1qw35WN0ynqiW+4+Te9ygwf2mcfMjaovWdjt62aY5MhE/zYNrawk5xbV4DXIrpXPnR5NB0
 hksysoSdD1xxb0Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 80F5D139F9;
 Thu, 12 Oct 2023 10:00:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qSFHHrfDJ2WKAQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 12 Oct 2023 10:00:23 +0000
Date: Thu, 12 Oct 2023 12:00:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20231012100022.GC618148@pevik>
References: <1697021709-22916-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1697021709-22916-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1697021709-22916-3-git-send-email-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[39.24%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] link08: Convert docs to docparse
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

Hi Xu,

could you please fixes the formating errors and the grammar?
...
> + * - link() fails with -1 return value and sets errno to EXDEV
> + *   if oldpath and newpath are not on the same mounted file system( Linux
    *   if the old path and the new path are not on the same mounted file system (Linux

> + *   permits a file system to be mounted at multiple points, but link()
> + *   does not work across different mount points, even if the same
> + *   file system is mounted on both. ).
    *   file system is mounted on both).

Kind regards,
Petr

> + * - link() fails with -1 return value and sets errno to EROFS
> + *   if the file is on a read-only file system.
> + * - link() fails with -1 return value and sets errno to ELOOP
> + *   if too many symbolic links were encountered in resolving path.
>   */
> +
>  #include <errno.h>
>  #include "tst_test.h"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
