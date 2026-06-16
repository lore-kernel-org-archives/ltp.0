Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ECB6CD98CF
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 10:09:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9A54C3E596D
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 12:09:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2E283C19F0
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 12:09:22 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 42E3C140099A
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 12:09:22 +0200 (CEST)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8ccf7b7d188so51689146d6.1
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 03:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781604561; x=1782209361; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7R5ZY+VUykJD1iareLmLWAjnNvnN3+Ajq9gp6mI/F5Y=;
 b=PonlLfO9pFhcOh+w3X0nNN1LcrqqaYeNhvwDtwvkHqs/9Xa4/rR/XI3jWWyMnBRnJ1
 w/jgrKQA6GztDKr3GwWh6Ml7YQJwUgVwK+iJpOPSLEOoLv5RIb41i7nhdfVw4w1SBoHK
 f8sM9GNup+RhrwsnP3tZEu+/RykIkNgHMvbdFfj4Kdv2zJ4jSL8WF2QQVSyv7pYxIotQ
 r4v7NrxjYfNE2sSAiv2FwkpKf/P+J0b8rCOvv18aUNgX6AtxA9cgu9tY3poKGv7twWVn
 mwaRMcT7UnP/OPNUlpkgrs+GrmOe1Km2JgK6F4Lk85NP64rVft/0RMuRVaJWYVj7QeZH
 ur4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781604561; x=1782209361;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7R5ZY+VUykJD1iareLmLWAjnNvnN3+Ajq9gp6mI/F5Y=;
 b=kpS7isFeDzgJ2kZe1IH9QTl6Ij/d7x/7RJX2aubjhW8EMJqfHEWzi3r8cXF4Qf0sLr
 dzKPoUbGDDqRmi+VHTP0bF0r5yemhgaTa02f8yeWmBi3BBzVTGqtbP6JYlxFqPr89EDh
 3Fxb7nT1P1lSmksEocp0VDEm0J588MplLow7SNOqx9NeRBF8G7u4jhQtYY1y5SzmCbA1
 xhsoxRk91jbTTtFGsAHfRLqrQSyOKyYE7rE+rl8JoumeLvGasxOywPprO2GG0JeXMra4
 gy/xZt2v4vmg9YG+ss1mS8nU4oudwtMEOg1gJlsu6OE0E1+i3KytqXgrhRgLKd6kKvqZ
 TgCA==
X-Gm-Message-State: AOJu0YwdP1g3pCiUOdhhEUdZKOGRYXfDyCLlod3PzQsesafAmFa6vut1
 JJFuKD3/pf/thgz/2IyjCxgscGQlIz6+tT2oOiDcvO+UHL9uQOin/xe4
X-Gm-Gg: Acq92OFUd0m4p97P+7I+ePf3ivg+3F2WzEG8BD7GBsraCYFIiSAACU9lLOjFUdvLkyr
 6i1ssRZpA8P/MpMDfC5GI1XicJL+xzC7vFjWwpdNsxOuLRSlUKQeS6OM1YISZ377Fng77mOqCs4
 WktLX+DnfceThu1VVu0hpNAn3jhTlnhblmAdF+mMueFfBcosnAbDiJldz7W8udoqhs7reRfhwLu
 ZaL7vklwl9SkNLTsbvNJA2SHarzLFn/emJEtoQY7m5yjAsVQG6mMmIxDZjBqEAOH71Db39SAgqn
 ekZARtjnmyKzpY3JDLejs28CGEZz4ZUcEB9iQ8HERHSbwL1tMl5bdu8Nu08YJ/luTm5vDruh44b
 3fPtAES5Nd52uWCagki46lOuYn0mjhRah07hMc0WItB0sEXuBCQwU5ABXXqxix+iUEiuJJ6+sAG
 E9AabzwvKmhDb2QeS/1u5nNKlls6A5yQ53LLIB8SgFsxqGzQDApEeVHjnGdFZ4041+pNIUHmwHT
 eEYxl6yAnj4AsquRntKIpb+sTxqEaizN/bV2Hg=
X-Received: by 2002:a05:6214:5684:b0:8cc:edd2:6a59 with SMTP id
 6a1803df08f44-8d9fcac7db6mr60711586d6.18.1781604560863; 
 Tue, 16 Jun 2026 03:09:20 -0700 (PDT)
Received: from
 runnervm1li68.nymdafkpwoiu1hemdoykmkvokg.bx.internal.cloudapp.net
 ([52.226.124.21]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f55bed3fsm27137956d6.44.2026.06.16.03.09.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jun 2026 03:09:20 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Tue, 16 Jun 2026 10:09:19 +0000
Message-ID: <20260616100919.4031-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616092300.177787-1-avinesh.kumar@suse.com>
References: <20260616092300.177787-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] tst_security.sh: Fix bug in tst_disable_selinux()
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh,

On Tue, 16 Jun 2026 11:22:59 +0200, Avinesh Kumar wrote:
> tst_security.sh: Fix bug in tst_disable_selinux()

Verdict - Reviewed

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
