Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68508CF9C6F
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 13:31:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1727184675; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=1zRaJdjJYTWQ6HelZSaOGg8fXRhOfmqc/u0JVAdGk0o=;
 b=KPLKxdnhjAuSJw6+idjTUbnl310x2CTk5Kuy34zB8/PMWc2Jo5rC3Jd57ixbJaicDmsQY
 CPj38E7loEhrqBpLnC1MJbgHnPXNflTNyB/k0Qoq9J1ukM1T/JJ2Tkt5/gQEic5vLPi/QiX
 3B0lh98C4LDifqMTxdLhwGweH0bUu20=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E33E93C4CC3
	for <ltp@archiver.kernel.org>; Tue, 24 Sep 2024 15:31:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BC7B3C30BB
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 15:30:52 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gondor.apana.org.au (client-ip=144.6.53.87; helo=abb.hmeau.com;
 envelope-from=herbert@gondor.apana.org.au; receiver=lists.linux.it)
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9A00D2009E1
 for <ltp@lists.linux.it>; Tue, 24 Sep 2024 15:30:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=hmeau.com; 
 s=formenos;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qzNhgBZN/5wjd+yDm2cjASGFuH1G1TFsEgliMH/h3wU=; b=owxnGKyhYfbroz8DQpbpVmxOAt
 4QLOvDuzLQb8mPz3b/Nb5EanhpCGdMmRAxe2gcMmz/W6Iq9xjuECbQ96XqColG6HKP3Yvtarbxqgs
 L2Nxtskf93tfN4LHu+VADYNTIpQl6Jb8x66i97rfYVDVhicU3xkVBYRq+rop2eHxJ0QMjMrEL7iaz
 tFxgWMabaj82s5PfocyURJWsPADk4Egn0qHd/vqO8h5GfP5fBCEpFsQ6bF+dCvORZxWmD0bii+wIL
 0buwVkLe4X6D8rxlA2vs2k5RFy/ObHpY9+B+r3MAWKsE3N96XGhp17kYQnBqJKtF5WyLIRB6wO4S8
 5ur7MyUQ==;
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
 by formenos.hmeau.com with smtp (Exim 4.96 #2 (Debian))
 id 1st5Sr-004LDo-2R; Tue, 24 Sep 2024 21:30:40 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation);
 Tue, 24 Sep 2024 21:30:39 +0800
Date: Tue, 24 Sep 2024 21:30:39 +0800
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Message-ID: <ZvK-_5QKQ2e0S2Sd@gondor.apana.org.au>
References: <CA+G9fYtu-h_pp_hNfmx1pBg48oGeRiEDnEc4b-r3AiC_QfWiKg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYtu-h_pp_hNfmx1pBg48oGeRiEDnEc4b-r3AiC_QfWiKg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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
From: Herbert Xu via ltp <ltp@lists.linux.it>
Reply-To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>, LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Sep 24, 2024 at 03:16:09PM +0530, Naresh Kamboju wrote:
>
> Warning log:
> ----------
> tst_test.c:1617: TINFO: Timeout per run is 0h 02m 30s
> af_alg01.c:36: TFAIL: instantiated nested hmac algorithm ('hmac(hmac(md5))')!
> tst_af_alg.c:46: TBROK: unexpected error binding AF_ALG socket to hash
> algorithm 'hmac(hmac(md5))': EINVAL (22)

This is expected.  You need to fix the test to not treat this as an
error.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
