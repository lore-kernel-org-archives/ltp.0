Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF90ECF9C6B
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 22:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727216945; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=EGxPMkcIa6Cz73KT5ICeqKvRAadJWmtePjo+SLbmJ5Y=;
 b=nb7sTz5n9GOC8kzJB9EeokOaJYxwSBts6CasjnaeBKGvdjgAKn5fw8FES4P9MprBjLUIH
 P6DWPvHrPUrqTvcsN/SlYF94/E8zN84C/NaMsrHo3OdWcz08cpUwwHxpqVf9XqUsejFcTOx
 +ZFokMdXQjGFmOvXd/eP+9DuaSPsLqI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 210973C4CC0
	for <ltp@archiver.kernel.org>; Wed, 25 Sep 2024 00:29:05 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 130C13C2FF5
 for <ltp@lists.linux.it>; Wed, 25 Sep 2024 00:28:43 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=147.75.193.91; helo=nyc.source.kernel.org;
 envelope-from=ebiggers@kernel.org; receiver=lists.linux.it)
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3BA1B1A02390
 for <ltp@lists.linux.it>; Wed, 25 Sep 2024 00:28:42 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 29DC7A4393C;
 Tue, 24 Sep 2024 22:28:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF30C4CEC4;
 Tue, 24 Sep 2024 22:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1727216920;
 bh=GsVkTtyX/rc3JJKceprQUMQw10UNBAbWAkdmH00ea+Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Nkyw7TgUrMk8k6+AAj4dlvo0Wf6I9ClSsmADp20hCwN5zP6jyECmqYdCVAyE+yBvP
 C+szEw6AKUep9mgcNK4F6TAO1/Zq3OA0ZOBBwnP8Z1puOiiiFduOHRME8495UOR3pM
 EaYiogikueTz2QTg3pL6NLk8Stcqhpg6XDfCi+kH5g951Fnb4oufus6d8/LVjMKzt2
 IW7ELaKsWCwCW2aKtvKJeyVZubRIJqbnoO3+2jypZzqfrpStw2NDzNkJuQl9Z10h4O
 OqmeRNWk5rpcl3RhsSZ/9RtU6qqRceCwp+egpt42f2Y14AH24xENro7vTO7oqmTEei
 2Aswcn+zHAgYQ==
Date: Tue, 24 Sep 2024 15:28:39 -0700
To: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20240924222839.GC1585@sol.localdomain>
References: <CA+G9fYtu-h_pp_hNfmx1pBg48oGeRiEDnEc4b-r3AiC_QfWiKg@mail.gmail.com>
 <ZvK-_5QKQ2e0S2Sd@gondor.apana.org.au>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZvK-_5QKQ2e0S2Sd@gondor.apana.org.au>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] af_alg01.c:36: TFAIL: instantiated nested hmac algorithm
 ('hmac(hmac(md5))')!
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
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Sep 24, 2024 at 09:30:39PM +0800, Herbert Xu wrote:
> On Tue, Sep 24, 2024 at 03:16:09PM +0530, Naresh Kamboju wrote:
> >
> > Warning log:
> > ----------
> > tst_test.c:1617: TINFO: Timeout per run is 0h 02m 30s
> > af_alg01.c:36: TFAIL: instantiated nested hmac algorithm ('hmac(hmac(md5))')!
> > tst_af_alg.c:46: TBROK: unexpected error binding AF_ALG socket to hash
> > algorithm 'hmac(hmac(md5))': EINVAL (22)
> 
> This is expected.  You need to fix the test to not treat this as an
> error.
> 

So the error code changed from ENOENT to EINVAL.  These particular LTP tests
(af_alg01 and af_alg03) could check for either ENOENT or EINVAL, and it would
preserve the main point of the tests.

I do feel that the previous error code, ENOENT, was more logical though.  From
userspace's perspective, these invalid algorithms don't exist and don't need to
be treated any different from other algorithms that don't exist.

Has it been checked what else in userspace might need to be updated as a result
of this change?

Looking at libkcapi for example
(https://github.com/smuellerDD/libkcapi/blob/master/lib/kcapi.h#L125) it passes
the error code up and documents it as part of its API:

     * @return 0 upon success;
     *         -ENOENT - algorithm not available;
     *         -EOPNOTSUPP - AF_ALG family not available;
     *         -EINVAL - accept syscall failed
     *         -ENOMEM - cipher handle cannot be allocated
     */
    int kcapi_cipher_init(struct kcapi_handle **handle, const char *ciphername,
                          uint32_t flags);

So that is now wrong, as "algorithm not available" can now be either ENOENT or
EINVAL.

I don't really see the reason for this churn.  The kernel commit which made this
change (795f85fca229) provides no explanation either.

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
