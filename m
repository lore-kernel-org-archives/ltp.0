Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C233CCD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 11:57:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 523833CC6A7
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 13:57:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA4A43CC6A7
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:57:35 +0200 (CEST)
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com
 [IPv6:2607:f8b0:4864:20::f44])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id DC2501000521
 for <ltp@lists.linux.it>; Thu,  7 May 2026 13:57:34 +0200 (CEST)
Received: by mail-qv1-xf44.google.com with SMTP id
 6a1803df08f44-8b4298d271fso10380026d6.3
 for <ltp@lists.linux.it>; Thu, 07 May 2026 04:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778155054; x=1778759854; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TI8v0U+zjQaWKE37ISSgxeRyL27CCJ7yO/YBYFImK8A=;
 b=ppH69GvBp+JTsdb1jQZn09aJxczzdq/TLIyjCyVWFHx66oSsMkqGUYvr9M8pZYUuA4
 8V8ZDKYtFAGvbzw03feNZnc9CRYyThAwL++T2uUcxD2dacTSzGaPtsDDqn0ZmUjhfYmf
 IcdK4keMgDK23h/Og68dWcAOBFjBYPQBykGuilFo5Kj+lTZuyHAo2K/JviwXljxeslkN
 ce4a7vBZZmMOcMhAa7aY5GfpanpAurI4QDVvGCT2LDbHfmFVL9eqfRUYeKqhYkNZzCf2
 k9/y15WlnnsahPq01NfT/espp5Lgays1NNSw+jL/6c5h/70A7Q1WtD0BDyDGf02e1rPN
 TUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778155054; x=1778759854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TI8v0U+zjQaWKE37ISSgxeRyL27CCJ7yO/YBYFImK8A=;
 b=bKzETgxenTRQy6fgOoJDglpk5G1y8bq4xf5k5t09JuZrLSPoFMBG2TQN/LYtPq6Mwf
 Ch5ObX1TsemS+lSCIEtR9ud6ruVrpaajndU8PnGCh2jJvkTqusWayMY9644/ANeA5nq3
 UUPHniuTki8MlJ5Hnq/PoW05F6/Q4q6jDFKjkDpVTTWZXM8MncRAk9iAdFC50CZWYWqe
 iB68u7u8pzGoAj40qAtILCsAFRz3J3cdR150oexPZNIOCQh2nBpuaaCsZ0wlKGixYEOf
 cy6YyC5GBSDSabODAI+yP/GyRyooyu9UuMUlidWmJkuw9f5ZrLbapAC3Bm/GqbtNHrh8
 oeZw==
X-Gm-Message-State: AOJu0YzG+BFpCFidO0LBzt/cXzYwDgMAQYKUOBzscKJ/HUFeQIvCCdDD
 qy1cXCxLst0Zklq4j5O6XeXptGHwlx29Xtg5TpN6nICLwc+3JJNBkg0c
X-Gm-Gg: AeBDievFHZiNBSL1NP0JRC5MBv5G1wB4HcONOgwIpZ5MIgmao6x15W8UWsOixHmyRgm
 jmwXe8sDZELoW6RqKfBNnlJtneZbm5nBbRiyBWwqEIC/Jqpbh5ERzripzpv7DYRwGR+UHWW/WUl
 Jep3IJcvyhjm29Qiyk00rDsDaDtpx7tAeDi+BOTPnugCX5MzY16/qtK3sQdMSntBJs14Btr2Nnr
 IB3u6vA44sXBIIk3sJZauNKpJUm5ZlbHG8GW8K4qs+wx6kIV7nmLwXd8Xtbm+VNcnOmbyqztBPY
 Re0ROQbqE76D/12U5YFosKd3jlJaLYUcz9AkjAzrmdcAYGyPfAUK9wJJzeP2JioTegPVFEuUSKk
 x06IFv3n6g5arcqTYowEmqmMrsYwuscORntoaY7DZNpVp+xDlUmQ/Xxj8esZDpZchL+nXKaBPpf
 uWDdpX2eyKh9TBxGSECC7pQMdgEwM3bSyY1zcQ2EsCzhECP5UbrNknZhiFBnZjZ858DSWzukBbY
 TjWxJiawBfek1GyDeqjApAdzslQK/q8bym7+BCf5SrQ5RKFLSqUpn47irI=
X-Received: by 2002:a05:6214:5544:b0:8b0:2017:958e with SMTP id
 6a1803df08f44-8bc42a704b5mr111950726d6.13.1778155053590; 
 Thu, 07 May 2026 04:57:33 -0700 (PDT)
Received: from
 runnervmeorf1.l03qozouujiejn2dhmjp1n313d.cx.internal.cloudapp.net
 ([20.57.47.228]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b538b1d953sm231904476d6.3.2026.05.07.04.57.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 04:57:33 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Piotr Kubaj <piotr.kubaj@intel.com>
Date: Thu,  7 May 2026 11:57:32 +0000
Message-ID: <20260507115732.4031-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507111145.112276-2-piotr.kubaj@intel.com>
References: <20260507111145.112276-2-piotr.kubaj@intel.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cpufreq.c: add new test for cpufreq sysfs interface
 validation
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

Hi Piotr,

On Thu, 7 May 2026, Piotr Kubaj wrote:
> cpufreq.c: add new test for cpufreq sysfs interface validation

Reviewed-by: LTP AI Reviewer <ltp-ai@noreply.github.com>

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://patchwork.ozlabs.org/project/ltp/list/?series=503158

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
