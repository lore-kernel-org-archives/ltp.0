Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71703C44501
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 11:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783941139; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=pyQWIJ4GegCNJX6z7TLDVa+ec+k8BOhcA6Yru4IxinE8VNJp/YyjDs5bMjmaSJVZBDX7n
 LJn7f2Zrw9C3Fut5LyY4VnrRudzprLogSZsxD8FNTd0r8GyMAdrZGSDliIYFKQPSFBOnAP4
 CMSiEr8/1CoRLcfIEYNieZTh85zkNbE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3AE93E5D41
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 13:12:19 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 033203E5CC7
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:11:45 +0200 (CEST)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9731E60071B
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:11:42 +0200 (CEST)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so4723872a12.1
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 04:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783941102; x=1784545902; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=AttF60u8RLDNSGfT52qYe/KhnNesa1Drl6QiYkjDhz88hBYUj6yr2UX+FTiGauABa7
 APWKw2DXZQQCTnbKC1EkIhifulgLG8f9dxIOFVxH6DkM7eieWzyjPXPtSZZ6tfm5PPy7
 2Qal3L2Y9KNwYEuPleFKMVOC09agoOBViq8wT7rgkOpaYz+j33aHBV6BwNxy2EtSLj45
 0ppOF++CzoTjZCiDMPv8hrQzICH8vM1gRZ12v2MGxIL3J0VUqZLcwrdQfg+9nr6m3lpa
 Dnt/vSUNOZTw86drgzkeWOYGsyTpkYO+qi8tz0Z2cphM+ivsxGRht0gaY828B3HYIdMq
 ftrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783941102; x=1784545902;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=hHnxMffnmLWRvJyuK8jgXAeNmmRRyL2cQmPlsX6/s/CSaxfAklFDA7uu7Gu9hQUOEL
 6kWu99tpMEMgV0R3/VP76wA382YRPKEOuvXowL4iCHjR9pcuM5EvOneDYvUeA4bmBC2n
 tAvVbgAQYp6Cus1Rjh2bo+0Z+U2g53sOJF83lSilkhbryN1EZSJAm45yk1prGePGsDJI
 n5bS46gW1SgFCVJ2mrpS6jgcTD6vCSaoCxAHd5udaO8IDwMwiN7iJWDqOKKwj1O5715g
 z7u/OoWttILJMBvpTCVmExoVqrZd7wXtjdkKBDFVAfv/sdnXNGDd5+S0wdAtxVbrkd4N
 TAWQ==
X-Gm-Message-State: AOJu0Yyyp5zBFa7aUSbXBDMVEQBM1ymKGsiROljtzxckSX0q7Vkjoi80
 IKRsmVSXWBiOcAU7L5nz2fxEllqtI8XOq4fZy4MbohXFBMfzlSJTBqeTwokHTMy1ZBo=
X-Gm-Gg: AfdE7clM3s2zVX3p6OCgAx4VnKU2GmXexS7BofM7o+HlR2fh4T7hvQj6M0pm5+tAQZB
 +w5Jlf7z15Kd9T4Tqn1smzy+wXvz041PyZFocyrCTCAWBqmEDY8KHJoSFzIdScQg/UhpauvAEeN
 2x5pcpfLmfzVIu4YrXFxCcvwOnoBDUJO3gM6iap++JTPb8aw5t3mbAEkojNQLnG/4VAKkvswKaR
 BlPteqA+bkdXCeOr4HDKz2SsZO1Xqm6LnA3nGdCFbtNM5HuJOQZkHfLKQUscyczIGR1nZvCG5rM
 VERP9ncXzh/erPGoGGAMeNoFftRvXGKZakWcjG0CCa6+/Wwb0stjc4K6MOi4rDlfj+mr2CiWVOC
 owaxzZIYfRyE4Y0vQuEYyzdEKtUqehYmS8ecCRGbF5GMrrBCvZtpfg8drCVa9ENpZ+Abp35ckn2
 XaLj5GHVsdwUuiMnh/g/9JnwBDaggIzHJX
X-Received: by 2002:a05:6402:5255:b0:698:aa8c:c15f with SMTP id
 4fb4d7f45d1cf-69c5f1212e2mr3667140a12.22.1783941100199; 
 Mon, 13 Jul 2026 04:11:40 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-69a19cf68f5sm15293863a12.13.2026.07.13.04.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:11:40 -0700 (PDT)
Message-ID: <6a54c7ec.33738867.2304eb.8366@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260710055556.1109220-8-pvorel@suse.cz>
Date: Mon, 13 Jul 2026 11:11:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 7/8] ci/tumbleweed: Install diffutils
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
