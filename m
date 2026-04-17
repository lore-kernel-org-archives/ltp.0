Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAA9F8E4BC
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 07:56:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EEAD63E262A
	for <ltp@archiver.kernel.org>; Fri, 17 Apr 2026 09:56:00 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED42A3CC8C5
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 09:55:41 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 69E321000A82
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 09:55:41 +0200 (CEST)
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-506a6cf8242so3442701cf.1
 for <ltp@lists.linux.it>; Fri, 17 Apr 2026 00:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776412540; x=1777017340; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qziBpt43Hkw6fUOpLvN8ORDl40mDuSxWcfD/5unEWOI=;
 b=HRzkXm42ArCGUNuXyWCA7UvWrcjZjnOvwXPMay1G0ptAfQyUMmIupoZ5CioojxFAS9
 UL9bh9+eHFwgSWTZp1r9ZdoaNxizsL/4h1Y3d2KIAnHPtVQQr/Agn4L9pkvZpXHH4jkA
 riqdPyIQwkotG2R9+m8Ct0UsEvJs+fkmUBzoBATxqXI0HCj0vAYFP/sej0k4bJS8wt9K
 rNBZQqbI1KZZJ16IHFto9rpMI5JQ6+f2X9OKFkDDEtweE6Z1d1LJ8mae7JN5wtxI+3Ar
 Pg+8LaRaHYQbJGw2bf04M5QrGKvVVt/os3lWzEx8QJMAhPPiyypjFSdsSunDZKQ/wbsb
 UwgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776412540; x=1777017340;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qziBpt43Hkw6fUOpLvN8ORDl40mDuSxWcfD/5unEWOI=;
 b=ikCS+4mBS22XV597R1P60Y26cMNdMhdNfzwiKqs84GHcuVWG9vPbRUNtk0eoTGkRhJ
 Zn/PjqKt03FFInXHT/5BKiYiY77Ydn4+6BQOnzwhZ4FncEeLWD5YFTk51fTiOfchz3vC
 zU+EECTHcuJzpFFiZdtUqX0PkTt18SduL2XCPh1CfDUHc+Jb8jgLxCiqpohNvqNhTSta
 eaitk15o1Ee2WzNaB/arHnifKGjangPjkq27zdnhnmYZPQ9VwmFurlmtwT5+leErlh/E
 +E0EqHNF6y8Re2LtMEaP+AhauwmXC92RVa7dIuMoeoPGcSZRFTZWQDceUvYrg2AECtcV
 9MaQ==
X-Gm-Message-State: AOJu0Ywh5TvHgFX/Gmb/XArzly7Siyl14KQnYbelsXIzGFfO5lO2xXr2
 TwNUT8ZrlmMPf6Dtpgst93QeP7JgeZuvccbU0nI2P/8pVIxr11A03exO
X-Gm-Gg: AeBDievx2UVFpktXuSUD8C27q3cTlzl9KX5x45gx9UJ38Xvjx13si1eyYr6AjKELK1O
 qae+pyj6/8KynbJ08puuJJVS3+EuM5lvmsNuKI8cvAX23EbJfN9n7dkeptoW2yE2hfuu9v2RniI
 zSko57K42jUx78pSG5IgFPKz3OuFgb+6umhtaJQZVs6ikJvo40FLpWoCrybm1+HoQ4qU32Z/F1c
 4XgZgqTCMbJerPdQ2Qb4lvI8BdVH67jYf6EAQdxi8ineLuX3aXWLRpdTakn0Wwn0vuJJgO7l15p
 udGopgbljKuqvbWstHUFAyZPzqwSacNFijRx8WvFyUi5Wdx05vJZM9UrpKtJ+V2hSk2ZqzUQjg4
 6ehE1pAfBjxeZWOB7WeZpaZXI1GMeTRKIzCQ1utm6J4L51hXGawBtwqr8Cf9l6bMV/Q7Mfi42jc
 /VdMQnx04al1ivIKZDvEv92eH2KT4G8GmvwRKo1nNY4uNWewknl2eGy2Pxqc0DrD+4smSHYEnDq
 caqcR6BLukNMxqLvoky8wrmL0fHb9XJ8b4euNhf75KmAQeppg==
X-Received: by 2002:ac8:5892:0:b0:509:3cd:b22f with SMTP id
 d75a77b69052e-50e36b41242mr26519531cf.23.1776412540111; 
 Fri, 17 Apr 2026 00:55:40 -0700 (PDT)
Received: from
 runnervm35a4x.floazsvxcilefmrd5phyrjbtph.ex.internal.cloudapp.net
 ([64.236.201.40]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e39449e36sm7847821cf.21.2026.04.17.00.55.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 00:55:39 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Fri, 17 Apr 2026 07:55:38 +0000
Message-ID: <20260417075538.3930-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417065332.23663-1-wegao@suse.com>
References: <20260417065332.23663-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] mremap07.c: New test for mremap() with MREMAP_DONTUNMAP
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

Hi Wei,

On 2026-04-17, Wei Gao wrote:
> mremap07.c: New test for mremap() with MREMAP_DONTUNMAP

> Fixes: https://github.com/linux-test-project/ltp/issues/1168

Use Closes: for GitHub issue references. Fixes: is reserved for commit
SHA references in the form: Fixes: <hash> ("<subject>").

[...]

> +static void cleanup(void)
> +{
> +	if (new_remap_addr && new_remap_addr != MAP_FAILED)
> +		SAFE_MUNMAP(new_remap_addr, page_size);
> +
> +	if (fault_addr && fault_addr != MAP_FAILED)
> +		SAFE_MUNMAP(fault_addr, page_size);
> +
> +	if (uffd != -1)
> +		SAFE_CLOSE(uffd);
> +}

SAFE_MUNMAP does not clear the pointer. If setup() fails on a subsequent
iteration before SAFE_MMAP reassigns fault_addr, cleanup() will
double-munmap the stale pointer. Add fault_addr = NULL; after the
SAFE_MUNMAP call.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/24554018117

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
