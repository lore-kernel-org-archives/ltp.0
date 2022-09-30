Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9412C433FE
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 13:36:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E1293CAA08
	for <ltp@archiver.kernel.org>; Fri, 30 Sep 2022 15:36:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2E7243C958A
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 15:36:11 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B6E69601177
 for <ltp@lists.linux.it>; Fri, 30 Sep 2022 15:36:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 8F5431F892;
 Fri, 30 Sep 2022 13:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664544969;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gtrf1wjoifSJ+I+NW7NR1y3vdHp/qf4LnHMEp7MDb3o=;
 b=DtRRFspgV1fV+6oKfRhNSgK2AYpVy9sEP0Zsyyk66ToN5s1YraOS8Ic4Aj13RltgLYCvL+
 oyewNOh+bBsPQjUBxmUocgyDASdZWrTjPDiFhkwnC1VB4mz9BIA0tRSWdOdEONZ2fjGzF0
 T1d+v12wuKv4ZgZHa2Rk+UaRFtEGXYU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664544969;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gtrf1wjoifSJ+I+NW7NR1y3vdHp/qf4LnHMEp7MDb3o=;
 b=IV2joDyrpLV9mpsMQEAqFTWdlwNMKHUE98fbOU5Tq1Bsf8utBxHA/2+MH4Wea9ZF3EGqNM
 TwjQB1fFrWDam5CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4DB2C13776;
 Fri, 30 Sep 2022 13:36:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tb6JDsnwNmNqRAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 30 Sep 2022 13:36:09 +0000
Date: Fri, 30 Sep 2022 15:36:07 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <Yzbwx/JcCtRCfnhI@pevik>
References: <20220927161408.23743-1-rpalethorpe@suse.com>
 <20220927161408.23743-3-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220927161408.23743-3-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] api/evloop: Add helpers for creating an event
 loop
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

Hi Richie,

> +++ b/lib/tst_evloop.c
...
> +void tst_evloop_run(struct tst_evloop *self)
> +{
> +	static int saturated_warn;
> +	const int maxevents = 128;
> +	struct epoll_event events[maxevents];
> +
> +	for (;;) {
> +		const int ev_num = SAFE_EPOLL_WAIT(self->epollfd, events,
> +						   maxevents, self->timeout);
> +
> +		for (int i = 0; i < ev_num; i++)
I'm sorry we still do not allow to use C99 due CentOS 7 still supported:
lib/tst_evloop.c:80:3: error: 'for' loop initial declarations are only allowed in C99 mode

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
