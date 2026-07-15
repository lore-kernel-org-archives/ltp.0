Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A312EC44501
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 11:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784114770; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=YewYP+Fpa3XimqmnY+UD0XnZQIf8jI1cguCKs/XmucY=;
 b=dFxQgh3akGc6Q+MaBVP2q5e+wjiFbefFco6DmH0OV0hkVELRTccltgFa10Ssksto0f2no
 d3vFxx7m745CU3tiXvauAcUyUpmwJ5TAeLcKyitWXk7rE1NDvXnwvSopEmxKX4xFf6/WQ0B
 l9KfgGmz5tQkzARIVWlvlr1gsxjbX9c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 29AEC3E5694
	for <ltp@archiver.kernel.org>; Wed, 15 Jul 2026 13:26:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28FA83E1E71
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:25:47 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 847682009B6
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 13:25:46 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-493f75f7172so36576275e9.1
 for <ltp@lists.linux.it>; Wed, 15 Jul 2026 04:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784114746; x=1784719546; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zRuKiRyBjmGxW0gcHbpd9lulddcYcyaHJaxy1jRRomM=;
 b=YttXyCIqQG+qy3NRkqDVkwFlRNMeXCGeX1hjqyBun04+hg8YNFDrZUf28ZbwAJL2gu
 wNVXhdaX1jY42xlmmOqMCP3dNr+k/t6KB7nQtP4kkTDxl+C+DqoUKcyIizZiwzvQUZql
 S38LpIK/pHIvSnlN+465+MgGMxJGRXM+eVu7fbKFqzY9ea7WpubbSwvVJbiN6bp8Yg8I
 RS6+OlNWiZfB+iFQAG80p6wblKud8jv3pC5aoCQI4nGqi4ysdZMtJZatjGb8v6QTZgPR
 GNFKjQjYxaT8GFL3dUilbQ1b9sQJxs6nlL/VdCJS8/vwhaMEjMnvwGYD+DHQIWXIAfTY
 jUNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784114746; x=1784719546;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zRuKiRyBjmGxW0gcHbpd9lulddcYcyaHJaxy1jRRomM=;
 b=Ic8xfD5hAegiD5+jxYhaiddRFYJE0N81Ak2J8t4F7/Yv4r/uNK7YCFHuOLlY9Cl8gM
 M7PbpuEBKN69FzKIjifjUKbS07qB4e2MzZ+45TFB1gQF0Dz7LTINzgI+ibzuShbRlqOv
 VLHMhuUSVZeBfEZkYpWVmjNlWFzFIaHgHsVrpRHdHvUbWvzC+cbO4LylgBZviEi/QIvO
 kIRj25kEN5RoCW3gCZhafKKG1JR1mZ3ZbC35dfSwBBY2LF0Wnf4FliWxn2SnUDzxMH14
 LOif+ZpmNwM2c1ilKJGkUXkL5CWFYjBk48IcoFqN7A2v0gGuRO1AG7AiAgg9CZ8wk7FR
 OVog==
X-Gm-Message-State: AOJu0Yz/+Rr4pPJ9zvZeLG4pVwYvkD95Bfxwnkyqk6gjciIh+RFKyUOd
 9VD02L0Q9rgiCfu/JYYVMHCRxE1ZBxsCSBZeTxHPKxHW/VwEOR7NwwtpqIY4aIL6ClTmFfqKByl
 AHmyExYU=
X-Gm-Gg: AfdE7cmpT4ieD2xPR3uBC08kfglPmhDUC82I7IrvduK8oHdpwL+jPOYTVDilwITNEIr
 PCMZPKa7OAmihMPG2BlvFJKu1sLMwpPloIE+1x6LHHrKb3/JMR0xStdFxvJyiOgLRCoQoDIyOOx
 BG+IUYnKBw8JPbyN6ZHKkAaGJhxhkpC3iPXBOta0Fo+iQzq39q8/3jglHnh7BAFtF2kfqLa75jN
 GRXXkFhZdeBHMR81bPFdNLzQeqAtp3BQtJsFrHY0R3SmrIQK6Q63hwRFQDKZNr8A9RC0m18pznK
 vrZb48eAUWkM6XIrg/VgiVvWzam9UxWz5yj8e823AMbI7UF4GBKK98HiZlq55NSKWVTD7RvKoyU
 s41x/TH3phKV1i98uR3y3XEXyeFBtkhuZMc6g/qt1j3z4nzlEGUGjHRrH0FEfeMtlVLoe3OwlNw
 1XKNXKHaGRv1SixDjIA2rnwKykUIXLGdRm
X-Received: by 2002:a05:600c:6211:b0:495:3a21:4e5d with SMTP id
 5b1f17b1804b1-4953c001211mr28513235e9.0.1784114745874; 
 Wed, 15 Jul 2026 04:25:45 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49506a1fbcesm147844875e9.0.2026.07.15.04.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 04:25:45 -0700 (PDT)
Message-ID: <6a576e39.5dfca4bd.1671aa.39e8@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260715094138.1679456-1-chrubis@suse.cz>
Date: Wed, 15 Jul 2026 11:25:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/5] Even more epoll tests
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

Hi Cyril,

the patch doesn't compile in opensuse 42.2. We need to define
EPOLLEXCLUSIVE because it's undeclared.

https://github.com/linux-test-project/ltp/actions/runs/29408205713/job/87328746756

Moving the patch-set to changes request.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
