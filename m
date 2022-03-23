Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED90DC433EF
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 19:37:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 493CD3C96C8
	for <ltp@archiver.kernel.org>; Wed, 23 Mar 2022 20:37:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FFBC3C1A87
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 20:36:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id EE1B51A00CD8
 for <ltp@lists.linux.it>; Wed, 23 Mar 2022 20:36:55 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7939D210F4;
 Wed, 23 Mar 2022 19:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648064215;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=otoSainDo95zC+VNwHVHWWsIvoudgxO32cr0OybTr+U=;
 b=aUlAvEXbisakuUv2/2PQ7ml+ZpWidKMUF37oHFIU6lcecW/9Q5BC0bVMTV/B0A+uV3k4Xw
 39CjTnXm9sAuXoKBRzxrRv9OuVMJz8aE/et6LPDF/nR8OfPfdXYvOoueCrSbUjIkbWwnEI
 T4CuWy2kbsf6+cL7+pVNE9sl8xpI7x4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648064215;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=otoSainDo95zC+VNwHVHWWsIvoudgxO32cr0OybTr+U=;
 b=Rfv4KSyt4XJQJG52hTJtnoxwgZS7qWfC5rDUzyOILKlbyFmmMEx388t6rfPX9egD6OnlAK
 GfTVQfbyw1BS/nCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A3D213302;
 Wed, 23 Mar 2022 19:36:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id scCXDNd2O2J4UgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 23 Mar 2022 19:36:55 +0000
Date: Wed, 23 Mar 2022 20:36:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>
Message-ID: <Yjt21XFn+8n78gZ7@pevik>
References: <623414B7.6060004@fujitsu.com>
 <1647629747-13405-1-git-send-email-daisl.fnst@fujitsu.com>
 <1647629747-13405-3-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1647629747-13405-3-git-send-email-daisl.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] syscalls/umount2: Convert to new API and
 use SAFE_ACCESS
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

Hi Dai,

> +++ b/testcases/kernel/syscalls/umount2/umount2.h
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
>  /*
>   * Copyright (c) 2016 Cyril Hrubis <chrubis@suse.cz>
>   *
nit: if you add SPDX (good to do) you're supposed to remove GPL text
(i.e. remove: "This program is free software: you ...")

Can be done before merge.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
