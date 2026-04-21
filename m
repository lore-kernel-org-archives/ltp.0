Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534E4F8FA73
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 13:30:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BFF573E1292
	for <ltp@archiver.kernel.org>; Tue, 21 Apr 2026 15:30:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAA0E3C5376
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 15:29:55 +0200 (CEST)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6B7A660078C
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 15:29:55 +0200 (CEST)
Received: by mail-qk1-x741.google.com with SMTP id
 af79cd13be357-8cb5c9ba82bso716931185a.2
 for <ltp@lists.linux.it>; Tue, 21 Apr 2026 06:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776778194; x=1777382994; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EkPY3dRE7AOo0Bg2nN/eMNQRWld0HS9GOu/qR1JZRgQ=;
 b=mM3XYG+WL0XFXFRkr8vRyVHYmApZx2imd2khdawZWoPiRPiQenagZ9aQ/W4qSA3CMa
 oBv5p06EXtTvBMbeAbASu2xiVFaWWv/yGpMP3G3c+y3+HEkr+GS/Gz6a+NU+mSna0PHA
 6aa0yDGptQNgx+LuPKh8UifnRqZyjcqYqRpFP7rWqfEW4Ap813BlGhILNPkD8Pc7NM34
 EGEb58A8D2RfyBUKYoW1R604A7sbQL5TAztlSN2WnHkZaQ+syG1Ars1PzkU2WCu9Ixbu
 wqjNGcLXQSm6qbbLmbU1lJvqgj2ehMzF0taJp3RkLYoAzLrX6R4n1DxlJF1Aw6fUZVjY
 x4Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776778194; x=1777382994;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EkPY3dRE7AOo0Bg2nN/eMNQRWld0HS9GOu/qR1JZRgQ=;
 b=P6eq7If0dIQj6qCR3l8jgY+/Q+Z7v9DKWsRMWbPfJ3imQj3CqV06NwyeN0jgHtkNmN
 gMmwtCL/tp4d7FxGLb4B03Df2FzX5c6yYXumMAItjFlYZikv4SGG0fW4tqiSvOtE9mVc
 ghOTVReHsKlUVjc9lcwdD+NZ/BIRy+jVGP0k1gDhoHiwlpRkQlhobE10J7rJzw6sWSvc
 J2LmFwC41jcJoTxlUfAmsSkMp2r1MFkvGipx/AFxOsaq6mBphvfVDurJt+HnD8ZaZ7B/
 X2WwTrgWsbeyGmgu8ntSgsC/CC0BJM4z46/n11WViNAS+OcAjeWiDs6H1MQImjKqDJ0Q
 rCzA==
X-Gm-Message-State: AOJu0Yxsm+i0VuWwAKvMXE8CG1JD7vlEqLxkK7+A6MvUoXD8uHgPZ1zy
 ku42ktY+1/tNDqJgxfQvp6On7gR09EXShf0MPh6HSM1aPWkL2k0zf9Ih
X-Gm-Gg: AeBDiesHPlIDWL13eyj8hxGL2ZdQyNYQDQH0sIpR/IDpsHwOl0Ex+pI+z01Bqs3sbzb
 ygskEaWbngfej8m+1TWm2RfWk+MqXp8w7ZSMXaRATMm+Xp5xdPMNJzKmzyi14SjonroZtaeJZU6
 BYJ6RxOpjc0XX9O1G6pQOiqelRMwYubWrC+bq5PE1tgUkes8KdkijK0zpyuAsnIL9YFV8XnAUVb
 qxHu/zztRpaOByMof0YeooO510kPO4hVHvYpxHdJBAx71/a4X+w9XYxjIrYW7NhMo4LFDikkJmp
 Ttysiit7fjoUJL0tCr1grVvQx1Xxb/x0HZgPzVX+E+k0ooMYHSl+0nn9mRTKjbOEWW1jWz79K86
 edhuIrQj+dJpIBahOkJAw0Ht4aQBEQxl7/jE6fXpsm/ZCDYBVbsjqmCLK+5jEpl1+IDYTd/a384
 WrsWuZcfJIWJHMAZT4zZyvH4sosQQpS0VOFNZsmOepTb54mVCmqdKgxNkurJP2z+y5IlodTA7Jh
 wI7xaI6oXgipErp6PbSwBJoNZWVvwr92ypkj9qQLLNTxVR0BMGi
X-Received: by 2002:a05:620a:19a5:b0:8d3:b614:9450 with SMTP id
 af79cd13be357-8e79217dc4bmr2528041685a.47.1776778194133; 
 Tue, 21 Apr 2026 06:29:54 -0700 (PDT)
Received: from
 runnervmeorf1.c1owmm2apunufa0yanmraqiv1g.bx.internal.cloudapp.net
 ([172.203.253.162]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8e7d92ce037sm1033297585a.32.2026.04.21.06.29.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 06:29:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Li Wang <wangli.ahau@gmail.com>
Date: Tue, 21 Apr 2026 13:29:53 +0000
Message-ID: <20260421132953.3918-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421130706.14254-1-wangli.ahau@gmail.com>
References: <20260421130706.14254-1-wangli.ahau@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib/tst_kconfig: rename runtime_check to
 config_runtime_map
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
Cc: ltp@lists.linux.it, LTP AI Reviewer <ltp-ai@noreply.github.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Li,

On Tue, 21 Apr 2026, Li Wang wrote:
> lib/tst_kconfig: rename runtime_check to config_runtime_map

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp-agent/actions/runs/24724928089

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
