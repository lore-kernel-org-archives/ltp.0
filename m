Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AD26CCFA13
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 11:36:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BF07E3E53BB
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 13:36:44 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2B7D3E2622
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 13:36:26 +0200 (CEST)
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com
 [IPv6:2607:f8b0:4864:20::343])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 49F961400762
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 13:36:26 +0200 (CEST)
Received: by mail-ot1-x343.google.com with SMTP id
 46e09a7af769-7d4c383f2fcso686908a34.0
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 04:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777548985; x=1778153785; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zN5kpdABU/65Fuq6xzD13EJyVOm7f3HT9Hif/WTwhwk=;
 b=o5OIjZ5c+YiX7sQlLx6b++DtLP10RN+5zxnhWRqRDyYzJZ9xrU1LAJCrySL8G0EYBl
 1d8+vVSa1Gk/lWzWuX3+IGAcd1L57vcWr/EVJAcuBEqeEKoowPLPwZDNFrvukH9JJuAC
 D/S759Ib27xed4hlkKFJewjI4IGPF9C31t95rZb3MLQND4I/NckOM5Yhi0Tn5qaJhx89
 Stvii0VqA1mpyt6AGNxj2jZ1DVcGDbuMTSnHkpOU2q8V4IPclQt3GVWWurm2lifbnmQU
 Qt66DBpPSAoPLBma+FDq9ZGW5xVX6IOazaqht5H62qa6tilf6nM3RJNy2Z+Ce6SFkAxe
 gr2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777548985; x=1778153785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zN5kpdABU/65Fuq6xzD13EJyVOm7f3HT9Hif/WTwhwk=;
 b=Gc1tho9CVU5UZryWL6BE6U3EPlYblisNsiNmIyd6G6C2FoqiVYR+pPJlG5x//P7jPu
 ryJdRoEhR9h37npttRB2G7EZ78A3q+WQn7kRP7c2AY6Vw5CXf1UprTIn2Rn1X/gkrFk2
 3dVFTc7wpJmK1udP/YqlkSczmrnWRXRtS8k9FrWQ+3HCBqutoHzu1zHwRra84tnGtNij
 2j+/2Aq3P443GR7s9vcobHrTl1pys+9eB2VwA+l+JqcyWBzLR2oOYSYf4cCXlK0NNCGC
 zn19ItNTqEFRPD12P42HgZofJjv17wgBoVQALAC1LQF/Wk8f1HZconMi5Yj261vLVhUi
 nXAg==
X-Gm-Message-State: AOJu0YwUJi2t69Qm+qv5t3aPoy7+DUbokUnk42xpnsoVzD3xau9Sj+GR
 9w/H8QJe7egKzvssgetyH4tUJnSpjyaDC8VfxNV1j9PvtHyc9PpLHdck
X-Gm-Gg: AeBDietWG1gbDnEfzVsiPRNIrh5J1AIzp5X6jL+sgGbKLeoHwdViNfiGGnBOsdKGpnc
 WR53M22ELxJGMUp5Pjr4jhZ0RMHjELAMuNEOmQoSaHcd1VeGQMNyBWNHU9APCY7gQrlLuXO+HoN
 rPadd59vg1UFozMOnXNq976kpx3ELY5OhaG4/C9suJjshvcK/QFpGWtWPKjAtyly5sIMyZNWiri
 PgyTN/fuTmwzy4iNnBCwyj6mTSeVUFv+dJfhgibdJouMiZfNXjT1pF3JUBUnyXUuUrY9oCOgtQw
 rqzZIjk60fxtYsPiE+/zFLURbIfCa1KK9OERWceFUfOoeEdmTt44RwaKS94TVM2p52hfBW9ppdR
 jnANDevSFXCadWkcW1MBCjDjcx5flccBVJhZSqiWasbc5CDP8x8tnmgCY5KRitblzQ0DDjSevD7
 ik7vfSQXSl3eO2opTma0hB08izQpxKQjlNJHdfs9NNFUea4vOfv9EP4vXuMOmnbzvTwkdRwwABc
 3Uiwv7pZ1rwIfpyC6nRSg0NyyFQwYXhlbbi9EPTxpeuZkf5hdE=
X-Received: by 2002:a05:6830:368c:b0:7d7:d60e:650a with SMTP id
 46e09a7af769-7debdf163efmr1054875a34.23.1777548984740; 
 Thu, 30 Apr 2026 04:36:24 -0700 (PDT)
Received: from
 runnervmeorf1.sqh55rn4vktezahojetgrejhff.gx.internal.cloudapp.net
 ([52.173.182.163]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7deab7cef60sm3241527a34.1.2026.04.30.04.36.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 04:36:24 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Fushuai Wang <fushuai.wang@linux.dev>
Date: Thu, 30 Apr 2026 11:36:23 +0000
Message-ID: <20260430113623.3904-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430094142.37777-1-fushuai.wang@linux.dev>
References: <20260430094142.37777-1-fushuai.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] read_all: Add /dev/fuse to default blacklist
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Fushuai,

On 2026-04-30, Fushuai Wang wrote:
> read_all: Add /dev/fuse to default blacklist
>
> Reading /dev/fuse without a corresponding FUSE daemon process
> will make the test hang. So add "/dev/fuse" to blacklist.

> +       "/dev/fuse",

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch.

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
