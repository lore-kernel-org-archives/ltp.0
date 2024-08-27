Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8257BC5472F
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 18:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1724785070; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=YmjkdWgkRd+YTfWNemX/aHt1oLM5GAJdmRyB40gSApE=;
 b=pbRMVubOGPP/SBEYCHtj3TRX86LMybxNXt3ccC23IbczKudrfW2ovQ6BTXA40+FlXEgVX
 qLf6GpnoysRolcmEf9ySi0oMhYmcKx2EEpvRnpSIOWjaB+RfKzMx3lOppt+mrSqBryoQpUm
 H8rPbyTxEKar3YkhE5NwsULBhewg44c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A47E03D2767
	for <ltp@archiver.kernel.org>; Tue, 27 Aug 2024 20:57:50 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3999A3D2266
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 20:57:30 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=145.40.73.55; helo=sin.source.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=lists.linux.it)
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E4B9C60239C
 for <ltp@lists.linux.it>; Tue, 27 Aug 2024 20:57:29 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id E9685CE1412;
 Tue, 27 Aug 2024 18:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55A4DC4FF4D;
 Tue, 27 Aug 2024 18:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1724784521;
 bh=TOskMyqvmJnMMdMK9trHR8rWGt1L+cQe4Dtdla0PK+0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=murPJKnrocvWfXX7rWlYLG3ledHoOxLgwG/e1Qwf9cs/KuUhuSnLz6a4PwpOAICuO
 7I+yhTbPeHZEp0GMdcgKfU0849z1wX6+w4+F9r3xzYA8tUC5mvlm6uoY/lydfbwgcL
 YbZIPndcqpP30be39cIFQKzkQXAUHFLV4iZilqIUEFJk/d1I4ZpM9MeRfk61F3L/UW
 qi4FAvEF0mCdQd+kCGVRsp45+khRStTBMoO2AwnBPxsNa1wzB6aRfW1uEKXueg92JN
 9KlbU+LvI6rKoGjx+2KIIvtsiGAkGuLnPpWBzAzReks4ZfNBEaaseoATd97fcjlw86
 yeTIdEUTFmOhw==
Date: Tue, 27 Aug 2024 11:48:39 -0700
To: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20240827184839.GD2049@sol.localdomain>
References: <ZrbTUk6DyktnO7qk@gondor.apana.org.au>
 <202408161634.598311fd-oliver.sang@intel.com>
 <ZsBJs_C6GdO_qgV7@gondor.apana.org.au>
 <ZsBJ5H4JExArHGVw@gondor.apana.org.au>
 <ZsBKG0la0m69Dyq3@gondor.apana.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZsBKG0la0m69Dyq3@gondor.apana.org.au>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
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

On Sat, Aug 17, 2024 at 02:58:35PM +0800, Herbert Xu wrote:
> Algorithm registration is usually carried out during module init,
> where as little work as possible should be carried out.  The SIMD
> code violated this rule by allocating a tfm, this then triggers a
> full test of the algorithm which may dead-lock in certain cases.
> 
> SIMD is only allocating the tfm to get at the alg object, which is
> in fact already available as it is what we are registering.  Use
> that directly and remove the crypto_alloc_tfm call.
> 
> Also remove some obsolete and unused SIMD API.
> 
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> ---
>  arch/arm/crypto/aes-ce-glue.c     |  2 +-
>  arch/arm/crypto/aes-neonbs-glue.c |  2 +-
>  crypto/simd.c                     | 76 ++++++-------------------------
>  include/crypto/internal/simd.h    | 12 +----
>  4 files changed, 19 insertions(+), 73 deletions(-)
> 

I'm getting a test failure with this series applied:

[    0.383128] alg: aead: failed to allocate transform for gcm_base(ctr(aes-generic),ghash-generic): -2
[    0.383500] alg: self-tests for gcm(aes) using gcm_base(ctr(aes-generic),ghash-generic) failed (rc=-2)

This is on x86_64 with CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y.

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
