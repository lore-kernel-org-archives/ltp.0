Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C0010A62CB
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774532007; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=Ze0vMJBAAjdxiws9AZVzyvoupGIsxIgI+Je7d9twGLo=;
 b=GD+DxmVtPpyPLlsY5DOhym2t8lSj5i/z6VlylZz1Juxxb97nootKbM2PtjtT+oqK0jADc
 k4J4VcIjGniZMmAf0id6PjfZaywhV/Pze772Z/0Pp1IgheKsZR1+ajCgI3q6z+AYItz8RtT
 Zgobu9o9NdwRs9BEfA8DeJi4fHSuxWY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57FEE3CC20B
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 14:33:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3C893CB935
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 14:33:04 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AACFD601904
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 14:33:03 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-486507134e4so11931365e9.0
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 06:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774531983; x=1775136783; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=SHTMdVs6DlVGXIpzjRxgdUZ7bkRLnTUQq26UqFeCXis=;
 b=L7ANU9xGrIVfTa8ikg0egPsoV9Drv/d8606w7TGkaVMqXbHY5+K+Y5s1vAvy1jE4J4
 5S32TzjTHXzRGJyrVMsSde2cKjMJVhN5ipp5W+g0zBdrzj4AgrE71H2I5bqwycgu3FDG
 r0HNNJNb4YKbv/ZoG1w39f3BhM0nMlHCL/EST6DHxfxfw94x8UjmanZk1vg0mro9ElnD
 EVYZ1bo69GMPcaBSzY/x9emyXjdlVImYwTwOgy9nPiFwytynyDgTGP5Kmb3HX8pfWZO6
 LOZ6abY92zznydXu6DqHIvZTANHkps1jZg2SzfGCNKy9RVQoDgGhLJnUGlYycTfDNa1h
 DzUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774531983; x=1775136783;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SHTMdVs6DlVGXIpzjRxgdUZ7bkRLnTUQq26UqFeCXis=;
 b=IBK4qcRKil3bkofXiZRjQfUX3XjL4koZPGNzpUIqms6gz86bDWEDhnt9tDwbnimbRo
 fb3ALxY9M+orO1F7spj0vN1shDDn2J+LHyQBHWUNioCvrZCQwn8zOhdyJhVsU05QHFpq
 NVH3HBANMj6xFzoJndIXgNbzEGsQ1j5xKCO0o+FhhzAGoiVoj4p3a5cGYav/IowE5wHi
 8fyS3u9mWD94Fpmih2KVU+b0p9cdXsEahg3QoYOgRRuz/zf0A8fTVih/cq4qkLBolWJE
 Qlc8aqCBZW0N02R673LSXYrsU495meE1h8BS2dNHXO066HSHM95hZ6ZeflRTQR8LbdQ6
 qHAQ==
X-Gm-Message-State: AOJu0YwKIIk4CcLrJuKtAxLQGuMIyclYAkLKl2midNJ7RAvxxmV1eior
 36nmvnl0U8OU3+QOk7XgaXKdznm1Qn4KPniR717WXFUEeIMz+O2FbDS9RfsL/tjj5vo=
X-Gm-Gg: ATEYQzwo7z1YsAtvaD2TmLnMcCAQeO5wEiHzfqaijSa2+fqbdpAyopcVsvtOba6ui9e
 IJTZ/JqCr1gcEGV3xpvVv6Q78PR8Cf3yf/x7m3g1YtO9cOgPdFA/t64eO5Qj6slOo/xbEYCEb/Z
 Wku0CJHLvu+vcmyYq9bkayXUYWSpoUbdWxJokXKboo2mMnhLKs1VwRHpQ1wTCGM4luHJZS0Oh77
 coVlF1nisu0GbkEbxEwRtl1/RKapq+ZmgUBrmIAIrFeHhbOXUanDEvoxD8hmKCqQe+CHFkAWKTU
 tpdr6uXweV7FFy1/URLzweTXBN0nWvF+aZcstk/q9lEsxFbX88LPWuLcztsU35FhOKxGav/40MU
 QbuaaitP+wvJz2+G+uBSH9omrbSh1U5IcfTGvtIkSL0Ctr1NVvAZq7py7NavHlZlT+D0GDw6hNu
 wrK4Zp38BJxFbVABP1Y5SwBzp4TQhcId2QvrWDzA1x+lmV+dY6c9o=
X-Received: by 2002:a05:600c:a4f:b0:485:3a03:ceca with SMTP id
 5b1f17b1804b1-4871606c9e8mr97751075e9.23.1774531982973; 
 Thu, 26 Mar 2026 06:33:02 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c957b9sm59306955e9.8.2026.03.26.06.33.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 06:33:02 -0700 (PDT)
Message-ID: <69c5358e.050a0220.2c9da3.a5f5@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260318132639.18818-3-pvorel@suse.cz>
Date: Thu, 26 Mar 2026 13:33:01 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] power_management: Remove runpwtests0[125].sh
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> runpwtests05.sh was disabled since 2015 anyway.
> Remove also pm_sched_domain.py and pm_get_sched_values.c (used only by

pm_sched_domain.py is never deleted by this patch but it's stated in the
commit message.

Otherwise LGTM and

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
