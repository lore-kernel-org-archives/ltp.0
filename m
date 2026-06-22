Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEA8CDB46F
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 12:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782129621; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=R9g5vWDka02dDwZ3G2lv3125LRtOJ8RGKWeZf8CNHxs=;
 b=KIpA73S6LlxVq3pHGd0+RZhn3FqcBMpkRA7QMWe5d6HiLsrYUsoCwOdC+NNWgXPe0KwRm
 TLGKrs/v+ekmDyvnH4P/8HDImqbxuSBhmg/PqELKcCTAFYHCsJsQk1Isv+iWiLTRtwo1+oI
 2UJeSqbINkXEQmGlXPkWoz4hLeNgIHk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C1753E69B5
	for <ltp@archiver.kernel.org>; Mon, 22 Jun 2026 14:00:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A1AD83E697B
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 13:59:59 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BBB791A004D7
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 13:59:58 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-460662fcb4eso2882920f8f.0
 for <ltp@lists.linux.it>; Mon, 22 Jun 2026 04:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782129598; x=1782734398; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=k9CcWpe7of9wkyE9735E6NoSfPyQUcjshajBEuy77r4=;
 b=RFDce/WWgfvnxgnJOMK7awhpDQk044bNDOOE12SMvPMXP8e4ULIxWX8HX8iM4qV/2n
 4+/5r9h64MRxRY7VoWOMuVnO3nU6HTFbt/aw3bkgbgUdoo+EMQ98qvOqH0yno/jyyUX/
 +Nn+OSS5TK7Ay6kmWB1GlJjdi/+9JXnJ1EOI2l91xeUrpdai+yW8BNXme0V8fsOb57tf
 DjnyGNQm5AoSac/URN6T1Cojd7fBx8WWY/o5H3jM3qOYKG0lcHFsMfn+7vrdsVW2TfeB
 vvjkp3ywbRo31Yy50jNcSvInkdWC3ua8FpXG5zV4oUwsM1Au81nuRdrOb7CEp114gUgz
 lPLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782129598; x=1782734398;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k9CcWpe7of9wkyE9735E6NoSfPyQUcjshajBEuy77r4=;
 b=QO6uUVelY8MH5xiaqsH+HbBP/9eWgvB6D9LqVrkeLuxkOpMw7/fn1ro/kaqpNvVsO+
 Z0g1kIDyYPXj0C6WSPK/9yPtc+RTwXa3PiZpytgu/pH3eg1mAk9ef6TuZLg6RMDvEiXG
 o0T8KCV6gkwcHvKR3WP/ou7RX104u8DejQN7YsTrHieQqkA2RLwdD6tx5PMd48C3mAC4
 PuBoq/AQ1TDSP+FnxsM91f2B/PuWrOj4bI9SjRqxywhIMGmtVzWx8Sfb7CffWmKEiZPi
 16ezSKtjStfdCazaxFpYCNDbC87jTPTxQvUGeSj4edd+wxKKe8JPuZwbtVjr6yoBX+Ck
 g5Vg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2lhEwQI4DDEP1irfkSXOR9v8RacRvPTkUMFYLQaUQdhyQ4yzhM7pxdlzJ2Yqd4kZrg1c=@lists.linux.it
X-Gm-Message-State: AOJu0YyqufCQtmWf+ezXsT219UiHhY0JXryWG1OFsla5YG3RIbb0mRug
 lK4t3H1piH1ShMPgXO1Genm5ccXke2s+zCzkgENId1+LwD2fUb9/x1dRpuneXN7ptYuyF1twsSz
 Kj6JdO/t3kQ==
X-Gm-Gg: AfdE7cnlqZF6aM0JYSQjny/nfXlf9bF+4ensexBkpV+jA9/mJ4/eOR3fDVQ3iOGGhF6
 PHGw995D5SOUQK7S53+vwVNyaPbsTvBEBZ055HmHlraNFD6sCc502uIwtpM1cePeASj+5nV/Ym1
 zRqvTQlUwrYmvM74u0UzdlqrC0Vy5gWedEKfH1yiyPtBxzSwqyFS9pkjCbdq/Ixy2d0MoBGBP6/
 euAoS0CjWrAOfVjlOelqc2QLsq3lfIzpIP5H4olLTeKzMlgaUfxNVfApZGIOwEHNFEldQ2MP8Wq
 bHKxw2N4PTy7aRyW+8/Uj0XtKwYiY32wU775Xo371d8MrFk1fsR6Gv43XQu+WZ+iifY/jE4y+/7
 agFwhLZjWp1xkEBNubbZC/k2mD6q+KZC461fEzHBu95X4So6Ac9eqkKfQu4exPMlx9K06Qg4hFW
 GZsoKjgxDOYu8oHnbWN7UGbXhbpPyq1w0Fih6Ha0H5KTLUt2mtWMvmsq+5C2lvWA==
X-Received: by 2002:a05:6000:298e:10b0:460:65dc:e9a0 with SMTP id
 ffacd0b85a97d-465071f9671mr16512113f8f.8.1782129597895; 
 Mon, 22 Jun 2026 04:59:57 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46666788302sm22504340f8f.20.2026.06.22.04.59.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 04:59:57 -0700 (PDT)
Message-ID: <6a3923bd.b682100b.5097e.2dc2@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ajkZTtYM1TeYRSTf@yuki.lan>
Date: Mon, 22 Jun 2026 11:59:56 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] metadata: add tests grouping support
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

Hi Cyril,

> Hi!
> I'm looking at the metadata and we will need at least one follow up.
> 
> For tests that are under cve/ directory we add a 'cve' group now, but
> tests that have cve tag but are in a different place we do not do so.
> 
> For consistency we should do:
> 
> * Filter out cve as we do with kernel in the group by path
> 
> * Possibly add cve group based on cve tag (I would call this optional as
>   it kind of duplicates the cve tag)

Do you mean to take a look at the tst_test->tags and verify if we
have a CVE tag? I think this is possible yes.

I will take a look at it.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
