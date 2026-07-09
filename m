Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB0AC43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 13:54:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39F9C3E5C6D
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 15:54:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 735783CD4AD
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:54:01 +0200 (CEST)
Received: from mail-pj2-x00.google.com (mail-pj2-x00.google.com
 [IPv6:2607:f8b0:4864:39::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1784260045F
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 15:54:01 +0200 (CEST)
Received: by mail-pj2-x00.google.com with SMTP id
 d9443c01a7336-2cc7a345f51so15894765ad.0
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 06:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783605239; x=1784210039; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bsjY36phOHQ1qvqU+a45+Fm53y4bP9nN1lj4CRwTfEw=;
 b=cVa6E6QvXbtt/bU+amrVgqA59iC/pzDa+KzJuXVygpFICxsfAUN56KcCm+ZltiEj+L
 30fVfjOXrUYtqwNT0IJncAjWTxIt+S/ABqq39QLlHcurgn12LQoXQGySsgtsbUMnVzkB
 yPPAcNsAQQB21xJ0rXOzbZz9IPjoM8RsVDykJcFqtZlOgXE82tuxsAAYlMNzaTzmaPgk
 SFo6BmxvHSYWVuqqhukxAOUssjDHrnAyGE6PHlsgYNnwC9iJKF6Bg/zHsJbPqK0MI3Pp
 r2wpTc1/8hn/IgGamR/YEjB0SAkHjBsCtMUiE3cDnGw2RzEmEwuOPQ9iYxetn1QamzA4
 KyHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783605239; x=1784210039;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bsjY36phOHQ1qvqU+a45+Fm53y4bP9nN1lj4CRwTfEw=;
 b=P/9CinJZunzbYNF8n7KYsP2doAO4TiMsCTngutZnPA4b7rtaTeSxLPhppkF+fnJ7bm
 XFmcFD3qbTK4GS6+8NMpGsGkXqTgDHlx4wALX2YOEtm5v6PcQEQF8q6YaeKeI42HBSGW
 NKcaVp1elEoQcM8LYiGfQeosq2dFMN/F1rLdsuJdSKz2TcKpZ7qWJwpLeqg9wVNH9KKf
 8skBJpqgEFSngPCv4enhlhzmFChTqYcwavNHxT7+j13plv0fjOO9TYbWnhoApJh2W/Ky
 yj9YTdbTx8eoEgbKW2y8Ry3b/maeUFdzetcVJpU2/1HDfr0FKx8VQUsTUDyS0ZQefxV1
 O3Cw==
X-Gm-Message-State: AOJu0YwWd478EwtP2tfRJFONaOdOBoTPk+8EitZXKtUd25g0FQ5dqNpu
 2BV7Dht8pj8jpmQ0tvKams9eamx6ie2hBYhC88sqNDDUorFcx7pAKeZ+
X-Gm-Gg: AfdE7cndnN7CxrkzB3q7MlP5GKAhFLKf3zO7xISWRCzbVdXV+vpXd57JRHc/3D2mbzP
 ma68rAT5G8zhG/kvq1xdxIlEouCW5Wo0GS/GUnH/1S89SQ/wbwzJkUY3sVDSyVJp1sG1Em5L74R
 X76I6e9t4URV+qrWqx1R7shSTJz3/0imTMu4L4d44BBQwfH0CH86vUZqiJRtY4K11GrOtG6iu7Q
 HysoLD5Lzb0xyJVWiEAS4ItG5yXVlZAV8K1AX/CW4O1P06lYBmOFths0NWDuqSQaSwzS81j1m58
 2+fxQtSZeMXKCtFIYcdomMiupFQbEnB90fQvLpIgHbsrh+RhvWYFCs21i9LOrYxA+nH5/vLYu4p
 1OximvZd2Suhh2srQheD0JbjxQryqDvQ+UggnlXlQy0pGPt7rmFbZHUjvsE7CgkeCmKngKkExLg
 YgpZCABoUdWUSWolVqUzT2a4GdNl9kuAbQjyxGYwbyPzazHSGmcSGtlX43nz+5F8dq3P6R58bXw
 91/qDCaWxeTqfiOaB5fAD7r2qneLyA=
X-Received: by 2002:a05:6a20:430b:b0:3bf:ae43:4d26 with SMTP id
 adf61e73a8af0-3c0bcf49cacmr8791473637.5.1783605239361; 
 Thu, 09 Jul 2026 06:53:59 -0700 (PDT)
Received: from
 runnervmkkn4f.3eoktrvvyoyuvprzmixvrumbeg.yx.internal.cloudapp.net
 ([172.215.216.204]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3118ee6091dsm26380660eec.14.2026.07.09.06.53.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 06:53:59 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Petr Vorel <pvorel@suse.cz>
Date: Thu,  9 Jul 2026 13:53:57 +0000
Message-ID: <20260709135357.4124-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709130135.927868-2-pvorel@suse.cz>
References: <20260709130135.927868-2-pvorel@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] build.sh: Add support for test-metadata
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

On Thu, Jul 09, 2026 at 15:01:33 +0200, Petr Vorel wrote:
> build.sh: Add support for test-metadata

--- [PATCH 1/3] ---

The commit body is empty. Is there anything worth saying about why
test-metadata deserves its own run-type, or why it is being added now?
Even one sentence would help readers understand the motivation without
having to read the whole series.

--- [PATCH 3/3] ---

>  	printf "* $i "

$i is expanded directly into printf's format string. If a .c file
is ever added whose name contains a percent sign, printf will interpret
it as a format specifier and produce garbled output.

The portable form is:

    printf '* %s ' "$i"

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
