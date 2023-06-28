Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48753EB64D9
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 09:07:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B61913CE172
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 11:07:13 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A4B043C99A1
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 20:16:10 +0200 (CEST)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5DF63600B7C
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 20:16:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
 s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
 Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
 Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
 bh=+l+HcNCx7j/WU4JvE93sXOflPbzjvQPHJ61VUu/0kdQ=; b=KR8zaTX4nsyXgFaGaxrFikLtCT
 MHqEDH2WIQrt8vT4K9HqV/enDd1XoCeEoKgjkeAnj26BXeB/agIwmlM0B/4m/hwFhhPOaEyMQQSev
 XQPtvFMHTy1zZHooW85zusaQoZbYG8KTn813dq9Mg5cCEZJcfy+t07E96RZkgR2reBQo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
 (envelope-from <andrew@lunn.ch>)
 id 1qEZhu-0009So-Jt; Wed, 28 Jun 2023 20:15:58 +0200
Date: Wed, 28 Jun 2023 20:15:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Message-ID: <27c450f4-0b72-4d32-b99c-1b29831ab468@lunn.ch>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
 <7fa02bc1-64bd-483d-b3e9-f4ffe0bbb9fb@lunn.ch>
 <87ilb8ba1d.fsf@nvidia.com>
 <0e82eff0-16ba-49b0-933d-26f49515d434@lunn.ch>
 <87ilb7qxzu.fsf@nvidia.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87ilb7qxzu.fsf@nvidia.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
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

> It can be after -rc1. I understand your point now from this elaboration.
> Since the change is not heading towards a final release yet but a
> release candidate, it's not an "urgent" patch to be applied before -rc1.
> 
> >
> > We are in the grey area where it is less clear which tree it should be
> > against. So it is good to explain after the --- what your intention
> > is, so the Maintainers get a heads up and understand what you are
> > trying to achieve.
> 
> Agreed, I could have used git notes for that in my patch generation.
> Noted for the future. Just to be clear, my intention is for this fix to
> make its way before the final 6.5 release (before the changes make their
> way to an end user since the NULL pointer dereference when reading that
> sysfs node from a PHC not supporting phase adjustment is problematic).

A NULL pointer dereference is a valid reason for stable anyway. 

> I think the issue being present in a release candidate is a minor
> problem.  Would I still keep the Fixes tag however if targeting
> net-next?

It is useful, even for something in net-next. It is not needed for
back porting, except for making it clear back porting is not needed,
But there are some statistics gathered based on Fixes tags, etc.

     Andrew

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
