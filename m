Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8711CFB421
	for <ltp@archiver.kernel.org>; Sun,  6 Oct 2024 03:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728184005; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=IB4loaxfejuuWSe/IEO5cf0mSGgTwNDx941WByitgg0=;
 b=MSdfyebn0LUfBKoXq1xn0KZkzxgA5m1RyOGGmdOhzZXg03CDUhK8Il+m1dmh41EBVrlir
 69VvxABtxl7fW4mpiPmx7feAKlZJKfR3ZZLZuho+2pbzVsnhpTxrpnZIz+K1Bw2bg4uiVCk
 LQ0MLIqxpgVbpI/eFeukAwp9uliKSno=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D7C03C6379
	for <ltp@archiver.kernel.org>; Sun,  6 Oct 2024 05:06:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 203443C54F0
 for <ltp@lists.linux.it>; Sun,  6 Oct 2024 05:06:24 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:45d1:ec00::3;
 helo=nyc.source.kernel.org; envelope-from=ebiggers@kernel.org;
 receiver=lists.linux.it)
Received: from nyc.source.kernel.org (nyc.source.kernel.org
 [IPv6:2604:1380:45d1:ec00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5B0BC1BBEDCB
 for <ltp@lists.linux.it>; Sun,  6 Oct 2024 05:06:23 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 19A81A40AC9;
 Sun,  6 Oct 2024 03:06:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69497C4CEC7;
 Sun,  6 Oct 2024 03:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1728183980;
 bh=ETNj5oHnep03n1zYQGiydmptlifreHJ4JKWMm0PPgOc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hV2G4zpXb6FS3EYmY1dNy7oN22blnsHgQ6m/M/VOeC5FAHoXgwfS3NNr7uHlPd5xs
 pJ4tcEZukTm6rKvLbw7Z+m4cw2IetDpX7wJeo14/w3PQkA8crC+EywxkvN8WNG5CHg
 HBvlAbRNCuojtTRWZ8uiUioVZPHt2n120hQkRXcdDWjP7YZmjOizjk/Y+B9HZHuI8b
 fTNvNUi59ae11aZ5Aoe41bWi0NABLzyPp8T4YxQIQ+L8AwLJo11T7OQKT///485X3A
 uFGYSGHJQRbw/ovW87FUXar/vRiYm0Et8a0k3qKTlJS3lTGqupuZ0seIoWSZm7oyjW
 vOLoerDuHyMDw==
Date: Sat, 5 Oct 2024 20:06:18 -0700
To: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20241006030618.GA30755@sol.localdomain>
References: <ZsBJ5H4JExArHGVw@gondor.apana.org.au>
 <ZsBKG0la0m69Dyq3@gondor.apana.org.au>
 <20240827184839.GD2049@sol.localdomain>
 <Zs6SiBOdasO9Thd1@gondor.apana.org.au>
 <20240830175154.GA48019@sol.localdomain>
 <ZtQgVOnK6WzdIDlU@gondor.apana.org.au>
 <20240902170554.GA77251@sol.localdomain>
 <ZtZFOgh3WylktM1E@gondor.apana.org.au>
 <20241005222448.GB10813@sol.localdomain>
 <ZwHfiNsP7fUvDwbH@gondor.apana.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZwHfiNsP7fUvDwbH@gondor.apana.org.au>
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
From: Eric Biggers via ltp <ltp@lists.linux.it>
Reply-To: Eric Biggers <ebiggers@kernel.org>
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

On Sun, Oct 06, 2024 at 08:53:28AM +0800, Herbert Xu wrote:
> On Sat, Oct 05, 2024 at 03:24:48PM -0700, Eric Biggers wrote:
> >
> > The tests are still failing on upstream:
> > 
> > [    0.343845] alg: self-tests for rfc4106(gcm(aes)) using rfc4106(gcm_base(ctr(aes-generic),ghash-generic)) failed (rc=-2)
> 
> You're right.  I only disabled the warnings at the point of
> allocation, the overall self-test warning is still there.  Let
> me get rid of them too.
> 
> > Besides the test failures, it looks like there's no longer any guarantee that
> > algorithms are actually available now that their module is loaded.
> 
> That would indeed be a bug.  But I haven't seen it in practice.
> Although the s390 folks were reporting some weird errors with
> dm-crypt, they have recently disappeared.
> 
> If you do see an actual failure please report it and then I'll
> consider reverting it until it's fixed.
> 
> > E.g. consider if someone does 'modprobe aesni-intel' and then immediately
> > creates a dm-crypt device.  Now it sounds like the AES-NI algorithms might not
> > have finished being tested yet and the generic algorithms can be used instead,
> > resulting in a performance regression.
> 
> That is not the case.  After modprobe returns, the algorithm is
> guaranteed to have been registered.  Yes it is untested, but that
> should not be a problem because a test larval will have been created
> and all users looking for that algorithm will be waiting on that
> test larval.

I'm not sure about that, since the code that looks up algorithms only looks for
algorithms that already have the CRYPTO_ALG_TESTED flag.

> > I understand that you want to try to fix the edge cases in "fallback" ciphers.
> > But "fallback" ciphers have always seemed like a bad design due to how they use
> > the crypto API recursively.  I think the algorithms that use them should
> > generally be migrated off of them, e.g. as I did in commit f235bc11cc95
> > ("crypto: arm/aes-neonbs - go back to using aes-arm directly").  That fixed the
> > problem in aes-neonbs that seems to have triggered this work in the first place.
> 
> Yes getting rid of fallbacks is nice, but this it not the reason why
> we're making self-test asynchronous.  The primary issue with synchronous
> self-tests is the modprobe dead-lock.

That problem is caused by the use of fallback ciphers, though.

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
