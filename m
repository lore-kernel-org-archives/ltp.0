Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24ABBC5DF94
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 08:54:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 510BA3CFAFA
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 10:54:37 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D844B3CFAFA
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 10:54:18 +0200 (CEST)
Received: from mail-pj2-x0a.google.com (mail-pj2-x0a.google.com
 [IPv6:2607:f8b0:4864:39::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 94964200046
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 10:54:18 +0200 (CEST)
Received: by mail-pj2-x0a.google.com with SMTP id
 98e67ed59e1d1-38dc4f9462cso1118482a91.0
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 01:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787561657; x=1788166457; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SScOr7zXkWempXbiBgu0oOccSgQyHgMwoy3HyGsMj5U=;
 b=XAAGy490gNYnZX7yb8kfNjDhR7qfkzZqnakv3S56Nh1nwlTyKLWT8QwiSnC/A31CtK
 evhjkC52uANGtRGALoxG5D+3nqTswrlQEoutRBQY1U5bQOXR8hWPkS54zPu4WwjLseow
 zaEr7bALDxxsADNDLNQba3kbjtY/E3KXXKx0bifGNolSOizEm2F3I6CPtXGz1wRiLGiD
 okwZvEEOuiXUd64+wNXNimlqG2mEVf9et2uygx+2NQ2fz49IBrP7ROFKL7JB8PHm/0ug
 AkLAnfHdI35+78sXB415aMEgjiffGzQ3RPxLUjCVh2xR0lbk94VZQWNBKJdgOfR7JJU3
 4HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787561657; x=1788166457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SScOr7zXkWempXbiBgu0oOccSgQyHgMwoy3HyGsMj5U=;
 b=a25fXEcwNQ5N+v3RsuQ7COitNeZLnTy9ySTHN7j69BoWIMvtZhKkE4YCG1SugbMXHC
 Mj/mnnvzqf9exN8Az4wgGIIExqAQE1s5iM9oZX+dFAaX/gtLFhfjYvHLrnE7s03VoEAf
 5ArF07JYWzKbkcmqEq+SjocQG1HlE6xnKFYi3CSS33TlTykrZtpykL/hcgpS4MFPbZrK
 v775PIOifS+uxPsOzcpQ/8mzGi70tI6r91g5F3R5js1nWO7gwg+P4YtcbUYDf+4CZ+IF
 R9EXtlbeRjumPiZJ4oc9yIBuawCI80S23joeldUQ8YMREXsv5wQeXd81tBQ/UZha9vEh
 JUVg==
X-Gm-Message-State: AFuF++nvBfO1yPVYR8LNa8kX5aOrn0cVe0cpoOwEarMtV29XQEjHnvij
 k+ku9HEHRAdPcGsVEnon4UHx6w610Ree4ZT5ojd4z7lj5F5V82UmiiPf
X-Gm-Gg: AR+sD11D4WJJ90G45QzO2GBvd7kSetEM5rv9vhKNLZ/gOWK3DTHrUMBYJVOzrTIpUbR
 QVJGWny4Z2fQh8A9ak2gUMYhdDVR/70lTroSDLgckVHq/x7HpF+KJPWlopI4/CgYkcrk7zbmqur
 GMeKVa7ASVPxpW7e+pvF/RVFZGrqyyVQ5Ni4hVGSQCuWROlJeGmLSTfzupGzSDwM89hX4LCG5ZK
 m/90V5QryBJLTci/NbdGbRuFF3iE2/gpHhHykS0FP8w2Xd3OZot7D7Jf1+BvONA6Sc6TSM/+dSc
 8lFwMbBAlYBeU1t4q7WGXpTmfrg4Vnqq0QghAgyjSHMvL1BzyrPGaaw//O/YiXlDFiwWktFtEwZ
 F2vnEVwVh/DRKDEUut2KHoN7/4gGw8zbty5G6hiwjTwLJFUOAqbGK7MChlWgdL/nxR/8RHxVDbN
 iAadYdMKcBJK+SasrS8vTLLIPmnwStGsCkhMD5iu6W9vBNlZId1FPBSD6y0GG+tnSdfZZHvMB6X
 EbboDn038HJDcm8FtErhO3yIBLGkQZOllcQ1tRlM51nKlKIyeIfc6IYQ8Uf/+4b+c8UKIjf1JB5
 7/o=
X-Received: by 2002:a17:90a:d44d:b0:38f:bbc:6a0f with SMTP id
 98e67ed59e1d1-395dee7e2eamr31507165a91.1.1787561656892; 
 Mon, 24 Aug 2026 01:54:16 -0700 (PDT)
Received: from
 runnervm76f27.f4530jdhkuyexk22dkczxkimmd.phxx.internal.cloudapp.net
 ([172.182.225.82]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-141860ec7f7sm24430005c88.6.2026.08.24.01.54.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 01:54:16 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Date: Mon, 24 Aug 2026 08:54:15 +0000
Message-ID: <20260824085415.4064-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824082350.70245-1-cyyang772@andestech.com>
References: <20260824082350.70245-1-cyyang772@andestech.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap24: Exclude RISC-V from the powerpc slice layout
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

Hi Victor,

On Aug 24, 2026, Victor Cheng-Yen Yang wrote:
> hugemmap24: Exclude RISC-V from the powerpc slice layout

> Exclude RISC-V with the same way loongarch is excluded from the powerpc
> 1TB slices branch.

Could this explain why RISC-V needs the lower-address branch? On RV64 with
Sv39, the task size is 256 GB, so the 1 TB MAP_FIXED addresses are outside
the user address space and the test fails before exercising mremap(). The
current text only restates the change.

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
