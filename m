Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B4DCFB440
	for <ltp@archiver.kernel.org>; Mon,  7 Oct 2024 08:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728289917; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=abR+nSx6W31z8u3wYdAESUUOg8rP36v1R5UdHhwm0J0=;
 b=Mq5F3b5P1mb6jLsll8dzQMUhMKSq8hh25jBaNaRfCoI+X53ngE+4+JfiLoNXcSE5sgJyx
 9oUvj0P1oePIXMfvuNQfvGbXsaYJmnGnKaI9TqTECNWDDemKyDE75pnSn1sh2YtGdA3uzZv
 rg7PmqJ53Sld3bfsR19xm2zEd4zLbzQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 84A553C581E
	for <ltp@archiver.kernel.org>; Mon,  7 Oct 2024 10:31:57 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 258823C2034
 for <ltp@lists.linux.it>; Mon,  7 Oct 2024 10:31:34 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com;
 envelope-from=herbert@gondor.apana.org.au; receiver=lists.linux.it)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C08A8201734
 for <ltp@lists.linux.it>; Mon,  7 Oct 2024 10:31:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com; 
 s=formenos;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GcToCRPaIztkagLop0+41I63NBz+F4uN8r4VJ4+Mb3M=; b=LGLOdpO+ZiyWz5P8pqeemo5ZDZ
 k+5YEArr0MzSrn/sdR/n5yZkbGPY/9numMySxhYRDCATlRqyJCx1PPJYm7MXeubgs1uK4R0SNCvkN
 bahmEHYesIlRGRrVTrAWTXOb4E3qCjvxHKJvw9P4n32xvkF0clFu8C7YP8NX43h9b7kddvxV0/Uhs
 qycBoSEpMdIuksTeoZkjvxmUFORbcny9c6sVncCohiPz7HavDCblR4DTjX7HnzbeFrxy1j0pvucLS
 GFCGQxJ+I0AGS7EyHkZYq/Rg4156Khy2OaObcLEtw5JKBT7rOwDTAMucpw0McXhrx5VQyzavQrGlY
 wbHUgWAw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
 by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
 id 1sxizN-007Ouk-0m; Mon, 07 Oct 2024 16:31:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation);
 Mon, 07 Oct 2024 16:31:22 +0800
Date: Mon, 7 Oct 2024 16:31:22 +0800
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <ZwOcWtgj3YaAvocJ@gondor.apana.org.au>
References: <20240827184839.GD2049@sol.localdomain>
 <Zs6SiBOdasO9Thd1@gondor.apana.org.au>
 <20240830175154.GA48019@sol.localdomain>
 <ZtQgVOnK6WzdIDlU@gondor.apana.org.au>
 <20240902170554.GA77251@sol.localdomain>
 <ZtZFOgh3WylktM1E@gondor.apana.org.au>
 <20241005222448.GB10813@sol.localdomain>
 <ZwHfiNsP7fUvDwbH@gondor.apana.org.au>
 <20241006030618.GA30755@sol.localdomain>
 <ZwNkVv5WWrmpOmqN@gondor.apana.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZwNkVv5WWrmpOmqN@gondor.apana.org.au>
Subject: Re: [LTP] [PATCH] crypto: api - Fix generic algorithm self-test
 races
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
From: Herbert Xu via ltp <ltp@lists.linux.it>
Reply-To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: lkp@intel.com, Horia =?utf-8?Q?Geant=C4=83?= <horia.geanta@nxp.com>,
 "Russell King \(Oracle\)" <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>,
 kernel test robot <oliver.sang@intel.com>, linux-crypto@vger.kernel.org,
 oe-lkp@lists.linux.dev, Linus Torvalds <torvalds@linux-foundation.org>,
 Ard Biesheuvel <ardb@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Oct 07, 2024 at 12:32:22PM +0800, Herbert Xu wrote:
>
> PS it looks like there is an actual report of things breaking with
> async testing in mv_cesa so I might revert/disable the async testing
> after all.

It looks like it wasn't a bug in the async self-test.

Instead this appears to be a real bug that was discovered by the
async testing (because we now run all the tests at the same time,
thus testing the whether the driver deals with parallel requests
or not).

This is a bit accidental, because the driver in question registered
multiple hash algorithms.  Had it only registered one, then nothing
would have changed.

Is this something that we could improve in testmgr? Perhaps we can
add a bit of parallelism ourselves to cover the case where a driver
only registers one hash algorithm.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
