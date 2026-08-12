Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288FEC5AD5A
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 20:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786567074; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=zoKjJuOK2ZqHEQ1DaoQZ8UtCTZF0OOco7sA3pM2Idzk=;
 b=C2YaKVLjTb7v09kmJkMC5faPo1wauNTGUUph+NcXyOy/VY5ahNY1SQ1ND1k0AeFS7AoGJ
 fHaoTDFPZ4xpQDe2uBj2330Ri8+pG8mIH2Ou91Mj7QQoprFfWEx03e+4P0LehCoCDS+mwEa
 4uOE/0iVInvzeaFvqjl1qsdKSWyz43w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7F9D3E7438
	for <ltp@archiver.kernel.org>; Wed, 12 Aug 2026 22:37:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9F2D43D0E74
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 22:37:35 +0200 (CEST)
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com
 [IPv6:2607:f8b0:4864:20::1035])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0051D60043A
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 22:37:32 +0200 (CEST)
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-383cb94f742so56068a91.3
 for <ltp@lists.linux.it>; Wed, 12 Aug 2026 13:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786567051; x=1787171851; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=noLBA5GZ6qPfpsuRzzZTU92jlB4Ei0KVQ7fRLFA7Ec4=;
 b=suj3vhbCQvnqlR+Vr/unuzrbl/bBeZeI8i7FzlHvBR6r7RL0ei5Jvu+/lWOPZu7Pk5
 xLmacf6zE6I4NncmKmS5fYfEBJDqaQTg0TBgR2qOpXY037fokdtz1JLO89am5taZcSi6
 1iCBdfQZoh13A4ApPk5XMOPPXML3dnW+3A7o6dQQZwSOYhkbwuB2FN98n/GY1pAoi+se
 Wnn/yNE94p331HxMdf3qSRaYPTFsKITvHYBrW+jvxsNa5h0J7IA2iAsIO1zyK1F9YLzp
 wXaEUpkaWB7PFrEbuRRQeVNbRo9NvFrNehysxbbUY8+PJi099gvXU4JAoEnXChjdtsjb
 sxuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786567051; x=1787171851;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=noLBA5GZ6qPfpsuRzzZTU92jlB4Ei0KVQ7fRLFA7Ec4=;
 b=rpQqI1pbxGlht/IqMDe38gK1Ro8W7DWmKwRhvql5TzrrAwKFcsDDWN4dITWcv+v6Bm
 aFM3MgvxuLJslal6KZsYueRJD4evIYH4RoFMOTlJ4ubjs/HzmCL9L1u3B2Ja264vlGPN
 Qp0Vu7QlYNXDGriuDI7CS6lVCtG4K6qvV5fpXi3o2QxIPxOi/Qyi/M3nRquaxPQhHbcM
 SWxpVX6T0aeaxPUGfUlq6ROHLBRA7I0RIhRjpkGpYr70m/FejvVm+QLi7VHSp0huCa2f
 NAHXli9CRuVww0ES7BbgryBmIAIdaGWYMsxYJR1nsYphLccXIVMfPxGqE86GZBvF75jz
 z15Q==
X-Gm-Message-State: AOJu0Yw8SM/chR50msFDqTM5SHIMxDdhiIuCHmuO5tHfB/XqaQNflmkw
 BmNhsr5wSed/N9IHNJ4OG0KdwdYIKPu+9xc7zlV2F69KTYoPUPEUXThuhEvtsscHa+ClH93XZyx
 OaZDoCQ==
