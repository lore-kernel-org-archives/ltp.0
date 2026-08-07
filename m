Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91DCDC5AC7C
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 07:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786089107; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=WamE2qi0cnMtTM0uK8a++5lCgZN/yZAPxav6DW9wc28=;
 b=DoMzNkZUas9t025lJim/xEfe9HdnhkwRau6aECNOnRHKkGwO0sBSfuh9sGC+Ni0itoz/o
 Oq9tJ+ugdrX2nj1WbqyCgOAr1L1snrSfaRGjs5FPYOlVhACuPeg7BWpm8CBwdtbg/ZQCyYL
 YpojKP1azDoPsdwfEmoEXCAQhlLu5n8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AA36F3E6FC7
	for <ltp@archiver.kernel.org>; Fri,  7 Aug 2026 09:51:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5EEC53E138E
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 09:51:27 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5BE23600B16
 for <ltp@lists.linux.it>; Fri,  7 Aug 2026 09:51:26 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-47f96c5b722so1888585f8f.0
 for <ltp@lists.linux.it>; Fri, 07 Aug 2026 00:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786089086; x=1786693886; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=WLpfdhAIMalfh+Ix3qr/2Co6+xOLjoAs5jPbDvLQ+ro=;
 b=YPbVtdFN/2hRposBAS2fv8GoX2pxQ5xSS6V9zFanW7rMtsUF0En9CFxu4mIcbV6wVk
 ZlZKmRaTAX7MJqhvPR14UUKhuDfvmFV3y3oTI9a2GPngCea+Kvg2g5GjpYl+e0yAsRmj
 oIhnn0lY/CidFprgWa0Ut9XvZY5l/D0N8yAV9G/wu8E9rodrJKxDhzWAQMRMZfHIsiCx
 s8qooRrVW2kpxoIUTub5gHQBMPmXIcjNUSmzViUodv9GNSOeHbHJ7Ws71qKw9v/6U1Ul
 oTZahjhJRlTLY+z1y5NSp2DVY3elYlefk7bQwbP0n5FIkTeTCwmZUFgyyLnoqYv8Kbz+
 Iebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786089086; x=1786693886;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WLpfdhAIMalfh+Ix3qr/2Co6+xOLjoAs5jPbDvLQ+ro=;
 b=JbzuS1KWhXHqi5IRiTVTZFhdr2MANSWPLbTLz/RuQ+2kAYy1yHVBJt2PRwkFTkQo0Z
 FQV/CKe9r8PIlNQMhCa3q00k058ErwRyuN8QrIv+7ryj5aKSn4ol5e+4/DSX1QK3u/YL
 9/DV1x/wmMa9p7CT3a9qZUD59GRPkS7ENzNdjRflZY1ovwPLuit1CEhSBH8SR4hSQQK4
 JdahoYQBeMBPydwjiy3+pRBPHsjuMtOCzGENYfR87NZ6C/YyQED6TZFPXk5ttvokGmyZ
 e/gf79S9jy+eKT+ZPV8C4a+89+wudA32mr/xa2JPsRMMptPC963Ml8yzszBOhDyqn0YS
 +4CQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpaU9hKKJXQxlx3mbQG1TlDWTNZPhYvsl6dG4CxpaDFI/YxNmPbU5zh3IxYdpXckkQFLLo=@lists.linux.it
X-Gm-Message-State: AOJu0YzHYYO14gCbgHlGdGy6DMGNpgoY5y8iTYbmpckq3qzIyRGzNs9Q
 51OGYh42Q3ak/SxR0Gy5QvPbrsAqthtE6JM0mU+ioT22OwHzuxJ+swvajNDxr61XeMM=
X-Gm-Gg: AR+sD12Q7dw/Qi64ADQCLQ05PDuQANt3HnKoJcA06HlS6AuBz+B/9r00YaO4ggY/4bT
 0CTv9AhQmrPHRqDX2ERVHOvAOzRTFxZidxWwkTUZ+I1MNcheVDl/9l2I+rsoVAnxn9c6SOCnNpd
 YYmnDm3nOIo+/llaB0POs9l5pUd7iYYFCw3EqLrpxQJ3Vv8JlwI6BGYXX4Dgtw4bk0e13lOIa04
 zK/1y1BeqHe769dgKpEzuGkxnZa8OUuDtG2YtZiHbZuGbQdsUDncfvXL84cKz8d1yJkXInokvsa
 zvSyDK0bVxSJrIE92sRFu+BPtbx0BqtQXFrWc/pu47vXI57tl0IID4i5MP2jCiZ+3C6yuqLbJI7
 GxpVjJ6AWlf87KcCEYyKkBu7RAWpJ2muzoHblAykIKvkJjC/qppPwIFKcLQmKwgqMnAXojSfFtO
 bN6zNvwTXkMmvBY/cVIzSlrFhEML9fX1ode0P9CbontA/6luSwrRRriT4LHfA7VpIdM98J
X-Received: by 2002:a05:6000:604:b0:47f:7526:598 with SMTP id
 ffacd0b85a97d-47fec5037eamr31068893f8f.12.1786089082060; 
 Fri, 07 Aug 2026 00:51:22 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.110.28])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4800220ab11sm3460694f8f.35.2026.08.07.00.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 00:51:21 -0700 (PDT)
Message-ID: <6a758e79.5fb1dcdd.355f96.e2e4@mx.google.com>
To: pvorel <pvorel@suse.de>
In-Reply-To: <a1d939127b54c51fd29f869b0fe1706f@suse.de>
Date: Fri, 07 Aug 2026 07:51:20 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] cve: reproducer for cve-2026-64600
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> > +			.min_kver = "4.16",
> It got introduced in 4.11. Is there a reason for testing from 4.16?
> Or is it just the copy paste error?

1e369b0e199bb ("xfs: remove experimental tag for reflinks") was merged
in 4.16

> 
> Other than that LGTM.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> > +			.mkfs_ver = "mkfs.xfs >= 1.5.0",
> > +			.mkfs_opts = (const char *const []) {
> > +				"-m", "reflink=1",
> > +				NULL
> > +			},
> > +		},
> > +		{}
> > +	},
> > +	.tags = (const struct tst_tag[]) {
> > +		{"linux-git", "2f4acd0fcd86"},
> Can you please before merge use longer hash
> "2f4acd0fcd862e22eab45690ec2c08c80b6ef2e7"?

I thought as a rule we always have to use short hash, we never use
longer one, besides a couple of tests. Is there a reason for it?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
