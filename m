Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E293DECAAA3
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 05:55:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 294B43CA4A5
	for <ltp@archiver.kernel.org>; Fri, 26 Aug 2022 07:55:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A7A53C8CA7
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 07:55:26 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 25223600713
 for <ltp@lists.linux.it>; Fri, 26 Aug 2022 07:55:25 +0200 (CEST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 0F22A1FA84;
 Fri, 26 Aug 2022 05:55:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1661493325;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QKDtcB4lrJKxakujC10NykJpwzOfJm5TQBFyP6MLHA0=;
 b=eaV1Lv8CMd1mLAMRMHlq+HJhueHtSNUV4vedjpxRmrNJUmUIWTVIxi04eVlO67vMjzak2K
 ZRmigx/m9I/iej2fkVCrfagdSBN4ci4b8d5rLKPiyaM4T3CQvik4YHozNWIM+TANg0qDj2
 OwoMB/Ci8LPS4sccroLCRJ3X6hfBpOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1661493325;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QKDtcB4lrJKxakujC10NykJpwzOfJm5TQBFyP6MLHA0=;
 b=Uk/udboLR3NLmiUN5q5dSBi/coeIBviw8xm13y1u3hl3rfT9MLMwZkqjaCAf+p9Msix6DE
 QMtbF6qZZbhn+rCQ==
Received: from g78 (unknown [10.163.24.226])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D259C2C142;
 Fri, 26 Aug 2022 05:55:24 +0000 (UTC)
References: <871qt42tev.fsf@suse.de>
 <1661486365-2361-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1661486365-2361-2-git-send-email-xuyang2018.jy@fujitsu.com>
User-agent: mu4e 1.6.10; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Date: Fri, 26 Aug 2022 06:54:26 +0100
In-reply-to: <1661486365-2361-2-git-send-email-xuyang2018.jy@fujitsu.com>
Message-ID: <87o7w71rcj.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/3] tst_cgroup: Add safe_cg_open and
 safe_cg_fchown functions
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

Yang Xu <xuyang2018.jy@fujitsu.com> writes:

> safe_cg_open is used to open the sub controller's file ie cgroup.procs
> and returns the opened fd number. The opened fd array is stored in
> fds argument.
>
> safe_cg_fchown is used to use fchownat to change file's uid and gid.
>
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  include/tst_cgroup.h | 21 +++++++++++++++++++++
>  lib/tst_cgroup.c     | 41 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 62 insertions(+)
>
> diff --git a/include/tst_cgroup.h b/include/tst_cgroup.h
> index d06847cc6..db959380f 100644
> --- a/include/tst_cgroup.h
> +++ b/include/tst_cgroup.h
> @@ -89,6 +89,9 @@ enum tst_cg_ver {
>  	TST_CG_V2 = 2,
>  };
>  
> +/* This value is equal to ROOTS_MAX in tst_cgroup.c. */
> +#define TST_CG_ROOTS_MAX 32

Thanks, pushed with small change to this comment. Because
TST_CG_ROOTS_MAX is actually greater than ROOTS_MAX.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
