Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68689C55184
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 09:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785835564; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=aESFKFz5Yf8AcGDSlPDmLFfz4n8Sos3+MHzciCnkI/o=;
 b=UQsePBdLf0bs/1wpGGW/xUb9VWzA13JxwsQh8BS2ixxtNK3x250BywihphAo/w5QeUi04
 IYi88YlRkwWFfJ0X6CEMDu7iXiPOMPxjDxqEO1ev/tpyrgzg+NWt+818PZFUci32dgtVSoK
 dMxxISeh9QuWEkiWqJhgUq1ISpFDbJQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5CD03E5A26
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 11:26:04 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 072DA3E1502
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 11:25:44 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1CFC21A0069F
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 11:25:44 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-4953e04ef16so30794825e9.2
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 02:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785835543; x=1786440343; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=wzUltUx/6wX88jI+91x9PG57HO4kM22v7rDqCUScseI=;
 b=gp7X/U6OfgO5TTd9efblg0orWXwfX4mbUyUuAnpmFw7boY17m+K0tA1PcYti/zYEuS
 qF0yfX9ww96MAla2h4j10ZO+dOUlIY5w9diSGFiT2sfDaSeh7tvoOeOUjeT2wSd46Wsp
 IJOqSxJRQpwaDfYC49fXyXprxgGFmfuCeVRArRdQpyJ+gnWTnU1Z5sU8XF2dtsD9LnsZ
 mofWaxPkOTEEV35y1ksjgwJIEecowguqGYAi8afZ3Fvy216dhNHPb9r9vR0vEwKZ2P1C
 hrVK5J8ZNqcNHmc2AJjC1EK1S2VKQx/LPMmp8l5uu4ht49/0Pvsd6UXvBRodXwRWCbFD
 tFrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785835543; x=1786440343;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wzUltUx/6wX88jI+91x9PG57HO4kM22v7rDqCUScseI=;
 b=hYhtDTRcOJmgifitY759HO4qjlXmkDExKfCMdLSrokzhm/rZMMDabLCmqWWl6ESU/H
 RTN5BGIq1+rM/zu7OP0AUMn3iUCqj50323AlxobL0DUkRl1ZElmrbijHQICsAbksl7nO
 tdtavmEIwg+SJiaC6T39EF8hRovLpPv8/Bp3/gmaRUs04sdjbAstpTSWqlPeuGt2AVAR
 LOCHdVi4lcTXWDsKjaLne2a+i5qBqpDaanQudTOTgpsoVWs12q4EBGzxvrzmz8v9Lt0P
 El+0R/60eWatPN/3l5heZoxljZgbP5yx9g8rGg0aZPeywlx1wy/DcPDM/aKwkaeXPlvc
 lbXg==
X-Gm-Message-State: AOJu0YwdgxJH7r8dGfz4TnlSA5kwWL+5de00grQatYQMdX99RpBZcp9Z
 mRHoy5q2pThDs9TD76opkgD3+yXvXBOokGGDDaVLKti870QuKOcKRy6bl08qU4d2jl0=
X-Gm-Gg: AR+sD1349imITHkfSL0TNtGaclJYyvTfINgllL/R6h+GKcFbelYonNwc9oucfV8TpIB
 V59wlr9CMFz8OBMgFTY8xmFjw77nRx2mzjNuwkTzpy+WBjDxHjVDXFyJZJ2B9yjcVr7NU9cX+gH
 axfwMbXjrnXKd45ulJ6lL+s18HLw7kSjSA8M+f+EbIWabOjy4xoZybuH6L1jfdimvBz0mqZuqvn
 hPHBnpaQ/05GrKrr9pQ4QrJ6K6ASXzYvL9SeKTj5vJI8IBOsaRghL5QxTHkP8IkbhDH8AkdF64O
 wSzrYj8i8EfillYIFzLUhkYoCivPxjtYDMSQBFcDer4rGRCBBPBz7Q2Jsm3bkM3zhW2xJPhYGJO
 BSxabieUTNdDSvuCXwKyofK/OmkFb1aPv6teHHbAeE6l9iVx5HXmZrLflKCYvkLnr6pEF1U6Wdc
 oa/c74k3wbcs+PoAX4YZHWULUDpf0DbNBU0Eoz+RMLCKlpssEGvYh3ZeBHP9Jk/1b8+Zo9qLQOw
 XuCaAf26iFbanJpR1Q0IY6g4CSIlFA1CliNdBpq08n15dQlHW51E6wLbVgzH/+ISBXLnEBwh24U
 FmY7Zm6YWFcGiIBbv96k4ACKe7wrMjuA0zyS+n+fHadNfoN6
X-Received: by 2002:a05:600c:8b33:b0:495:779a:ed33 with SMTP id
 5b1f17b1804b1-4980c66c798mr346925385e9.7.1785835543446; 
 Tue, 04 Aug 2026 02:25:43 -0700 (PDT)
Received: from p200300ef2f11090032755c67e6ad8da4.dip0.t-ipconnect.de
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49807b84fb2sm193708795e9.1.2026.08.04.02.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 02:25:42 -0700 (PDT)
Message-ID: <6a71b016.fe7f0a4c.2781b4.8b2f@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260804-shell_oom_protection-v3-1-fe42b15d034c@suse.com>
Date: Tue, 04 Aug 2026 09:25:42 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] shell: enable OOM protection by default
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
Cc: Linux Test Project <ltp@lists.linux.it>, Li
 Wang <liwang@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li, Petr,

I updated the patch and simplified it a bit. Maybe I missed something,
but it looks good enough now. Let me know if you still have some
feedbacks. It's somehow a new v1  :-)

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
