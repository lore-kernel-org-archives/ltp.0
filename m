Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 768FEEB64DC
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 09:07:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E13723CF584
	for <ltp@archiver.kernel.org>; Thu, 29 Jun 2023 11:07:24 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DD6E3CC734
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 22:38:56 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 870331400E7B
 for <ltp@lists.linux.it>; Wed, 28 Jun 2023 22:38:54 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AD99561467;
 Wed, 28 Jun 2023 20:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6642FC433C0;
 Wed, 28 Jun 2023 20:38:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687984732;
 bh=gbPT71ueY++FFfVXPWNZrmY/iVBXkebDJfbxtxDqAos=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=RVB0Q5g7c4ziMQpA+WWA5mHPsxbG/HdkbQzBw7h7oGeOgDx8cR13jpz6gIM5tDwuU
 F8pas0DFfgTlIC9/yxDgYpOEcA/O6duWjIZ35tSDOiw6Vjm/4ADx6wGjeLsq87LB8x
 gqfOjQQbyiUL8Z4CCTx/6Dz5sMxrkv/mU7Ww/OompYY/6dJj3eXH7JdTjgbHEbAuWo
 gNEhKXyzf9i9tXUvtkfvLYNsy0rNTCNszihcdAR3TsyXHIDIQ7nd85Gpc7D0MY36xf
 i/d6OPBccRcCHqLyLktT4kD9OyVhgmGSw3rIR3TKN7JeH4oUVouQF4w+m8vbQRoaZs
 W5pd9NY74h9xg==
Date: Wed, 28 Jun 2023 13:38:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Message-ID: <20230628133850.0d01d503@kernel.org>
In-Reply-To: <7fa02bc1-64bd-483d-b3e9-f4ffe0bbb9fb@lunn.ch>
References: <20230627232139.213130-1-rrameshbabu@nvidia.com>
 <7fa02bc1-64bd-483d-b3e9-f4ffe0bbb9fb@lunn.ch>
MIME-Version: 1.0
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
 Saeed Mahameed <saeed@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, 28 Jun 2023 03:16:43 +0200 Andrew Lunn wrote:
> > +	} else if (attr == &dev_attr_max_phase_adjustment.attr) {
> > +		if (!info->adjphase || !info->getmaxphase)
> > +			mode = 0;  
> 
> Maybe it is time to turn this into a switch statement?

I don't think we can switch on pointers in C.
The patch is good as is, right?
(The tree we'll pick appropriately when applying.)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
