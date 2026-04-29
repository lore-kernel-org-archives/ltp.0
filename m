Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4816DCCF9E3
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 08:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777450424; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=QSMrREY2gOgBz0CzVSp/t9eMxJcdjdRNJgI2+F9hwiQ=;
 b=XxyY2AxW3d6t1gTLiBfaEjv3E9M84/rAN7/dzPQGOkdjxCKu6fEE7tpINiWmOfKPzWhBy
 jgzrAKgtCiwgBkqUu268jFR7PDiQMWKRqOyoUSQyjkJP/je42YahveawNj5wo/Mu2+ucqo4
 Fx6U46OJC/1rmuQ7H2V6OQObh7k7/MY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E8F7B3E12DF
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 10:13:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A3C83C2979
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 10:13:20 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 823942009F3
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 10:13:20 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso167309345e9.3
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 01:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777450400; x=1778055200; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=8gfPdvjKkf2Lx0wF2YAlds6yt/h6FvGgRr09T3m3NfY=;
 b=OVGKynm143MN3U6XQTXv+/zA2ZLkj0funKQccnVcTpzmIaYHVFq8P1eqh89AXn8Ewh
 LysGkUa/e/lJpcrQHp3JAzLcR3LhIiOGPrxWVqmrncgo9yClzfLuifBY3q6kLBX3IOD1
 9pmK8CuydscrBUzeJJhEu/lWtEPpw42lAfDcDlHM+aZvzTZj80WJKx3hfbtx1oQMGXIN
 TXMXTJCklf7avSMNod5rAvCSVMYyFFD+mQYY3DyipuM2ObDvLR3hqyUaT9kiqi7KkRH8
 gGsUhuYca1sSVT2u2s5jl6wqTKnJGuo0EAZa0zxs7jw6mBNpdGeT1D5f2LjoSuywbaEl
 C2Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777450400; x=1778055200;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8gfPdvjKkf2Lx0wF2YAlds6yt/h6FvGgRr09T3m3NfY=;
 b=Rb2DkznV1UXgjzAYHEZFeAxH0z27LPzg/Tlhh/7tLyOl3SCwpbUdEUycxAL1N5VjCV
 1uZ9GIFEatCoBlNmKf12CmfYDnJOJ5NbYe/4s8WCWvm+DEvPRpZ8D8MXUYO8GhN/ROiW
 ywUxgWvWoix10oH4GTpGWqv9LPqlPiUSUAHc1G0EXEmguSznN0WDctlzyiZYcBryei/1
 okZIXLGANbftvYet7dhNnwLwd+9MpusLVSxHOPCWMDIfVwUij0ITHvUaMf2KSutYi+dN
 7sUvF7+qgHz5Cw/Ab4Zv3tz4B1BCu62IpJnJ+cTnMqgfu5jwu1rcxY/yCw0PWZ6hOlaq
 e7dw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8d58LBmD0LD4ILQNkwBAf1rQtWKiAyjzYK1ShYLnKPewslGRcaPQx3kN89T+Fu4meeNNE=@lists.linux.it
X-Gm-Message-State: AOJu0YxtrwUluYrc4rjvejHzjOCiv9i/JroqvvBNQRvF5GtqL2R0D8dg
 zk0IHloUNMLDrdnv+ZrTEDtBPXKTJvpasACN/XTpoqUzox3nUMFIlDSk+Qvj/3FFK1E=
X-Gm-Gg: AeBDieuWJgAVP4ysUaa/DCiLH5Eue6F3G/G/ElW6jvxRbMXNKMb0gQy/3JgRks+eU+5
 UZKAglW31hXZpZ9KUFwn6ECAxBG8tGCwHavbWFs0bBrI4ZPpgqehe0P+uBT1VYFwCf2ZBYR65Ef
 iQU3hBFxcx9LhSIZ/PPkJ2OLer8Cmwo0XkbAj9tXtz/bP8tKdo7TZR7J6PQI423lkUV/fXh6sHW
 +ZgozXJEmLLVIiKHSj/YSnK9UjF4PNWuyGFLQASNyTbBlyOUzxpRKRwHm2vT59E4ciyNXiePyHA
 D7O8/7ONggOl9fAozc2LJNRYFWacI5GQ4yTJlP3JKNyp65C4WIpb8a5ZlyTanmTBhqE2jpLEYpx
 vY5m1OZEvwNvmJaH+WZG3molfMVptM+4s2bM2CBvBRJt9ba7arYILJuiSNLPcP3R3/Dypg0/iww
 nVeheOPsYZeItJHFTA4gyl0bUNkCp+Ji28ElQ8bYqOPImIL72uZx6kZ80bgPLE2KEmU2KW9mOq1
 eghsjYAOQdy16H70XeTj0YgWmqBxzI8Js5FUD1O8ypskEolj4NLsBcNRGz6f2m4Hp6gOAvjHT2S
 uGrTMsZya/ip
X-Received: by 2002:a05:600c:c101:b0:488:8c89:cfaa with SMTP id
 5b1f17b1804b1-48a7b5125b7mr35192285e9.3.1777450399736; 
 Wed, 29 Apr 2026 01:13:19 -0700 (PDT)
Received: from p200300ef2f4fc90003f4f7286cdeff7d.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7c33f51asm33657925e9.0.2026.04.29.01.13.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 01:13:19 -0700 (PDT)
Message-ID: <69f1bd9f.050a0220.2d9710.8f66@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260429080417.GA970790@pevik>
Date: Wed, 29 Apr 2026 08:13:18 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] clock_settime: use POSIX runtime detection for
 CLOCK_MONOTONIC
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
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> 
> > > New Open POSIX testsuite headers should carry a "Created by: name <email>"
> > > line and a brief description of the file's purpose in the copyright block,
> > > consistent with the rest of the tree (e.g. helpers.h). Please add both.
> 
> 
> > This is correct, I will fix it before merging it.
> > Ping @Petr
> 
> Replied previously. BTW Agent removed "v2" from the title [1], therefore I did
> not reply here because I did not want my reply to endup in old patch version.
> 
> It'd be great if Agent just keep the title to not confuse humans (people usually
> trust the title instead of parsing In-Reply-To:).
> 

I didn't find a way to do it yet. I will take a look

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
