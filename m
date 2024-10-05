Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D5ACFB43C
	for <ltp@archiver.kernel.org>; Sat,  5 Oct 2024 22:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1728167114; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=daE9hz+4JR5XN8xoQf/ePWqULne2pyOdLQ82lNzVSjI=;
 b=dkF7jMk3gTqZaNop2MOuYr2rvA5T1lzfuXX2uFimeLKHuf4qDCSQMB2ZD+9kcSAIgNYbg
 DLwWbVfPbOCPWHcLISAGMZHkH2GYw+j8eL6ZotG+TErDC61G88WjX6Axp3JaDbqzfDvjz5O
 WCWLJQKt7GriJ4Zvu8PlbjgLpkElS6M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA63E3C62E5
	for <ltp@archiver.kernel.org>; Sun,  6 Oct 2024 00:25:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B5193C5576
 for <ltp@lists.linux.it>; Sun,  6 Oct 2024 00:24:53 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=lists.linux.it)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 71D9B600F3D
 for <ltp@lists.linux.it>; Sun,  6 Oct 2024 00:24:51 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 1192AA4057D;
 Sat,  5 Oct 2024 22:24:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D771FC4CEC2;
 Sat,  5 Oct 2024 22:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1728167090;
 bh=kDmOTkqU+mtVkWcFBrBhjsbbyJJ+k0EDqKHVsSe00Z4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=aNOjKEd0ftkO7XKY14bg37V5n1UpAE8kDoj5j+qcNNpNH94kmzYspk/xJ/JYR9rTc
 rC0TsOFHzXxHRpZ5V110XY5WXBagQOB3/Qs8ZzImdS2rom/3+GSXrdMebdLLsQXL2U
 uYJu9vmKb1rKwP9+CKJ3x4Kz6QxN+AsAaVFYT2+hUsb8THzfp+PeUDQFNPqaIOwvif
 Cjea6LInvPRRFIyVlFtwXjV40dTgS2ZcEfwqvI+a7p+XEqFhyStP2ZI7ZyOW59GVc6
 a82C8FWbUm9PHd+4RpRSLe0cSWK6QDCV/eQmgqoVyRxz358Gq3QzTjGMKQUa90ZqUy
 eOOdbUDhFe9eQ==
Date: Sat, 5 Oct 2024 15:24:48 -0700
To: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20241005222448.GB10813@sol.localdomain>
References: <202408161634.598311fd-oliver.sang@intel.com>
 <ZsBJs_C6GdO_qgV7@gondor.apana.org.au>
 <ZsBJ5H4JExArHGVw@gondor.apana.org.au>
 <ZsBKG0la0m69Dyq3@gondor.apana.org.au>
 <20240827184839.GD2049@sol.localdomain>
 <Zs6SiBOdasO9Thd1@gondor.apana.org.au>
 <20240830175154.GA48019@sol.localdomain>
 <ZtQgVOnK6WzdIDlU@gondor.apana.org.au>
 <20240902170554.GA77251@sol.localdomain>
 <ZtZFOgh3WylktM1E@gondor.apana.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZtZFOgh3WylktM1E@gondor.apana.org.au>
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

On Tue, Sep 03, 2024 at 07:07:38AM +0800, Herbert Xu wrote:
> On Mon, Sep 02, 2024 at 10:05:54AM -0700, Eric Biggers wrote:
> >
> > With both this patch "crypto: api - Fix generic algorithm self-test races" and
> > your other patch "crypto: algboss - Pass instance creation error up" applied,
> > I'm still getting errors occasionally, e.g.:
> > 
> >     [    5.155587] alg: skcipher: failed to allocate transform for cbc(sm4-generic): -2
> >     [    5.155954] alg: self-tests for cbc(sm4) using cbc(sm4-generic) failed (rc=-2)
> >     [    5.372511] alg: aead: failed to allocate transform for gcm_base(ctr(aes-generic),ghash-generic): -2
> >     [    5.372861] alg: self-tests for gcm(aes) using gcm_base(ctr(aes-generic),ghash-generic) failed (rc=-2)
> > 
> > I can't follow your explanation of what is going on here and what the fix is.
> > Would it make any sense to just revert the commits that introduced this problem?
> 
> As I said earlier, these errors are expected.  What's happening
> is this:
> 
> __ecb-sm4-aesni-avx gets registered (but not tested)
> 
> cbc(sm4-generic) gets registered (but not tested)
> 
> __ecb-sm4-aesni-avx finishes testing
> 	with lskcipher this is equivalent to crypto_cipher sm4
> 	so it triggers the destruction of all instances of sm4
> 
> cbc(sm4-generic) gets marked as dead
> 
> cbc(sm4-generic) fails self-test because it's already dead (ENOENT)
> 
> It's harmless because whatever that is asking for cbc(sm4-generic)
> (in this case it's the extra-test mechanism) will simply retry the
> allocation which will then succeed.
> 
> I will send a patch to disable the warning when allocating X returns
> ENOENT while we're testing X itself.  This can always happen if X
> gets killed for the reason mentioned above and it's perfectly harmless.
> 
> It's just that the race window was tiny previously because testing
> occurred immediately after registration.  But now we've magnified
> that window many times with asynchronous testing.
> 

The tests are still failing on upstream:

[    0.343845] alg: self-tests for rfc4106(gcm(aes)) using rfc4106(gcm_base(ctr(aes-generic),ghash-generic)) failed (rc=-2)

To me it still seems like commit 37da5d0ffa7b ("crypto: api - Do not wait for
tests during registration") is just broken and should be reverted.

Besides the test failures, it looks like there's no longer any guarantee that
algorithms are actually available now that their module is loaded.

E.g. consider if someone does 'modprobe aesni-intel' and then immediately
creates a dm-crypt device.  Now it sounds like the AES-NI algorithms might not
have finished being tested yet and the generic algorithms can be used instead,
resulting in a performance regression.

I understand that you want to try to fix the edge cases in "fallback" ciphers.
But "fallback" ciphers have always seemed like a bad design due to how they use
the crypto API recursively.  I think the algorithms that use them should
generally be migrated off of them, e.g. as I did in commit f235bc11cc95
("crypto: arm/aes-neonbs - go back to using aes-arm directly").  That fixed the
problem in aes-neonbs that seems to have triggered this work in the first place.

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
