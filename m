Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10603CFB440
	for <ltp@archiver.kernel.org>; Mon,  7 Oct 2024 07:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728287920; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=dxr2JCuvsFSRty9Mpzxs4hptk+I1J6Y9ADQ1zNVqXM8=;
 b=bGs5/39JFY4O+YRprTV1lUoMKN5smhWjjau0LFyH8mGP+Se5lZeBWBbVFg/mR3TleQt46
 ztktAivCKJs8j2UU+8/vq6NCtmtihwdN0r3mdTR1746cYbeormbnbkDzpMvQFLfv9bfT2zS
 3YPQE8Toz6KzwFbO6hsF7mC49JzGqBQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B1813C581B
	for <ltp@archiver.kernel.org>; Mon,  7 Oct 2024 09:58:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AFEF43C57AC
 for <ltp@lists.linux.it>; Mon,  7 Oct 2024 09:58:18 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com;
 envelope-from=herbert@gondor.apana.org.au; receiver=lists.linux.it)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 3193F600B08
 for <ltp@lists.linux.it>; Mon,  7 Oct 2024 09:58:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com; 
 s=formenos;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ux19mWauQ7boi+6LoWvIzChBwm+z3gI4jolScsUjUqo=; b=BuW2cOQrh3VoWGswVcM4S3rK17
 TH0xpp+XvSAnw2NUwRTlgwdvHdfaxe+h0wUAz98EwBcF6LQDKRrVecqFhmmABbVriYPfY64mLHIwt
 JFuFh5n/9Y8LqLGv59+6SU0PtAx/GV/rJA7Vemc6XGfQVTBUIpqHJvkZ0IsgWsoJ+DicCU/mw3nrI
 E13eb/BpOPgZKBvaRlwnvzrsGi7W6xCGmtkVLDoL+7stSYoB6anI2N+0I4cVWDZ2jqU4HzGt06+Fi
 3Vqx7B/zKCpai65OrjzLNSZl1N0JOthV81DuOd4QIpXl2W8bBSHQrvsmmlK3BII9EfbmErUlH14Oe
 C+cZwbHQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
 by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
 id 1sxiT4-007OY3-2C; Mon, 07 Oct 2024 15:58:01 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation);
 Mon, 07 Oct 2024 15:58:00 +0800
Date: Mon, 7 Oct 2024 15:58:00 +0800
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <ZwOUiBXrUF0Lj2u5@gondor.apana.org.au>
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
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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

On Mon, Oct 07, 2024 at 12:32:22PM +0800, Herbert Xu wrote:
>
> For normal lookups (one without CRYPTO_ALG_TESTED set in the mask
> field), the core API will first look for a tested algorithm, and
> if that fails then it will look for an untested algorithm.  The
> second step should find the larval and then sleep on that until it's
> done.

Actually that's not quite right.  The test larval is registered
with TESTED set so normal lookups will latch onto that and then
wait.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
