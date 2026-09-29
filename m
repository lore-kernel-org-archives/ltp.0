Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D844C9832A
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 07:06:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A65453E27BD
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 09:06:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D96423E201E
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 09:06:10 +0200 (CEST)
Received: from mail-qv2-x0b.google.com (mail-qv2-x0b.google.com
 [IPv6:2607:f8b0:4864:33::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8A4D81400523
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 09:06:10 +0200 (CEST)
Received: by mail-qv2-x0b.google.com with SMTP id
 6a1803df08f44-91457cc5b47so10948016d6.1
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 00:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790665569; x=1791270369; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K8X6KS3N2OUje72VjnD1Kx+0LCJTyJIqz6qw4ADDpiY=;
 b=lsEvk5/f0PmTxnMt8CbuKftr1fdTarkXrwo8sCLGao2v6kCmnP4PvJPrbJBMGxHslF
 sysWMNHRVQvlOf6svkXVNEV2vtBf0/GtlnLkPC0kAm+RYr+rFh318u7ytGPl20BrUFUW
 omk314dCzkzkONYOdfMiSx0SJ/DeyA2rUankhQa1ZzpM+TGFoxEyxP0AJIAddjK35Zv5
 dE4wDU6KUD62EnrNnk8r1dY4jVZgEal3iC1zHM3qXFRq8Is1FijCFTjvYTPY/AMyDs4e
 LH3Gt8hTtdgglreIhbKmdQXpxUENYONtHHAKTy91L7Y1PPLIKK94Z17XCLJ/sJ8XNQYd
 LTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790665569; x=1791270369;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=K8X6KS3N2OUje72VjnD1Kx+0LCJTyJIqz6qw4ADDpiY=;
 b=jhEHXnrUtSv7T3draFMfbBVtJulw+99K/R7dSHNk1Xw+I6s1jszPSVQyVwo2rTn/5N
 ziYYBCCVWG32eSZq8EKau3P74Kw5orIe3eIvGIbNa6RK+HPKzYT9UcPbC5oWg7Umsl3U
 GHUw6OIbJxESMVKmpU9M9nOr3AzEGC8XDF3ev9fIVcG0SzgRvKKBdpoXd9RC7+sFhE4I
 RK+y9c1rUL4bGWiDywkxDUynpFqmbgwCBejNj1Qxmt9dTn8Lx9e5MwaIzVfHBZj1hiNm
 nwvX1jJIv1ExawxfepINtx1Djjr8AE+m2I1FTWnKIPNn4SaesUT2nTzfgpfTN7ZtIFxo
 8L/g==
X-Gm-Message-State: AFuF++mPiVNohwa4njvq/nga7Ehkl+giRX7TgBspG+ooGcLgl1vKD1tR
 sjw4+rknKKQXvCOKV8TTtzVBXJRe8E3OXy1v/SQ6vE2tXcKhx+cxpUuN
X-Gm-Gg: AYBFou0u4VNP+zipXmIEk5DIIgmGPtbXJesZR0bQIOw39jGE1s3rXMwsuNLOfaOzEfo
 OmdY5EEQFUtWegFnvDGjMu73pEAXOV8pwtp0JGYgX7VcEt6pzhxTCobGe39EVHr8w0oxM59TIn1
 H1QW2lHSuIWEh8yX37MOrIqRyew68tfIOJCM1v39I4tvTjZerM8+55dvQdudfl3qCSU6bR8LjU3
 yDx+1YvgQyXDXXOpohN8kfoYvGvNxZu9N2Olnv5GUmGFDioNdidzUI6yJ4pQjU3B3K4mFK6/dYA
 KDLieQhy3EEGQ3KYT3zQdtM4jYOpkVt01NxsgXo8CWerzvpSr4Y6TI4rgIYHW6X+4r0jWTt1T1k
 fmorZjhK19CqBo75wMLQgnGdmfEI6Jg3gcFGvQJnASGOpV6ixPwOcrNRfGxtzk1S14KzlhNXwoy
 GPXBrzBHgwqR11EZeBZeULeBH6oQAmM2ATywiuRRF9TfcdPlMG4a+AiJ39hn35LL65CtRovcVOa
 piePz3egvJmn9Zo3dr1t87ECQOgSLcx5niDU5cSjU8O0GWdZeuYmwRWPcw7Gmpm0EM4AlBHVbgk
 oqi9Qd8HJqKiIi+ayGDWd3g=
X-Received: by 2002:a05:6214:4689:b0:910:388e:9c8b with SMTP id
 6a1803df08f44-9142f8da6d2mr264989776d6.27.1790665569016; 
 Tue, 29 Sep 2026 00:06:09 -0700 (PDT)
Received: from
 runnervmtr4k5.blqkew0h0opulhxsuh3beiplya.bx.internal.cloudapp.net
 ([48.217.177.229]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9178d3726b6sm4030986d6.39.2026.09.29.00.06.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 00:06:08 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Tue, 29 Sep 2026 07:06:08 +0000
Message-ID: <20260929070608.9045-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260926204459.20699-2-sebastianchlad@gmail.com>
References: <20260926204459.20699-2-sebastianchlad@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] memcg/memcontrol0[34]: Use expected values from the
 protection model
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

Hi Sebastian,

On Sat, 26 Sep 2026 22:44:53 +0200, Sebastian Chlad wrote:
> memcg/memcontrol0[34]: Use expected values from the protection model

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
