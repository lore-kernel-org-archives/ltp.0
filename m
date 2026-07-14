Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE1E7C43458
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 08:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784016567; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=AGhA98CG55qTFHGWqC2cJcNdcluB0x2q+E/pfA6qvYg1qFm77bcHuhuk24V0kfXoQUB+V
 /XFn/XQeLYhhDp7/uGGdsLwkRx8ouV+eIQhB7Pc+vsZN3VAUryT9MtKCd++ylxPH6BMC15a
 QHUBBiT0FVJheOKszqm8h8n8ELm1uTI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CEAA3E2618
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 10:09:27 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C92C3C17CE
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:09:06 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 04185200753
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 10:09:06 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-493bc8fda98so4816315e9.0
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 01:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784016545; x=1784621345; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=TLDMKCk3l2ZWY3kywY59nCCd97a/B2UBpJxsFIEwUA+OxBUcEonb7byfkjgPwUsXpm
 qRtt9/++WQr6R78FRw47nCK02iBqrs3/SvEHBn6d9Iw41g4xvVxFm9jHkY/u3IgIDs7L
 6JbElchzTiZsWr37e3heWcFxXsvan641toRYDRCaMwPI9muUmE08suh4C/33f62D0PrS
 NpM1CZ+v4H7141sEIzRuFeg12eVfMz5qUfYcQmNGXDs2Wc5bmmgStvRqp3hZhSpR2xZG
 Qqwt4w97LaP9BRsWk5mtn/tY7U2zR8u0wuqaPhuvUkfBVmmWicq9DWBZ3EOckNsuo8f9
 gAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784016545; x=1784621345;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=b/p5LrK+o/nkGHDhVH7Nf+Ri1VWQjf4GMBqzeSAYkWpNgTfHlTrvUrC56QeJKOaE/F
 3tIaj3hz/9Du/k+B0HbXUJ08sn1nlqoiseYReweYJhHNj6+QfAEJLUnkMAtSQkHg0sNA
 zlEueN5UGeksmLkqIVeWmBg/xbSS5oru+XorC0uGND35T/+0YS86PwFduETYakt1Aa4k
 aoC+8UbAtbQdeuEZz12q7hUc2N+ZkJQPWbyHZ/i5sUUh6ZlvyRx3fE7RFkAJzj1DA1wh
 AHTXH5ZZbIPqHmBjo7CA2IsjXFqdi9ViSY3zBAbsDEOOPs7TByldqhkzJ7Sghi6EW6Bp
 Tz4g==
X-Gm-Message-State: AOJu0YzdIDlVWcXJ90eJ2KpYKB5/FGs+vfiiacvMbiqefleWDCtPvupV
 v/8B02XGfjkow5tphtfY6gvoZgTp4YgvxFfIJvPcRID4NRJ9gfHSNlBIa9ViegKjCDokoi1H4OG
 2lJph2RkQoA==
X-Gm-Gg: AfdE7clWn4ltSC+PRa7dxgL49ZRqIxl7VA+iII+hEs1MTVWUAQvV4a06IaZYS2VOsOH
 FOajiKQIsM0bmtiUYWiBepfmhSjRQdcTSuoCVXx39f0W82oL0w1FE/DXj2uE7ilJMuDp4Pkwoaf
 f8SxHxDNVT0B3MTr8/6/KcK8ZG3UpHVwYwezEM2Spc9jFU3ZC7BPZDD1XxZ5Dr42rN+tuctPPYz
 B3fTw472hZGLCBWbJd+qizh1Vc/iJi0f9L8MMnQES7kNC5IBZizMkJxRn2qMZE6nfVMbHsjLW7s
 zBcmP/BaYshVIp6TryknxP64ph4K7PmtrCa0SJzdMWVOxb1QwrqOM7LQ8RsOs0DEXkgIoQftnzX
 N6gcxXju3kWTlVBEMfkBS4OxiXgpGsXJGpihJ6qHrHNDQMT4O6bgzm/zoDfr89xK8deThhc0JkT
 Y70z1EEh6+vjDja4aAGOlOPYBUj/gXjaYcrncF
X-Received: by 2002:a05:600c:4f8a:b0:493:e947:b24a with SMTP id
 5b1f17b1804b1-493f87e72a8mr125635675e9.14.1784016545292; 
 Tue, 14 Jul 2026 01:09:05 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495087384casm57162875e9.8.2026.07.14.01.09.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 01:09:05 -0700 (PDT)
Message-ID: <6a55eea1.80d8f3ad.3774a6.8a91@mx.google.com>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <20260714075710.894370-1-wakel@google.com>
Date: Tue, 14 Jul 2026 08:09:03 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] madvise09: Reset cgroup limits before retrying
 test
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
Cc: Wake Liu <wakel@google.com>, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
