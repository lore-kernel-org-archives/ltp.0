Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCB2C38A2D
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 12:31:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C5D43C969F
	for <ltp@archiver.kernel.org>; Mon, 24 Oct 2022 14:31:42 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 71A5C3C4D7B
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 14:31:28 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id A9858200760
 for <ltp@lists.linux.it>; Mon, 24 Oct 2022 14:31:27 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id C70CE1FD80;
 Mon, 24 Oct 2022 12:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666614686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oEiEsXYQonmKAZJpNP/OyGG22QELXKSz1Mdbu3d/FBA=;
 b=pd2hxlhnOhvQu3ereMnX9siaLn5BTFCItVPfLp8on1EnCtCRs0ydXzkHyjZSrW/xAOVwSO
 wKP8aMl1kPvKybSd9NZX5X4FSCpwa3XaK7c/ltx9fXgI2xvPXorsJ0K/xQCJMvHtp0nfDI
 emIkJFQuJW2vg9Mx9QF50QNTbUFayM4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666614686;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oEiEsXYQonmKAZJpNP/OyGG22QELXKSz1Mdbu3d/FBA=;
 b=MvABtJ+jXpN3bGgwOfeoXy6vvdLzhXc5k+xEec8ypNkrwfZY934v2XvVSsiZaIXtUcOViV
 DU/jMKHu1nyh+9BQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 69D342C141;
 Mon, 24 Oct 2022 12:31:26 +0000 (UTC)
References: <20221017014333.42180-1-luoxiaoyu9@huawei.com>
 <20221017014333.42180-2-luoxiaoyu9@huawei.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Luo xiaoyu <luoxiaoyu9@huawei.com>
Date: Mon, 24 Oct 2022 13:29:51 +0100
In-reply-to: <20221017014333.42180-2-luoxiaoyu9@huawei.com>
Message-ID: <875yg9z9lv.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] signal01.c: Rewrite using new LTP API
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Luo xiaoyu via ltp <ltp@lists.linux.it> writes:

> Rewrite using new LTP API and remove the UCLinux support.
>
> Signed-off-by: Luo xiaoyu <luoxiaoyu9@huawei.com>

I removed the switch statement and merged, thanks!

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
