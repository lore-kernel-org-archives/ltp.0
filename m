Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41DDC4452B
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 11:15:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ECECA3E559F
	for <ltp@archiver.kernel.org>; Thu, 23 Jul 2026 13:15:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2B1F3E2E48
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 13:15:36 +0200 (CEST)
Received: from mail-pj2-x02.google.com (mail-pj2-x02.google.com
 [IPv6:2607:f8b0:4864:39::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 32C471A011D6
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 13:15:36 +0200 (CEST)
Received: by mail-pj2-x02.google.com with SMTP id
 98e67ed59e1d1-3896ccc93b5so170711a91.1
 for <ltp@lists.linux.it>; Thu, 23 Jul 2026 04:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784805334; x=1785410134; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=U7xPQGMMBaSOHabPLywnQNAdVAxxlqSn5uZ/7tnNcLA=;
 b=ktCxaekLP9AWaTSo3GBsI6ybVDgMkBs5Zjuvmyz/mPkBjcgcFPQL224i14yZjBMkKF
 lHD+UmAF9ZqtgYZJBdg2+O8oNj89JZyC5U53M20JGjMIn+6oBmSnMIVYr7oPWV3koK5C
 /3Nc5C0hlzg7FbUo+g49/QAZsdZIv93WkebuWaTSw+a9ulBNJvxvx5qMd4PdHY6IBgHx
 6Gvl07H/EJa9u6W6WcqvDxxGZ0TcqcT5XkESOZ85dTD9Fo8p8odSeifiiEL/rsjmFm2T
 RIwpKjPqCEf5J8MD7EDRHgvZHThNhklIQX3xxkuPrzihAaGSc8X8Cokp2HgSTv1iDw/X
 lReQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784805334; x=1785410134;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=U7xPQGMMBaSOHabPLywnQNAdVAxxlqSn5uZ/7tnNcLA=;
 b=jhM0S8zuWyBbF3vrWjaBewyI0MqPhj+njol/awRaXw+N0SXspdyWw7gz/H2WZPyby3
 SuiIlo6ZRu7+CaQQUVeBMUwaFwChh6aWrtsoV3o1P0hHPAkKqaTreQGXNpsHNYtrgcLu
 Ank74BNYQtjxVuVVU9WoeMyDXR2te6xmc6eQQ+++uH6OWzstshWsvfJMGHnrbco9Lbc1
 M2Q1Li79D4nVrCPbc7Ee8z1Bu+GcGGxsKDKdXJxuT7OT4EK57nebuk5+daK7h7em0ji8
 HT75XO92gzNucNndJo/18Bs8JDkohkeVP3FgownAfMnf7AwrqZQoako9aiHR+D40ldx2
 lmIQ==
X-Gm-Message-State: AOJu0YxvN2CGpA44aHf4aXS4n/V65aW3Z8tlJqtpKPNY86M4kj+Mwga4
 PRZZ0ZrwhhoXW+vAonaIpwlX/p3Cn8F9+9Vus7D2tBQR6ksaOtAlX6rHrl0nCzBy43E=
X-Gm-Gg: AR+sD11WlNHtTm7RsDb2qY0gZSSDHPEkNlqcqb/QYc0PgQ3oGuMg3Qjy5S9lQ62LycR
 9fKE6eOYb06o+AuO3vBRxXVKBR7xBrPriPzr/zvJkmLWPakHScDkBeE/9QR9KQZxGjdHNjiHiCy
 oJCymScmRm9wqGX/3LtUe1+a+nZlvDKsQsT91DBSVVwLvA3cQ32XH8O1MGnC34RNAGJgWZEH3MH
 iU5vZZpR1INR5d56VKMUUft52E3m/V65BaUs6giGL3qVDJqJlUXB+Hm2gCSOo2otwuDFNZXPY8J
 0m6YINfJO2B+R8gukw9+ElvNRqrqsIEVeTkA8hgmjFoB/k+RlL5cM7H2OOfW72d/cl6cNN5XFNp
 Y63tro+w6267RwEZHaFMMsqSfrvDewIotZHZAjwfd6PGRfLY2z/ui7vLtOyCf6gxcvDJHP/Jxhn
 mEw/t6AsYUsFbWvIlD4GlB2ZTrma3so1sYQMsADUvgUXcSHNqyDVcsqmKW0ydIBatKBWIvT7hB2
 1bmm8RkAfh/1akIci8=
X-Received: by 2002:a05:6a20:1eaf:b0:3c3:b57b:645e with SMTP id
 adf61e73a8af0-3c44afcd360mr2701860637.5.1784805334279; 
 Thu, 23 Jul 2026 04:15:34 -0700 (PDT)
Received: from
 runnervm3jd5f.f5ckgwuhno0ebkjf23bdyvgvpg.phxx.internal.cloudapp.net
 ([20.169.74.48]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1c9289sm19380395eec.29.2026.07.23.04.15.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 04:15:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Thu, 23 Jul 2026 11:15:32 +0000
Message-ID: <20260723111532.8924-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723104458.1287008-1-andrea.cervesato@suse.de>
References: <20260723104458.1287008-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] inode: convert to new API and merge into a single test
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

On Thu, 23 Jul 2026, Andrea Cervesato wrote:
> inode: convert to new API and merge into a single test

> +	for (i = 0; i < tc->repetitions; i++) {
> +		SAFE_READ(1, fd, buf, len);

The literal 1 is used for the len_strict argument here instead of the
symbolic SAFE_READ_ALL. A few lines below, SAFE_READ_ANY and
SAFE_WRITE_ALL are used as named constants elsewhere in the same file,
so this reads as a minor inconsistency rather than a magic number
choice.

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
