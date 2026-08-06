Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF9AC55ABF
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 10:42:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 689C43E28F2
	for <ltp@archiver.kernel.org>; Thu,  6 Aug 2026 12:42:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B6213C2678
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 12:41:52 +0200 (CEST)
Received: from mail-oi2-x02.google.com (mail-oi2-x02.google.com
 [IPv6:2607:f8b0:4864:32::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DB04110005BE
 for <ltp@lists.linux.it>; Thu,  6 Aug 2026 12:41:51 +0200 (CEST)
Received: by mail-oi2-x02.google.com with SMTP id
 5614622812f47-4ab2d8e7e4cso549195b6e.1
 for <ltp@lists.linux.it>; Thu, 06 Aug 2026 03:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786012910; x=1786617710; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SWkERVk2wvQU7mjbybEWVjKAqi38xhmf9RbrwYcJEj0=;
 b=ajZg/zYiK27YTHJyVA8Y9j7eojbfUj/gmgW6Znp90OJF5I10R7gqNMjlT6lvmdvumN
 7ZSh68p4ZVAejeuuuVD2FSASbaXTjj0ODHhQut43PpHBAINIUTbDjMUtYXZ2e+vne2Fi
 wpB+vhaSlL615Seq7QZtrPUdg4/ZiPiu11Uk2nyC6oDy0mE/reSWBS+JLe9phW1ump7z
 3HbJMQnUGoAid4E2oqHxW7wEl2Gt35mO+CW+muvzOGWI3tEqyWGDw641q8bl06B4dSrT
 lvf1/pr/ae3Bh/RwVyXDvtir6V9M8b417uc++Z9tZcLGpJ5XSS/1Zlbw+o9ARXpv9XHB
 wzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786012910; x=1786617710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SWkERVk2wvQU7mjbybEWVjKAqi38xhmf9RbrwYcJEj0=;
 b=RhzjPWj6uo9wYq6jetNYcFEAponUDotsK7kCdFTXJdEJ0V6w2YNyeNMf6CiPVFJrT5
 ur6vg6e8vCVkBgjD4kC4P1c/fWWGSziQPy4Z402802AZI9zb1pjlEJBx/d0nUxnyZEoW
 olpxyuXc7j052ILIvornBn6dTAJ7ORa6Gc5R2XsivZtcT1fCcs4ugdyVu6a3ZcI1M3Nl
 62IhyruxAHHprTg8y1Hw5HDc10HMe6cKiGsR/2QweEanaek4/l/vN8Li55pUVxMy2sj9
 tuzbDXdGoAP4mUTDvmx+oraPjWodANUykAWoPXcXeE874+fjwEO7Z5apm/NqR9ZJbQor
 OHPA==
X-Gm-Message-State: AOJu0YyzTKfPuLKAn2aJui5wMqflZ8G2QTcYKCHYKxo9T89Rh/Mw/kQN
 7f39xW1x4j8NXpQ6C72kekUxqmVJW5wOpfxmU0rxfPcmEqlA+UKqhDGO
X-Gm-Gg: AR+sD107hbVXYERAOegYWSAqpw9LqTjLAVeUPpTV6rqPeYi52gYKN96sAsjMlEbpUsL
 yj1PvPHqANBmlAXqVYCWcBCqRckRQIrA9HoheXE7/euHhsnYAQOQgwGOa0FJueJKHcZ06Ir5Mrm
 SnXhqQjmOCN5wgqEzNpruoA8PsWhsheR+dSUw2wW0WwC/pzoot3CgW3kEQSFba+bH4ld0UkwI3S
 oLGBWub7TgJj+nO9BUCBqY0BXgb4B11gj4dGKnhmjA+HcsdUI6oZFXqbQu8N3XFAlWtZi+UyjeX
 hTvBk5MsZhw9lLMOXnxydr9RX32amK5/ln8t7LMXSSzxeV2VVDRawzh6IHO6n22rLRDee2rwluK
 Sdax+7/siICRwatcQPNAXxLhxQB6W4FcR8ZH4nEwLBbgGS6rrsZ6HV2nHpMxc86TaCcT2z/mVqy
 EHh/ywftJgren/Gbt/oWxPpQ/PxA8JbWGl2rCF+eTgrJJAoNTqVjVJn63puoE4S063hz/gFnH+n
 4AHJAhRdUo4F9FLveIpmcJMnbPiekjXhDsWqOWSFgTFTcDkrx5tMQjmHjEFkZHilQl5alT66nY5
 aw==
X-Received: by 2002:a05:6808:1824:b0:4a0:97bc:53a4 with SMTP id
 5614622812f47-4afadf2d77amr7710793b6e.5.1786012910375; 
 Thu, 06 Aug 2026 03:41:50 -0700 (PDT)
Received: from
 runnervmvrwv9.5pbdgxxwrqiuxfrk22vlocdl4h.gx.internal.cloudapp.net
 ([172.202.100.55]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4afae7c50e9sm4180672b6e.17.2026.08.06.03.41.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 03:41:49 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu,  6 Aug 2026 10:41:48 +0000
Message-ID: <20260806104148.8947-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260806-cve-2026-64600-v6-1-26c11513c75a@suse.com>
References: <20260806-cve-2026-64600-v6-1-26c11513c75a@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve: reproducer for cve-2026-64600
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

On Thu, Aug 6, 2026, Andrea Cervesato wrote:
> cve: reproducer for cve-2026-64600

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
