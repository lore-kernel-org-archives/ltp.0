Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA2DC4451C
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 07:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784705499; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=sg86BdTO05y3GK3yurDRLBQ78IYIDo03GFk5/pvWn5Y=;
 b=i5W/4U8+3yrLUHZKYdzuYP9T9GZ1sdWyB02Ibhv4m2ANnQmxrpwwhUjUF4QAZuLLXDlsc
 9dB3vO4RpJTcFJh0Mmz5cOpqopskjIn6iNcMtQSj4xiFKrLcLq2EG24bwLOkYqZ+SwMiDQf
 mgaNrr6Fupt5A4EuOwZvS4JMTGvLj2I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F12FB3E1F8D
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 09:31:38 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3196A3E1BFA
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 09:31:18 +0200 (CEST)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1558D602231
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 09:31:17 +0200 (CEST)
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4956869750eso9517795e9.2
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 00:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784705476; x=1785310276; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bVsLqHD+AMgDqlrOvyF9Bfc6pRBq/hrI4OfWje4cUZk=;
 b=csJrjzabXi02eRrmMlS5jtcc36/rkM+SwHz0S7Yf7KwDrSV3yeBRxe6kO3K9cOnQrM
 cNsWQkF+nOqyDlMNd4qtYQzO+2nM1hBoRE/iUZA2T36TiUZ/AkFCWYIq930kCWHWp2Eb
 uqmGVFxdB4oAlGmGJw7MVUUVWAAwxN91Yuv1IdWdMiqAAMPt7OJ4eM7vnF1iDJ/jwrIb
 mRIE9emPFFR2S9wlvAUtt2gxtzIafLNeo3oJrPyaszGC+KKDaSv6yeSS9cVwwjnJefhk
 TOf9B6WpXrjVADTyEd0ixca+TIerl6n3P9HMZbD8QcH5UVDd9THGI5k4F/3wfj5/On8Y
 5FVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784705476; x=1785310276;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bVsLqHD+AMgDqlrOvyF9Bfc6pRBq/hrI4OfWje4cUZk=;
 b=p064wSd+1xEfJ+SNelKhzBxa+Olga0sV9sEE/KRxfPR2dJzoC5lHpyHATpAgqVrK1P
 IXxGFVTw8lYq7AtK73Kv9Fp9oBpIM0B1JU8W6Zg9K6xnseyLmfxftH1HeTh+yhtWdEsK
 2+TxTScGvUZMtPEo9nbRXyjDn3PEK+tKTsrgwZ4WuPcpN4U2Yz57UMWR/V55thH06zKN
 So/REXeKnVDJzMbCY+hvpY9eDOGoHKkUeufdlx/UcuX4BCZXGFn3B+ARa0i+wqyZ8Tut
 PNo+URSN/VFAIkkXDgq31+JzGngqkn3HLGdW9i2sJfkn6JBoPm42NW0nOPSLtRjrQZSQ
 4j4Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp8CIpBMU6AvDmjmj7VtwlIoqmkOcR//I/hs7g3/QJ9KBPCdub6iUQay6D+2sd2YOSJHF4=@lists.linux.it
X-Gm-Message-State: AOJu0Yz+/cuusuRMzJzFTa7XfYryKH7UlMTnPp0VSvOozWFimkFF1wz3
 LuQuRQGxF82KT3b8WkKHZYt5fvWLeixI6qvR61/1Qu2kZNgHHr77hKduXMvu13pQ4ws=
X-Gm-Gg: AR+sD11Piyey6+LuW4wRNpOGd6AdESI9mcSUBDAs5731qnCcNVwQgMx9bEcBKlRIXUL
 O9XPcw2JRrDwY+LEDHeCewkcjujhxRsZWn6mMj0FsA7GeibIzF/kq39wEDi1HZnaQ2VST/nT6Qt
 NSN6WkYwx1o/2JRhJP74r4qfrUJJeh14eUxeqhH+UJicSGGeVLvuRhK80E4byGaEFhxACrwdWeX
 TuDf7WWKRBGXsPUqrWO0EaCiTWRfFeAjzImKQpI1PDsTXTM6T6jrXs0oeRihs37sOCiIg+GwH6X
 r13wKBjyeLgYVGHYdhk3BgI4hDQwYpx675gTDpzIyMoIi29fTtl+13rP38UcN30UNHLHq9XAmna
 3xzzxjTT2QeSZaU7OUG4AglWjRyByWnnX3Sr8Few5586TTYHqgmZaTYu0uUeQDrofw22OpblG2N
 eRK48MrVF1SkR+YrZdMRtziRsbVQ==
X-Received: by 2002:a05:600c:1549:b0:492:3da4:81ef with SMTP id
 5b1f17b1804b1-4954a50c3famr213340195e9.18.1784705476415; 
 Wed, 22 Jul 2026 00:31:16 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f864305f5sm2839407f8f.17.2026.07.22.00.31.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:31:16 -0700 (PDT)
Message-ID: <6a6071c4.d1054386.2e8328.2dc0@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260721212137.4220-1-linuxtestproject.agent@gmail.com>
Date: Wed, 22 Jul 2026 07:31:15 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] thp04: Simplify to focus on CVE-2017-1000405 race test
 only
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Jan,

> Hi Jan,
> 
> On Tue, 21 Jul 2026, Jan Polensky wrote:
> > thp04: Simplify to focus on CVE-2017-1000405 race test only
> 
> --- [PATCH 1/3] ---
> 
> > Remove ptrace mode support from thp04.c to keep the test focused on
> > its original purpose: testing the CVE-2017-1000405 race condition.
> 
> The pre-patch thp04.c has no ptrace calls or "ptrace mode" branch at
> all -- it is already just the plain fuzzy-sync race test using
> /proc/self/mem. There does not seem to be anything to remove here.
> 
> What the diff actually does is move the static globals (write_thp,
> read_thp, write_ptr, read_ptr, thp_size, writefd, readfd, fzsync_pair)
> into a heap-allocated `struct thp_state *state`, and add a new probe in
> setup() that performs a real write() to /proc/self/mem and reports
> TCONF if it fails with EIO (i.e. when CONFIG_PROC_MEM_FORCE_PTRACE or
> CONFIG_PROC_MEM_NO_FORCE blocks unforced self-writes). Could the commit
> message be updated to describe this actual change and its motivation?

LLMs tends to be a bit verbose in here, so please keep commit message
straight to the point. The rest of the review is correct.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
