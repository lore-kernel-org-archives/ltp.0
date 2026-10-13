Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EAC0CC6B12
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 15:42:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 38E853EB0F6
	for <ltp@archiver.kernel.org>; Tue, 13 Oct 2026 17:42:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 158B63E6A6C
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 17:42:43 +0200 (CEST)
Received: from mail-pj2-x0b.google.com (mail-pj2-x0b.google.com
 [IPv6:2607:f8b0:4864:39::b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 82E7A2001D4
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 17:42:42 +0200 (CEST)
Received: by mail-pj2-x0b.google.com with SMTP id
 98e67ed59e1d1-3a84a12aa97so774694a91.1
 for <ltp@lists.linux.it>; Tue, 13 Oct 2026 08:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791906161; x=1792510961; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1rA4xUwoaB+uu91ffF+tIuali6L6IJ57qakwgC0aHsA=;
 b=czN5tamzbcjl0dyMS81D99eSmdA+USUWbRIbFdVK/311GUgMYxIyXvUKzeDebCz+XX
 37Tcn6Bi5LHNkDjXemFTrw5rX6G54e5HBRYlTh7OBfLzAbmE8QpWPoYNSSx16TbVakTw
 b2cBUVpkZW69ERexB2GyLfsLyzUUle2KlQ11cGlSVVtFhEWtu9+LyuyO3v/CiFJWK0Ow
 mQu6UpN2ROyyT8V3p/lWmMCGULZXjIzwiug8cU0HJqu/imx+Y12gDLHkv/qZVnewnMy1
 uZHttuQf4di0YxFdEWH5QOeagOdShe8d74j6WQLwIanCIdsTax+p0Vgr4H0uqfwvhtbc
 8EJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791906161; x=1792510961;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1rA4xUwoaB+uu91ffF+tIuali6L6IJ57qakwgC0aHsA=;
 b=GNwzV8BPjj0tso/06ph/1Y19fq9N+2N+aH0Muipl6jL3ODd0XjCENvkgVEaOcF+3f2
 JbQjz10iT33z85Ns0eAGmuLZBf14r8w5zObVAcbkRpAx1ATpnCkFBxQTUosM0CBQEWsC
 c/mXw43S3p343SD+0/jOMN81br5U6BNC8xbqH4PoHvCzs5pOVhWWY+J8z5kuWSQdINr3
 4lZYQHYCGY+auJkW38vXiHn6jGL/2WgjJkog92/JxSHmG0OpIvaoNoLeorZgO0+AmAZR
 MyKe09U0OHruuld/P3edx7mlrFOqxtXw1FBg8ddQtsXQgt+JH5ziiKhdAbSsLzInvxF8
 FNAw==
X-Gm-Message-State: AFq9FYKp/HbNesRkEJ9jRs1nQUoEvFwx0x/n8ljFOxpXZpXpPUYoLhgl
 h39PdUb69umNQm3gIPmelsKxkxrRDh0oIBdY5hCSGhYj6buq6Gf486on
X-Gm-Gg: AYBFou3zJvxrWrfwqnWBR2WaurPHwotHN2rBfCWEXbMTvH4S5+kkeUNOa9G9Ynf4kuO
 hwH6WfJOwFu7XzWa5QiY92Qgm9UCSham38YWF1C/rWwZseMlkE1QYewZ+Y8J+hL32sNPkoaVCWQ
 P2e8SbHlDCT2tG7wsCo4zHVvz6bYDIpjZb9YQVJZSi2gevxRkhxnSJ+AmMkq3lKJWdzlyt7Kl3y
 kVYAesFgefTknyghQY/B9qLcbY8EPWmLBiDwfREsX94gPjrBP0rR8aZnj4rUpDzoSyuhFWbY+98
 Ac6pKCRi45wvxODXczV9W35sBPmkUZ0eBsA3AbIeBUY3MtAJg12mdGat2lt1qGzUt8k543SsgYD
 ZbH9hFgoZ+FbYkyM0TOteVhIrjsgwFzkcqfxqgnp5CteO3jjw2yAVM+uY50g6lMleiHqcO+H5r1
 LZN0r5qhUfF7IfRos8Y4AgBFo6WvLWP24nw9YplhMniOL0D/CWvVNYqfyv6sjZyZgLy1ZRFGtZX
 1gkU30O6W8nyY6uJsWXE8gyTIP71H4lsuAZdh0ttmgMGw84B0ztP2VpdufAeYY7k75zV5wqpGvY
 5D44GkTmTpk=
X-Received: by 2002:a17:90a:d2c7:b0:3ab:2d17:51c5 with SMTP id
 98e67ed59e1d1-3ab3a32d9b3mr10480138a91.6.1791906160770; 
 Tue, 13 Oct 2026 08:42:40 -0700 (PDT)
Received: from
 runnervmmprz5.zp1jdlg1lluuxdof1vfzjm5fwc.dx.internal.cloudapp.net
 ([13.83.160.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f24b74csm162518a91.7.2026.10.13.08.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 08:42:39 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Tue, 13 Oct 2026 15:42:38 +0000
Message-ID: <20261013154238.4969-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013-fix_core_lib_deepseek-v2-1-7a6670fd6fd6@suse.com>
References: <20261013-fix_core_lib_deepseek-v2-1-7a6670fd6fd6@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ujson: Fix 4-byte UTF-8 sequence decoding
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

On 13 October 2026, Andrea Cervesato wrote:
> ujson: Fix 4-byte UTF-8 sequence decoding

--- [PATCH 7/15] ---

> ujson: reader: Check for signed integer overflow
> diff --git a/libs/ujson/ujson_reader.c b/libs/ujson/ujson_reader.c
> +	if (sign < 0)
> +		res->val_int = -(long)val;

Medium severity: the bound allows LONG_MAX + 1 for negative input, but
-(long)val then negates LONG_MIN, causing signed overflow on both LP64 and
ILP32. Parsing [-9223372036854775808] on LP64 triggers UBSan here. Assign
LONG_MIN directly for that magnitude, or accumulate negative values without
negating LONG_MIN.

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
