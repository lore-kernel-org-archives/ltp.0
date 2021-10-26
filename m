Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4DEEC433F5
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 14:04:43 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3841F60C41
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 14:04:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3841F60C41
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2FB6B3C67F7
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 16:04:41 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4EF7B3C04B0
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 16:04:29 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5654C601561
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 16:04:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 93B3521637;
 Tue, 26 Oct 2021 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635257068; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L5CMXE2EYQpR1apn1LQU1pwXSonjXRtEBcZRzU/ZQl4=;
 b=cmsWE0G8D+iVdUzGgDD36yNq7gRxYL7WDpcT9m+HWq7eA3yhm3PMaHxgrMqO3C1wJ62Z1v
 0046bKU8WZ0IFaeJPdeSIqDSadd7yXvDFH7EbMVpk9BcCKIBNJ6w9wHUHjJINVDerZfNqe
 qDAXZK4wIkqoYGQ4KmrvzpYyQJgZJRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635257068;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L5CMXE2EYQpR1apn1LQU1pwXSonjXRtEBcZRzU/ZQl4=;
 b=YgIAHCakmH0EZsbY24kTz8dzt3drijWXLUvm8KHcH0aM83zu3BZxPkazIBgTIIaEyjRmbu
 VCY8dUCqgUkyrsBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 467DE13B06;
 Tue, 26 Oct 2021 14:04:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id PU0vEOwKeGGLCgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 26 Oct 2021 14:04:28 +0000
Date: Tue, 26 Oct 2021 16:05:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YXgLHulsUiCRQmXE@yuki>
References: <1634562591-5830-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1634562591-5830-4-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1634562591-5830-4-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 04/11] syscalls/quotactl[3, 5,
 7]: Add docparse formatting
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
> -/*
> - * Test Name: quotactl03
> +/*\
> + * [Description]
>   *
> - * Description:
>   * quotactl(2) with XGETNEXTQUOTA looks for the next active quota for an user
>   * equal or higher to a given ID, in this test the ID is specified to a value
>   * close to UINT_MAX(max value of unsigned int). When reaching the upper limit
> @@ -16,11 +15,11 @@
>   *
>   * This kernel bug of xfs has been fixed in:
>   *
> - * commit 657bdfb7f5e68ca5e2ed009ab473c429b0d6af85
> - * Author: Eric Sandeen <sandeen@redhat.com>
> - * Date:   Tue Jan 17 11:43:38 2017 -0800
> + *  commit 657bdfb7f5e68ca5e2ed009ab473c429b0d6af85
> + *  Author: Eric Sandeen <sandeen@redhat.com>
> + *  Date:   Tue Jan 17 11:43:38 2017 -0800
>   *
> - *     xfs: don't wrap ID in xfs_dq_get_next_id
> + *  xfs: don't wrap ID in xfs_dq_get_next_id

The commit hash of this fix should also go into the tags in the tst_test
structure.

>   */
>  
>  #define _GNU_SOURCE
> diff --git a/testcases/kernel/syscalls/quotactl/quotactl05.c b/testcases/kernel/syscalls/quotactl/quotactl05.c
> index e811e47a4..fbc7f5924 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl05.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl05.c
> @@ -2,19 +2,28 @@
>  /*
>   * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>   * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
> + *
> + * This testcase checks basic flags of quotactl(2) for project on an XFS filesystem:
>   *
> - * This testcase checks basic flags of quotactl(2) for project on an XFS file
> - * system:
>   * 1) quotactl(2) succeeds to turn off xfs quota and get xfs quota off status
>   *    for project.
> + *
>   * 2) quotactl(2) succeeds to turn on xfs quota and get xfs quota on status
>   *    for project.
> + *
>   * 3) quotactl(2) succeeds to set and use Q_XGETQUOTA to get xfs disk quota
>   *    limits for project.
> + *
>   * 4) quotactl(2) succeeds to set and use Q_XGETNEXTQUOTA to get xfs disk
>   *    quota limits Cgreater than or equal to ID for project.
> + *
>   * 5) quotactl(2) succeeds to turn off xfs quota and get xfs quota off statv
>   *    for project.
> + *
>   * 6) quotactl(2) succeeds to turn on xfs quota and get xfs quota on statv
>   *    for project.
>   */

Here as well, the list should be fixed to render as a list.

> diff --git a/testcases/kernel/syscalls/quotactl/quotactl07.c b/testcases/kernel/syscalls/quotactl/quotactl07.c
> index db477589b..a55416f0e 100644
> --- a/testcases/kernel/syscalls/quotactl/quotactl07.c
> +++ b/testcases/kernel/syscalls/quotactl/quotactl07.c
> @@ -2,6 +2,10 @@
>  /*
>   * Copyright (c) 2019 FUJITSU LIMITED. All rights reserved.
>   * Author: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> + */
> +
> +/*\
> + * [Description]
>   *
>   * This is a regresstion test for kernel commit 3dd4d40b4208
>   * ("xfs: Sanity check flags of Q_XQUOTARM call").
> -- 
> 2.23.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
