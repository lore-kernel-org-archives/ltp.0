Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92979C83F14
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 08:30:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACE843CC0FF
	for <ltp@archiver.kernel.org>; Wed, 30 Aug 2023 10:30:20 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 289DB3C527F
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 10:30:08 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 84F9460257B
 for <ltp@lists.linux.it>; Wed, 30 Aug 2023 10:30:07 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id D06A621854;
 Wed, 30 Aug 2023 08:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693384206;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aRucCyRQxwkBAao4kcuH7sY/HVMRF5IVg1/tZU0r6Jg=;
 b=Cc9bDzEzTrm+6kReLccdRX0MdSNDIuiaZXg3LF6Njx1r49bQqvm1ylOwSf67zjA//4RBnO
 /BWNiH7GmgPTpym4yp0mlABb60FRrQB7q1uZ6TnFkeRNANRrBVISeb0/m1HDCL7ScDtrns
 uFtwr9yipmJiYZcsqGQ0sQIdwUbQVsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693384206;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aRucCyRQxwkBAao4kcuH7sY/HVMRF5IVg1/tZU0r6Jg=;
 b=QX2g9zINxGGSPaKMZ/kQ741dnE6I7pOc48u5uz1097vU1pq9IXOPk5HVJKdw/qG9UIlSmm
 Dk0VDgr8w1jAQBCQ==
Received: from g78 (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 0ADA52C142;
 Wed, 30 Aug 2023 08:30:05 +0000 (UTC)
References: <20230803015149.69906-1-iwienand@redhat.com>
 <20230808035641.364676-2-iwienand@redhat.com>
User-agent: mu4e 1.10.6; emacs 29.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Ian Wienand <iwienand@redhat.com>
Date: Wed, 30 Aug 2023 09:20:44 +0100
Organization: Linux Private Site
In-reply-to: <20230808035641.364676-2-iwienand@redhat.com>
Message-ID: <87il8xhr05.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] kernel/device-drivers/zram/zram01.sh : don't
 fill from /dev/zero
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

Ian Wienand <iwienand@redhat.com> writes:

> I have a system (virtualized aarch64, 4.18.0 kernel) that is
> consistently failing the zram01.sh test as it tries to divide the
> memory stats by zero.  This has been reported before at [1] without
> resolution.
>
> After some investigation [2] my conclusion is that this zero value
> represents the pages allocated for compressed storage in the zram
> device, and due to same-page deduplication the extant method of
> filling with all-zeros can indeed lead us to not having any compressed
> data to measure.
>
> This is visible in the occasional divide-by-zero error, but in the
> bigger picture means this test is not exercising the compression path
> as desired.

Do zram{02,03} already do something similar?

In any case I'd prefer to see a zram04 written in C if some coverage is
missing.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
