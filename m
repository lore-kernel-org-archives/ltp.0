Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21544C5CFDB
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 09:49:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786614563; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=m2lvf8SWnEFYmHLHBxyJoua1eX+UlNnmPHjbjiaTNrA=;
 b=S9JScMKVd/k/UJPbxH8QB1uCQAGv2DskGa8O692uxvxQFo8BGT0qns9AN7ysywWXjtcLh
 VTjGsQ/SRBymtNtWK/A7zXFtfxlEhji0UrmIt2XesE0DuIJmt8p9BmXCbfq4SKObVNIzL7z
 j9gahYWlv4iv5inignLxtm+8Qnhj9p4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54B173E6C00
	for <ltp@archiver.kernel.org>; Thu, 13 Aug 2026 11:49:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 849823DA1BE
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 11:49:02 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C597C140074A
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 11:49:01 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4957eefd361so14358365e9.1
 for <ltp@lists.linux.it>; Thu, 13 Aug 2026 02:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786614541; x=1787219341; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=k7Lgpws04Aiaa4+LHohkYWBOQ+hw8tr0N4y0CBm4wwc=;
 b=JJIGEiX0sbAX+SeuGEXDxhjn8zBmJ0WnqtcCqP+meKQ1OnLfGnpgwYOUo7PTZUhax1
 7hAYYUZdbXHsc00GgxN9VFYAW49iicg1iNKj6pd1M4/YpxvgjPgOyLl81ZmIb35KT1RJ
 eNzjmU+Il5fFr/wBUwQ+flLxlin5q6jSXTsDpRTP+GV3eZvhYRPPSSfUg+NgAYaOT/yb
 QIpW7pJxM05+moxMeD5H/JFj5ThlodZ00KL+2R0DYZfYtPq3NTXR0efg0SVrdPtnhFyq
 6y65u0IsHkb958EIjYOIXl59m5jcTDQ/gg4O4oa7F57Jq2E78ThXnggRuiwOn6GIvaQ2
 8jkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786614541; x=1787219341;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=k7Lgpws04Aiaa4+LHohkYWBOQ+hw8tr0N4y0CBm4wwc=;
 b=X6S321aNr6PjyuG/G4tlfDvrA1Nyyt/mLjIdlOUspalq00z+/TPJOFOoQiwDJeUi1L
 mOsom+021nHc7UvW9DpOJrwOaTkZI869W9hOTyo0jxnYUCqAq6Q92wZaamY1tVyDUOjF
 PM0mYzwAl7/537Cgg10N9VW+bZbF7G2WmXgVGge5Yc5Em3IC3C+Rf1WUwXo/DXDg2AYz
 2PrjPTaiBw+0/vQIr2zEYa1RZZF+sOaGrBc8mGYCyn7bnSXJvobwCtKlKUOwmaHiHs+4
 mtlWOz30NqaYAc7wsRnQ/8jS+lpcFLoRat30x+Poh6gJqbvquxnroxcw5l1NLv0/xZOH
 eS6w==
X-Gm-Message-State: AOJu0YzN7j7Hez3v5qzhe/KmNoWKv5LWa6r9MYoFpDey1BNx3qdr8/P4
 jUhNkPtpqS+Ka10NqUICrd4jOhDpgun/bivuvNlDMLIrKxWy0BLgR8EtY2tzloQZZHo=
X-Gm-Gg: AR+sD11nz3dopeSf3+YdqjjlQQ+NmxvR5WIKeOm1FTE+85Rl9fWziPzzXYPWmHLSHEa
 Vxt2btMrPbzDMmLszakZlPc0UGuBoaXEYrPGhByn9n06ex+y/wP6N7wOZ//xv/L4zLIYoBZKc3m
 PDbvsyS9nEUrUMu75PcU4JG9KymTSCSKMv13LuN1zxTpcCVdfFrkjCnXhXQNqMWKu1qLt0iLIpC
 kJEEuTP5e+SQS/GGPtAACo/YplbpO9K+ExjdqeMCFPX7DyEZOnF3DYtP5qwWqtgOm3Utx0C7sll
 OZ9bFNkjB/fJPEpdMK1cw+pifqOLtZHb7qm53lA2tUQMxhGC9P9JB6luxXm0tBlFboJTfRrviQ7
 f6kffENvSJpiI95jWPMSmFtMEmcniOQjkCsdt8tAiscTnoL8ToFIlaAxfjshzuZbe5Qv86cqwXa
 /IoE5oB3D9eXeZMqvAT2ysu/smgZL+8P5z489P14pYTTGt8qOKLygVk8SAMWzUBFUOgSUazUhh3
 rzZwbLAFg==
X-Received: by 2002:a05:600c:a59d:b0:499:80d0:8b73 with SMTP id
 5b1f17b1804b1-4998215a941mr35405075e9.4.1786614541134; 
 Thu, 13 Aug 2026 02:49:01 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981ded713sm33894895e9.1.2026.08.13.02.49.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 02:49:00 -0700 (PDT)
Message-ID: <6a7d930c.fe7f0a4c.7cd5f.b2de@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260813094549.196724-2-piotr.kubaj@intel.com>
Date: Thu, 13 Aug 2026 09:48:59 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] pmc_core: add test for
 pkgc_blocker_residency_show
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

the commit message is still not following the request I made
in the previous version. Please send a proper version, this one
is rejected.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
