Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63C9CD8C92
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 12:51:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781009466; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=B3M7bxXt8TH4lCiZhuk2B7HGhQLmVBY1JqGLWG7ZEU3HSkz9hzXHl8z0Hf8bzUuLyw/vy
 82I+2+z98pS7ERZv8FjGvhQ4CWX/muGye+E/yCx1Tg3QpyGyZ7RFdaYftk7wUvqyOS4S7uQ
 bbzphw7W5IRrlDp++jpedqvvTvoX2xE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 453F83E6F21
	for <ltp@archiver.kernel.org>; Tue,  9 Jun 2026 14:51:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4D98C3C1C6B
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 14:50:46 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 419A06003CA
 for <ltp@lists.linux.it>; Tue,  9 Jun 2026 14:50:45 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-490c1915793so36825425e9.2
 for <ltp@lists.linux.it>; Tue, 09 Jun 2026 05:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781009445; x=1781614245; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=MUKs1Vs+/w5PmrT3Tw+ZIpLpNnNMtjuyTTUPuRbpxp1fRwOEgDo8apu51vTY3HWGMj
 8wj3YNw1N8VWuEE4i5/dCAMuEEEM7Gmk8D+04HSuPbKkG2HjKLx8XMYl+EGaSfK/QVT9
 rnRWROZ0qV0TWzYYtDGbYhzYHkg+YU3nJXdcjvTHw/vwP2uK0A50bh0FPMfPaRfcZFUj
 9Nc6i5993fE1b6+DQ7z5v3oGRoLGSj1SsTjmmOGyWiZ+Wm9m+BO/MPu0X9+tw71QxMDj
 0ZfXhQU3Yvs8agiqYu/K6vU0AXKiMQ4dfHcsfCPoObnjYSGM7ZgUSj2yZd76+e7wTcO7
 dh6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781009445; x=1781614245;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=mN9peXu5+eVp1ikXLBwTNPMvmiOcSyzm+/OWTQV4i3TptZpEeDVBJHKOVc/HW4Pr/a
 X2neqJW2d1pzoX9VM1JP36gbtnbunWOVRapYmz+LeXoECK1nuX7aCsN/M7yMmpWP9xa5
 QGkmdBTZnoyqSrvlImelkocUX6AstJvc339djiznwKs+KfZUd+B9HQzkKGY2r83BRGr6
 8b2CzdaPxUCgakEOfVHJI00lQdaEfv0OAjOu4H5EomghDEbmSJQ6g737yJ22SGRZTw/e
 pSi2gMagelTH7xVYaPhYA9VCNNYzg5OtkPWPC1K2tA8LgTP/ArnEHyFBlrzGtwlrt3RD
 Ak2w==
X-Gm-Message-State: AOJu0YwO4zGPLJ9TbwtbFKn2LYq/pxY5V6DaRvtsKx23YKUZsgahOJW2
 /Hply/8f/BNMblVjoQ+plJpWyGaIxXFq6g3z44MR/RPdHUB2KWHQsgQacuiGwBV4KPPCUHnb1UL
 lpN3eDUA=
X-Gm-Gg: Acq92OGOMjaKfMwm0UPvll5lv8a/kLbljTtl5Ab8XU+4EDW6SD7UH5ds9qhoYmYqyJy
 S9JxD9eS4ew63n5hfzPtAiLK3CQ5z6IouIqRfv9SLM099T6pPrn6k2kZYOp/UAEr6g92w/uZez1
 a5/gb93C+6Zn8Fdv/YN3uyepydpf4wPtHOjTlzZ/PXHijHEWTVkg6w+Xo8nadsAlMis1SNhmlRC
 Xu7pVNUxiL1UlYbn+Tj5/9rKTC1WgniE8II0IlXtjA00dNuzce0KeqPW7aO+2CcAQuoOKW85Xk2
 C8/hNrrycmftSQaOWWBmd5EI+T1SFLXz2PvSLwXEeN/7UWfNiQv/anz9POl8ixppWzU7HRXbIaX
 y3kh1BfT54pHGoxa6l8N2PC6WnlkQkwvuFn7shtLYW9oBt4PZG548waW3feVIYFACS3/b+WUGnO
 CmSssu4t6QWRUQ2sLPvLTG2WydAfNPc5J3ULn5Yqm7KmPWIcCiOKf0et8ek/in7DzBdXzTTyGdI
 RaclLwq48c=
X-Received: by 2002:a05:600c:4ec6:b0:490:9d1b:201f with SMTP id
 5b1f17b1804b1-490c2629be6mr315127105e9.32.1781009444640; 
 Tue, 09 Jun 2026 05:50:44 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc39e024sm638679755e9.4.2026.06.09.05.50.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 05:50:44 -0700 (PDT)
Message-ID: <6a280c24.97b0ce82.2e9ec5.ffb9@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260609-clone10_remove_checkpoint_leftover-v1-1-a2a99f71ba9f@suse.com>
Date: Tue, 09 Jun 2026 12:50:43 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clone10: remove needs_checkpoints leftover
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
