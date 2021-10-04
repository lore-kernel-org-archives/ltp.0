Return-Path: <SRS0=YkbW=OY=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5435C433F5
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 06:07:42 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97FAD61354
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 06:07:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 97FAD61354
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 511993C7FFA
	for <ltp@archiver.kernel.org>; Mon,  4 Oct 2021 08:07:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 102703C21F2
 for <ltp@lists.linux.it>; Mon,  4 Oct 2021 08:07:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 14A9D1A0014E
 for <ltp@lists.linux.it>; Mon,  4 Oct 2021 08:07:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 387981FFBE;
 Mon,  4 Oct 2021 06:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1633327649;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gENZ6IUXOnjdYJR/DbtZCaNmebva8Bv2LRjabI0plAk=;
 b=PJPc1bGNMC9wY9IsxFJDA2dcokx+b2wj8TWSFIZ7wzIlI0SkaWDIPc/02iAyyKsNvx8DQo
 +9tnJBMX5bSNycKIZok2gs8obUHTL0/ITHsY/eOIG81CKMHO71/pkdKs1nZsqNGkk43oYm
 2ZT6tPbdXi4Agz/qmsjQG2AfqC0fKWQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1633327649;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gENZ6IUXOnjdYJR/DbtZCaNmebva8Bv2LRjabI0plAk=;
 b=gBZp4KQ0kjS5bXsFfzEBmM9niPFFbvtWtt6kTgFgL7PLc6lTJa+QYVnadef27o0DlquzZh
 /Z7X5F1zHvK76BAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D7723139C1;
 Mon,  4 Oct 2021 06:07:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id rlwnKyCaWmHsWQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 04 Oct 2021 06:07:28 +0000
Date: Mon, 4 Oct 2021 08:07:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.com>
Message-ID: <YVqaH2wxGRegEfiR@pevik>
References: <20210929085910.23073-1-rpalethorpe@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210929085910.23073-1-rpalethorpe@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] clock_nanosleep01: Avoid dereferencing bad
 pointers in libc on 32bit
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

> In 32-bit (regardless of kernel bits) glibc and musl will usually
> dereference the timespec pointers and try to read them. In some cases
> this might be avoidable, but they must do it in others.

> Passing invalid pointers is undefined in POSIX. In any case, AFAICT
> libc would have to catch the signal in order to guarantee EFAULT is
> returned.

LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Possibly we shouldn't test things like this at all through libc
> wrappers.
Only for 32bit or also for 64 bit? Anyway, there has always been some cases
where bad addr testing was problematic (e.g. non-intel arch).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
