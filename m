Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8C8C00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 11:38:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC6BD3C95EE
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 13:38:36 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3EC1B3C013B
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 13:38:27 +0200 (CEST)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BB5546001EA
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 13:38:26 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EC0A6B80DF1;
 Mon, 15 Aug 2022 11:38:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A69C433C1;
 Mon, 15 Aug 2022 11:38:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1660563503;
 bh=00iWghXu1D8BGFfHNyrQsbQ26GA+h94ZxRBfNbIXA7g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=kU3QwHmueOr4jIcgECpKsNb0gb2I85a9KO0t4UmgEQ+cBq2AD2CxjJELaMN7aVU9F
 pm+8v2UDHFXVTIgofOsTgj5iZWB93ZXft3YiGfmgT/AAWgDRF4KOfEyLghADVDyj6c
 qDNM3j6+kOfJefa64qVSQIfWHbPZ7N4iJsRZLQ2M=
Date: Mon, 15 Aug 2022 13:38:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YvowLH8GvMxMWcHH@kroah.com>
References: <Yvopj0gK5Dg95u+b@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yvopj0gK5Dg95u+b@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Backport d4ae9916ea29 ("mm: soft-offline: close the race
 against page allocation") to 4.14 and 4.9
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
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>, stable@vger.kernel.org,
 Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org,
 Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
 William Roche <william.roche@oracle.com>,
 Andrew Morton <akpm@linux-foundation.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Aug 15, 2022 at 01:10:07PM +0200, Petr Vorel wrote:
> Hi all,
> 
> I wonder if there was an attempt to backport d4ae9916ea29 ("mm: soft-offline:
> close the race against page allocation") from 4.19 to 4.14 and 4.9 (patch does
> not apply, haven't found anything on stable ML, nor in stable tree git,
> therefore I assume it was left as not easily fixable).

As it didn't apply, why not try creating a backport to test this
yourself?  I'll gladly accept such a thing into the trees if you make
it.

thanks,

greg k-h

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
