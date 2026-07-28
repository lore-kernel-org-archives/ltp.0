Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FD10C54F52
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 12:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785240377; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=XR6nV0CH5JAI/DKjpng28YaQNvl0DEeou/gQmzFoEnqjSNZWugGUKuYTcNwbmH9GFM5Ib
 Ba5E5Z6153IKF1TVSzzuzsLjN2Hn1Vj/pbuNczl9hhL6qHgoqds2eXJRiBDB5Ctc1lIsc8f
 m9zYfxACM+pnm3qrDqqpdwh6EaYml/4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00D083E747F
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 14:06:17 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 95F423E1AA2
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 14:05:57 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1C91C1000403
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 14:05:57 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so2641727f8f.2
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 05:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785240356; x=1785845156; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=BQ2gwBvnoFWCfy6MX8UJfEDlquuDSxi9JS4zNBIHlIfp+nHhnOqU2vcrMZC19YQSsc
 lJ7SA1K1JeLgLQgZNW9gHaS22raEmaN6N2kklbrjxs7HTp4mzJofmZAsrvJbYX6LDvNd
 g5xNUI5aH/HjjS2dLm2xhck6MFi3tlCVeWjjA7fcIJvEqkjwkVtOSbbS5a38e1jDb2IB
 7jOLPiPuuVlcIvCFb5rK6SeEtRJBDOUgfo00RK53RXc6b5y+FIN47g01ClPJVFX1PyRo
 J9iU6kuNa4ORt1QYp/DvPmsj0MgCUiF9It+GfvTASURXw6fztryWbQQgNS+5dCAzQ/Xx
 rOCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785240356; x=1785845156;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=NmHu3j3UXxEXCh1EUrlkLY7T8ZniTi5waqYpRaDNCKq1xIpZB8Z+8jx4JhBmi7YINg
 UBOOYO7MmrDK/68QDD9z0MlcEw7kk+WaZ113eElHDdGTMOAtHcd30gXlZcjI/iyqLu+g
 g7QcbMtUzzVqAZuysF+8y0evnVeoi5798A0wJQDWjiscZ1o62P1f0c1ihRn9/qqM6e+D
 SqCwv1pforCCaXT1zWE9r5p60MnAnemiSCk90kAQ4QC2aTFQuwpB2Feos9Po2DUD5584
 u0O7vYu03RLTiwjQ8FRRKPRyJSYUicYU4iX9tFE0ZLj+dX6LQYI2Wujon013cJ1g87Vt
 TJ6A==
X-Gm-Message-State: AOJu0YyOxbUifhFewCpZaRQRZrNJgtbTiUAEk8I7/VixpTXXutiwKTb1
 LgmKol7Bi783MALPazK0mV94oXpw0o5IcP3x645ZYlf/O+e5xJ0s7ag4Swh1wRLwk9ALARD9l+I
 uGczvYksMuA==
X-Gm-Gg: AR+sD12/F3yoI4aw6aSTNHOQnmt4LJHj4+Us/zIWFAgQI/T+l1Rvhv2TMz/2C0IYwG+
 znZyYWmDhSvVIfRPN22cJBU0efCLVVo8qXo3ewPaiFx6PSg8lu34Pgd4joFCXmANuyJnr5hBsgA
 JwO1JkifcCN0eFbweUd2oWtR3xRx6zM6pxIbVeC1ZqHjRsj99R6X8Jz8qN3Ikh2iI8rKZAUp0X2
 ttRdr4U4pVA4xDZeib0hqKNHLdtKFGIhZKY23mTakl2rG7qfgMgqSA8tvxHazUQSMhhA1aV8JVu
 b/hJPqNS7tTuUZb2n6evw4rgeZa85W3ZrJg3Qe3FfxmWTFJZVmqCJa8BwIo7uoJetI94dmkxCSu
 +WVyku2t6ICR4OgqKZZn3+Urf0GAieyCEUwNHKS2qP4NJ4kf5ILzF4YGdsYEKS28q8wPJBcoAsv
 HrjCzQQTqhip2edN9417PKJh96o5H612kl
X-Received: by 2002:a05:6000:1861:b0:47f:6d57:5a93 with SMTP id
 ffacd0b85a97d-47fb1f149a4mr2498114f8f.38.1785240356381; 
 Tue, 28 Jul 2026 05:05:56 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f9c4fe4c5sm38093678f8f.12.2026.07.28.05.05.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 05:05:56 -0700 (PDT)
Message-ID: <6a689b24.14e24f9c.281727.7dfd@mx.google.com>
To: "Sachin Sant" <sachinp@linux.ibm.com>
In-Reply-To: <20260710091437.92148-1-sachinp@linux.ibm.com>
Date: Tue, 28 Jul 2026 12:05:55 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] mem/min_free_kbytes: fix comment typo and
 whitespace alignment
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
