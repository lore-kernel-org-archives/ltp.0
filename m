Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8075C5DF94
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 05:32:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C501D3D064C
	for <ltp@archiver.kernel.org>; Tue, 25 Aug 2026 07:32:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 145553C21F2
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 07:32:14 +0200 (CEST)
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E03A32009B5
 for <ltp@lists.linux.it>; Tue, 25 Aug 2026 07:32:13 +0200 (CEST)
Received: by mail-pj2-x02.google.com with SMTP id
 d9443c01a7336-2cb3f5bb19aso14563825ad.1
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 22:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787635932; x=1788240732; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TZL0RTonE5dLyiEx1OHupJu1n3IHULohPyxB73tnPh0=;
 b=Ph1puWOcSRxeAN0toh3OjOI37APnapsipO4kbBHRQTy1I3AQ5qmhDG8LDjqasqjkBt
 I0fCnVOQqTRcLRwWiSPN3Cl/+U+xyM0b2KL7kmrJTnpuUvEad3U8PXlNAYNs3lEkg5aF
 K1ZVBNAxvR95HDfbjR9Xy5MhNqjpgdLw787pkqQFuMZMYKbMJyYFkWMsJsaXGCKIu2wc
 7Y9pfTtRHowAd/QVTnZk42dVxYtCcPCzL8FxukB02ywruv77AnDr7GS4yQtWPWbfi9yX
 xoibAqsW0WkAra/s+W7iD/Zc05qy54sIIqBU9aQuLlEYCvYLPlvokQExiEqmd/vWb+IK
 g+dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787635932; x=1788240732;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=TZL0RTonE5dLyiEx1OHupJu1n3IHULohPyxB73tnPh0=;
 b=GUKSBeeVnUoSyAApi3pDw8aH3w9l80n3sfw+6cdFZznJXxOiw373o+ewQWEJZUcpzh
 9pJcDC3D1WDe2aZrLpJeoDpV0xPwNZXq9OECB3o2tP7/0+TWv1Wc+tGSey8D8TlPxa91
 0Cc0lAIe5naOoW376+TGPFvLgwe4bPxvjW9DDIbgXhgQlAfE0CJGPwXS6pgvHzO4IG3U
 mu5jvqZDba7HsBD4vRKYDNQbRQGZ3etzAGzSKS2SJz4mIygils4J32MHiEODu7JaWiYa
 qg66keiztkCT5i0heANQ88XC30t/9xBoLMrI8O7xbkxUY331wNqg2Ubh2FZUIpPew8Jz
 RXPQ==
X-Gm-Message-State: AFuF++nY4xJxo9J6Zn/tXMrKzpml/i3NIOcAh2iCXyikMwERzIpstOrA
 QymS+xgLt71cL1JgZyXa53+Ikan6FablYjCYBsX8gx5ShcVqzq3jm95FT0sHiaE5
X-Gm-Gg: AR+sD11n5ce6eKZF0EHMY3v+dmVBNkr6pVV47fxNfjWO4UsrGz5s0sz1zQVXtb8MWeD
 Kn0ryx30I0OEizrBSFWIj3ZmZT+rnmeTIUnaiPpOC5zimt9hBbswgHdOhC8LqosJh2m/2zRE4G4
 v6FGmt5j1Yqj/gY4mtgY11hxZvKbSsSZiPj6+uFjICl9av5Vdbg3LqCiHKFzygOO5gmHfEu+81u
 qiqIqiD+kYk4i6Qfq/2lbc0iU0xF4CQkfyAyX/KfaL4YlTNAlvGHrSW4Bz3ivgYD1xm2EP3dr3U
 s+93WYoi8WmXdpUtk6QCJQG4qShV5ejvuVrNIS8ceu90S0ISMnKgzA36W2cHRRv+ZpHtQQEcmDz
 pmh0+l1gyKPIK26Ow6pDF8lN+gu53SQbw+dBA0W76LXFtzAQ5UbgBb/5eEgrs3Qsn/WEBTj7UJV
 bRrBW/tn7kwLpsHZS93lGMFf/3RJCuVeUj+DEuhaZJEYWQUGYA4Et/7pL9HNl2fCfhF5zmZEV1T
 A5zr5t5ZFxOPTFo3/9sVbLWTwI7ChINcfJs+NDBr5PgGf0zBsaak2Zy52LpeANLOe2Dm48TfEPp
X-Received: by 2002:a17:903:40cf:b0:2c0:b6c7:227e with SMTP id
 d9443c01a7336-2d6dcab590fmr86541885ad.5.1787635932212; 
 Mon, 24 Aug 2026 22:32:12 -0700 (PDT)
Received: from
 runnervm76f27.ylsntxfoq4iuxizsmqxnehi3ne.dx.internal.cloudapp.net
 ([52.157.32.192]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f91d2d1esm33820760eec.17.2026.08.24.22.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 22:32:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 Aug 2026 05:32:09 +0000
Message-ID: <20260825053209.3893-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260825045515.24503-1-pvorel@suse.cz>
References: <20260825045515.24503-1-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: test.sh: Backport tst_cmd_available (DRY)
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

On Tue, 25 Aug 2026, Petr Vorel wrote:
> lib: test.sh: Backport tst_cmd_available (DRY)

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
