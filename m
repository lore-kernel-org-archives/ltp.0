Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0CC0C5B572
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 16:29:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B95A83CBD5C
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 18:29:23 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A08C53C7172
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 18:29:05 +0200 (CEST)
Received: from mail-pj2-x0a.google.com (mail-pj2-x0a.google.com
 [IPv6:2607:f8b0:4864:39::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 9CA1F14001FB
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 18:29:05 +0200 (CEST)
Received: by mail-pj2-x0a.google.com with SMTP id
 d9443c01a7336-2cf49dc298bso31164925ad.0
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 09:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786984144; x=1787588944; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=83DH1W+PCkATIvKfUOmmq4aSo6dYqF6svkaCRnZrvRw=;
 b=pKOj0lFdkGg3cGpL/nVhtTAWNrf9NKvGz+yQ5vk235oNySu4zAL1XRizAhKNTpQNCi
 +Ltavv0RIrHTqqWrDY2a1xpylioMWCfQFz31gFnbbpiAzQxmroRF0gw3zBtN54dWfTg0
 GCk3+gCB8PAX63Qz9ZsBYZJIBqgEuFwFVcNHkACeVgc0ZsvfSpqxbLcrJsHYgVLi5uPh
 GuJiSf7mdNsdTfxWsyhRffbRiQUFyiiR9qCMxMdvy2GOB0yqOPZay+YYZnnCWzBoYJby
 H5dtnK6ek5Go+TUWVrzwaLcugkUprRlQ1AMMiw72w4l8ZO5Le1IroNLpB6H6l+jFg+XN
 RHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786984144; x=1787588944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=83DH1W+PCkATIvKfUOmmq4aSo6dYqF6svkaCRnZrvRw=;
 b=IN8OzmGi7RNU9N53iRtbgsk1RZQd0S3xWUExvHIYQzq2VNrvfyilE/uFmBo/gQQae9
 I77zlH/WyX6HnzT6tMg4sqhUIBHHt/HOlAFHcj7+zU/NHRoUGKeue/FspqierUdLO8rb
 xmRqEIA/PE0UL/4C/hoN1fHzQJxZI55tdKJ3L2jdJSYJSLpK1WZg8oLMs+sexJMhhZp7
 Seg0idDQ9Hj8cTZv213agG+66CkCgdunkmk01jj49RQqrkeLT0W+6EL2+Pl0l+DA+eG7
 2C0gUg+3DkNOcuEZxKRM3/YRMWhQUb6lv9dR/lAn/cp9jpGXGMFqhyP/EX2XlJg2TTzj
 vs8g==
X-Gm-Message-State: AOJu0YwZxJ1urRQ2Wf4Je2n8UHsYT+bSYWaLxVjsb2MWjyNzCekODdDE
 e2fw30/w0x2nWNZBbJ/Op4eUjWJ0eg2VuC2s/J3FHI1oec2pBdqPOzEcS5tyRiqD
X-Gm-Gg: AR+sD10iVjY2CQ1PkOXCPsnotogAxj3FERun2lGbuh6vdoFJVJxQXGbMMvm2exXWQof
 cFvE2bdSZkQapDZI4tOGJejK60BKpWCIaIci5QCvjSoNkX/T3XJICulbq091q2MIDpuYqNtqMPz
 w+wgIkGxE26sinM0aAf/ZMc6eUvtCL+zJ/agUJbs4m8nGxR/xMDwWQggPhZHO37wziLZvRBjRud
 vfFqR5NITca/U/S3+oNL6pyw0GAnXAJbrgofAGtNs2y2tMOXHbt7fAEyoFIjmSrwk8noSTh6Dvw
 dN4tMKRlLBXMosCGVBaB4S/KC3yF1n3YFi3JV/6Bu6m/jkcJxlbBOf8C10udnU7bXb0BL5y4mIo
 wZg+DC6kaLIjydKFi9lVDvHQIDVzQ3ZYt6jhzJmVk6jjZ0t0eVexxrFnR3rJYnQ7rMuCqSXK8ag
 a5QZijrEN0d54VsPVWytHZlnXTN32z2DCEyJ+9QXC4wNuq/lHxiGkPf5S7qzD3o4/894Co2fwvX
 BmCWfTPdR+ILbfQ6WTq8esDF5zLd12oyaay/I2YmCf74nzFvx/UYHKa4PFNmy9d8w6owZsy1KH8
 dQ==
X-Received: by 2002:a17:903:46c5:b0:2ca:b89:7bcf with SMTP id
 d9443c01a7336-2d3b0cd8b20mr330574215ad.22.1786984143905; 
 Mon, 17 Aug 2026 09:29:03 -0700 (PDT)
Received: from
 runnervmzvulz.x04nhzvefmxebapkm5iytxa5ag.xx.internal.cloudapp.net
 ([52.247.210.114]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d5c1e91b53sm5594365ad.60.2026.08.17.09.29.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 09:29:03 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Mon, 17 Aug 2026 16:29:02 +0000
Message-ID: <20260817162902.8968-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817154048.3854-1-always.starving0@gmail.com>
References: <20260817154048.3854-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fsx-linux: Fix reference buffer corruption in
 op_map_read()
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

Hi Jinseok,

On Tue, 18 Aug 2026, Jinseok Kim wrote:
> fsx-linux: Fix reference buffer corruption in op_map_read()

--- [PATCH 2/2] ---

> +	max_len = fsize - pos->offset;
> +	if (max_len > op_max_size)
> +		max_len = op_max_size;
> +
> +	pos->size = random() % max_len;
>
> 	diff = pos->offset % align;
>
> 	if (diff) {
> 		pos->offset -= diff;
> 		pos->size += diff;
> 	}

Could the offset be aligned before max_len is calculated, or could the final
size be capped after alignment?

The new cap bounds pos->size only before offset % align is added back. With
-o 1 -w 4096, pos->size starts at zero and can then grow to 4095 bytes, so
-o still is not an upper bound. This also affects the existing fsx05 entry,
which combines -o 1024 with -w 4096.

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
