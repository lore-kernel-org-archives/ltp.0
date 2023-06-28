Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63F7EEB64D9
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 09:06:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A62D33CE15B
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 11:06:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B39683C99BA
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 03:17:00 +0200 (CEST)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D2A8814002DC
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 03:16:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=bKYdeoZshl+DSHO12L5i3AewmQy9fMyB+ioBMw0Hibc=; b=qq68OthO0wrPbR5wLVLvxAeaRH
 3yRymbGwrM6pRl9f6hTu7RBmvyRV24+frhgngCINRBrhq8S7iwjWXd9FeQqm4eGpmQLFNgnanAqNq
 wQYWSSZuHWQ2LD/lP6vj7H7WggPxjJXWP8fgpbX0pwtOuqYk8g0Ci+Xo6iafNEcPcNu4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1qEJnX-0005IO-LS; Wed, 28 Jun 2023 03:16:43 +0200
Date: Wed, 28 Jun 2023 03:16:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Message-ID: <7fa02bc1-64bd-483d-b3e9-f4ffe0bbb9fb@lunn.ch>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230627232139.213130-1-rrameshbabu@nvidia.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 29 Jun 2023 11:05:53 +0200
Subject: Re: [LTP] [PATCH net v1] ptp: Make max_phase_adjustment sysfs
 device attribute invisible when not supported
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
Cc: Linux Kernel Functional Testing <lkft@linaro.org>, netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>, lkft-triage@lists.linaro.org,
 "David S. Miller" <davem@davemloft.net>, Nathan Chancellor <nathan@kernel.org>,
 Saeed Mahameed <saeed@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Gal Pressman <gal@nvidia.com>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jun 27, 2023 at 04:21:39PM -0700, Rahul Rameshbabu wrote:
> The .adjphase operation is an operation that is implemented only by certain
> PHCs. The sysfs device attribute node for querying the maximum phase
> adjustment supported should not be exposed on devices that do not support
> .adjphase.
> 
> Fixes: c3b60ab7a4df ("ptp: Add .getmaxphase callback to ptp_clock_info")
> Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Link: https://lore.kernel.org/netdev/20230627162146.GA114473@dev-arch.thelio-3990X/
> Link: https://lore.kernel.org/all/CA+G9fYtKCZeAUTtwe69iK8Xcz1mOKQzwcy49wd+imZrfj6ifXA@mail.gmail.com/

I think Signed-off-by should be last.

> diff --git a/drivers/ptp/ptp_sysfs.c b/drivers/ptp/ptp_sysfs.c
> index 77219cdcd683..6e4d5456a885 100644
> --- a/drivers/ptp/ptp_sysfs.c
> +++ b/drivers/ptp/ptp_sysfs.c
> @@ -358,6 +358,9 @@ static umode_t ptp_is_attribute_visible(struct kobject *kobj,
>  		   attr == &dev_attr_max_vclocks.attr) {
>  		if (ptp->is_virtual_clock)
>  			mode = 0;
> +	} else if (attr == &dev_attr_max_phase_adjustment.attr) {
> +		if (!info->adjphase || !info->getmaxphase)
> +			mode = 0;

Maybe it is time to turn this into a switch statement?

I also wounder if this really is something for net. How do you think
this patch matches against the stable rules?

    Andrew


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
