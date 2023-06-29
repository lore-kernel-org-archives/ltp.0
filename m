Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8382DEB64D9
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 18:07:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 102683CE148
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 20:07:05 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0EC43CC5B3
 for <ltp@lists.linux.it>; Thu, 29 Jun 2023 20:06:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C8D441400327
 for <ltp@lists.linux.it>; Thu, 29 Jun 2023 20:06:52 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5AD6B61575;
 Thu, 29 Jun 2023 18:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 541ACC433C8;
 Thu, 29 Jun 2023 18:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1688062009;
 bh=7Ks0hv1XTuN4Iv5JUqC6lvcE81ZceWI4a8y/7x9CqXM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=XiK70HkCWF5/YqgANZx6p+vSgxyyYySejOV90UW5Cteyg9yOE12bXdoaIUi0cs6vE
 EhOv/rqi+Q86KbzKnbN1a69O7Jw82DKwXBDvUpcNBfPDnYfrU8TJwRK5PARlT9j6Mh
 AuAjvMCIcPeXAmOLkn02O/miOgo8aafKMJ/h282aBbkrNr4yngH45sYQD8fJFRR4z8
 4R3ILpuJ+RhPEnsv8RWtqYSnSXdZzmnEkTN4MIkdmzrsNxUABmHZq6BbZUGfr6mFq/
 3fohSdcMPq1svVgzCdnzM6N5L9uUBMT0+npsS2h+89gDwJwhlTFzUlYC1ETX1Zs4E/
 l0nCV4+zM/oPw==
Date: Thu, 29 Jun 2023 11:06:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Richard Cochran <richardcochran@gmail.com>
Message-ID: <20230629110648.4b510cf6@kernel.org>
In-Reply-To: <20230627232139.213130-1-rrameshbabu@nvidia.com>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
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
 Gal Pressman <gal@nvidia.com>, lkft-triage@lists.linaro.org,
 Nathan Chancellor <nathan@kernel.org>, Saeed Mahameed <saeed@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rahul Rameshbabu <rrameshbabu@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, 27 Jun 2023 16:21:39 -0700 Rahul Rameshbabu wrote:
> The .adjphase operation is an operation that is implemented only by certain
> PHCs. The sysfs device attribute node for querying the maximum phase
> adjustment supported should not be exposed on devices that do not support
> .adjphase.

Richard, ack?

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
