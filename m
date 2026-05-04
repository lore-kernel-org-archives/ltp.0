Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C4ACD342C
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 10:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777890714; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=CyVkFxXKD/lmFBvChF9WWMlFVggs0vZkw66Jx/YClCuW1LTATxdPIwb8QcYq3sJhPnA/7
 HBihySlusdhja9pvBdtpoph3Q0ltqfSzZsSfJZE3QJJJONZAbtzGZgs4C6sL76lFzwfKS3N
 Sk8v3+rW2TfR/NrdtL2yYuaO0PasVkM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3D993E499C
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 12:31:54 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C6993D227C
 for <ltp@lists.linux.it>; Mon,  4 May 2026 12:31:30 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 231F66002FD
 for <ltp@lists.linux.it>; Mon,  4 May 2026 12:31:30 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso48928355e9.1
 for <ltp@lists.linux.it>; Mon, 04 May 2026 03:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777890689; x=1778495489; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=DwgiDiXYeaskffjBd1rCGcP6HQQR/xQKiw3cOsO3aWOUQEAMPQJFT/qX/cYhTQUK9s
 taGxThCmbIMPmDz51YKKlL4oR9G3M+Q7ixTeEyWHkXLHKVFgm5agZFBqi9BP3Fp/dgXZ
 Ik/KNVwtaWm5hlAbSzAuo9pztMFDMGuNjW/D4FkYCx4LKZvdHK3D3EVIOiIwu8Ios5sI
 f8B+PqXZqy0HS9iSqNkJYbKldD7d70xLeVx6aKlgwNgbszhNVFp1JjF+nFvND5HjBTIU
 8d6gnRpKyF4huYMePxO7ZJTzYGn8R4m3O4KfjQ8cXv870WXKoYWZ78GePH0RkNqCSTR7
 cm1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777890689; x=1778495489;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Hha+pMy9ETipsC8PwG7KOzqNXo9OZg/21DYlR5m8TrUCl1QboZ703ALhsKA8bYyJDk
 k5RP4GoLlHWQLbiHLgszzsGt6kCl0O2ewM0qV9hf8yuoS79Nrmqj1nXCEdF3q8ICl4lv
 BEux+Byx0qKgIf0dyK7MKFLjDZAiw5D+w/FPX3RarQuDlbDhxULjyRtjCIFHklUdUk9z
 8XVjaakWGSrAtC13BsFo8qDBgQ+NEdRGCtdFTR2l9hm80ODNeYDV8H4pwIaydJXBGxWx
 G5Uv+LJdK72w8DafPjjQFb6ByOFG2GdQUmfKqT0fcm+OIk3vUdBz6XidZ1+F12TDLhO5
 BbVQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9oJKe/v2u6d5dEAQDn8vdqqSem284LLZC8YMeCDO8w5OvU2hZoNJ7snWFNb0Awo6r6o/M=@lists.linux.it
X-Gm-Message-State: AOJu0YxVMznixhHPgvY9r5AGK7laI/Tki0twTun4LDJcxb1vwDjyoHBe
 0cRPZTVq5Xj0jNYKsgQe7omOCcKv1np7tvBatG44Ge2fMaPUQBnqNbdApsqC6tsOwD4=
X-Gm-Gg: AeBDievHld8m0jBJWtw+R37/zd+9l70bP6GwpvCu9i7zNEwn1GVGjMVnD+h5GG49/7i
 ybTqR7oT8jpTEwt+kvq9EweutNpksumHVewfouvLNlH+gW80dIltAkuSmgSINQjg3y3JLnAEuOk
 WdmsX9/m47WXbwE5K8EmZ9HYVkdnDA2Nplu6xMdyqA9mEacLx+cieZnO62vUBmK7T4bEqtaSl/G
 0CGEuPe7o/4nzKRPeChSzCTdAW8nn9dPbD4WBFn16CVnvYdelcOZJrhfla1LkbLClgVlTRD+n0F
 EbzZONSopvKCsEOKUFTZEeFrZz2LShVdRG6Tjkuqo/CSP7/GBN6spAELU1MsnpfHWoYol8bRefQ
 ltD6gUXq5UMkKUopmFZyABdns0ayfkA4IoXvX3KKl44lQdR+6cZ7AF4SwnTfweL0LQ8oSEHSuMU
 0Kir0ZRU4GV5z6YMWXPV0HIlxUIxCjx7PWboHDO7NFlBEzXqEE+Cbq
X-Received: by 2002:a05:600c:3e0c:b0:48a:563c:c8c5 with SMTP id
 5b1f17b1804b1-48a98639db8mr162239115e9.8.1777890689481; 
 Mon, 04 May 2026 03:31:29 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eba8487sm257358955e9.11.2026.05.04.03.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 03:31:29 -0700 (PDT)
Message-ID: <69f87581.7b0a0220.120d47.6573@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <afhz0P2mrJgBhn5v@yuki.lan>
Date: Mon, 04 May 2026 10:31:28 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] clock_settime: use POSIX runtime detection for
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
