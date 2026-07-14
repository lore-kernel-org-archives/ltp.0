Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B69C44508
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 12:15:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EC97C3E7ABE
	for <ltp@archiver.kernel.org>; Tue, 14 Jul 2026 14:15:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7AC63C5E52
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 14:15:23 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9128560085E
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 14:15:23 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-38dbe53179bso248717a91.0
 for <ltp@lists.linux.it>; Tue, 14 Jul 2026 05:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784031322; x=1784636122; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TpqLcij8IfVgJ3CWKBkcLRDk68irNFT6X8zjseg/cZ4=;
 b=CALdnniFBqjJLc/cUXvITXVi3QZ4A9dAKWo/IsbF9qd1Bxayguo+TFVfQuMNyPTQeQ
 Dei0VmFf70rbt2sOqEozZ0UZDQJ5rzFay+IFJpXcgTDzgghvcCihef4VZ4D5g73L5sdD
 SfkZXKfIGJhyattvaYQtFvCJqXr9VALih9a0cub8VWNfArSgtah2d4VacBHQ+0/Aq9c1
 +Uw3tga3jNqFgO49qKhNHkIPLzs4vhlXFD7Uw2UesRf7eh/e6R9ZvNc0tjJRXWMjo4bf
 PC2R/oIlUVfsizfSbSVjHsgs1y+Ou2CdwASgh9f1vRqiu6QDobrzm8lsLAg1PI8FGWYC
 lilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784031322; x=1784636122;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TpqLcij8IfVgJ3CWKBkcLRDk68irNFT6X8zjseg/cZ4=;
 b=rgkNQy+9UE7cIr+wL8sY8EU10qVb5THvuj8dyNXboaKrD507USQP02ICpK5AQ7jAsJ
 GuyviK42UezvX8d9SqtarDKiedHa/CmkbrjRGzRBXIsrL9DRLGAT1JabJrrkWiLA8XYn
 xQF24UFRWyuTVxWSj6m9Qg5SUpRGhcWoqDqdPK+vUwE3Lmjlevf+Nk3cl0J+2YoUPEQe
 kd0Xh5Z5EI3XFMuuUAg5Dic36Ubhsnfv4zLWNYPej39VaL6FOq51Vg30DzrvFrAdP4hK
 MDSUkhobm6s1m33V2uQwXzgtwwhAeCz6rMl3ipGm6xQe9cf9apfHv0UHcXO1Eghs6P4I
 BnaQ==
X-Gm-Message-State: AOJu0YwgdMz8m3hNXOWxVtjvBvKJcwNQT0M3o6GXqlZ+RVgj9NCEkcyf
 KnBT+7QhyMGB+hg16NsZ5+y0g5epgd2qIaoohrNsY0av31enyEadgrmL
X-Gm-Gg: AfdE7ckMbYJdl0Yw8lCBYUAq0YTj9ATokxYkvLvLc8oPV2ZqnXDUW6jC7of2SDTqDFe
 0SRSaBxIOag/zWyOBvSvJhmiwSXU12dsDodQZq/J3uBMldMuoBMxmvbeUW68hqtAB3hOHlGnot9
 TSUDzD4nVv6eETxRiizdjaxwbca/UN+uUhn6Ti0DI/BfG802P59LE4h0+ViB3YxDJM3NpnzqPiU
 Aq2f0MW6kU1mDxGy9rcBvdcm1LueKCwhC+J2uHZPWJigeZhRZWj2QKrysyOVqqWdw5YQUIS2+Mc
 kKKnaALjI2/hycAnLkRasVZtDLU9yER58SyaaQDSuUvppW99Xaf2CUNhBLpTtHJq+Sd1EXfw56C
 klytezIvhpgtSVO+hlBtwc8P9OVUeSsJmNrxWwCe410LfwULSusSEPTW+kniLkDhJhlgfN8UbSM
 vn3kYWI48heFf4vwjgWSwnjoG9lsnq5Z9RLRUQtz71IwpwFzDLz653ey9FGtu3O8WnQ02XFuQlU
 +17dojYE4EJ7ZkGhgRatDcQnzbW87dg1LMap6d7
X-Received: by 2002:a05:6a21:468a:b0:3bf:6ac8:8d29 with SMTP id
 adf61e73a8af0-3c11060c043mr14409279637.21.1784031321743; 
 Tue, 14 Jul 2026 05:15:21 -0700 (PDT)
Received: from
 runnervm5mmn9.eqapidzkgl1e1neuqjep0cixze.dx.internal.cloudapp.net
 ([52.159.244.176]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659d8da9sm142676111c88.14.2026.07.14.05.15.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2026 05:15:21 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Tang Yizhou <yizhou.tang@shopee.com>
Date: Tue, 14 Jul 2026 12:15:19 +0000
Message-ID: <20260714121519.3975-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260714111307.166205-1-yizhou.tang@shopee.com>
References: <20260714111307.166205-1-yizhou.tang@shopee.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] perf_event_open03: Track SUnreclaim growth instead of
 MemAvailable
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

Hi Tang,

On Tue, 14 Jul 2026 19:13:07 +0800, Tang Yizhou wrote:
> perf_event_open03: Track SUnreclaim growth instead of MemAvailable

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
