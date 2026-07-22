Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAD1C4453A
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 23:05:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62E273E93FB
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 01:05:52 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D7B53CD5F0
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 01:05:37 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 272191400B83
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 01:05:37 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-92b21f65b60so620170485a.1
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 16:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784761535; x=1785366335; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AJa4qB4ZZK2X2iv7Z/ol2+ZtFYrsONo2T4KaRFhOqiw=;
 b=XqWwX6SNqjsBKrcaE+cZAlNrQeB2/611XUN7JxnggXp2ztC+GQrTuQqdKVUwEJ4bd9
 AxXqT0+RMN4xB5Jayi6fEHzUPTMb0BZpTCb3ZHKTlRqpvzjDpycX5cnxamUnhD+wckzi
 AKLKabMP5L/WhGY7bvMrOWxwD/e/a88/sqSXKZX/6/wsqWRilO0m57KHNCvekFWJtYHo
 yvxorCeoYbwcn9HbrdxbjR46XqwVbAbmb99VOHWVy/6J27i1uw6Z3lSVVZ60mAi7Z7pY
 wzUvCUCoy6KRMJi1nAKP9bk9vPoy9LpZ723/w+1398s7QPJTBstO14zoqInhLECVOupM
 ho9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784761535; x=1785366335;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AJa4qB4ZZK2X2iv7Z/ol2+ZtFYrsONo2T4KaRFhOqiw=;
 b=d9a6o5T+8WoYzcz5THLdi7Dp2aYmw1WiQ6KRlqPTSnz81mucOX+eZiJryjtKskWeXE
 LidS0fTfPL8yEjkMax7xnV/ZD4yP0aD19CPSe8fcUx1qPZ1jDh+bPFi5s7d22dmU4ORR
 3g2yO88iLN/B+csFNJVkjCm7FhABvjk4UKFpvCHX+QbTGQpTj/8pMp0Q3/6wHXmAAe3e
 WOi9GERqOZSPAGQxc7k9xd28RnXcM2tKzvI75aDZ9NUNO9zHbNRDhSPKi0OoQhvMNiU4
 UaygM6UDAw1Vsj57T4y129hIgl+6S4QnsdsEDsvUYRdFi8OaCfG7g54N9sD4o45jgIDv
 Ze7g==
X-Gm-Message-State: AOJu0YwSLyfhVoz69PrzzPiqO6O48i+dteM5P111VwogaI9lCGvkhVGF
 hNV50Pd3h/5a/Ogpj9w9IpNSyCx20QD0cAGceYDwAgKUzC7H2/448Lts
X-Gm-Gg: AR+sD13eVg8/CeYsVljI9YlCGol0Kx6p2UIm3Qqr7jEJeJHs6QxKPYyhr0rAaSG1DGb
 6aRs5FCNogVF/W42R1+YZb9E2GjPNVwPIgCaOItzqNZ1JdEvD/VuTwkbSxcmxBLi2e1S2nOvjAW
 geSHUDcT+MEHOec5jdHhr6v19/aFvdQGAQxTRtZwFzugmrkiQRtzbz39SpYH5q2qEfuVvuepZov
 vZkkxOZQi3mj9GW/0+J4mwMW9c2u4Nou2C83ll2T1turwFKCjbHjD5fjE5hgPzmJ2rWvZ7oBsj8
 vn1HdTzrr5XGvhXqFlYJaAi7xv3vg7o5Rfk4/ySDclPyACpVcDDzKbPXY5wS/xQ+v7RAoAwVz+7
 PA3FZo2eAERh8jvHRef6p0OhD1tARctbJ8c9nnLZw9gSZBP5pYIbd+AFyrvdyn+PkYWf3jXlI5j
 +AwMy5KDqJYxXz5NnLxJq6Hct3rPr6S4J8iZWNtFGI2P6r8XK0rxskIP7kb+US8wb2Wyvl1yRf/
 /CJ6TU9BydvwMBLTA==
X-Received: by 2002:a05:620a:40cb:b0:92e:5949:3563 with SMTP id
 af79cd13be357-931047ca104mr31903485a.15.1784761535533; 
 Wed, 22 Jul 2026 16:05:35 -0700 (PDT)
Received: from
 runnervm3jd5f.xoxzbnckc3tuvhtfp2zpexthsa.bx.internal.cloudapp.net
 ([20.83.175.231]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-930f6a41180sm268928785a.34.2026.07.22.16.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 16:05:34 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Brian Grech <bgrech@redhat.com>
Date: Wed, 22 Jul 2026 23:05:33 +0000
Message-ID: <20260722230533.3999-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260722212646.2340340-1-bgrech@redhat.com>
References: <20260722212646.2340340-1-bgrech@redhat.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve/icmp_rate_limit01: Lower icmp_msgs_per_sec for debug
 kernel reliability
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

Hi Brian,

On Wed, 22 Jul 2026, Brian Grech wrote:
> cve/icmp_rate_limit01: Lower icmp_msgs_per_sec for debug kernel reliability

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
