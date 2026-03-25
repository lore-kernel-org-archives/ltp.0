Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA22B109C034
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 15:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774452881; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RVBIoV01XKYZuUNcRDPL1GN7Db8N/Fg/sTtIaiSGhMk=;
 b=F/+A7v1uZ/4RYH1ekm0BllAr5HvVeOcnKu68v4iOwSgTzpHYIUsFBcQmHbdpaDZVKV5xy
 ygsNj3qdynlJ5yTSDj4eRQRiEvljI0MHi3L/X8UJgoJhgzG6jlmG8/Zozc4ZFJOzIXkDgYi
 u+6vrUHtiQtm+Jh4CkQinT8ydCaPDcs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9242C3E3000
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 16:34:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A48FE3E2FF2
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 16:34:18 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1322B6021FA
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 16:34:18 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso47598205e9.3
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 08:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774452857; x=1775057657; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=1vNszpJUpBHN5j/x3jB9/fILeimK03qclL0i1tYvsXs=;
 b=WXuJwucLzxajnYsl95/nQTmin9KfRHufpn2debPNAIC0RLVEEe4Ovoz/SFP0zl6hSK
 tvgs18efNWWOFTVQuBwrPi3pyhb4gY/3qpHytsO69m1RMRUpt+gKcry+D3G1irScEO3/
 6qholGDhZJIwwsNppHhRqU8Uglk9IqzM27fIL9C51j3HgOqyqn3NuSl3xLfuWieYVMgI
 bq5tw0xvnPObjjrTIATljq090wMbR2p7M6KDW3R7Bbt1eAtvndv9sZSwJPW+s/vTCfJH
 GHpEhRablkyFVuHCUV/ql5p7/w9txW+1cZJXYpAV8GdaXQaRqvW2WtmO/5IVTw/ZmMdI
 pCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774452857; x=1775057657;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1vNszpJUpBHN5j/x3jB9/fILeimK03qclL0i1tYvsXs=;
 b=n3Wa0zL8O8vUY7HxXbe+4zZo8ixZYSmVXtSMzXhGj4EWwlGcpdM0774bw1WpK+ChBT
 WBNb7iWnmqcse2RO+WlELjALMfrMLT2Np/ehOTfnsWtF9kPA+sLmTycqi/BBfeAAN9cW
 0s6EtA/mF36/iuai77EmWjzBxEqOFrkKF6MjvRTGj1+skV2MR6C2SQ2MhINBOyTwYGVZ
 eAA4/axmJwVkG8/pxmdkvtsrizOXR4Rp36D+nPnKdMLkWk+YhPJG7j/6zuVpiiEmETNe
 VuDwCXSEWeMGWJJpFqdOZkPQU1Eh0ZVOL/S5FuzyUbS99yQqBvZ5UJ3D6NJEDyAOQdfp
 IXuw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8UaxgUdMCwQSLWdFEYlU/yBUdbzpSlHmNX+S+2zHpOfl3tTVrCxsUu11H6CmTL1q5zHI=@lists.linux.it
X-Gm-Message-State: AOJu0YwGS12uJxQ7DBRmeCq5raY30EqHg8ysv/rEnz9a+On2QhI6Ifbb
 ezNxcCdcfB+pswv/VOitjIMFlyjT7GfXLafWqNaznLhaJ55ATHgE5UpHFMLytVj7ndw=
X-Gm-Gg: ATEYQzwUZCfFGO6aPET07SWfH7yFOfzXUnidqlLfVXT8b0lxM04/C7NUkn0MawgTTXN
 bP9LFRlXvM1y8a5QzZsvhGpEI4Od6pNEZAsxQUS4JsA7RCOAsLGwEq91cvIxt6CfOIH3LXfa6Yq
 qAjPgUOAWPJ10+0a004xOJ6vO35DBoqRT5zQmBQeKPRYGFiti1k1C8ev/XUCM852xaUG4SIIAUR
 RPLJ6mkbUhbdFnBKGrky+A/0a0wn8wDGmJHcqbwF/wtCj6cixQ+THwuUcpe2dzFj6S+dy0MGkPu
 L70X5fS1PPcl1+uGdJoF4IoX54Atzd+T/EvVxVVWsXchwo7RhuvNnrJrqQGxnupd4hm2voOPZEb
 Y5hxzNjcaO5LEWu88EYNBXeMuCjuo9LsfbF0ubpjN3+U6L4jMfaM1GABNNFkTwPWKTor9k0HN7h
 Mgc4oI03qeMey+K+vA5e1foeRRGGjH++47CciDlU7LMt0/leNSQfaOaldsvJKwtGSvygJQtmASO
 iXJ2kg0oNChhWhMdMcn/sxNPJiKdwGeC2uPjxAJ8xr9WOncdmhNTtNYnJD0qsbZ72BZdOlYo8pK
 Yw==
X-Received: by 2002:a05:600d:848c:20b0:477:7af8:c8ad with SMTP id
 5b1f17b1804b1-48716099145mr42404685e9.31.1774452857421; 
 Wed, 25 Mar 2026 08:34:17 -0700 (PDT)
Received: from p200300ef2f4fc9002ac0653bb49440e6.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b919432f0sm627053f8f.13.2026.03.25.08.34.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 08:34:17 -0700 (PDT)
Message-ID: <69c40079.df0a0220.1260e7.732d@mx.google.com>
To: "Jan Polensky" <japo@linux.ibm.com>
In-Reply-To: <acP66MTKk3LzceQD@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
Date: Wed, 25 Mar 2026 15:34:16 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add cglangd specific files to gitignore
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

> Small nit: with the leading '/', /compile_commands.json only matches in the
> repository root. However compile_commands.json is often generated in
> build/subdirectories (depending on where the build is run). If the goal is to
> prevent accidental inclusion anywhere, the pattern should be unanchored, e.g.:
> 
>   compile_commands.json
> 
> (or equivalently **/compile_commands.json).
> 
> I can reproduce this by generating it from a subdir (e.g. via bear), which
> produces ./compile_commands.json there.
> 
> 	bear -- make
> 
> Thanks,
> Jan

I see, I never used bear honestly, so this might be a bit tricky for me.
But I see the value and the correlation with clangd, so we can safely add

**/compile_commands.json

Will send an another patch.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
