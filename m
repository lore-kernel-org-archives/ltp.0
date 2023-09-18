Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF39C46CA1
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 11:18:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ABA2C3CE4CE
	for <ltp@archiver.kernel.org>; Mon, 18 Sep 2023 13:18:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C3A33CAA0F
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:18:00 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C472A1000A11
 for <ltp@lists.linux.it>; Mon, 18 Sep 2023 13:17:59 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1CC6D1FE11;
 Mon, 18 Sep 2023 11:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1695035879;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vnuKye0TcZyWI56vBebl3MYbnrIW48MiktQVOVNo8jQ=;
 b=TcxZ+Xrt77TlB201J0XgxSgWj3l39XfkZ1XBUQmi2iRPRxqRMO1SpEf/pRB2z8L8i3AqFq
 DZjtat8q0bYEd9oRcl4v+Fk6zeFt5qWqCd4SuZ9E/Cbfy003V1PgiH8LT7uoR1cRr2EyGv
 /o5MhlYf67zlGXWWi1Eh2kNLT278zUs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1695035879;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vnuKye0TcZyWI56vBebl3MYbnrIW48MiktQVOVNo8jQ=;
 b=oUvgYFMqvG9Zg57K62SAmnhoOsNs+5FjvpvBVI7fGu+4FirP3zdQAQbbOeCGScJk2eJIU3
 2lsxqM9w6M5yhIDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F23A713480;
 Mon, 18 Sep 2023 11:17:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PJ6SN+YxCGUEUgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 18 Sep 2023 11:17:58 +0000
Date: Mon, 18 Sep 2023 13:17:57 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230918111757.GA29246@pevik>
References: <20230918102711.9567-1-pvorel@suse.cz>
 <ZQgszt74aIR_wWDm@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQgszt74aIR_wWDm@yuki>
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] tst_fill_fs: Fix printf format error
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

Hi Cyril,

> Hi!
> > openat() first parameter is file descriptor (int), not string.
> > Add also original path (string) to be more informative.

> > Fixes: df1b01cc1 ("tst_fill_fs: drop safe_macro from fill_flat_vec")
> > Signed-off-by: Petr Vorel <pvorel@suse.cz>

> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> > ---
> > I'd like to get this tiny fix merged before the release.

> Yes please.

Thanks for your review, merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
