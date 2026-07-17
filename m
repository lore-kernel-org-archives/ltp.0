Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CD6C4451B
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 19:12:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF1283E979B
	for <ltp@archiver.kernel.org>; Fri, 17 Jul 2026 21:12:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C036F3E269F
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 21:12:37 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 136251000463
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 21:12:37 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-38dbe53179bso1242339a91.0
 for <ltp@lists.linux.it>; Fri, 17 Jul 2026 12:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784315555; x=1784920355; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=eio1r4rVc3MJFYuWOqrLCI8XRU8zKOdJ2APqzu2666E=;
 b=fx9qusHLxIsoNWtLjk5u4eUINiSN8+3XN61X1+7eixYn3c5ULCQLewDrmHzADRcAoF
 QY/SCJCVSbIVkt4BU4DOEKpc2H/pHM+rK0JOk6+IEKlIjWyoD297mbd8+PBrcZ0Yr9qe
 rNmGS0Wp+AGfGWaXdzdO3WHfee8YP/U9ZUjn6l6J1uGONoDRNvcrjiWiaZ+b5HrNF4nV
 0n0ihgeO1dTJDJ5w/96N11ZPD4G6sjxtdIZ86Gbn2NpnoZjHLxIGYqN6JbNbVC7LrIzg
 UTuHtpB4X/Fbv/tN/BSu59/MqXB3MrFQMMpWvFRjsSHsCCuAvjtJxEWrh8EQufIGnlge
 dxew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784315555; x=1784920355;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=eio1r4rVc3MJFYuWOqrLCI8XRU8zKOdJ2APqzu2666E=;
 b=ChjGFfuhytkd8plnzl/0dg003U5muX6Wg2DlPlQVTOzc37GIrWpJ0M1XFMALzf0FNJ
 ApiBo+X1OWJAOyWq7ulkfXYjoXZgEiBW3F8GWynyRh2Bx/mCbpuvfreAMsCYwWD4llEq
 ea3Jiv4Bv+0B2tGWJZqSCtwtjZi5cRztErLpcyXn6DRsAwrYqPmpXAtFGH/05qy3+3pl
 Cpg81WYyjaxJjiTOhjdD2/9VyF1owMjtl3In7aOz4mJT9BhGfQYY035d6NXIG1F9GfjI
 seuK7EC1MSs2+/cDcT01r7mW5yXpYMXQ8F9CU50EJOVcJ8eSFfdXiDvnct/pU5N0820l
 aEjw==
X-Gm-Message-State: AOJu0YynKuvfQP/D92nzjoS3Z+V7Y7aTHT8elKxVmXHEi1drZrC0gikS
 UETowTcet2UD9vZcZgJdu0DlgiwQ6QmF/jO6rtODlQQxlTqgFVKlslQH
X-Gm-Gg: AfdE7cmOsTcG1AHSHujUI32rR1rLAGJ5RobWv92bMbm1/FemdJUCx1HWCK8gj+7j0lm
 lENs2SjwB8/XvtwNevIxdvSsTmZFfwBOYaxRbBE5UND4ix5ucCZifHeg1CeTvGAooOWT0yhGZZR
 I5zqRaGvKdbvi8k74tCwrSxqdEhYslji8euYJ7xMhoCILXuGObx8xp026A4h3EGX6KxBGn9sshk
 27IGHGjIBZkVLSNCwfwrGig9py0YEvH3CH5J2YPkAVeMzocwJdHleqhKeuhGyLmI58slB4AphRA
 5g62b4SbGBE6KgjSmBQct0kh0Yuu2+yUo59nSMWYFacNPzNUXn21ue1dzYM4hkP9lAnMdAHA1CX
 qcrG5RRXXu38Pz7PUrjZn4CZUhSUBU1hnDmwgFOXjpHYAv4wcQ6caYF8SIdr8XuU1YIRRWczrLb
 FSKPMmSJPsu5nRSxb0Y0H15PySDefQzY5nw131t8Yy2W6wqiT4moEFNx7TgclZE9S1nBjy/SQNc
 9KoGC1RXENYgErUzQ==
X-Received: by 2002:a17:90b:4ac3:b0:37c:8628:f79e with SMTP id
 98e67ed59e1d1-38e4b431479mr3402633a91.16.1784315555203; 
 Fri, 17 Jul 2026 12:12:35 -0700 (PDT)
Received: from
 runnervm3jd5f.uk0y3m2hcqoulhnsten1kxzdpf.dx.internal.cloudapp.net
 ([52.159.243.16]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13ce2cbb7c5sm7463522c88.10.2026.07.17.12.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Jul 2026 12:12:34 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Fri, 17 Jul 2026 19:12:33 +0000
Message-ID: <20260717191233.4148-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260717180638.1203715-1-pavrampu@linux.ibm.com>
References: <20260717180638.1203715-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] hugemmap/hugemmap38: migrate libhugetlbfs test
 truncate_reserve_wraparound.c
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

Hi Pavithra,

On Fri, 17 Jul 2026 19:06:43 +0000, Pavithra wrote:
> hugemmap/hugemmap38: migrate libhugetlbfs test truncate_reserve_wraparound.c

> +	.hugepages = {4, TST_NEEDS},

The test calls SAFE_MMAP once for hpage_size (one hugepage) and has no
other mappings. With TST_NEEDS the framework will skip the test unless
at least four hugepages are available, which is unnecessarily
restrictive.

Should this be {1, TST_NEEDS}?

> +static void setup(void)
> +{
> +
> +	hpage_size = tst_get_hugepage_size();

There is an extra blank line between the opening brace and the first
statement. Linux kernel coding style does not allow blank lines at the
start of a function body.

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
