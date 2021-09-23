Return-Path: <SRS0=3vE2=ON=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B228C433F5
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 14:03:48 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6D4261090
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 14:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D6D4261090
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C949E3CAB27
	for <ltp@archiver.kernel.org>; Thu, 23 Sep 2021 16:03:45 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 07FE83C6E67
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 16:03:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E80B11400B94
 for <ltp@lists.linux.it>; Thu, 23 Sep 2021 16:03:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 250852028E;
 Thu, 23 Sep 2021 14:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632405813; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EG3mXqwzvMq30nXUPxRAimOTax9ci3dJ3sqByWGEYzI=;
 b=Vex/+KwSkHZnLpnLAhnOkAIg6au7qYAN89+0z4Q1Dsq19VPDKeLxLG3qQXu2WC4qb+00Qq
 j+9l7UXDM6M6F0Tk+aYZTHqDm94yXWr7l7yV+Lkzsbh1ecdjcOvVW1HuWDUEN280ChF6Ij
 YGIv04wN1oGzpsrABU/MC7zH1Upt7Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632405813;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EG3mXqwzvMq30nXUPxRAimOTax9ci3dJ3sqByWGEYzI=;
 b=RnMIWTIg3oP6rzWM4IT9ymKaNnb0tP/SKXrkoS4Y7WkXlJvwu/+GbQeRvFfMUjx61rTtvH
 E2paSKOYLmt+qfCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0813013E6E;
 Thu, 23 Sep 2021 14:03:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id UsW0ADWJTGE1YQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 23 Sep 2021 14:03:33 +0000
Date: Thu, 23 Sep 2021 16:04:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YUyJVGDpNFXCd2Me@yuki>
References: <20210923134413.25174-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210923134413.25174-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] Rename get_ipc_timestamp() and move to
 main LTP library
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
> +/*
> + * Returns current system time for file/IPC operations, which may slightly lag
> + * behind time() return values.
> + */

I've added slightly longer (and hopefuly better) explanation why this
happends here and pushed the patches, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
