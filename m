Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EA82CFB43C
	for <ltp@archiver.kernel.org>; Mon,  7 Oct 2024 04:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728275587; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4Jme2mQXFS+pouQDC1iAhHWjbbtPE59wlZUJQOuUXVs=;
 b=G/0+2np7xoQAmkR+KhxgKKlfSrDn99K2CyWvfXtfSDM4Z3A9BgwlaAMlZ2FKKnnp7eMW1
 GugY5m3DHQTuB9Mo59bgSiC+RcIzwERhtAvuTON5QYH6KyzUoOOXticNUIZLumYZ8ZEOVDJ
 E8dsjIOSSwSEFoCXDKaMsz9r0D6x2Kk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4AE6B3C1C7F
	for <ltp@archiver.kernel.org>; Mon,  7 Oct 2024 06:33:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 584B93C1C7F
 for <ltp@lists.linux.it>; Mon,  7 Oct 2024 06:32:42 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com;
 envelope-from=herbert@gondor.apana.org.au; receiver=lists.linux.it)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8A5F01A01231
 for <ltp@lists.linux.it>; Mon,  7 Oct 2024 06:32:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com; 
 s=formenos;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=o7SMnmFH+FyD3bxWmFoMm+ObZ1/7pInGDbzO+Qr22oc=; b=rUdzX5q3E3IzZGOmrTZexpSRkd
 /B47jUSaRYKufG6nVJz0ixWfJYozWlNTMloZFAbuccu3h1lt4rPvuVZ7tTkjygEt28Z4CcSTVpGkr
 KFdeCOfHZi6No6WMfDgq9vOdf9h8oCWuUSobaLGs1qPBNxWTyO2wIeCwTegpsyZA+gP7NARufsLDu
 fBy+yFodaw1YbYPa8OGhl29AVF7xPeFsEVRXtjoFuXNHivnb6HirZ5obgBwapmlH6MOyTYcdlE+2X
 kQkSNNW5DgkQt0A8DYdWEt5FXW/hVV5detVUbWhvV5Sun/+bkVLN6684V7PR+vucXNLHwJOIAPmyY
 cI3N6jAw==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
 by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
 id 1sxfG5-007MaH-0n; Mon, 07 Oct 2024 12:32:23 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation);
 Mon, 07 Oct 2024 12:32:22 +0800
Date: Mon, 7 Oct 2024 12:32:22 +0800
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <ZwNkVv5WWrmpOmqN@gondor.apana.org.au>
References: <ZsBKG0la0m69Dyq3@gondor.apana.org.au>
 <20240827184839.GD2049@sol.localdomain>
 <Zs6SiBOdasO9Thd1@gondor.apana.org.au>
 <20240830175154.GA48019@sol.localdomain>
 <ZtQgVOnK6WzdIDlU@gondor.apana.org.au>
 <20240902170554.GA77251@sol.localdomain>
 <ZtZFOgh3WylktM1E@gondor.apana.org.au>
 <20241005222448.GB10813@sol.localdomain>
 <ZwHfiNsP7fUvDwbH@gondor.apana.org.au>
 <20241006030618.GA30755@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241006030618.GA30755@sol.localdomain>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
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

On Sat, Oct 05, 2024 at 08:06:18PM -0700, Eric Biggers wrote:
>
> I'm not sure about that, since the code that looks up algorithms only looks for
> algorithms that already have the CRYPTO_ALG_TESTED flag.

For normal lookups (one without CRYPTO_ALG_TESTED set in the mask
field), the core API will first look for a tested algorithm, and
if that fails then it will look for an untested algorithm.  The
second step should find the larval and then sleep on that until it's
done.
 
> That problem is caused by the use of fallback ciphers, though.

Sure that particular deadlock may have been due to a fallback,
but such dependencies exist outside of fallbacks too.  Especially
now that we have the fuzz testing which will dynamically load the
generic algorithms, it's easy to envisage a scenario where one
module registers an algorithm, which then triggers modprobe's on the
generic implementation of the same algorithm that then dead-locks.

PS it looks like there is an actual report of things breaking with
async testing in mv_cesa so I might revert/disable the async testing
after all.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
