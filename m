Return-Path: <SRS0=uWjX=OO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 586E5C433F5
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 09:51:12 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A81A661050
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 09:51:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A81A661050
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E860C3C8F29
	for <ltp@archiver.kernel.org>; Fri, 24 Sep 2021 11:51:09 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3BA2E3C8610
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 11:51:01 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6DBE26013EB
 for <ltp@lists.linux.it>; Fri, 24 Sep 2021 11:51:00 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 951DE22379;
 Fri, 24 Sep 2021 09:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1632477059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bozMngnYHdiS9r8Hrl4JFiTLm3FfjLEEc/mmcpRStAo=;
 b=aPvkyOD85SnG+yLjh/cXSjaCiYetrZAkab8Y0lfxnDl0PjsYj2vXve9imTi5l+Q+ZUhFTR
 +og97V4A5ffqQCrZa4SUVoYhY4Tz+Bilhi6Z9PWn4WiBWKnn4xFJ677LiRH77+la+DXKC4
 1xu+61RJdYO2zC73TOhGB7QCvr/DoEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1632477059;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bozMngnYHdiS9r8Hrl4JFiTLm3FfjLEEc/mmcpRStAo=;
 b=q6qA50gUl/YXWQy6YmTCJcYQy7UxdiX/2AuuSNJMS7I+ZkF2/9h6ikwdKLNhNZeyPQYoYl
 o8FR81aFdNWG72Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 707FB139F0;
 Fri, 24 Sep 2021 09:50:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IhveHIOfTWE+PAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 24 Sep 2021 09:50:59 +0000
Date: Fri, 24 Sep 2021 11:51:30 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <YU2foq6v5PUBNUeD@yuki>
References: <20210924070756.3916953-1-liwang@redhat.com>
 <20210924070756.3916953-3-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210924070756.3916953-3-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] lib: unlimit the tmpfs size when test on
 small systems
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
> Since commit c305a53c5 (lib: limit the size of tmpfs in LTP, Jul 9)
> Ltp set tmpfs mount size according to the tdev.size. This cause a
> new problem on small RAM system, which consume too much memory and
> finally trigger OOM.
> 
> To fix this, let's cancel the tmpfs size limitation when MemAvailable
> is less than twofold of tdev.size.
> 
> Reported-by: Ralph Siemsen <ralph.siemsen@linaro.org>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
>  include/tst_test.h | 1 +
>  lib/tst_test.c     | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 5e3619698..3dcb45de0 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -42,6 +42,7 @@
>  #include "tst_lockdown.h"
>  #include "tst_fips.h"
>  #include "tst_taint.h"
> +#include "tst_memutils.h"
>  
>  /*
>   * Reports testcase result.
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 4224353da..b50856f20 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -895,6 +895,9 @@ static const char *limit_tmpfs_mount_size(const char *mnt_data,
>  	if (strcmp(fs_type, "tmpfs"))
>  		return mnt_data;
>  
> +	if ((tst_available_mem() / 1024) < (tdev.size * 2))
> +		return mnt_data;

I'm starting to think that we should do it the other way around, i.e.

- unless the test defines .min_dev_size we should set the size for tmpfs to be really small 16MB or 32MB
- if .min_dev_size is defined and there is not enough free memory -> TCONF
- if .min_dev_size is not set and there is not even 64MB of free memory (for 32MB limit) -> TCONF

I think that this is going to work because most of the tests does not
actually consume more than a megabyte or so of the disk space for the
actuall test, the only reason why we kept bumping the loop device size
is that there are limits on minimal size imposed by filesystems.

>  	if (mnt_data)
>  		snprintf(buf, buf_size, "%s,size=%luM", mnt_data, tdev.size);
>  	else
> -- 
> 2.31.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
