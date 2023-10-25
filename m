Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71012C0032E
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 23:09:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D07C3CF90C
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 01:09:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC0F63CCC4D
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 01:09:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 810AE600855
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 01:09:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 285671F8BE;
 Wed, 25 Oct 2023 23:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698275356;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eaUKiMdWedvvURB2N9c+knpeslSG1ouHjhdLhng8EtA=;
 b=Up74hrM1IZ2yMYsxu+tIhGSCUQ+oHZr4nhYaJ0iJzOUhNayPXYbDnYY/tlEJezAKhFogQx
 LsCxL7anEZtJYJW4U9YQR/1AoZt5qllIOSBV48Z4N65J5MvGatmjs/RgWp/LuJnQ1+HmuZ
 N+4jtp84n+Fep+OapkJkGWiQ7FfFOjg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698275356;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eaUKiMdWedvvURB2N9c+knpeslSG1ouHjhdLhng8EtA=;
 b=PwsybUWgYA1clnbNQD/EotWx0Ei2HV9uFZ/A5CFFhtqeY0Eo0b4f3tVWRfg5gzQIbnFTFO
 EwkRA8vsiJM4UnBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0E4D513524;
 Wed, 25 Oct 2023 23:09:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 44RjAhygOWVwUQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 23:09:16 +0000
Date: Thu, 26 Oct 2023 01:09:14 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20231025230914.GB507231@pevik>
References: <1697794677-14892-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1697794677-14892-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1697794677-14892-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] Refactor and merge symlink04/05 using new
 LTP API
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

> symlink04 and symlink05 has been merged together, testing
> the results of symlink(2) for the existence or non-existence
> of a file
> + * Copyright (c) International Business Machines  Corp., 2001
> + * Copyright (c) Linux Test Project, 2003-2023
nit: IMHO LTP copyright was from 2001.

> + * Author: 07/2001 John George
>   */

...
> +	TST_EXP_PASS(symlink(*tc->srcfile, SYMFILE), "symlink(%s, %s)",
> +		     *tc->srcfile, SYMFILE);

nit: I would use just:
TST_EXP_PASS(symlink(*tc->srcfile, SYMFILE));

this:
symlink04.c:45: TFAIL: symlink(testfile, slink_file) failed: EFAULT (14)

is not much more informative than this:
symlink04.c:47: TFAIL: symlink(*tc->srcfile, SYMFILE) failed: EFAULT (14)

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
