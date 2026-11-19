Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44264606A324
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 12:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QBkjvRR2
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE81B3EA002
	for <ltp@archiver.kernel.org>; Thu, 19 Nov 2026 13:12:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 436303C7C29
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 13:12:38 +0100 (CET)
Received: from mail-yx2-x04.google.com (mail-yx2-x04.google.com
 [IPv6:2607:f8b0:4864:41::4])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 03E2A2009F2
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 13:12:38 +0100 (CET)
Received: by mail-yx2-x04.google.com with SMTP id
 00721157ae682-8b4d0c15898so2775527b3.0
 for <ltp@lists.linux.it>; Thu, 19 Nov 2026 04:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795090356; x=1795695156; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DIA7tPxnvDZQtB4OEhwvh+WGn2jV2tCnGr9DafhapbQ=;
 b=QBkjvRR2o3lTrhy2TMbnuJ5C6rM4UbUY2p+znRGL92dJ6nDdllq6Ig+PIoZO56mUnP
 ZfaUnS5vm+0ByxXnAhyf4sp9bmXts7eB6BHI5aGo6Tl6p+6aZl+YpijtstVpDgQrAwHc
 Vnu6QIbKe8/LwGX7U86xFyL0XME9/Xepz7371m+MMNW/d8ZZIn0/8G2ogLTQkp4fHgUa
 C1O454f0cNtHQchPIFYYSzRN+TZo9jF5PM+DO4NGR4ifMdWC6JcLGhZJZ1dwXkjtUeGe
 1wKha+lg2Cs5/uivMvqd6U2+GBB2EnRLA3IN7Nk2akhQj2vssyRdfxJ97kWmseH0NEOG
 sGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795090356; x=1795695156;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DIA7tPxnvDZQtB4OEhwvh+WGn2jV2tCnGr9DafhapbQ=;
 b=m3HzYXbUwHNxydbriTB6oJ0to2TXO8d5KGUYzDt8/QurtIxJTJm93fyf/Yy6lYRJ8N
 oU69ZGYBmZtmBszaXNFte5+A1iBdSj7tY9SAqSShQqStoG8czn0NGoCQ3CV0CGIuK7rk
 Euh1VGKE3/YPfQXqGGib2hsZ/Q2y/3O732zCXL8v87r954IqjZwp+AMheTT6FmOe4G//
 MW8JRpixc7KPJk3b6orzUV2Fb7V/weWff9mMcpBcUbic04+2vde27HP/R+t5glABXTQV
 arKeWtq/wgAbNtyvct4cfKtGuFcNnPj7KrhIS11iRXzlOO7rWjl81LmtfrKF17Xs3Brg
 +A/g==
X-Gm-Message-State: APuU4Z/XE2ysKGpQwa4ny4OZHQkbDyfHc/2NBQ3DQPvtSGbeKPM4mjf/
 jYDxPIRG56ZwQgEiiH2tNlI/e/yGvTwwouG+DNUwGZB9+lVHy+IsvVBI
X-Gm-Gg: AZFdTZeP2Jvyc0zSHO+JvgawKfGkU43AlOkBLZhDWODzTKs10dK9Y46IwpYMDeFCjs9
 MqAhLpahT7EdGarNnHasvkHSW2XekgTMiYmLnlF6pQQNLT3o1xpK1dL9/AV+OWJjNLw/NgaZlRW
 8xsSHPEsISi8bMx/0+CDuB4pr6KgNVDIyWbB++0Ol8EF5c2qD+yMhpRQgJbzF7H1IokXUlBdD/9
 CqFg5mPFcsC5ZvotrjGzStl9BwWpyy4dnCh2aYU0AIcB/Vx8ov05riq3Vpp2Pe+t81AqpxZUIeh
 VH591RJKtdZpwLLhvsauL7Nbpglv8aDAzpGZKpvTUcIkD4OBxczwiQ9XQbO9GLA8nSLc/UmjjZR
 Kf0Jek80Cg9FQvsNWD2dCJNly4RAZRFMAuXhnfc1OXkhTb6pRCWZ/7yYQhEf7JN3tCpRnq7ZJjO
 lAQj6Kq340W6DwHd5n2wB5HOFE/A/v1aXt7uzU2zqPW81pCiJsziS/2Cen42WXKDtgP41Q7noXx
 7eKsx9szr3v2aT2kbS9PyAsShgI2Gd/pcZj84+eCnblazA/GkR4curvth5eAIsx4U+Bs+vucTwZ
 icMaLrsOf4PW/6WmmD7GQXS0Fpv4XurNapK0W+xwxcPHCueUhKStKm9oPsuM+rSUeXC4EDvTOEG
 jhomgM8bHXVXEackWzuoeDqos/ulW9wWVO/oRtqQEYPAA
X-Received: by 2002:a05:690e:1553:20b0:67d:b309:a247 with SMTP id
 956f58d0204a3-67dd3f89d1amr1621412d50.81.1795090356460; 
 Thu, 19 Nov 2026 04:12:36 -0800 (PST)
Received: from
 runnervmccnms.4tr5djmxp3ceveiqkac2cjg2jg.ftyx.internal.cloudapp.net
 ([51.57.160.125]) by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-67dd58d34ddsm3060730d50.23.2026.11.19.04.12.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 04:12:36 -0800 (PST)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Thu, 19 Nov 2026 12:12:35 +0000
Message-ID: <20261119121235.4059-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119112938.22522-1-wegao@suse.com>
References: <20261119112938.22522-1-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] irqbalance01: Set min_cpus to 4
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

On Thu Nov 19 11:29:29 2026 +0000, Wei Gao wrote:
> irqbalance01: Set min_cpus to 4

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
