Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698FEC28D13
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 11:00:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 77AB53CA457
	for <ltp@archiver.kernel.org>; Thu, 25 Aug 2022 13:00:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAD723C144C
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 12:59:57 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 35CB61A002D1
 for <ltp@lists.linux.it>; Thu, 25 Aug 2022 12:59:56 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E8FD1345A4;
 Thu, 25 Aug 2022 10:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1661425195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eRz4WnH+2Y2q+XU7OrRrwcNlJAdh3ul8KsfSwMh7xuk=;
 b=QD2pWkhuiLzi5fFxJsM1bqr4zX9uGtjFiTOodfAL1Q8b9/Pao50zBbI9pRPSI6t4JFfAPj
 wqUD5VuReue+AukEetpVhd6Ny559XYkBm5HKx1JciUY4SuKFO2iBVDChQ5H25mrB9ppDj1
 5rK1rj0tXlEjQiDOPPNuU5WZNuaIvbY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1661425195;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eRz4WnH+2Y2q+XU7OrRrwcNlJAdh3ul8KsfSwMh7xuk=;
 b=JhbGcw8kPvp3uj3Yx+VqL2t7X92OML/E9Ci5SEY7DqK/YEpf5k0wDN2G1fHESRLD/49H7i
 DrINRSP3w69jTyCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B7FC213517;
 Thu, 25 Aug 2022 10:59:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ly3fKitWB2MSbgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 25 Aug 2022 10:59:55 +0000
Date: Thu, 25 Aug 2022 12:59:53 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Message-ID: <YwdWKb/Imzwk5F1V@pevik>
References: <20220824215421.90947-1-luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220824215421.90947-1-luke.nowakowskikrijger@canonical.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] API/cgroup: Add rdma controller
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Luke,

> There is a test reporting "TBROK: 'rdma' controller is unknown
> to LTP" so lets add the controller.

Out of curiosity: which test?

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> ---
>  lib/tst_cgroup.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)

> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 1cfd79243..1da3f0a5d 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -93,9 +93,10 @@ enum cgroup_ctrl_indx {
>  	CTRL_BLKIO,
>  	CTRL_MISC,
>  	CTRL_PERFEVENT,
> -	CTRL_DEBUG
> +	CTRL_DEBUG,
> +	CTRL_RDMA
>  };
> -#define CTRLS_MAX CTRL_DEBUG
> +#define CTRLS_MAX CTRL_RDMA

>  /* At most we can have one cgroup V1 tree for each controller and one
>   * (empty) v2 tree.
> @@ -253,6 +254,10 @@ static const struct cgroup_file debug_ctrl_files[] = {
>  	{ }
>  };

> +static const struct cgroup_file rdma_ctrl_files[] = {
> +	{ }
> +};
> +
>  #define CTRL_NAME_MAX 31
>  #define CGROUP_CTRL_MEMBER(x, y)[y] = { .ctrl_name = #x, .files = \
>  	x ## _ctrl_files, .ctrl_indx = y, NULL, 0 }
> @@ -275,6 +280,7 @@ static struct cgroup_ctrl controllers[] = {
>  	CGROUP_CTRL_MEMBER(misc, CTRL_MISC),
>  	CGROUP_CTRL_MEMBER(perf_event, CTRL_PERFEVENT),
>  	CGROUP_CTRL_MEMBER(debug, CTRL_DEBUG),
> +	CGROUP_CTRL_MEMBER(rdma, CTRL_RDMA),
>  	{ }
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
