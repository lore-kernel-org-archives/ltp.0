Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEF72C433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 18:41:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D3953C9481
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 19:41:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB1333C051B
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 19:40:51 +0100 (CET)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EEE761401335
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 19:40:50 +0100 (CET)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id EFC1FB81CB5;
 Tue, 11 Jan 2022 18:40:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B169BC36AE3;
 Tue, 11 Jan 2022 18:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641926447;
 bh=tA4nPjvJ0/M8zSBEYPhi5Zss2z6FpfI0c7LDe8na1vY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=a994p6IGviw0hLp0KxREpEAI/KJooOOa0Uf3ooViJ49BKqpS3e9hHIpjZ66Ue1pLi
 LaTLYvd+2UY2X0ewfEwtqrFYdxgvywA+P3qwih9pAjlfUP2eDgGzymW+VR34OiWiGU
 /ydLO6F38gkJMCT2seLq5PGTlvPc+cgaWqZb6xVdjb/mHU18iOod2lF93f3fndqbXa
 9WJECVtKwhgZseyYKWw/P+cT09Mldjv9HEMgqQ/apI2vCo8o1Fc2OD3e4nem88JRdh
 QNcpw181Q88Ko7xdFAWTVFszrgHhUgDVnuUmYlLrWzldhw43+aaSD8JhcIT+edg5jb
 WuN7s0fU4buDg==
Date: Tue, 11 Jan 2022 10:40:46 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: wenyehai <wenyehai@huawei.com>
Message-ID: <Yd3PLiA9n75u6an3@sol.localdomain>
References: <1641886599-246423-1-git-send-email-wenyehai@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1641886599-246423-1-git-send-email-wenyehai@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] add several hash algorithms for
 crypto/crypto_user02.c
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Jan 11, 2022 at 03:36:39PM +0800, wenyehai via ltp wrote:
> crypto/crypto_user02.c: In some cases, only a certain algorithm is
> supported(e.g. only enable sha3 algorithm). In order to make crypto_user02 to run in more
> cases, we compare with the latest linux kernel crypto/tcrypt.c, add
> several hash algorithms which not list in crypto_user02(just list
> possible algorithms, but not exhaustive).
> 
> Signed-off-by: Yehai Wen <wenyehai@huawei.com>
> ---
> v1->v2: add commit message to introduce why to modify crypto_user02
>  testcases/kernel/crypto/crypto_user02.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
