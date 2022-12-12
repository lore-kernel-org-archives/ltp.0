Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B353BC4332F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 15:57:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7E7BE3CBE7F
	for <ltp@archiver.kernel.org>; Mon, 12 Dec 2022 16:57:08 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BD433CBE07
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 16:56:59 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 0CB551A00437
 for <ltp@lists.linux.it>; Mon, 12 Dec 2022 16:56:58 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 26072337DC;
 Mon, 12 Dec 2022 15:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670860618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=heOh/kny3uq7aaAQziAvSRxXNnwfIaSKc85gj+UA16M=;
 b=YeBRu79kKhEfZoHMjfj0uWTaNz2i//e/mmziI8c0HUqKgjbgutIq38nR0BUdBnhT9r9/On
 AB1OediGBYse5Si8B8Pn0j2k9TKmuhkpSWVp3ysv3q8gj4ySfoGnWm83TklXwAON7sOajx
 yDQh4le/L8NF6mqkmyTufkp5ZhLN5wo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670860618;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=heOh/kny3uq7aaAQziAvSRxXNnwfIaSKc85gj+UA16M=;
 b=un7upDJOP/luXV3ujzDuMh58H/mGqS+iFNhTX8f6cydSrETtJz+pPIKr2dRG+gSrXn7L1X
 Nymc++1ZujUES8BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0554E138F3;
 Mon, 12 Dec 2022 15:56:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Ok9YO0lPl2P8cwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 12 Dec 2022 15:56:57 +0000
Date: Mon, 12 Dec 2022 16:56:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y5dPRz3sP6YVr/pY@pevik>
References: <20221209140631.11609-1-andrea.cervesato@suse.com>
 <Y5NUeKtwr2b6Bx0t@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5NUeKtwr2b6Bx0t@rei>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v11 0/2] Rewrite aio-stress test
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

Hi all,

> Hi!
> You could have added my Reviewed-by: to the patches already, anyways:

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

Thanks all for their worked!
Merged this one.

Richie raised [1] clang warning 'iteration' set but not used. I thought clang is
wrong (static int iterations = 500;), but there is really another variable
iteration not used). Going to remove it. Sorry for the noise.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/87h6yfifbr.fsf@suse.de/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
