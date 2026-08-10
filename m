Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA96FC5AD55
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 15:00:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 031363D0412
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 17:00:18 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 720473CC32E
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 17:00:02 +0200 (CEST)
Received: from mail-pj2-x08.google.com (mail-pj2-x08.google.com
 [IPv6:2607:f8b0:4864:39::8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1278E6005F6
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 17:00:02 +0200 (CEST)
Received: by mail-pj2-x08.google.com with SMTP id
 98e67ed59e1d1-392a608284dso1021167a91.1
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 08:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786374000; x=1786978800; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AEa79IiNNHhijUhaHrlbJ0MLQFXzWnzrQrnK+9OTXQs=;
 b=TZ6xwVv7O3/pCz/5epNAAqPfkhymBw3AzJC5TIVeaP0Ip3EACQgM5Sac9G7O/7p5IY
 TU5YsBxNAcVG1RbxcECD+Yg74FDdGJXU36dTVgR0skt0RNxu5QTNUKJB4HBikwT/rl1o
 jbWdifa1DXk1PcGxDqwSbWopsCHy0vb/wnSyDjx0f0mLIsvok8GCuLkKhC/TOaLxRwtN
 a1qUJPiMSTOVtv6N3jL2ssY7WxLMRWg5u8xyrDCf6tn8xHYhLJ1COyKkWKneYXww1o4z
 v47LmTuy77N55UCHN95jjV5U29RgK+U241MQKPeYxWcYOJdFLNi8Bp5aSBBQ8jpsHhn6
 TRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786374000; x=1786978800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AEa79IiNNHhijUhaHrlbJ0MLQFXzWnzrQrnK+9OTXQs=;
 b=aYwRCRgcBULgpZqwYfc1yB+kSSPzg0LtiLaq7XrTWyX/mk2ikuIhSKZKzi5cURfDaY
 T4E2r09yYk4UECN0g1Z48hSgpzldRUu7LO912qH97HLsmzEzR2NiPRgzZ8RCJXROAFvY
 7Ew1yR5eygpWLdNufyE298vPqT0D8li6Q4ebd6Knp3psxbG9cyY2MzU+ioUCZVCH61wS
 l46Cg+sG5yCTjPJEZpgx3w7v+QOHIt7qp03ZMNCiapm+bNMbghbi4xebloJrEdlut+5N
 kcjNgpgCCsNlplJiltXw3BjrTOr9Oymqq8bIew6aDoZbDhTRH6BM97F2A083/LAdQQiL
 hz/w==
X-Gm-Message-State: AOJu0YzTJJyZRuwruGR5jUO/l4StTuiboUdcD9vn5RZktYNnAa09QyEJ
 kcpoySDC2cYQc5vo9gDJgYyU2VUj5sORjm6BMZ6bDlXQcNg8iXM8zkUY
X-Gm-Gg: AR+sD12Ezef1lxp3VCkLbSV3q30huty7psuax9a5or/P0y4x+i/4LLYQccdgg5eATZJ
 i+DKEtMa6f1c8UHc76hy0REDu6XLGeBPamH2Oapr6OH++E38u8nq/mFrbGecS42kmmzXbOVuhUd
 jmC39Cj7hblv2p0PNNCc5dZd6QImno/FrorSB4u9qQp9YBs9A9N9qL32HlBpx6MyNWC+s/xj+zQ
 FUow21JkYVmbwQNdQQuhLYopa4ORsjeUCsDNPYfeYAO16RB4T52w8bPYV0l7q/N9ffz4AayUHj1
 2/u7ZFXUFNu/K1coUaL8Erm8kzOmXOlXBSDcXzV8mz9OjarfAXA3u2yUj1eC+xGLbm/m74pzLC5
 YoijJk8W5o1fYruhBjevm6XFiCjuIC2p1U4BWhKaKO3/4awrvytfTq3phZjOMyRwIMSgXtN7SdR
 n6EejCX0J/pIs2h92hLOixrV+F8/E2FV/Ejt3ANUwarDt27en7RFMSIX8/stM3kSdimnkUCNpvt
 seZ0R/eTQJWFwS2szl+JS5Pw8oJT7Muue0smaXGp6w4bjjZvlcUTCKAl4ezjFdQ0rhiHHUSsBP+
X-Received: by 2002:a17:90b:1d02:b0:37f:fdc8:71b4 with SMTP id
 98e67ed59e1d1-3903c599356mr44949497a91.2.1786374000313; 
 Mon, 10 Aug 2026 08:00:00 -0700 (PDT)
Received: from
 runnervmvrwv9.mlatwgtx3xgu5eejbrqchy0rkg.xx.internal.cloudapp.net
 ([20.64.173.184]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925ff69eabsm13121192a91.15.2026.08.10.07.59.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 07:59:59 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 10 Aug 2026 14:59:58 +0000
Message-ID: <20260810145958.3897-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260810143344.1029588-1-pvorel@suse.cz>
References: <20260810143344.1029588-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima_setup.sh: Fix check_policy_writable() for kernel < 4.5
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

Hi Petr,

On Mon, 10 Aug 2026, Petr Vorel wrote:
> ima_setup.sh: Fix check_policy_writable() for kernel < 4.5

--- [PATCH 2/2] ---

> ima_policy.sh: Require kernel 4.5+ for test02

Could the commit message explain that test02 needs repeated policy updates
and that CONFIG_IMA_WRITE_POLICY introduced support for them in kernel 4.5?

Verdict - Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
