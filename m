Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4159DCD13CF
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 17:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725296779; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=C4oqk63Bgiot/ZG0V7H8VWGjVszTFmBdugujWvdB10A=;
 b=cpJZt4VkRNnrpZ7AS+icf0anLs5K4RcN1PgNEIPLzhJGEcRcnCnMEyXZeZF8UZJRuJJEI
 s1E6lVwLgUXV3MyHyKLA70D9pfYZTdDDy2JeQm6GrqnCDO5iEAo17ZKl1wBG+Acd2q/9Xrn
 nI15BoT4REYmIS2qL/tCBcszsCTlqVg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7CB5B3C4C5C
	for <ltp@archiver.kernel.org>; Mon,  2 Sep 2024 19:06:19 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF4C13C2669
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 19:05:59 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=139.178.84.217; helo=dfw.source.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E593E1400E73
 for <ltp@lists.linux.it>; Mon,  2 Sep 2024 19:05:58 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 22D075C58BA;
 Mon,  2 Sep 2024 17:05:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AC6C4CEC2;
 Mon,  2 Sep 2024 17:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1725296756;
 bh=tPVdkbVWmvXleWePW20K3pLjS+FR+6rviVNPuKfB82M=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=dRXqWvgcJAflt3mtsqeLiRSm1maRlwxzyCY3of4rt8WcdSgRKINrVsgkEFiYgMlAH
 T6MBCsXlzsbNxoHlMfiD/f5OAcb+vyuclSNGuhy6I3Vhun2tLJgLHM2uS6b3PqTJ/+
 xnEjA7v2sgxiYSmjeXEWGxF2FY7PP0CYNGXLPBoFAwqxKrAD7v0RR0+RV4trbIlqyt
 3ybG+oosmFz0XLdaCF9jEhodhNbMDBznNNG54dmD801Y/XzarOKsZP7Y2n8AGYNaN9
 BTfgeCHhEroVmogexYf8/nx005NYZAL99IWK/NpEnEFRV6NzdqSI2i4iwKAqJ7HNNM
 mO0cmmLXrx+IQ==
Date: Mon, 2 Sep 2024 10:05:54 -0700
To: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20240902170554.GA77251@sol.localdomain>
References: <ZrbTUk6DyktnO7qk@gondor.apana.org.au>
 <202408161634.598311fd-oliver.sang@intel.com>
 <ZsBJs_C6GdO_qgV7@gondor.apana.org.au>
 <ZsBJ5H4JExArHGVw@gondor.apana.org.au>
 <ZsBKG0la0m69Dyq3@gondor.apana.org.au>
 <20240827184839.GD2049@sol.localdomain>
 <Zs6SiBOdasO9Thd1@gondor.apana.org.au>
 <20240830175154.GA48019@sol.localdomain>
 <ZtQgVOnK6WzdIDlU@gondor.apana.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZtQgVOnK6WzdIDlU@gondor.apana.org.au>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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

