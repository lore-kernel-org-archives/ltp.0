Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C59AC433F5
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 05:29:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D7313C93D4
	for <ltp@archiver.kernel.org>; Tue, 11 Jan 2022 06:29:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65AD53C0F6A
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 06:29:14 +0100 (CET)
Received: from fornost.hmeau.com (helcar.hmeau.com [216.24.177.18])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9B432600C7D
 for <ltp@lists.linux.it>; Tue, 11 Jan 2022 06:29:08 +0100 (CET)
Received: from gwarestrin.arnor.me.apana.org.au ([192.168.103.7])
 by fornost.hmeau.com with smtp (Exim 4.92 #5 (Debian))
 id 1n79iO-0007BS-Kc; Tue, 11 Jan 2022 16:29:01 +1100
Received: by gwarestrin.arnor.me.apana.org.au (sSMTP sendmail emulation);
 Tue, 11 Jan 2022 16:29:00 +1100
Date: Tue, 11 Jan 2022 16:29:00 +1100
From: Herbert Xu <herbert@gondor.apana.org.au>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yd0VnFwxahO0fXjc@gondor.apana.org.au>
References: <20211220212756.13510-1-pvorel@suse.cz>
 <YdQ1hg+12qGbzfr6@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YdQ1hg+12qGbzfr6@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] tst_af_alg: Another fix for disabled weak
 cipher
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

On Tue, Jan 04, 2022 at 12:54:46PM +0100, Petr Vorel wrote:
> Hi all,
> 
> [Cc Herbert and Eric ]
> 
> FYI Herbert's view for using ELIBBAD instead of ENOENT (reply to Eric's question
> whether using ELIBBAD in kernel is a good approach or bug) [1]:
> 
> "For the purpose of identifying FIPS-disabled algorithm (as opposed
> to an algorithm that's not enabled in the kernel at all), I think
> it is perfectly safe to use ELIBBAD instead of ENOENT in user-space."
> 
> I suppose that's justify my proposed changes (i.e. testing also ELIBBAD when
> fips enabled).
> 
> @Herbert if you care, you can post your Acked-by: tag.

Please hold the horses on this patch.

I'm about to post a series of patches that aims to disable algorithms
such as sha1 in FIPS mode while still allowing compound algorithms such
as hmac(sha1) to work.

As a result of this series, ENOENT will again be returned for FIPS-
disallowed algorithms when in FIPS mode.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
