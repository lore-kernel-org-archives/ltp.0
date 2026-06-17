Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46EE3CD98E4
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 12:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781698100; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=ij2yLUBtriWH5AHk31mjfgIXLtXJzwCtT5nIQ/53YVsrmgkPf59Y8NnE9qwmhPJuYDWYS
 85rBsDLwCF8UOqZNhGyuS7Qk0VTn3Tm4XQ+dgZy0Wwh3SricjbmkgTOLN13iN6jL8z1lxMC
 KAGWzTbfLeDk+dQzzldgBWoCWlfDAYE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9C3843E5935
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 14:08:20 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B7E23C54DA
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 14:08:00 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 097651400B68
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 14:08:00 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-490b9318997so41930565e9.2
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 05:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781698079; x=1782302879; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=V+tFSXzEM6K9Nnt8efNwuL7MJuUaRIovQsz3iXjX62xXEfjR+dYdQmGPASjNkwYuAa
 YgnqQ8P6vc6HqLl3PbHF0CQMhnASe16Qjn48P1CPh1u9y/d4bY91Mm4h2C4gsfNijhiT
 nMXpmVncPrdDerzq0zE+6+XS/vpZNJrJQXp3xeOVV5cNtXTlD56OLrNu9c7CiuMSWaDF
 tgZBT2cDxs/P2gyeH2RWsxCA8jEE4NgxR3W9+3emInlWB6VS7kg+e0LxUWfinfv1i9rW
 mRVSOY3JnfEO7Vbtr1kESbED1KuXIIW6SVvvFfnkZl9sUVZCqeJG2XAyJgTRJx1uByuB
 5P2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781698079; x=1782302879;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=bJjNGKcnM+ytbR4ZD8suwZT7FSmUJmeIc36eyKTdMSqGzBwdQb9UTajOp/uK0Uq5xe
 sxcQBtmJavd8DMFTCqhqecvDIOWn/G2MHvocjNcRTwuUzphMfGK7R2Ebax32FE2DKx2x
 86RFXg02OZ0lekW72NpAVGPSgGe8OWKqP/n7/qIVrsiGQXGx3LlkTQX3+Q02ymq1ilsS
 aPuKgMFBrsXCTB3BdJLQTmv4zfvPpMUMOBQ4zejKwTfFkA+MCFmhEb/9oLVQnWorS1Ro
 oCNL5iyx0ZH1OEatEe5ks8UNPo1gkV4NKCo8bZG6jjGdmIOcnlxAxj8o6/KyvUx6gy+/
 m/Rw==
X-Gm-Message-State: AOJu0Yw5Ly+WmhY3bdrfTZdsyPCSCyQmDGjYTeX9xzj2p8fB0cm4SK58
 6xqpUx8cT3pCIn3FDctBPjhDBBmENF7TlM6CQH/PQkHd8sfvI8fW+VU0J9ds5uFQ84q4q43gufZ
 VWNbnKSY=
X-Gm-Gg: Acq92OFZb9ZEH2hl2YRVYht4j/C215p15hTAWw9k6H77XZAoXKNhZHcLrbSf6nyC6Z6
 oAskjOoNaYdBhChAOA6RYDOsVPRluqP8StmHPdglrd7zsCzfsRwJPs+myQgy7/Kx/4PHN89jcmM
 8PBXjrDCiyYzbORODmjOb4SP3T1BmsyAwqH3dhqS6DmU3QlQh3e1dpVdaDv6yP0OVz+PJj/dLn0
 ZqHbhdaLMkfmz7zWH24MUZVaWuREv0Yl/SrVipeZxMhWOPuMaVHg5BR2D8GQ3Vdne5wl3vB7gZh
 yUQRZMQAwJfI6RP8W8HXzP4iSwP+T36XZ3UTI3OqrE33ZSyo0me0J9Lt5mneu9L1SRytmNNLpv9
 lpd50tJkaajT8nB5KQPyioOsrqoj1w9l4HP2sXLCL9yCrfVx5U830j/5HFH7LFI+080yso/eYf0
 X2dSzDmkoUBdT+L4zHRWeBV4JboFJpXAkVjmhQEWN+QKPZRseH/YbHcBqfJheAQg==
X-Received: by 2002:a05:600c:828c:b0:490:be14:bfda with SMTP id
 5b1f17b1804b1-4923339fd76mr65748735e9.6.1781698079207; 
 Wed, 17 Jun 2026 05:07:59 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa5120esm169471155e9.8.2026.06.17.05.07.58
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 05:07:58 -0700 (PDT)
Message-ID: <6a328e1e.f6661fbe.2a4b63.a8d3@mx.google.com>
To: "Michael Menasherov via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260616183025.26554-2-mmenashe@redhat.com>
Date: Wed, 17 Jun 2026 12:07:57 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v15 1/2] futex_wake05: Add EFAULT error coverage
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
