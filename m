Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D8DFCFB421
	for <ltp@archiver.kernel.org>; Sun,  6 Oct 2024 00:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728176051; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=97SJ1dpmwqw/Ga7fl3ZOG/0gnLEot/Ql9wOo+G+YmeE=;
 b=D13C8VYBOVO5c52EUDzPkpLMoMtpO7ycIiBwnbqHKGKm4Io0ghPlHbY0MrO5GRXUD61v3
 EGu+vvkHDQU6fw4i5x5lZn21WlvA1BzEwk7oKbGGvfLBm1LuVKjyitmZwyCBFdH0dcgDypc
 kNCrecaksONvTZDX3HT+U6/wl9ALZNM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 241DB3C6353
	for <ltp@archiver.kernel.org>; Sun,  6 Oct 2024 02:54:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 356673C5461
 for <ltp@lists.linux.it>; Sun,  6 Oct 2024 02:53:46 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com;
 envelope-from=herbert@gondor.apana.org.au; receiver=lists.linux.it)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D6229600F9E
 for <ltp@lists.linux.it>; Sun,  6 Oct 2024 02:53:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com; 
 s=formenos;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MgLp7O8qyabqY2WttHA2j+5INq2cuCIdKsU/gi4xZFI=; b=sGrCGQONWndTtHjekWdzInysfx
 nbSuTE1odM9K/bnARndZx4rnCXVKYQCDFKtbyC2I2OU88YdA2/U1YKrX9CYp7LRfPQtp3O3P0UaPV
 ZULTipmpDPFKwSLUKgSceALhxgtmfpmmPHu4VQ4zYa3hAfS0ZsRy1yYuzhWvCuQKBGJP7LC4yphx1
 CJWU7nvDjw+L3J26LHE3901GMe4y6JYmUUuj8OifSJjYPdkJgKBlxFNjUtdpruohYCCXTSCFK+I9v
 5KWoU4lAdE1izivb50TvTr1bpnIRwXsB7nr3KUnjrPOb2h3WCnQTKAmz22n66iS9RaF2GbTP4pBrf
 vTDgQNcg==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
 by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
 id 1sxFMg-007AZ7-1D; Sun, 06 Oct 2024 08:53:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation);
 Sun, 06 Oct 2024 08:53:28 +0800
Date: Sun, 6 Oct 2024 08:53:28 +0800
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <ZwHfiNsP7fUvDwbH@gondor.apana.org.au>
References: <ZsBJs_C6GdO_qgV7@gondor.apana.org.au>
 <ZsBJ5H4JExArHGVw@gondor.apana.org.au>
 <ZsBKG0la0m69Dyq3@gondor.apana.org.au>
 <20240827184839.GD2049@sol.localdomain>
 <Zs6SiBOdasO9Thd1@gondor.apana.org.au>
 <20240830175154.GA48019@sol.localdomain>
 <ZtQgVOnK6WzdIDlU@gondor.apana.org.au>
 <20240902170554.GA77251@sol.localdomain>
 <ZtZFOgh3WylktM1E@gondor.apana.org.au>
 <20241005222448.GB10813@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241005222448.GB10813@sol.localdomain>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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

On Sat, Oct 05, 2024 at 03:24:48PM -0700, Eric Biggers wrote:
>
> The tests are still failing on upstream:
> 
> [    0.343845] alg: self-tests for rfc4106(gcm(aes)) using rfc4106(gcm_base(ctr(aes-generic),ghash-generic)) failed (rc=-2)

You're right.  I only disabled the warnings at the point of
allocation, the overall self-test warning is still there.  Let
me get rid of them too.

> Besides the test failures, it looks like there's no longer any guarantee that
> algorithms are actually available now that their module is loaded.

That would indeed be a bug.  But I haven't seen it in practice.
Although the s390 folks were reporting some weird errors with
dm-crypt, they have recently disappeared.

If you do see an actual failure please report it and then I'll
consider reverting it until it's fixed.

> E.g. consider if someone does 'modprobe aesni-intel' and then immediately
> creates a dm-crypt device.  Now it sounds like the AES-NI algorithms might not
> have finished being tested yet and the generic algorithms can be used instead,
> resulting in a performance regression.

That is not the case.  After modprobe returns, the algorithm is
guaranteed to have been registered.  Yes it is untested, but that
should not be a problem because a test larval will have been created
and all users looking for that algorithm will be waiting on that
test larval.

> I understand that you want to try to fix the edge cases in "fallback" ciphers.
> But "fallback" ciphers have always seemed like a bad design due to how they use
> the crypto API recursively.  I think the algorithms that use them should
> generally be migrated off of them, e.g. as I did in commit f235bc11cc95
> ("crypto: arm/aes-neonbs - go back to using aes-arm directly").  That fixed the
> problem in aes-neonbs that seems to have triggered this work in the first place.

Yes getting rid of fallbacks is nice, but this it not the reason why
we're making self-test asynchronous.  The primary issue with synchronous
self-tests is the modprobe dead-lock.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
