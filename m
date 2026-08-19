Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C8DBC5DF85
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 09:40:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D255E3CD638
	for <ltp@archiver.kernel.org>; Wed, 19 Aug 2026 11:40:17 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1F5833CB329
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 11:40:02 +0200 (CEST)
Received: from mail-oo2-x03.google.com (mail-oo2-x03.google.com
 [IPv6:2607:f8b0:4864:31::3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 76D95600467
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 11:40:02 +0200 (CEST)
Received: by mail-oo2-x03.google.com with SMTP id
 46e09a7af769-7e9fe57f70eso249953a34.0
 for <ltp@lists.linux.it>; Wed, 19 Aug 2026 02:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787132401; x=1787737201; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jOu1mKnV42czyIMuuX42nIyHe+d8F+HydmE+8ahRLCU=;
 b=BB70S2cKssq+NKJCD0fbIeT2WiFiEXMheY8NzRTQQszbFgVeWhjeLtbJmVgLRJKSeW
 cz0WTSxkOveWaOwhQVckduXmMTxdW15MHYvr5QFUh0Dhtj7K0/RY1DYs0FiP8oflqZlT
 42CdYzOO7DVoyU+nzzRD2Ska/3BqnkJ9onCzw1N3oKJAhVIYKoTsuwQen32sO8OT4nVE
 FJxyStKU5eytzkYUhTsTuhrikM6YOv9ErCPtDUgdsweAnxRhYLhM7lnz4xYzwAPf94hk
 4kZr6hCTfq0VzHIC/VzYMPgKQHrH4fEua2V172g8F2/jPWHw8u6uY60iKhp2EhI42raJ
 nv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787132401; x=1787737201;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=jOu1mKnV42czyIMuuX42nIyHe+d8F+HydmE+8ahRLCU=;
 b=O9N4BCX9dYfAMvZkYwGO2o+QHKxgGIRUN2M1McGvLuI6RkWnSt431Yy5gsOh02nDee
 Ty6imXgcdcMLV6nqEomsxP+A2lFLlX38uXl42L7q5It7p3eGkZPE2RGNchUBxMeRynjK
 3lCEN/RkNEp5nTdrrQTpmTPyKFtsLyEcmJWdIXgn1x/kwljBulNcXwKraMXk0BusGz0v
 881VW1qMl06qq3jINpqAVGLTSF+dcoa3ytXPR2xIpe0rB8XUxNyKH5L9kLwO1WsOkSoO
 Dne7dQkP1M5xZ1DXzqiNFLkJtdpsLLKHCMyNY8Ozr516VjLNF6R89JV1oo4oKXMkARIA
 YXug==
X-Gm-Message-State: AOJu0YznXvK6xKr6cwTOJy0bNlysRSIA0JDxE61/S82s6RBSVBbjrgn3
 HALwHZchekXC4Zfrmc4Dh/4X1Hnp6Bhh9CXklEzZ/a7phPfu6AsRRwFe
X-Gm-Gg: AR+sD10Vt2OeqWGDlw1FVZNOmcsfmOZlWBxAh4VF+ZMjRow9/nlTYeW//NTdFZd8/xR
 2EfIsTwwv4K2Qs9YCFfSaceqXVVsS+vAE/Jrd6dps5A95e4wFgGoqZC3A/9ZPzPqGC5cJx2wd/d
 0uasHxvysBS8lTFk2BHJqE0nZ5FnJafeO03LfQUpJqIMzAsAuGv3xJ0YNjexm9mVys3ZPB9WVoA
 fSEzp++dkGxgLekD6q3lh90WzwKrutByQRHrJrazUYNX46r6iLMVqHp1YXGuO68KflHdgWGCLhO
 IGxWT87pNE69u8MKtFLbpjSx686/bnZ5+yxxXvzqx+KrMtnB+5Crv+1NFE8u68M9HQdsiiH9c+Y
 f3/Z3nFQQbGzizCc4Jnit1wKQB6tp9BLrpqIUE93pndBeDLtMR73Zk6QqnSN6zKhArsMwNp93oa
 fY1bV0cQehq6a6qC+QPrfiRh8PGlHt89AJYRV5g+ZLIaaYOGXDLrN16l+NbWloke4CmQ1ePBY4W
 yu/XjcL7wEni6I11uJYa4MhK+G87oW3Ol2rKMy6RFjZrq/ozYLHV54H2b3PYDBOb0zzgwreHe0S
 pg==
X-Received: by 2002:a05:6830:2696:b0:7e6:e162:915 with SMTP id
 46e09a7af769-7f43f97a54cmr2794324a34.5.1787132400984; 
 Wed, 19 Aug 2026 02:40:00 -0700 (PDT)
Received: from
 runnervmzvulz.5bm1vqshnmiejfeel0dii4uw1b.ex.internal.cloudapp.net
 ([64.236.133.183]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f43fea4893sm1286197a34.9.2026.08.19.02.40.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 02:40:00 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed, 19 Aug 2026 09:39:59 +0000
Message-ID: <20260819093959.9153-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260819083907.26866-1-wegao@suse.com>
References: <20260819083907.26866-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] shmctl03: Fix 32-bit compat mode failure by adjusting
 comparisons for compat mode truncation
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

Hi Wei,

On Aug 19, 2026, Wei Gao wrote:
> shmctl03: Fix 32-bit compat mode failure by adjusting comparisons for compat mode truncation

> +#define TST_ASSERT_SATURATED_INT   0x01
> +#define TST_ASSERT_BITWISE         0x02
> +
>  /*
>   * Same as tst_assert_int() but for unsigned long.
>   */
>  void tst_assert_ulong(const char *file, const int lineno,
> +                      const char *path, unsigned long val, int flags);

Could these new public flags and the flags parameter be documented with
kernel-doc? The existing comment does not explain that one mode clamps at
INT_MAX while the other keeps the low 32 bits. [Low]

> +		/*
> +		 * On 64-bit kernel, shmmax is clamped to INT_MAX for 32-bit
> +		 * compat syscall, while shmmni and shmall are truncated
> +		 * to 32-bit.
> +		 */
> +		TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni, TST_ASSERT_BITWISE);

Could shmmni keep the direct comparison, and could the comment omit it?
In Linux 7.2, ipc_namespace.shm_ctlmni is an int, the sysctl limits it to
0..ipc_mni, and the compat path copies it directly to compat_ulong_t, so no
truncation occurs. [Low]

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
