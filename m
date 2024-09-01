Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B4AC54FC6
	for <ltp@archiver.kernel.org>; Sun,  1 Sep 2024 08:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725177989; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=DgopzZ/sAzZ3hD6tYIrpZMwYRNPVDL6dUgDQOJXJIOQ=;
 b=nt6P+l62UxAzHtPPq/neVjwCiZAWiLjiu4gkN/J4E5DiWtPfql9G8OH6X0k+gQ9fRZcw6
 H82Hc0XRkBi3/Ian4zDbyFScoiJJwoiCDDF7flHFdruRLak1pSXbfKMHQzuqHhhZTJbGCfi
 k1CVKIE0UDwQT+t/1+PbpJhD50scUPo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 180163CC7EA
	for <ltp@archiver.kernel.org>; Sun,  1 Sep 2024 10:06:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 130FC3CC75A
 for <ltp@lists.linux.it>; Sun,  1 Sep 2024 10:06:06 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com;
 envelope-from=herbert@gondor.apana.org.au; receiver=lists.linux.it)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5A8B060227A
 for <ltp@lists.linux.it>; Sun,  1 Sep 2024 10:06:01 +0200 (CEST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
 by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
 id 1skfSB-008rgH-2v; Sun, 01 Sep 2024 16:05:42 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation);
 Sun, 01 Sep 2024 16:05:40 +0800
Date: Sun, 1 Sep 2024 16:05:40 +0800
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <ZtQgVOnK6WzdIDlU@gondor.apana.org.au>
References: <ZrbTUk6DyktnO7qk@gondor.apana.org.au>
 <202408161634.598311fd-oliver.sang@intel.com>
 <ZsBJs_C6GdO_qgV7@gondor.apana.org.au>
 <ZsBJ5H4JExArHGVw@gondor.apana.org.au>
 <ZsBKG0la0m69Dyq3@gondor.apana.org.au>
 <20240827184839.GD2049@sol.localdomain>
 <Zs6SiBOdasO9Thd1@gondor.apana.org.au>
 <20240830175154.GA48019@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240830175154.GA48019@sol.localdomain>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] crypto: api - Fix generic algorithm self-test races
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

On Fri, Aug 30, 2024 at 10:51:54AM -0700, Eric Biggers wrote:
>
> Given below in defconfig form, use 'make olddefconfig' to apply.  The failures
> are nondeterministic and sometimes there are different ones, for example:
> 
> [    0.358017] alg: skcipher: failed to allocate transform for cbc(twofish-generic): -2
> [    0.358365] alg: self-tests for cbc(twofish) using cbc(twofish-generic) failed (rc=-2)
> [    0.358535] alg: skcipher: failed to allocate transform for cbc(camellia-generic): -2
> [    0.358918] alg: self-tests for cbc(camellia) using cbc(camellia-generic) failed (rc=-2)
> [    0.371533] alg: skcipher: failed to allocate transform for xts(ecb(aes-generic)): -2
> [    0.371922] alg: self-tests for xts(aes) using xts(ecb(aes-generic)) failed (rc=-2)
> 
> Modules are not enabled, maybe that matters (I haven't checked yet).

Yes I think that was the key.  This triggers a massive self-test
run which executes in parallel and reveals a few race conditions
in the system.  I think it boils down to the following scenario:

Base algorithm X-generic, X-optimised
Template Y
Optimised algorithm Y-X-optimised

Everything gets registered, and then the self-tests are started.
When Y-X-optimised gets tested, it requests the creation of the
generic Y(X-generic).  Which then itself undergoes testing.

The race is that after Y(X-generic) gets registered, but just
before it gets tested, X-optimised finally finishes self-testing
which then causes all spawns of X-generic to be destroyed.  So
by the time the self-test for Y(X-generic) comes along, it can
no longer find the algorithm.  This error then bubbles up all
the way up to the self-test of Y-X-optimised which then fails.

Note that there is some complexity that I've omitted here because
when the generic self-test fails to find Y(X-generic) it actually
triggers the construction of it again which then fails for various
other reasons (these are not important because the construction
should *not* be triggered at this point).

So in a way the error is expected, and we should probably remove
the pr_err for the case where ENOENT is returned for the algorithm
that we're currently testing.

The solution is two-fold.  First when an algorithm undergoes
self-testing it should not trigger its construction.  Secondly
if an instance larval fails to materialise due to it being destroyed
by a more optimised algorithm coming along, it should obviously
retry the construction.

Remove the check in __crypto_alg_lookup that stops a larval from
matching new requests based on differences in the mask.  It is better
to block new requests even if it is wrong and then simply retry the
lookup.  If this ends up being the wrong larval it will sort iself
out during the retry.

Reduce the CRYPTO_ALG_TYPE_MASK bits in type during larval creation
as otherwise LSKCIPHER algorithms may not match SKCIPHER larvals.

Also block the instance creation during self-testing in the function
crypto_larval_lookup by checking for CRYPTO_ALG_TESTED in the mask
field.

Finally change the return value when crypto_alg_lookup fails in
crypto_larval_wait to EAGAIN to redo the lookup.

Fixes: 37da5d0ffa7b ("crypto: api - Do not wait for tests during registration")
Reported-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>

diff --git a/crypto/api.c b/crypto/api.c
index bbe29d438815..bfd177a4313a 100644
--- a/crypto/api.c
+++ b/crypto/api.c
@@ -70,11 +70,6 @@ static struct crypto_alg *__crypto_alg_lookup(const char *name, u32 type,
 		if ((q->cra_flags ^ type) & mask)
 			continue;
 
-		if (crypto_is_larval(q) &&
-		    !crypto_is_test_larval((struct crypto_larval *)q) &&
-		    ((struct crypto_larval *)q)->mask != mask)
-			continue;
-
 		exact = !strcmp(q->cra_driver_name, name);
 		fuzzy = !strcmp(q->cra_name, name);
 		if (!exact && !(fuzzy && q->cra_priority > best))
@@ -113,6 +108,8 @@ struct crypto_larval *crypto_larval_alloc(const char *name, u32 type, u32 mask)
 	if (!larval)
 		return ERR_PTR(-ENOMEM);
 
+	type &= ~CRYPTO_ALG_TYPE_MASK | (mask ?: CRYPTO_ALG_TYPE_MASK);
+
 	larval->mask = mask;
 	larval->alg.cra_flags = CRYPTO_ALG_LARVAL | type;
 	larval->alg.cra_priority = -1;
@@ -229,7 +226,7 @@ static struct crypto_alg *crypto_larval_wait(struct crypto_alg *alg)
 		type = alg->cra_flags & ~(CRYPTO_ALG_LARVAL | CRYPTO_ALG_DEAD);
 		mask = larval->mask;
 		alg = crypto_alg_lookup(alg->cra_name, type, mask) ?:
-		      ERR_PTR(-ENOENT);
+		      ERR_PTR(-EAGAIN);
 	} else if (IS_ERR(alg))
 		;
 	else if (crypto_is_test_larval(larval) &&
@@ -308,8 +305,12 @@ static struct crypto_alg *crypto_larval_lookup(const char *name, u32 type,
 
 	if (!IS_ERR_OR_NULL(alg) && crypto_is_larval(alg))
 		alg = crypto_larval_wait(alg);
-	else if (!alg)
+	else if (alg)
+		;
+	else if (!(mask & CRYPTO_ALG_TESTED))
 		alg = crypto_larval_add(name, type, mask);
+	else
+		alg = ERR_PTR(-ENOENT);
 
 	return alg;
 }
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
