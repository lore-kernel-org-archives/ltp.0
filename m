Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58695105A596
	for <ltp@archiver.kernel.org>; Thu, 12 Mar 2026 13:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773322005; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=LzdTgLRjhfF/4HmD+WOkZJU3A42I2PC1mdy6RjtQzJQ=;
 b=qHwd61lPPsTti1qu/UMl9I6twtEIA66b3ISDa8Kh9uhlsduMV5Y1lJJvjXrHDt33xJbPQ
 jsUGHOb6KGccKLbJEAfJlB4jbfv/luVSuh2P+S+sDzXxHPWZnch07+Oo1rK7bhC9wAEOi8b
 HFns+ssGDP+c3HPGoy4PsqPndJW3w9g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D36303E490C
	for <ltp@archiver.kernel.org>; Thu, 12 Mar 2026 14:26:45 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 69A353E11EF
 for <ltp@lists.linux.it>; Thu, 12 Mar 2026 14:26:23 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CD5BA601D7E
 for <ltp@lists.linux.it>; Thu, 12 Mar 2026 14:26:21 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48540355459so8828795e9.3
 for <ltp@lists.linux.it>; Thu, 12 Mar 2026 06:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773321981; x=1773926781; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=I1NO0DSSF0o+MmLjTkwRVDLL+9y9C08wC8bwfnaNHLI=;
 b=WPxZn+uvqst4BtoGFZ3DpGCJtd8d2NhyORKutPh8sA15SOqJk15bDzstJLLFFf5OoD
 tDWvT6g5BZE2ZG3u4PE03+dioVpqF6xWcnD+6JGgSKRDkpoph1aMchmWmIjcpSYov9yH
 o/EPKL5qCurJbHk4pPpK59bpEISpKE1T7xBC3o8T1hlyZyslyg5xaSbfp1ZbcL1oQlWt
 jOZ1wWcCXZiTWifDqGcfmvl3oolEXjSHR8ItXXhnEKaSHXHMtl4jYgTdzKdCnyEn8w2l
 MZ5faLtJqgW5kOAolB5lhTwHJqbYCYS4ZAlPM6Kd0maIVaIpQ5O/zcYReof3tM6WtzzD
 p8VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773321981; x=1773926781;
 h=date:content-transfer-encoding:subject:in-reply-to:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I1NO0DSSF0o+MmLjTkwRVDLL+9y9C08wC8bwfnaNHLI=;
 b=ljpRTeELZXz/pqfn4osP0T56TH082gpt3PcKJ4rb0BshEDKbclrDUi6JuxZ0jwZOeQ
 LaTzWWYTGS13XPxL25FMZEgOxYll1B0XClGK3EIFyrgqr8tGaaUAS4AepfXD2v4xM3YA
 YLE0htbp/TeRriJ2yQ4oHqP3roQssdT2iXS9cl/HfxP2OnRsmCcPreX+yGAarpIGGJmH
 tDQHuupoUTSzfpUJTLLbPzUw9XD0FGpn7rVrj84rim2Jp1XVXvEEKt1SSijUrSH1vZx4
 NhIyln+dpjSkiPvzokWu1QdIlfycix0QLPezM9/3nrsLfhTN3ItQXKx4bY0xgmm6a9sB
 7/Iw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvtli+dh4pbCKQAwm7BTheyu2cjZ+Hmjhbpun7sJo7e7+jSUG3vW0wuWhMLnM/l/4aBtQ=@lists.linux.it
X-Gm-Message-State: AOJu0Yw1LC4O5MEOaP9JvywtoW0SYA/tFCfox5uLXrt2q1XZuERKUZh9
 06xpa7Cp0qMY7RyWEb8f2GCdq2nTrIt3dAN1zIUmMbuyLhN8TyVOtV14VMN56tUW49c=
X-Gm-Gg: ATEYQzyJEkmouw/oRsQQq63Kx1R9jXxQlTwF6gP0jdQJszILQ6DERyzoDmNaB2kSid0
 vhcEcdBt49iCZ63KGqN1ncLVc7M9nilfDamO6zE0XCrOLL0TM9smg71QZnTK9dAnLCos7oq102Q
 EbGmGWarAETdL5AeQxrONSlCTv9eVb3XXWXaAf7QmWHJsm8MeHcOSqkRzXdlUOUlAI4jc6DlN79
 poYr/jyiYH48I4HJf/ZQNo8BhBSpsR01U0eDTe2PL7MXNcZVR4ERaYYdDvwiwsKDcqhwwt9D+oi
 a+JKjszmht9bcH0zXEcCUFfLIM7qbzsB23p4ywgPWG5MKlD6I5U62MBJh5ELi1RVMxyA37bWa5/
 FeFjzK2ivZvCviJ6+loLBEHtD0KNXz+k+awxDZhc1bQTcgNwa6ZBtthdeiorWfuYcj/F9yHhYns
 A4y15EyyakcH7Sd7YfT3zxy5iGYgGl8mD7RU5fsYCo
X-Received: by 2002:a05:600c:3104:b0:485:3e19:9e01 with SMTP id
 5b1f17b1804b1-4854b10d0e1mr104250995e9.28.1773321980979; 
 Thu, 12 Mar 2026 06:26:20 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.60])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541aa73dasm664948745e9.2.2026.03.12.06.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 06:26:20 -0700 (PDT)
Message-ID: <69b2befc.050a0220.2181b9.a09a@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, ltp@lists.linux.it
In-Reply-To: <20260304161425.12461-1-chrubis@suse.cz>
Date: Thu, 12 Mar 2026 13:26:19 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls: newuname01: Convert to the new library.
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

Feel free to merge.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
