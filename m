Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2389C433EF
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 15:04:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 78F343C9253
	for <ltp@archiver.kernel.org>; Wed,  5 Jan 2022 16:04:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3DCDE3C58DA
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 16:04:13 +0100 (CET)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 90E181A00914
 for <ltp@lists.linux.it>; Wed,  5 Jan 2022 16:04:11 +0100 (CET)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 8828361760;
 Wed,  5 Jan 2022 15:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92FAC36AE0;
 Wed,  5 Jan 2022 15:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641395049;
 bh=XiMH38rA3kPJxyJmsHYUVOqRMb5aKgbJThm8oUTAopk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HVE103dyABhXd79MOkaD5DjKDi2wLo0nG3GLNrdcZRuOJzgxz1vCsCzUJfwHSIzOc
 plk3IrjiTTYN0gvkupWVxg12K+fJ1XfyimP/PdsWy8bhI8EaoUZi127GoNdhFU/u48
 g9+SSVGgqaGizyq8IKdFHYrl33hWkkm5NXNtyu3LUV2VDuo4BvG2h0595uC8Pb5jB5
 YZSxdp6CXtICdhTE8vfXOu4DX3YzjQdglDdezZiYxfDfv8p+Ds7EFhtoAYjpJDHTVe
 /Uip9fNWQAkfuc70Pt2QXxmYycWbCuIGQfXlb8OpsixWktWkYy2roCxCoZhSwz73qF
 9UJHCskh86t3A==
Date: Wed, 5 Jan 2022 07:04:07 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <YdWzZzzOqpS2pN+3@sol.localdomain>
References: <20211222192604.16839-1-pvorel@suse.cz>
 <20211222192604.16839-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211222192604.16839-2-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] tst_af_alg: TCONF on ciphers disabled by
 FIPS
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

On Wed, Dec 22, 2021 at 08:26:04PM +0100, Petr Vorel wrote:
> Similar fix to 4fa302ef9d. It fixes:
> 
> ./af_alg01
> tst_af_alg.c:84: TBROK: unexpected error binding AF_ALG socket to hash algorithm 'md5': ELIBBAD (80)
> become
> tst_fips.c:22: TINFO: FIPS: on
> tst_af_alg.c:111: TCONF: FIPS enabled => hash algorithm 'md5' disabled
> tst_fips.c:22: TINFO: FIPS: on
> tst_af_alg.c:111: TCONF: FIPS enabled => hash algorithm 'md5-generic' disabled
> 
> ./af_alg02
> tst_af_alg.c:37: TBROK: unexpected error binding AF_ALG socket to skcipher algorithm 'salsa20': ELIBBAD (80)
> become
> tst_fips.c:22: TINFO: FIPS: on
> tst_af_alg.c:36: TCONF: FIPS enabled => skcipher algorithm 'salsa20' disabled
> 
> ./af_alg04
> tst_af_alg.c:81: TBROK: unexpected error binding AF_ALG socket to hash algorithm 'vmac64(aes)': ELIBBAD (80)
> become
> tst_fips.c:22: TINFO: FIPS: on
> tst_af_alg.c:111: TCONF: FIPS enabled => hash algorithm 'vmac64(aes)' disabled
> 
> Tested on Debian stable bullseye and SLES 15-SP4.
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> NOTE: I asked Herbert Xu for confirmation that my code understanding is
> correct and ELIBBAD is expected for ciphers disabled by FIPS.

Can you link to the mailing list thread where it was established that ELIBBAD is
the "expected" behavior?  Otherwise I guess this is fine.

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
