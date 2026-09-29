Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC2DACA5FAC
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 17:50:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 096903EA9D4
	for <ltp@archiver.kernel.org>; Tue, 29 Sep 2026 19:50:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9134F3CD51F
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 19:49:51 +0200 (CEST)
Received: from mail-dy2-x0b.google.com (mail-dy2-x0b.google.com
 [IPv6:2607:f8b0:4864:36::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 31EFB600BC9
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 19:49:51 +0200 (CEST)
Received: by mail-dy2-x0b.google.com with SMTP id
 5a478bee46e88-3468ec30866so2818670eec.1
 for <ltp@lists.linux.it>; Tue, 29 Sep 2026 10:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790704189; x=1791308989; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hc7B5TrWw4+oysy01LxjY6PZI4h3yztLs/1MbkAGfKk=;
 b=ULIMnAdz1Zyxg2ByNs2Ku7cfoQUxDvnEb/Xqbo4iBZxBqLeidqjLOZwtYltvuzvWaP
 2w6zpnWiqHhr45dtGCD7Z23V/rumRjtB3IeSRKOcFzWC4/QSE9X2w9l9mugrPMLVwaB9
 SljTBiFw2ADnwXAbZJt7LgUFN1JvJHm/w7eHVeKFsMl6dEqqwo0AP+81LEAOMXSVjAMu
 TGWBHyE+TQHeB6EhlKi1FRnmeFyepjs3H2kxIhVH5uiMRy9/0lgN1gOajeVMf//lOT1+
 cciShUI0yBq0HPHEuCaM4kVli7p4Nxri3VXtCdKP83izDSdAEiGDUvISWhzEMYySC37v
 Y2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790704189; x=1791308989;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hc7B5TrWw4+oysy01LxjY6PZI4h3yztLs/1MbkAGfKk=;
 b=kVTAtpzqMGDtZLgzW4VqQG2OabtHBCFFfb6BjIsxxoVM3fm8T13yqkCNj9hK3z9qp0
 xW3XZvxHb4T8vgYSGcdpQd8oTz4ePKuWb0CYh5zG3j5kCW0P29mwUK4ThgWRDipEx23k
 cahu6V++DEA1Sfp7PgDgwXcsGvmEoqg1snH0ZdPehJ4D/3MPQ0TvyQJoGl/tYwrN/xn4
 f27ddkAtfUTOrYUOvOIt5N7Y51QK5e9N8Z+iU91QoO+wPJgaPpDPm8sv8jbcIktvSF79
 cttyHsg9n6tiAZnkrAjqLNARF/zAJnDX3pJ8uZ27vFl27pYUBl3/9Ya1e2Qa4fvDMu+8
 4+Zw==
X-Gm-Message-State: AFq9FYKpbzhd0rXWZWpX57tZ66VkEBgfMaZsLjBfmp6kmA2edRrRIFFf
 Z4DhCTasOUvVaJNPjyoT6vBJPZVeGZFgoEiIlq75MRBk0P3VeLGKZrXZ
X-Gm-Gg: AYBFou2LcBmUPB0FDhXDBcDKHbDN4WsNJfAr+aHfk96L8VX1WY/iFMLaowqdltB3OVX
 mDoqKfFmoUeXv37uE1IPKhqU5GjOWtkOvdV9Itb8cSbgr8IJe6nvBo6tjj9RbmSU0Mci2kHWoc8
 cwniJ7ehvKRke3i84MEeMW7UNAVrPIXyWF4R97HK3/J8JYDGq96BXGWOOb30jcEcVGY9uap0ynh
 OAuz3BPXXPuS9pIflp8UgzMfAqnPva5xIJ57L3IHUC0kVHfR1RFA4KvhWhd+YfIi7yF0iNuLIFJ
 y2+Da8+dQGkZ/4Xkl+BAaPAanX6iZVEzKZx3nmT+DwuV8MlPRb4020hzjqzreSSW5ftNppunqB1
 wALRizQPduVmVwWWm/zVoYQU9Dw8v5rENCGL7+G8Bv5Ew4MWY5XwTfZHauZyDUuu5t0aDIPusft
 2GfMInNTiEd5VIJgD3YXWYXKihDrrsLY7WTmS44nmM9ldGBaOquLt/oMO/5im/YJwAAnhXvhTZ6
 qDiyyyonfKoesYBSsIOFOD9oMqWhuwsKNWwsRWcrVJodbpt+eESNhwCtIqfnOzHNY67vte1kkpe
 +zhNMowgTJmWgA==
X-Received: by 2002:a05:7301:2396:b0:343:fdea:9a4 with SMTP id
 5a478bee46e88-34c676c5ba4mr72060eec.28.1790704189113; 
 Tue, 29 Sep 2026 10:49:49 -0700 (PDT)
Received: from
 runnervmtr4k5.tm5rrcrii2xevck4shrvo0jfid.phxx.internal.cloudapp.net
 ([20.168.124.183]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34c350c0d0fsm660841eec.4.2026.09.29.10.49.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 10:49:48 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 29 Sep 2026 17:49:47 +0000
Message-ID: <20260929174947.4059-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929-fix_epoll_bpf-v1-1-39b19ab043c7@suse.com>
References: <20260929-fix_epoll_bpf-v1-1-39b19ab043c7@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] epoll_ctl06: Fix BPF map on old kernels
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

Hi Andrea,

On Tue, 29 Sep 2026 16:15:01 +0200, Andrea Cervesato wrote:
> epoll_ctl06: Fix BPF map on old kernels

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