X-Gm-Gg: AR+sD12T7ol6Nwx2kBV3FkHQ680Y+FWc7BVaFALlOC/G+I0FB5ecy80SkrWLXyzPvfd
 YEpAqUzPJ0bADqlE0wM0CEO/jA2iZShW7Mod0rR64JbiLJBGMPLqTXnA1b1nmbGyoTyZjvnrwU6
 yIAJWqQACz2ulE8H0NH50T5RzAeHO+qorr4hLCpaZh5MaE+ldi7nHrtSdkRXiLmc+BzWorwERW+
 ZcUFdwvBfuofojBB2fBR/9Lebsh8zaC23OvM2ziEHnlEcJRp7TZzi28YXT1P0aH5EVQVbQdWJ+o
 pgG16O6bvbvlPNIDGhk86Bnqn0joca6leGB3ll0aOffJ4uwmwYwPmB0JEU3H88vj9vgA7x5gIYC
 ReqzvVYqEjIPXzJU5bnkf+pmltf3A2gJtVbSlfoz5x3ltCPmkd9U52ggrEQ6K0GyMS5vNTPVBKO
 bkXxMOvVPTY4C6IZ5+MTD+cp7++5aiDMnRq5rzErFSl7C2YYtv6LzaEw/u24tPQV7abIx+vxckq
 qgRuofWNB+7DX/kDZe6fupYdGSrCCWkGul0baI35g==
X-Received: by 2002:a17:90a:d88b:b0:38e:75f3:ad4d with SMTP id
 98e67ed59e1d1-3931e0568a9mr1063397a91.7.1786567050734; 
 Wed, 12 Aug 2026 13:37:30 -0700 (PDT)
Received: from google.com (131.109.125.34.bc.googleusercontent.com.
 [34.125.109.131]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3931cce323fsm775036a91.3.2026.08.12.13.37.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 13:37:30 -0700 (PDT)
Date: Wed, 12 Aug 2026 20:37:26 +0000
To: Frank Ranner <frank.ranner@intel.com>
Message-ID: <20260812203726.GB3734410@google.com>
References: <20260812112737.2222475-1-frank.ranner@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260812112737.2222475-1-frank.ranner@intel.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH ltp] testcases/kernel/crypto/crypto_user02.c: try
 non-generic hmac names first
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
Reply-To: Eric Biggers <ebiggers@google.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Aug 12, 2026 at 01:27:37PM +0200, Frank Ranner wrote:
> Probe plain hmac(<hash>) driver names before the legacy *-generic
> variants when selecting a viable algorithm for crypto_user02.
> 
> Newer kernels commonly expose non-generic algorithm names while
> no longer registering the *-generic aliases, which made the current
> candidate list fall through to TCONF even when usable algorithms
> were present.
> 
> Keeping both forms preserves compatibility with older kernels while
> avoiding kernel-version checks in the testcase logic.
> 
> Signed-off-by: Frank Ranner <frank.ranner@intel.com>
> ---
>  testcases/kernel/crypto/crypto_user02.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/testcases/kernel/crypto/crypto_user02.c b/testcases/kernel/crypto/crypto_user02.c
> index 88ae800aa..c08d35c84 100644
> --- a/testcases/kernel/crypto/crypto_user02.c
> +++ b/testcases/kernel/crypto/crypto_user02.c
> @@ -35,6 +35,20 @@
>   * The first algorithm, that fullfils the criteria is used for the test.
>   */
>  static const char * const ALGORITHM_CANDIDATES[] = {
> +	"hmac(sha1)",
> +	"hmac(sha224)",
> +	"hmac(sha256)",
> +	"hmac(sha384)",
> +	"hmac(md5)",
> +	"hmac(sm3)",
> +	"hmac(sha512)",
> +	"hmac(rmd160)",
> +	"hmac(sha3-224)",
> +	"hmac(sha3-256)",
> +	"hmac(sha3-384)",
> +	"hmac(sha3-512)",
> +	"hmac(streebog256)",
> +	"hmac(streebog512)",
>  	"hmac(sha1-generic)",
>  	"hmac(sha224-generic)",
>  	"hmac(sha256-generic)",

This kind of defeats the point of the test, as the hmac template will no
longer be tested; the kernel now implements the stable names
"hmac(sha1)", "hmac(sha256)", etc. directly without the fragile template
system.  The test is specifically checking for a crash when deleting a
template instance.  I guess use the new driver names generated by the
template to force its use: "hmac(sha1-lib)", "hmac(sha256-lib)", etc.  

Not like this UAPI has any point in the first place.  But as long as
this test still exists and is trying to test for this historical bug, we
might as well preserve the intent.

(It's also strange that so many algorithms are listed, when just one
actually ends up being used.  But that is a separate issue.)

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
