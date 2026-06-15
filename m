Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C42CD98DE
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 12:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781527465; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=H/S/jStcludwuG87Nw7EnXQ5bCFgF73B3S1lpgbLIzTaXtBHLSh9Vwxmi/FmmG2E/dLvt
 wt7RwaDnuSUR+1UUEMMbIlMd+h167Srwx7z6TFHX6RxV9Swn1Dj5dHX5qFY9mjwbGCI/mJQ
 +H0PQrXPK5yjeT1QN6uCe4tE/ZVSbrY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8966B3E5D97
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 14:44:25 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1880C3E59B9
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:44:05 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 2DC3C1400067
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 14:44:05 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so19343265e9.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 05:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781527444; x=1782132244; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=V6Sd5D4UuyiwZeINg1cCKOE/MCVQHsE7DUHSLICyTeTXEDAToFk5qha35wQa6Kjiji
 ds6vRkitMgkty5ELj43F7qIhioBaDuTxCEgWhTYfsV1AFc8/RrdBIsQF7FbWChihtCdv
 cBja91J3EERhcmVPFUH/j+TtBL9qskyaQAbF1UvLklRyNJVo8Lu6536fIa506lxVth5n
 /erKK4a7X11iyvIPjAH1lhZROnkZc4+va9gvgaPegwinQVh4xI3cXLUR+KvcCoyHz1GQ
 qH4VfyV1b+2sv/2RhOuOD7I6oYKbsswoKwErvyP806aL0NsHMaMRVsF44oZi3kVgkojR
 3Sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781527444; x=1782132244;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=YkU3YMpopzcMFy+bKCcuRdXJeG6kILyEX8pYEOYYuWsV92kSpm9yRDrCQHOj+mZ4U3
 uyRkoEIPDXhz8WqgnsKaa2LlnxL0YTQFwwP8jIPM3Ie9AD50/vPkxoLG48F1smgQHyaA
 bMkZDCpZnVPovNVulMQaSN84ElhE032mg96d4qHfJvh70Fk5KnfEd7RYW17MtxXBuKHk
 fNh6DpMfqnu+6h/j2OPJrq/6+O0lzfOQCRLmGa9p6sO6iaA9qdogclGJWqrgcqBG5Sv5
 sFv1pzhKwNOKdOpLCkcPdFDQm1MerIAqv84qUHo4zG10iUSzDvlahsTIIf23f1VMdeQA
 GBYw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/b1SdwWqf7s2ENAKnkPtgqeD6J9Wk9O7dK3+SPCXZxoT2tkW32zs0RqmPh9UVGGSm/EJA=@lists.linux.it
X-Gm-Message-State: AOJu0YwlA7Ulnz440rOKUTTZaH27qsPA/mEyK20OJG3aUfEDLeSBDq+1
 sR5wK0kAYGmCJ6NPo+oKZVN50GSBIJvIQPHyxUoLuYbTyPgEFbUwtnZu21bvnTJT7Z8=
X-Gm-Gg: Acq92OHLx3k8ZaquR08cahHvSBpVZCZw/dZZqjyZZWBkUU6i2xNQhceG+wIle8yKMeZ
 /ZVGEi1HYXlGox2wcunwHkysnPSjjKWpH9OqMVMj3iIbhgxSTaqtfuRmSGh0sKQJPpSK3zYmOQO
 PY19PlavGuUdYzR3r4h3ekyqetlaFS8tgMNcB5JvVZZKMflKu5Jnvm9nL4ieQ/Bu5AlTEuhDZXr
 /j/FkFt9e1C3DMXoH6MWoTvytucW0JhI1g4YIQ0R4oxUcKf88p5I1mScR8sZ6efJoEKXqOTk+HJ
 pL7gW6kEiLtmotWwx+RPRIPtoXOk+mxaR7TtBMtTRJahm1Jx0aAtF54vQoRQ3MsDL+HnZMLmPDa
 lmCWPe60P4GXUkeqziTptPjrurtfjcvZc9k/QZ3abrDEm8jenVN8NvlOvIHsAfFvWL3+jerpZ9h
 i0tmH7pN7GSYTHTMg8RNVdowB0qSH83j7JoqRWlswZUCfeQYRv2oiD9vlrFiOlBP5fdYZ1Tl6i
X-Received: by 2002:a05:600c:524b:b0:492:1f06:ec9b with SMTP id
 5b1f17b1804b1-4921f06ee55mr144942285e9.24.1781527444358; 
 Mon, 15 Jun 2026 05:44:04 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ea9563b8sm219557985e9.2.2026.06.15.05.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 05:44:04 -0700 (PDT)
Message-ID: <6a2ff394.73de60af.3a056d.5618@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ai_x0tylGb7f-XHZ@yuki.lan>
Date: Mon, 15 Jun 2026 12:44:03 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] build: run make check on test sources in kernel
 module directories
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
