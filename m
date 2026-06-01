Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62FD7CD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 13:43:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEBC83E56D7
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 15:43:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 046673D0EA6
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:42:53 +0200 (CEST)
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com
 [IPv6:2607:f8b0:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DB43520077E
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 15:42:52 +0200 (CEST)
Received: by mail-ot1-x342.google.com with SMTP id
 46e09a7af769-7e62b6163c8so2851628a34.2
 for <ltp@lists.linux.it>; Mon, 01 Jun 2026 06:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780321371; x=1780926171; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PP6GDU+B0lk+JWiKFp9RBaInLGUG+ph5TzyjJsOEIW4=;
 b=RLez1iNhDBiqNXdXDlZ/vVazTVdw9KrTF67wmwjwg2Nyy4mSw7ALyXOm1Gkop45XsR
 JYOVar0Mde8PZwhp0tzvDjV9ECeervJ7Dty2SKg5k96k3N8Y7GFGzlj0102STIfOXfMn
 SdWusBT/CYrvvcwxYPMxd7+6qUsgQo53+TWV2/UAy84GhXf5IQFzgk+qf+dHK6HY2D44
 1AydK4WICSGhjZHbqsrDYVY/xLKHjIvuVxr43eDH1pIh1kmTxGuBuRadUy/RkJ0SnQea
 nSYo5fMlVhzL2pIYpRHbdqGiKVT9huEFjkNVRH4XMWbBH+mCOtkAq+iOFTWwCaswbA7b
 4UGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780321371; x=1780926171;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PP6GDU+B0lk+JWiKFp9RBaInLGUG+ph5TzyjJsOEIW4=;
 b=gqDAr9AUYf5JKc++EXpqIHqvEk2nCywGSLMn7Ai4wRVJXCmskfEfuQVw/Tzxkz4R3M
 2p+IchUq9FRBj6tHbYYceeQFoKC2GZ/SaXpalf/gkDuNOu6PWnpvpJMGbp11jtpJyXWU
 au8TsMydD6silgTnS4puJ9GFfTPb2zBikj1aP3B8PltxPIBLl4Pm5q6XHCnAewYW5KXL
 Ia2+Ho0X8HXSchBi8RQk7UoC2ZNgbEx4pxL59cJ1vZgmNS4Jg5Uo5KU245+uGROEXYrx
 GgyF6i/MruHMwoISXsF376O4vpDCXLY9qkyC+37AFY05Ou1bczNJT8DI9X5myGB67QAO
 knHA==
X-Gm-Message-State: AOJu0YxKnSlF5+1y7+wojzQwb6xfgPv6Z81WLFkMmizO91GM0QiBTDRq
 qQcguMvTGUqjPF2eftMEKX81PNGX/W0LGuZ2T6A9hJSChAaJ3O4+P/dg
X-Gm-Gg: Acq92OGH5jpJIcwTQFAwKElaNDIOcHmlmw/5Ewmlp7a5o0hGPCJbSroUFyfWDZmJE2X
 7n9XJxXQsMbHw/oiUPL0ldOynmguxUD6wTXwsh4hKX1jusT0jiqP6VWUIJALBT70q2BWaQrsCdH
 zVhUegn1Gg7LEats1KohqcZEI3aVXxl0ZZ+Lz37UXy/cyfKyFSDOmf46ry9J3RgpaX5DbY6mZWp
 XRtJV5eGCsyeIRNsIwf1YyzxaKY4w1VoxwZPLI76BwP1x42xu3AeIHbBomPJmwiGwLJVrAyqqi6
 jTzO7DXxdEfHQ5SbaOBsVm7rTp4tjnef+pKe5u3v6YrMQS1yITA8ig6EBb9l3cJFEK0LBpC3Jly
 ekKTefIttk51WLzkj+Qncu9eRtvc8xdj8VvebUNsRpTY9/2mShlHXf4eVqtjOgu4dpyH0nx/VML
 wb5BBac9pxJFtdYZvup9U/7dECP/V4zoURIa+EziJJ7b4H54swQ/EObjtir/IG4N678YCI9/VKT
 JmbyJluHATKgErfs0K4ryfIMf3GtlemOlpIG0XXm02sYHeK
X-Received: by 2002:a05:6830:641a:b0:7e1:cbe3:bb1b with SMTP id
 46e09a7af769-7e6a1ad98f3mr7282072a34.0.1780321371463; 
 Mon, 01 Jun 2026 06:42:51 -0700 (PDT)
Received: from
 runnervm3jyl0.hppsbykjavouxdtdb545iqfrfg.gx.internal.cloudapp.net
 ([52.176.37.67]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e695bb4aa6sm7656734a34.8.2026.06.01.06.42.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 06:42:51 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Doucha <mdoucha@suse.cz>
Date: Mon,  1 Jun 2026 13:42:50 +0000
Message-ID: <20260601134250.4161-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601132055.58728-2-mdoucha@suse.cz>
References: <20260601132055.58728-2-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/xfrm.h: Include system XFRM header
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

Hi Martin,

On Mon, 1 Jun 2026 15:20:46 +0200, Martin Doucha wrote:
> lapi/xfrm.h: Include system XFRM header

--- [PATCH 2/6] ---

> xfrm01: Use NETDEV_SET_STATE() to activate loopback
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>

The body is missing. The subject states what changed, but not why.
What is the motivation for switching from tst_cmd() to
NETDEV_SET_STATE() here? Patches 3-6 remove the "ip" command
dependency entirely, so presumably this is a step toward that goal,
but this commit stands alone and should explain the reason.

This patch needs revision.

Pre-existing issues noticed in the surrounding code (not introduced
by this patch):

- testcases/network/sockets/xfrm02.c in try_corrupt() -- usleep(30000)
  used to wait for the espintcp strparser to process buffered data.
  Ground Rule 2 prohibits sleep-based synchronization. An
  exponential-backoff polling loop on the processed data would be
  more robust under load.

- testcases/network/sockets/xfrm03.c in try_corrupt() -- same
  usleep(30000) for the same reason.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
