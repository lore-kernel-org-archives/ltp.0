Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EFB1C5AD4E
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 09:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786353488; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=KsJUK9YjWNEYPv36+mOXvAVYJhiEaDk5WENoysDWYpa69i6vvIArcphi2DMWi6PtT66al
 G0K2MWmEmkA9QQZ0Z4j5tfuFoLU5dSbdoaRn53VvoVcpGPV4YvSjM/JYtzpOWMvKxVjK3nS
 nB7bV9+ZG6V6P7bGf8/bOFGThNKa71s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E915D3CE465
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 11:18:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 22D713CE59E
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 11:17:33 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 8E49F2003A6
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 11:17:33 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47ffaa8ebbdso1343674f8f.0
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 02:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786353453; x=1786958253; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Hfk8Q0mB3muHI0Z2MZ08na1llKsxjwy9hR5ivbfT6bK1TsdeozN9MqeD7/ODmEComo
 SpmGgup+qM1FMGhg/NZM81aDNtfpximwotz5Qy4bxWpXgVM3kf512iABkUsWiAA7Eaok
 gc6/XjE6ldbLqmxpgI74tjVGw0iIBKx8V1EzHiT5oGGfSUL4K/1QeEtF1LD9/kg6tN+L
 SzpOOXMcB5lBRwr4dr88hpSshw/X5Et9Gr04PdxVVXJMEVrdyuBu5QDc9UOQSuO6x6aZ
 z8RpTham7F7BD9FmUDH9MkJLtox/qwhPS6Z4WzZLfg5H6jwJxKBe86j+uTW5Vu50jgPF
 yPyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786353453; x=1786958253;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=OJUjjP7RGqsU2fOyR7AHoUnKfjs2rx0viMppX90VTlpHHHkFbbKWAKPEiye/ngATWX
 IAIMOtOxy63O1xVQUTlEPhYABjHWF2wQrCrqr7SZaKRwNG40wzcXHJoOp1TEwDWZYXbt
 Zi4mQx8DuXaEL3xy9OMgBct23eaXc5VOqMKgKXaH0JxDEETdubf1FQFPCN99EsOLWXSu
 MUX5oD65Svu1JKSc1BedsppuWRdlHowAEPbj1GWlvYjDzB2cVSCk0VULbzqeYjQSJ1yZ
 ngC42wukK5yP5Ynjl3zmumCEMcjP+0DWGbW1gJCSrtsK3PyhyuIYSOphRiI3tdgQkNIS
 jAfQ==
X-Gm-Message-State: AOJu0YxT/u5GFkzqbzUZf7FPTofmBy/aRDcHCKqch56FTFPz0tdjPZxZ
 XW/DKZwbK/NouN53KXL96BPFadFcEfBG9utVtOZS4Hj6mbIAMUL7HzggybXt3pjeW2iKD8KElFp
 qA/3T
X-Gm-Gg: AR+sD12CFdXoT0QQkAEe45iX9p5QoFiAxHqCSHbqUYFOO634gK2Z3plonh+gmpaCkeZ
 78nFDIpBNr1hAGiGNlaYdE9TAzk598yHNef6f2T8A0bbhWNpLxdBEYrH6wwEOVaDiUew5iEawp2
 dEQlxExdJw6CnlOGsnYgzQHclgWhbtNAO2xM/sfKckCzOSxsCdG3COidR/9421C7kNGUgsMgkcs
 JciIGPLIzyJF9AytmYwVg7L2sHyJAKVhnUHgZ4sh03ZI4MTVKWC9ejVfx7RKLysXwFjPi+XbTEv
 E+6/e/pBUuXpH6Ue8TNYcOGg2gQgoK+2IxrAbkV5JhLeNe+UQUHUt3IycW7o6o+VAxZuCnGlNni
 OUpZXBOrdLivb2M6fOxMx3s5/z5QXzXLDHrFQ118QHuCrNI/gqJ18+2BOgPT50Vm8Sh2vWqKKPr
 AWDEVkKhb+Mfc8Re7YX60YkFaCoFbxQpbbMmrOaGYcNTeqiyf1qYMsJuF37pga4B28NXb6qw==
X-Received: by 2002:a5d:588c:0:b0:47f:eca7:ad1a with SMTP id
 ffacd0b85a97d-47feca7ad3fmr64996281f8f.1.1786353452994; 
 Mon, 10 Aug 2026 02:17:32 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-480021e8cd0sm32381579f8f.17.2026.08.10.02.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 02:17:32 -0700 (PDT)
Message-ID: <6a79972c.c9eda3e9.137cc1.cf31@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260810025817.1665141-3-wakel@google.com>
Date: Mon, 10 Aug 2026 09:17:31 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/2] lib: Use backoff polling to wait for loop
 device nodes
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
Cc: wakel@google.com, ltp@lists.linux.it
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