On Sun, Sep 01, 2024 at 04:05:40PM +0800, Herbert Xu wrote:
> On Fri, Aug 30, 2024 at 10:51:54AM -0700, Eric Biggers wrote:
> >
> > Given below in defconfig form, use 'make olddefconfig' to apply.  The failures
> > are nondeterministic and sometimes there are different ones, for example:
> > 
> > [    0.358017] alg: skcipher: failed to allocate transform for cbc(twofish-generic): -2
> > [    0.358365] alg: self-tests for cbc(twofish) using cbc(twofish-generic) failed (rc=-2)
> > [    0.358535] alg: skcipher: failed to allocate transform for cbc(camellia-generic): -2
> > [    0.358918] alg: self-tests for cbc(camellia) using cbc(camellia-generic) failed (rc=-2)
> > [    0.371533] alg: skcipher: failed to allocate transform for xts(ecb(aes-generic)): -2
> > [    0.371922] alg: self-tests for xts(aes) using xts(ecb(aes-generic)) failed (rc=-2)
> > 
> > Modules are not enabled, maybe that matters (I haven't checked yet).
> 
> Yes I think that was the key.  This triggers a massive self-test
> run which executes in parallel and reveals a few race conditions
> in the system.  I think it boils down to the following scenario:
> 
> Base algorithm X-generic, X-optimised
> Template Y
> Optimised algorithm Y-X-optimised
> 
> Everything gets registered, and then the self-tests are started.
> When Y-X-optimised gets tested, it requests the creation of the
> generic Y(X-generic).  Which then itself undergoes testing.
> 
> The race is that after Y(X-generic) gets registered, but just
> before it gets tested, X-optimised finally finishes self-testing
> which then causes all spawns of X-generic to be destroyed.  So
> by the time the self-test for Y(X-generic) comes along, it can
> no longer find the algorithm.  This error then bubbles up all
> the way up to the self-test of Y-X-optimised which then fails.
> 
> Note that there is some complexity that I've omitted here because
> when the generic self-test fails to find Y(X-generic) it actually
> triggers the construction of it again which then fails for various
> other reasons (these are not important because the construction
> should *not* be triggered at this point).
> 
> So in a way the error is expected, and we should probably remove
> the pr_err for the case where ENOENT is returned for the algorithm
> that we're currently testing.
> 
> The solution is two-fold.  First when an algorithm undergoes
> self-testing it should not trigger its construction.  Secondly
> if an instance larval fails to materialise due to it being destroyed
> by a more optimised algorithm coming along, it should obviously
> retry the construction.
> 
> Remove the check in __crypto_alg_lookup that stops a larval from
> matching new requests based on differences in the mask.  It is better
> to block new requests even if it is wrong and then simply retry the
> lookup.  If this ends up being the wrong larval it will sort iself
> out during the retry.
> 
> Reduce the CRYPTO_ALG_TYPE_MASK bits in type during larval creation
> as otherwise LSKCIPHER algorithms may not match SKCIPHER larvals.
> 
> Also block the instance creation during self-testing in the function
> crypto_larval_lookup by checking for CRYPTO_ALG_TESTED in the mask
> field.
> 
> Finally change the return value when crypto_alg_lookup fails in
> crypto_larval_wait to EAGAIN to redo the lookup.
> 
> Fixes: 37da5d0ffa7b ("crypto: api - Do not wait for tests during registration")
> Reported-by: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
> 
> diff --git a/crypto/api.c b/crypto/api.c
> index bbe29d438815..bfd177a4313a 100644
> --- a/crypto/api.c
> +++ b/crypto/api.c
> @@ -70,11 +70,6 @@ static struct crypto_alg *__crypto_alg_lookup(const char *name, u32 type,
>  		if ((q->cra_flags ^ type) & mask)
>  			continue;
>  
> -		if (crypto_is_larval(q) &&
> -		    !crypto_is_test_larval((struct crypto_larval *)q) &&
> -		    ((struct crypto_larval *)q)->mask != mask)
> -			continue;
> -
>  		exact = !strcmp(q->cra_driver_name, name);
>  		fuzzy = !strcmp(q->cra_name, name);
>  		if (!exact && !(fuzzy && q->cra_priority > best))
> @@ -113,6 +108,8 @@ struct crypto_larval *crypto_larval_alloc(const char *name, u32 type, u32 mask)
>  	if (!larval)
>  		return ERR_PTR(-ENOMEM);
>  
> +	type &= ~CRYPTO_ALG_TYPE_MASK | (mask ?: CRYPTO_ALG_TYPE_MASK);
> +
>  	larval->mask = mask;
>  	larval->alg.cra_flags = CRYPTO_ALG_LARVAL | type;
>  	larval->alg.cra_priority = -1;
> @@ -229,7 +226,7 @@ static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg)
>  		type = alg->cra_flags & ~(CRYPTO_ALG_LARVAL | CRYPTO_ALG_DEAD);
>  		mask = larval->mask;
>  		alg = crypto_alg_lookup(alg->cra_name, type, mask) ?:
> -		      ERR_PTR(-ENOENT);
> +		      ERR_PTR(-EAGAIN);
>  	} else if (IS_ERR(alg))
>  		;
>  	else if (crypto_is_test_larval(larval) &&
> @@ -308,8 +305,12 @@ static struct crypto_alg *crypto_larval_lookup(const char *name, u32 type,
>  
>  	if (!IS_ERR_OR_NULL(alg) && crypto_is_larval(alg))
>  		alg = crypto_larval_wait(alg);
> -	else if (!alg)
> +	else if (alg)
> +		;
> +	else if (!(mask & CRYPTO_ALG_TESTED))
>  		alg = crypto_larval_add(name, type, mask);
> +	else
> +		alg = ERR_PTR(-ENOENT);
>  
>  	return alg;
>  }

With both this patch "crypto: api - Fix generic algorithm self-test races" and
your other patch "crypto: algboss - Pass instance creation error up" applied,
I'm still getting errors occasionally, e.g.:

    [    5.155587] alg: skcipher: failed to allocate transform for cbc(sm4-generic): -2
    [    5.155954] alg: self-tests for cbc(sm4) using cbc(sm4-generic) failed (rc=-2)
    [    5.372511] alg: aead: failed to allocate transform for gcm_base(ctr(aes-generic),ghash-generic): -2
    [    5.372861] alg: self-tests for gcm(aes) using gcm_base(ctr(aes-generic),ghash-generic) failed (rc=-2)

I can't follow your explanation of what is going on here and what the fix is.
Would it make any sense to just revert the commits that introduced this problem?

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
