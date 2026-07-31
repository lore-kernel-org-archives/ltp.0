Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F81C55167
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 10:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785493322; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=Ojqtf1TmaDVCds4UZE0MDDU9WoxS47No9tu4c5kad7o78LjOGmz53BEdG17XbzP+UIgtP
 wiJ2PyYSZngdmgY/Y3oqe0BTbItTaFKGgi8ujWqh+Mf8aobQBVbPy748BtMuxxXVtgNz5g3
 2Guc3Vqlp708NuHTd4j5H19jDVkvLx4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 46B6C3E71D4
	for <ltp@archiver.kernel.org>; Fri, 31 Jul 2026 12:22:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 666943E2202
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 12:21:41 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7D2E760097D
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 12:21:41 +0200 (CEST)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c15d3cd51b2so98266466b.3
 for <ltp@lists.linux.it>; Fri, 31 Jul 2026 03:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785493301; x=1786098101; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=WxXDUxfJ6UfvvSS1Vj/kkJvq5uVch6FtCwbNT8SsQwz1kXmGCu1HQ5AUfIuyIS503Q
 ic2WXaIs1jtn7HaHGeH8jZxFWUdfutf2D91Ygg9CgmdmGzcfefDRitQKh0wBS7j436MW
 MbGY/0UqCE8fi3CsPFJNltOGO/djQZg/l6ha4XQKkj5dcq7vba4iPCZbDXT6yRUlblsw
 vmrcNBaIT0ieyYnYultbSQHo3XFnMY1mIhwxhlFhbNJYWkbH9lKJNSpMls4v3WB0B9FW
 1M7JCY4ZjrO1Xb0R8gkbBcTY7bJU+Tq5SzaJ7RTVnT0/+/d9h+vPBPIb2SyMHoz27h7z
 YKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785493301; x=1786098101;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Km/PuLn4c+qV44vtdF1RaidC6pbzeAxJQijcuyy1d5RYbLduaz1ffaE+CxGkWmcOOA
 JtrZ4tLf3L9nPyGZ3WZHH/rey6+a87/GXjeplrK5HI0kw94AxHAYg5rLqN5NUMw6ut7F
 fbHMBcPckqn44iOAoZwA/vn0BNm1NnDscBZF5hPAuXb0m7xSEQwdWSecKiM01pkVS+uw
 8DjnckF+GGoGPapqXkqEHA2k0N+G6Sk+Q76jovnkTTFCwYg4MrTyeQAiaVbIszidhsdA
 qOWFIhAy9ramq5dbJn0jdagBeZ8b2N9DNCyNLj1J4fef+kTFOByXdkr8DF8c4+uAeFpU
 E5jg==
X-Gm-Message-State: AOJu0YzBuNchq10VRIDN95pBH6wrk+aZ1pMPIxJm64GBxYWhxLjI4PMV
 Tr1PRNyflphUoPR5bSQDSIW8t39qz/BUAum06RAkfOwMyporvjPSBozgHXkZgsia4sxOTCFQfrU
 LEFbWtjTpQg==
X-Gm-Gg: AR+sD123R4T0GPGISwgu6FpoNDTVWOROjUjtzCQZjwMujds42h+2Eh7cAi6kbuPeqFw
 nn75zf/y5ONu0YwapP8MoKisKPFyfdrSniP387GEX2nxGQpiNzBH9AFkv73f/MGmRL6+l9BUi9v
 Bhd2mcI7QQ5FAajtkcWwghWAuNx2dgZblDF4K18rkukQTT3Gwm7NUIUrhj3ArOkZrvlGsKGw7BK
 LOET2jUhp+6gaXnsN2hwPDpMexewNWFT5AY/cLxdUKqgvdPq91wzJnbDTH7s5oE8pTIUwc6AHV3
 XzsnvbZdYDudrsi94tMpGOUB8qGFccIjLIRn/NKfrthQXpjpfx6aUxmy5xqaXLT3DtK0mSg5llK
 /p0hvabUWa1Vr80TU0pZEDbrbIBS09w6+v8mRKFPQUmjFQup08rF0PIPoqYa2szZsgaqi5Zy5Av
 LyPynDskvnoWoTwCmJIUDTErQgyO4i+z6Wq1X3ie2EZ4K/eX+T0fcl+DYe04iTaijgQlEOGmzEd
 S0AyrgFIFjvz+aP+b0YIzZzkg8rzE+w5XtIQg==
X-Received: by 2002:a17:906:9c8a:b0:c12:9a13:47c with SMTP id
 a640c23a62f3a-c1fd23bdaeemr77288466b.2.1785493300831; 
 Fri, 31 Jul 2026 03:21:40 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd42d91bfsm3576261f8f.15.2026.07.31.03.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 03:21:40 -0700 (PDT)
Message-ID: <6a6c7734.a294856b.805ea.987d@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260731071545.1334046-1-wakel@google.com>
Date: Fri, 31 Jul 2026 10:21:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clock_gettime03: Extend tolerance on slow kernel
 configs
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
