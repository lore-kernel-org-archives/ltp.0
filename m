Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21B41C5474A
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 03:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724814004; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=AW8nd3Dpg9QY8pbtRzSrH+0sMlq/t+3oH25rJF9Zycg=;
 b=MMFBxhDLX3lJFb0+NCbFfAff/qINpHYyxj3Fu8L60Q/cVybwpEMZbvKu8mLVegXo77mtv
 UqSOZhlarlFHiiiqBoYDfFsljuRejz6AQVioPNvAwxIzzuEkoQOJzotZH16spibbgF8K4WR
 RrYLUNPj/CMiO9Y13mFaNEgt0RUZ+5s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09E813D2774
	for <ltp@archiver.kernel.org>; Wed, 28 Aug 2024 05:00:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FC9F3C07AE
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 04:59:40 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com;
 envelope-from=herbert@gondor.apana.org.au; receiver=lists.linux.it)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7C2D81401242
 for <ltp@lists.linux.it>; Wed, 28 Aug 2024 04:59:37 +0200 (CEST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
 by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
 id 1sj8lW-007pM5-37; Wed, 28 Aug 2024 10:59:21 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation);
 Wed, 28 Aug 2024 10:59:20 +0800
Date: Wed, 28 Aug 2024 10:59:20 +0800
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <Zs6SiBOdasO9Thd1@gondor.apana.org.au>
References: <ZrbTUk6DyktnO7qk@gondor.apana.org.au>
 <202408161634.598311fd-oliver.sang@intel.com>
 <ZsBJs_C6GdO_qgV7@gondor.apana.org.au>
 <ZsBJ5H4JExArHGVw@gondor.apana.org.au>
 <ZsBKG0la0m69Dyq3@gondor.apana.org.au>
 <20240827184839.GD2049@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240827184839.GD2049@sol.localdomain>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [v3 PATCH 3/3] crypto: simd - Do not call
 crypto_alloc_tfm during registration
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

On Tue, Aug 27, 2024 at 11:48:39AM -0700, Eric Biggers wrote:
> On Sat, Aug 17, 2024 at 02:58:35PM +0800, Herbert Xu wrote:
> > Algorithm registration is usually carried out during module init,
> > where as little work as possible should be carried out.  The SIMD
> > code violated this rule by allocating a tfm, this then triggers a
> > full test of the algorithm which may dead-lock in certain cases.
> > 
> > SIMD is only allocating the tfm to get at the alg object, which is
> > in fact already available as it is what we are registering.  Use
> > that directly and remove the crypto_alloc_tfm call.
> > 
> > Also remove some obsolete and unused SIMD API.
> > 
> > Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> > ---
> >  arch/arm/crypto/aes-ce-glue.c     |  2 +-
> >  arch/arm/crypto/aes-neonbs-glue.c |  2 +-
> >  crypto/simd.c                     | 76 ++++++-------------------------
> >  include/crypto/internal/simd.h    | 12 +----
> >  4 files changed, 19 insertions(+), 73 deletions(-)
> > 
> 
> I'm getting a test failure with this series applied:
> 
> [    0.383128] alg: aead: failed to allocate transform for gcm_base(ctr(aes-generic),ghash-generic): -2
> [    0.383500] alg: self-tests for gcm(aes) using gcm_base(ctr(aes-generic),ghash-generic) failed (rc=-2)
> 
> This is on x86_64 with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y.

Could you please send me your config file?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
