Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288ACC433EF
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 11:27:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 02D5B3C9ABE
	for <ltp@archiver.kernel.org>; Mon,  7 Feb 2022 12:27:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC4473C06E5
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 12:26:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4F8DB10009A1
 for <ltp@lists.linux.it>; Mon,  7 Feb 2022 12:26:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 851F6210F9;
 Mon,  7 Feb 2022 11:26:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644233209;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ysBUw4nZ8LZ6mnF1Jn8n+3Zu5y2xokJzYc4UPbcKtLU=;
 b=FRrBv36qhFKYX138S7lDYR/n5+L44NFgTNJ7174Hl3+F3nk5BxM1HKBZC30sagCxMFWiGC
 Fmq5RCkVtEuBzMnS4lztOYRc8Bb+0DJYqUSOJRMD3MPeg/hYxwzM0nf9j0uSYdkXQTBk6h
 QcaIgbnlDkfsjhG2GVrD2CBcW1EE1xI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644233209;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ysBUw4nZ8LZ6mnF1Jn8n+3Zu5y2xokJzYc4UPbcKtLU=;
 b=77WJyUo48jKhPjdOD6rwVhmv7mVNxHScp7rgIdDhB23qGwSfm0JZMNCBaUS9cEwmdNNaee
 VrPYYjI4c8dSqTCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 540BD13B9F;
 Mon,  7 Feb 2022 11:26:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 91ChEvkBAWIMXgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 07 Feb 2022 11:26:49 +0000
Date: Mon, 7 Feb 2022 12:26:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>
Message-ID: <YgEB9/BvNhgIAl2n@pevik>
References: <61F36C39.9030806@fujitsu.com>
 <1643365754-5366-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1643365754-5366-1-git-send-email-daisl.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/statx09: Add new test
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
Cc: xuyang2018.jy@cn.fujitsu.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> +++ b/testcases/kernel/syscalls/statx/statx09.c
> @@ -0,0 +1,160 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
> + * Author: Dai Shili <daisl.fnst@fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This code tests if the attributes field of statx received expected value.
> + * File set with following flags by using SAFE_IOCTL:
> + *
> + * - STATX_ATTR_VERITY: statx() system call sets STATX_ATTR_VERITY if the file
> + * has fs-verity enabled. This can perform better than FS_IOC_GETFLAGS and
> + * FS_IOC_MEASURE_VERITY because it doesn't require opening the file,
> + * and opening verity files can be expensive.
> + *
> + * Minimum Linux version required is v5.5.
I know this has been merged, this probably not worth of fixing it,
but the "required" is misleading when we detect via EOPNOTSUPP and EINVAL
and thus not use .min_kver. If it was due possible backport,
thus it should have been e.g. "functionality has been merged in kernel v5.5".

> + */
> +
...
> +static struct test_cases {
> +	void (*tfunc)(void);
> +} tcases[] = {
> +	{&test_flagged},
> +	{&test_unflagged},
> +};
> +
> +static void run(unsigned int i)
> +{
> +	tcases[i].tfunc();
> +}
OT: we may lack something in the API, when function like this need to be
defined.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
