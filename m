Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A89CA5FC7
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 15:02:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 69BC13E5E11
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 17:02:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87B493C2EC2
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 17:02:19 +0200 (CEST)
Received: from mail-pj2-x0a.google.com (mail-pj2-x0a.google.com
 [IPv6:2607:f8b0:4864:39::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C2BCE1400246
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 17:02:18 +0200 (CEST)
Received: by mail-pj2-x0a.google.com with SMTP id
 d9443c01a7336-2cf5e516e67so15697425ad.1
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 08:02:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790780537; x=1791385337; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=43m6d9icJmQ+R6TpYjdp7kZwL0jEiPJCAjJaYtUzBhI=;
 b=FN/CUhJ9OhEU3kUN5+sg14Ab7nlLb3WtZa5+FIXoFCqvAYe2iYFG7Qtl0WEgp6J+1F
 ijXVdBcuJ4NOrxVxw7IMS5vadpRWKKj2R6Wn4KZ1a/f+ZX/vcPc+GItjSQZkx1JoRkxh
 1lGBrRh5II+teM2t8X39RRig2G6ttGiF61R0ScMY/2nbDVxHNfPDeOfJU7WcfFnFTRKv
 Zmxr6JJe0qgASMNGWtKzNCqpHabtbTOeVBXjmrXGt5M9iH/YqkAL4Wj5qhE7+QXVFGhn
 WMenX/eC9Sc7HSfkiuuBfBK/NZ25bruU8+DpPpM+UJuviuKU/xyFQKPUv3L4xsXpO4Ux
 RoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790780537; x=1791385337;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=43m6d9icJmQ+R6TpYjdp7kZwL0jEiPJCAjJaYtUzBhI=;
 b=rTb2V6jrfnGIwTQr0E9CAdIJoe5J0k/e/MUnVFNa24dIV5yMgfydrGUPRmuDNmmZE+
 vwSGepCOxRK1Jq2qa79x8otj7C56VM9YXE3LUPgdp902Rnl65PMuGPFqNLk8kLZh1W1Z
 BfAqTJCGKpVmbyvVMsEawE4o1WKxZqOtr76ylAY2XKNVoRWzKplUKCnv2mJ1xVEOtrK2
 hsjRJvcdcqf0tvj4P0sWnQg7BXAiCQUVpO+UHJ3N6fGhp8uhoZE3nrHFChviU5FVTPX5
 PIWN7G7mBpq36775OZrI38EHG64yg77bJcrp/A/5vQR9iVVWAjc2mxwGXuxTG6zF80wP
 YVYQ==
X-Gm-Message-State: AFq9FYLiYlV7o+p2cMtoQmidOadgg2g+PE4vLINdoMIYtfEnYxR8DqEg
 c24gO5H02KQ6UV5h5YPPnKh3OX/kwMXPzMGki1t7ekqDTKe2twUEjlHhBuHlrCw7UnA=
X-Gm-Gg: AYBFou1OjTl0eLbQcjvhkUsLWU6Z0Dxf/ZuZ7VKUxZgCqq4IJB9wo5eF6Tmuc028Gq5
 xImU5OHwi9HcrXfE0JIWsxnfg5akmHU6nCR+Tf0V/EHyXqOjz7SMnyhrkiF/Q05LXlmYXw9Fpcp
 G/SR4r7OD9KUf15zq2zzHTfDgUVLhvWO/JjMlqEwUTXK9vo7Zn2bwKpq4QlzDT9qWdQacdZEoqt
 diiBVe5LG+xm3eFSzixfdf5PrPDccOiQJ7WhzMoZuhLNczLa2YKqLnv8Dp26/nhfTJs5mKecYqV
 bSIjid+G5y4MIbMYrVduJaKt/QbsQon4kGXBdwJKClOxEbTDHx56R54zhBHEtcZSr0Shqe6JthX
 5qk6hcTKlNyjXQxuB4LOjWUyfqkMUo0BO6xouDwSnxTdLVTrXnDd1h4OHtlmcS8yqZCZTUWUod/
 Z3OM0HQRUh4NFJT3jOarCmU3E3dqy/FRT3tTINIVtfvqtCK2HcEWraa3JjlSDvrpRLJg1LiI5jp
 V0no7GRnruKSaTb2tH0yzU0e1ml6ahffDitY9wy5XXdeZz2XpYjeyhhAQsVIyHdZPpOxkBe7Y1X
 zboZt41P8EjAbfIdRa4=
X-Received: by 2002:a17:902:ce05:b0:2df:ad58:cf5b with SMTP id
 d9443c01a7336-2e2e491952bmr13960455ad.3.1790780536565; 
 Wed, 30 Sep 2026 08:02:16 -0700 (PDT)
Received: from
 runnervm8df0l.gwsxv2ois3gero3osach3nzdnc.xx.internal.cloudapp.net
 ([4.155.237.7]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e2e5b897d8sm9421635ad.28.2026.09.30.08.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 08:02:15 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Wed, 30 Sep 2026 15:02:14 +0000
Message-ID: <20260930150214.20225-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930-fix_generate_syscalls-v1-1-fccaef437fa1@suse.com>
References: <20260930-fix_generate_syscalls-v1-1-fccaef437fa1@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] generate_arch.sh: Fix syscall extraction bugs
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

On Wed, 30 Sep 2026, Andrea Cervesato wrote:
> generate_arch.sh: Fix syscall extraction bugs

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
