Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C549C433F5
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 13:44:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1802F3CA5FC
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 15:44:45 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED9183CA580
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 15:44:33 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 77D6A600A4A
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 15:44:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B488021617;
 Thu, 14 Apr 2022 13:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649943872; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SJ4n6a3U7LW/0c4an91OQdhSXJlgpUQQFjj44lGPrs0=;
 b=aK52CklSa6o3vLg+ckdAcPlhduCOlQ1pLK5w4kwKcB554tZ+tm+yebV8qHqJBFuC2MKJW4
 SR0Meev9SP5bprFpFUnOHjxnOSwKA0iuxJ47gJWGQ8qbr7iVUvKD/qraChl4XoUkagJqTF
 f09rANLgxsK/4OSzdotjLcb49KwT52o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649943872;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SJ4n6a3U7LW/0c4an91OQdhSXJlgpUQQFjj44lGPrs0=;
 b=qtdWZr+gsIBSqjz0oipV0+xlFrLD5iF0L3/zJjeUPWfj4Fb8CTNVHNMtJZjfhgdnKkdRsT
 qHlteJs4gn/GB6AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A0101132C0;
 Thu, 14 Apr 2022 13:44:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zKZoJkAlWGIaTAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 14 Apr 2022 13:44:32 +0000
Date: Thu, 14 Apr 2022 15:46:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Zhao Gongyi <zhaogongyi@huawei.com>
Message-ID: <Ylglx/abcFyHET3s@yuki>
References: <20220413114014.51577-1-zhaogongyi@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220413114014.51577-1-zhaogongyi@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] futex_waitv04: Add test for futex_waitv syscall
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
> diff --git a/testcases/kernel/syscalls/futex/futex_waitv04.c b/testcases/kernel/syscalls/futex/futex_waitv04.c
> new file mode 100644
> index 000000000..783d481e9
> --- /dev/null
> +++ b/testcases/kernel/syscalls/futex/futex_waitv04.c
> @@ -0,0 +1,83 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2022 Zhao Gongyi <zhaogongyi@huawei.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This test verifies EAGIN and ETIMEDOUT for futex_waitv syscall.
                         ^
                         EAGAIN

Is there a reason why can't we add these two testcases into
futex_waitv01.c?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
