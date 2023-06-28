Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4664EB64DC
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 09:07:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 257623CC2F9
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 11:07:35 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C40B63CC6FA
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 22:46:47 +0200 (CEST)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DD5011A00ED7
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 22:46:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=+y1JusCGLuOzWsZPtC769VYTFYhrXWGIXGBzKkpmVLM=; b=fqCQ32/ziNsLhj2D9dSSUtxmcc
 uW1B0MFkhS4OimnmdN5FN6UbHFBa53JSWBxmSRaFN/KRYBa2218ix5EZix1fp4LJAjvDmwa+shjXW
 nokF3ufHshpUwcrrfM2tmTNs7ETBbN4E8ZxxFJdp/aptamGVror/wQRp9B5FSoOQVd6s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1qEc3c-000BG8-7G; Wed, 28 Jun 2023 22:46:32 +0200
Date: Wed, 28 Jun 2023 22:46:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jakub Kicinski <kuba@kernel.org>
Message-ID: <06f5c065-2c6d-4cd2-9699-89f05443f137@lunn.ch>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
 <7fa02bc1-64bd-483d-b3e9-f4ffe0bbb9fb@lunn.ch>
 <20230628133850.0d01d503@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230628133850.0d01d503@kernel.org>
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
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
 Saeed Mahameed <saeed@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Jun 28, 2023 at 01:38:50PM -0700, Jakub Kicinski wrote:
> On Wed, 28 Jun 2023 03:16:43 +0200 Andrew Lunn wrote:
> > > +	} else if (attr == &dev_attr_max_phase_adjustment.attr) {
> > > +		if (!info->adjphase || !info->getmaxphase)
> > > +			mode = 0;  
> > 
> > Maybe it is time to turn this into a switch statement?
> 
> I don't think we can switch on pointers in C.

https://elixir.bootlin.com/linux/latest/source/drivers/net/phy/sfp.c#L749

Works for temperature sensors, voltage sensors, current sensors, and
power sensors. Maybe hwmon is different to what is going on here, but
both a sysfs files.

> The patch is good as is, right?

Yes.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
