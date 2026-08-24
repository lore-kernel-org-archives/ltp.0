Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750EDC5DF94
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 10:38:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53BB63CF6C8
	for <ltp@archiver.kernel.org>; Mon, 24 Aug 2026 12:38:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9125B3CF6C8
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 12:38:35 +0200 (CEST)
Received: from mail-oi2-x01.google.com (mail-oi2-x01.google.com
 [IPv6:2607:f8b0:4864:32::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1DFC410008F2
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 12:38:35 +0200 (CEST)
Received: by mail-oi2-x01.google.com with SMTP id
 5614622812f47-4a41b6fb855so1295460b6e.1
 for <ltp@lists.linux.it>; Mon, 24 Aug 2026 03:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787567914; x=1788172714; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9QeFziARZXAZPsweLrOXGlxXL6Zve3+8D0p6afdPLYw=;
 b=BBuFIURlV5mgWZ7eK4wm0ajVM+9x9sKAjLtUUMYqTABbVTEcV8oKuBptKOpzm1LcxI
 QDb/xMlbww/7oqBqAQ0/EbCm8YFkPxh71tOjuemW0FDL7bqlR6HMq2tMYvYzr/MSg1yB
 Pe+Gq7P9fBdJIh/1qyzLf4LTDqAH2thipVQP1daMlxnkB8B81l70p9ZotSJsmHmgTYIe
 cTb/dBo03R7xVaNiMh0+SJHO6245fgMXq/iXiVTzhbXdivvMnz7UFTdmzNhbXsrZ1Q7u
 lbI65lCPokEN48SX6qR2T8tNyd7HEHZ8MA+V4FRX93JDBKD4tZGmPajwT7xzc5xBTPqq
 tv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787567914; x=1788172714;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9QeFziARZXAZPsweLrOXGlxXL6Zve3+8D0p6afdPLYw=;
 b=UsyHODaE6WcKab/mhezigz0cQM39fxrI4nRa6r9bTlsTFOTju3InZsUSZZKfX/vha/
 Pm6QQnyTkas3P6Lrrsy6p64X+SnIyCsNPgSn21Cb62KxRCduvyV1vJVkinLUP5wW3yOJ
 bAnMcyBBEXWUrz0pQoAF9fXy2u0vMiRhKeDW9MVlQJkacOiPsIisxaomIpzg7t0y9cnB
 Ejotj5etGZ4rUZ1HtnEFMBSlhIi3nmCOx1GaBi4dwif665LLOGPWNTCVh+Mn5dZygvSK
 RrsxAUsoovhKs6viBDNr8Vm4sreIjjVUIGqTr6mYGVKpLz8JD252AN9AXAwXg0cEoONS
 q9Aw==
X-Gm-Message-State: AFuF++kfyW3HJ36Yzs64ftx/Y+mTpNQwIdjNv1vuLDHzjYtSnnq5mprQ
 RK+1fJQIpxQ9ff80fpP0DLS+rHCVWxoNIrFJ6OHpUiRcBnhem6lQ+/yI
X-Gm-Gg: AR+sD11xbfropPxBzx4nrOF2I85qZIwXdpJh60S0Ahvpgrv65DZJUp+FadFXCBpUywD
 kSpkmqt05xQk/R7OqLZsskfsokJNiYUPFHo1QaR7GkrrGeBhHlqk3D7EGQvBr0zx6bn8WAtOIm3
 xCFnDRa6w9v8Ic285aUtV8VfNL5jLY0+HN5xUhP6ljogr5btXbKYOMpVI9302xGOrTKzEF47pqr
 j9KBYaFTIMe15FYKcm1HobMlM6USCchTbI+ohoMUnWymLl+TNP0frBMRmiM6lxZ8fm5JE1d2cE/
 GM/N1Jop+8W3F3MyB8Bm/JnKSkQCWDcPk8U7RGBlIJXseocOg01yBUNh1p1Tnn9WLwdYtq4Dujz
 HHp6puFuzlIa2ZRqBh0He82legepRtnDW3xceYkSPat0ZrnWcF3OpNTgDdBKOG60dUIwIBUTde3
 OOA74HR3rZ902LR/AnolXWr6Oq5V+HNlR1Gmg9zgn3ZR/NttSAP1IlNYnNtXzmi1QN3AyxuhmI0
 bXwrYykeuu5xzDKciO+O/lQSuNb9wlPknJ7356qWmSGtVpJKcReDE4/flzIkvRZc0rds796GYN8
X-Received: by 2002:a05:6808:198f:b0:495:f79d:b08e with SMTP id
 5614622812f47-4b2ef584b2cmr27273199b6e.21.1787567913776; 
 Mon, 24 Aug 2026 03:38:33 -0700 (PDT)
Received: from
 runnervm76f27.floazsvxcilefmrd5phyrjbtph.ex.internal.cloudapp.net
 ([64.236.201.35]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4638352cba7sm4587383fac.13.2026.08.24.03.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2026 03:38:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Avinesh Kumar <avinesh.kumar@suse.com>
Date: Mon, 24 Aug 2026 10:38:32 +0000
Message-ID: <20260824103832.4058-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260824101525.176017-1-avinesh.kumar@suse.com>
References: <20260824101525.176017-1-avinesh.kumar@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] landlock04: Fix false TFAIL in _test_truncate() deny path
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

Hi Avinesh,

On Mon, Aug 24, 2026, Avinesh Kumar wrote:
> landlock04: Fix false TFAIL in _test_truncate() deny path

> +	fd = exp_err ? open(FILE_TRUNCATE, O_WRONLY, PERM_MODE)
> +		     : SAFE_OPEN(FILE_TRUNCATE, O_WRONLY, PERM_MODE);
>  	if (fd != -1) {

Could the deny branch report open() errors other than EACCES? EACCES is an
expected reason to skip ftruncate() when write access is denied, but open(2)
can also fail with EMFILE, ENFILE, or ENOMEM. Those failures currently take
the same fd == -1 path, silently skip the ftruncate() assertion, and let the
variant pass without testing it.

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
