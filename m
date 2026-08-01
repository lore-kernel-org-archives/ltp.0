Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D126C54FCD
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 10:03:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 473543E9516
	for <ltp@archiver.kernel.org>; Sat,  1 Aug 2026 12:03:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29EFF3D00A7
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 12:03:28 +0200 (CEST)
Received: from mail-yx2-x03.google.com (mail-yx2-x03.google.com
 [IPv6:2607:f8b0:4864:41::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 0829E10005F8
 for <ltp@lists.linux.it>; Sat,  1 Aug 2026 12:03:27 +0200 (CEST)
Received: by mail-yx2-x03.google.com with SMTP id
 00721157ae682-81e7a64294cso4156577b3.1
 for <ltp@lists.linux.it>; Sat, 01 Aug 2026 03:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785578606; x=1786183406; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cY1lAgeDW2jW1lN7PYiqAzH1Rbfn5H+F0I1Rxg9EoBc=;
 b=NR+BkizH+9HqO7ElnbQMzAXGXZ/hZytAoz0kzqeY/sG6Q8uGo/sb4NAz8SSnIDrJ0T
 +23ijBXS1pRhXEK0A8DUbbUPsFAeZvWJHzSSCRLiHOTypIkv5e9ppDltF4U9zE41HyNX
 +G5YOUBf4XjnmQaVqhSkON31aDuqtwgYGteQNco+pHcrV8Pn1oJfetLTZ1/BNYYwWg45
 xOeHJ3uPvGiPnNmBus1MwDAerG6hfQWCyT8n8Q6uES2ulcG2dfk06JGIvCHrq+kLTGHz
 KGtnZCOoRWdOMpqjit+/BBoaoAjcYxWma0aN0hDeTndGYWOPeEZmPPDZw4A8Eq5Pd68/
 MAhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785578606; x=1786183406;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=cY1lAgeDW2jW1lN7PYiqAzH1Rbfn5H+F0I1Rxg9EoBc=;
 b=S5tQ+sAEV4ecKwGZzdlRuW+dM8nKrO9LXQZDAIB6kjoqfMc+ZfyMVTjb2rWJC+cddE
 i/rmICWomKtpVfR1MVG5PhIjOUq0LPeTwrxOyV1OKhLyb/IR9uJpvKSdgeYOizaP6UoJ
 SVR06Mv0z7MiApueRmszFbQ/wxqxzSLEro3eoLSpoWao71Bxps1DnHPZZIlFYHS6E6Wx
 iaEDq39CMafSvJzUJEJ4qit7tv8rJmT/ZeIOg7cF+wNNqsikqgbzWRYVv+q4xBgjVcKE
 eiuxmJ299JIEtFT7yiObLkF4xYNd/6o9b9sP9d0MsSXQOuZyV2042OdlWCeBNf0Caksu
 JV/w==
X-Gm-Message-State: AOJu0YxwWg4WyvKOL3mlF9vchL+Ijmgav7kacrWaPTG1IObnSsgXFck6
 qh92k0llMrpg6TAU9S/2QejVGlQ+lBdtcWfxAibJApwFQSnSDB/CEISl
X-Gm-Gg: AR+sD11DxJFA5hSRh32Fa1YSyzWSPONkCxnqBN0mcz/y7dqTxVasbbrA6k56nctfuS0
 1Es8cLYd5G6jcTD7k/XCnp8aoeQNGSF3K39qVpuinqK3VjProojUwFJUwlMo9yDMTSRgRATGc50
 D7eBmN1dD7qZUVbGxhBlaSPhpLZUOm3EpK16c5G+aTmQfo9kgGq8cYjRd5haG0y/EsG12GqHgv2
 uXyABb/8pk9LuQookFadgjGN1dZztvELOfWNw5uE5O7hPPKeTCrCDyTLmY6ykvNzyOWPtReKm9X
 2vVJFGIQUxi/z6pljjE4lxEfuq/4N9S0i6Y3oRr8mFXVlEKjqObtDQC72DRQdunvOwcNsx4TeTR
 lXY1UAFj4w6m+hqUQJYkFRdfXL2SI2HJwLPVJQ21mQthdfTAD8bNKOKyOEUqcSg7T3tuP4uYJva
 iLc86iYNBrvbnXlcoX1Nfscg4+iKjF2qOz+M7YwERk4mviA3cU09UMEy1BjxuAdVBX3LywcGCaH
 T+7OKPm525RtlrVa/Ri6WRpUfg1La93Q9oqYIi3LVOiz4+MCI+zKhYAW9iD5tWwmnFztS9Ci2sK
 mQ==
X-Received: by 2002:a05:690c:630c:b0:81d:5499:4cc4 with SMTP id
 00721157ae682-81fd4a217edmr47923317b3.14.1785578605557; 
 Sat, 01 Aug 2026 03:03:25 -0700 (PDT)
Received: from
 runnervmvrwv9.nvcrsk4lb03ebagxjwngdrxj4g.ex.internal.cloudapp.net
 ([64.236.140.211]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fccf841e1sm22807787b3.18.2026.08.01.03.03.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 01 Aug 2026 03:03:25 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Sat,  1 Aug 2026 10:03:23 +0000
Message-ID: <20260801100323.9154-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260801-cve-2026-64600-v5-1-2b9e0d5277e4@suse.com>
References: <20260801-cve-2026-64600-v5-1-2b9e0d5277e4@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve: reproducer for cve-2026-64600
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

Hi Andrea,

On Sat, 1 Aug 2026, Andrea Cervesato wrote:
> cve: reproducer for cve-2026-64600

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
