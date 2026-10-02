Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E424CA5FDD
	for <ltp@archiver.kernel.org>; Fri,  2 Oct 2026 13:44:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D2673E6B32
	for <ltp@archiver.kernel.org>; Fri,  2 Oct 2026 15:44:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 98BE33E11F4
 for <ltp@lists.linux.it>; Fri,  2 Oct 2026 15:44:16 +0200 (CEST)
Received: from mail-qk2-x0a.google.com (mail-qk2-x0a.google.com
 [IPv6:2607:f8b0:4864:34::a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 43ABD600698
 for <ltp@lists.linux.it>; Fri,  2 Oct 2026 15:44:16 +0200 (CEST)
Received: by mail-qk2-x0a.google.com with SMTP id
 d75a77b69052e-53332906208so40520801cf.1
 for <ltp@lists.linux.it>; Fri, 02 Oct 2026 06:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790948655; x=1791553455; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wF8vf/BdoCNvNNHezHfCBI9n3BNwaoJFxQ2AhXRFxr0=;
 b=YF3XJQRycIv5T8j7MQv91ZhSbRVBciM1KvfW3BHQ27ee7Vqcn7R9b9HC4wdc9sPfET
 lTMqV/ASyif/w8pLPp6rTtv7ds/InYwrfyGf2hj/1i5jgkp9e4dTFtN6iGDUzwrLX3KE
 OXf8KdG3rSUzNjgado02YKKdsmQ6gNJtgIkJFbwDD6r3S8OZNFiF4ePhyUgfRrEwBgEh
 2Zrn3ILSV8Wh9bfT7XZ91gTBVpPKFHfGDm2pKSBE6/n1T1BFJDWEQ8azHdzlbkSJuR8J
 0PzLtrepOyhn1bqhBRZ3In8+5oOeLxjJ8pp02i5I80gx7GnTZCsloMpA4Xpm1SpoYjIp
 XyYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790948655; x=1791553455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=wF8vf/BdoCNvNNHezHfCBI9n3BNwaoJFxQ2AhXRFxr0=;
 b=1qFB994EnaiFOO6BE2EPXolEWGqy593OGZoiuKvvgE/48sGe3ijxNvIZpQBk/vfrHy
 uekUqUlxhlom6edYznzUveTETR5lMzRYE4ULTr5NYcjtCo0A5sSC7197LTfl301k21vA
 Pa9Ixc/1/p3MWsAJBoEXVJu+XgR2OROZTmXkKya6/piyvpW21AUEbsCCH5E0Yf84bmMh
 u6m2iLLzDaG7uaWN/elKKaPGjnVprrYntpp2a0JIJuCiIjAaW/eqpj0tSF5/4N4qRrq1
 JwOwtbMmXlY1GssVKBNQN/9rLikM48w8thDiADTuq20h6w0FH043ItpO24LBDfZhZ1/Y
 sBZw==
X-Gm-Message-State: AFuF++lunzOMrJlg8a990xzJqDwrMxENhyO9JAnRRRtmd91n7cvPSk5A
 9NXz3EAYb+Lip+JCaPONCFmL0xR3f048b4WMFkKWgxAZFQxCac6xj3H7
X-Gm-Gg: AYBFou1yRBRShyrKe9Es8x7nfodF+/rSgO0W/NoS/XmekbFncHKQKOAP+jVYzShoWQM
 ppOWXknFXABcVF+HqQHmNGIp/a23OW92DxHQPXPMUQgYXCGrIxTxsD5lS9AACJlNkt4ikm5uJn0
 +L/i7D/pcQnAHT4Av5yR42YhXrqWHaN7PJHjICqu/5b6IlLhFnkvWMc8+h128GDIJrJwjQvLf2I
 afPlz1YsyAH8sfW49nujD7oAdDHdJ9PRV5PCToQBuO/UQ2LCO0nc5x7S4CvIBY9zf9VQTkHthiM
 cifzM3i0wcaNnEIuxvfQpuXo0W9IEhFZsT2a2JOAPkFt2HB5/qP0A9XLQMbR0RUms4sUkPVK7iN
 169HIDH/6BbVjVhTTx/E28qK3FtOoitZlsrl82SHy1vRiWJ9hE3B3WnA6STQuDedwWmU3R9eey/
 JRq/DRqrhgGCSx58Wa7L9HjiKILWXWpFjDFShMtB7AvNmjlTXvXhZDsggZnuT9QcE9BzSUafeBt
 plbXbPkLb5QbDwjE6xUBakgdZT/yxREB5dPFQavl6EyOA+WcCy6PjCUCwzHuyc4wwNyN3WPB9cY
 XlLEnqzK/Efa
X-Received: by 2002:ac8:7f8c:0:b0:533:3f17:cfae with SMTP id
 d75a77b69052e-533bd17ee64mr47514501cf.6.1790948655107; 
 Fri, 02 Oct 2026 06:44:15 -0700 (PDT)
Received: from
 runnervm8df0l.sdkwdzzwaqsu1mar1bzdugii3h.cx.internal.cloudapp.net
 ([135.119.236.51]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-53398bd97e2sm26094341cf.18.2026.10.02.06.44.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 06:44:14 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wake Liu <wakel@google.com>
Date: Fri,  2 Oct 2026 13:44:13 +0000
Message-ID: <20261002134413.11862-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002130546.1236713-1-wakel@google.com>
References: <20261002130546.1236713-1-wakel@google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] keyctl: Fix struct keyctl_dh_params build on Bionic
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

Hi Wake,

On Fri, 2 Oct 2026, Wake Liu wrote:
> keyctl: Fix struct keyctl_dh_params build on Bionic

Verdict - Reviewed

Pre-existing issue (low severity, not introduced by this patch):

In include/lapi/keyctl.h:55-56, keyctl_join_session_keyring() uses
KEYCTL_JOIN_SESSION_KEYRING before its fallback definition. When
HAVE_LINUX_KEYCTL_H is unset, including this header fails to compile;
the same failure occurs with the parent commit. Move the fallback
definition before the helper in a separate change.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
