Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4C0CD5BAB
	for <ltp@archiver.kernel.org>; Sun, 24 May 2026 17:06:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C49453E9E52
	for <ltp@archiver.kernel.org>; Sun, 24 May 2026 19:06:23 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4FDC3C58CC
 for <ltp@lists.linux.it>; Sun, 24 May 2026 19:06:02 +0200 (CEST)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 980926002C8
 for <ltp@lists.linux.it>; Sun, 24 May 2026 19:06:01 +0200 (CEST)
Received: by mail-qv1-xf41.google.com with SMTP id
 6a1803df08f44-8c921396e37so92075816d6.2
 for <ltp@lists.linux.it>; Sun, 24 May 2026 10:06:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779642360; x=1780247160; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qi9FcCKKpf+E+v8wvSQt5qCvfZ975hdNdrMilEznPso=;
 b=bjsnCzWjR/Az00KfhXVcE/XocAuuQ8asrxHVs9Pzwt5KFQYLPr1fOwIsrAu6ZzwdV5
 9DhbpcIxmkJq3EfHnAerYJeBDBivlq/xP8x0bZcxu3vSyU6ZeHkENiZuCKml3JBvM9Ao
 /akXEChPwFuEAVcKZxSLEUOANiT9jnnN71jHnMgh8TkTS8+xVhHaN6SsoIFqlJ4T/rcK
 bRjlgYCM94sAXnKmba6UQB6rGgCHsLLeTFL/Li1w1Qgp1Htq5D1By7XB4LQOcOQOpYwZ
 QlWMfjNxXYBLWR1iXFxInPq7jGY2VhxG3UsaDF91yYkp/IBV8BdulwPgxk86CHwFF9WW
 pWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779642360; x=1780247160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qi9FcCKKpf+E+v8wvSQt5qCvfZ975hdNdrMilEznPso=;
 b=DtsQrI7Et/7Dg4Hn2v1Zt5vLAB7mt8xgG9MNS0MEJo2pAR3uQ+j2SZv6Ik+Oh/g6OW
 L1ZBJ6c2OedJTtWpDJ2Yc/KPj9EdzbqwCkbaogztlZCw2vaur/ccv6Z+GtMB0uLo3jEW
 +kO0UYVuMDiTa2vpZcxFCzie6RhHNW7yqAQhqNUc0oRCQpT5kx7By/7JATBLXuAtp5CN
 J49cYBlnOVNnhyV4HKaWj+EExlJvn6iL0PRJ94fnQQlijBLUWY+bCZB/gBSLyfbacdbx
 GkO7Npj+3MjkbBs0Cy2jbtebj2VE80awKpjapDfyJeZ505pmMGxGB4nPCmAA7xEqmDhQ
 ryRg==
X-Gm-Message-State: AOJu0YwIdAER8CR2prQnvgtsKhmSn1EbMea+apot/hTlCke37IR39+dd
 JXlBy534UKlKdMCdBMskgxjvljoB/5JRNl7XSfK8FHUsAnswGSpY72/Z
X-Gm-Gg: Acq92OH17kubVruD9Yjc7hxhcvuKyO6sl6QMs/vFbTrDulSInXR8Z1UpsC0u5Q0EtAW
 MMBUgk15owl/WNvx9+WVEPY5XhMYmLD6JCseQdKXpd0bDMumRdrnTxYarzS/aSKakAZlOFW05ST
 3UX2ynAbebtw59X/P/GmGLrrcIpIHScPTwVwxcEgB3uM+LsJ1PE46Ei1HXA4M5pVFBYgqTaKO4i
 dswJfSpGgFtpX4stM5IBVClCeiT5fUfZoNvknGP0KHy4hV+PVePKxIk2nfQcgRhjtZPqdc3s9J+
 UdhBjs4gWnDrjIXQ08sQP6ueKuXGNQ8cL1zWhBYUPi9FTBs9GT5oP+YvXuGndlxjk8R5mbAA6YF
 7Q5DCQEkRnY7vB/40r0GFveenAjQ3prbKUcdnk66M4YQFv8BEK6kDCXeZTzYyR+wt0nw66ORZvH
 X+saNm/cUkTdzX2OJt1OPnME6E+oyfc4yGOQeGkWyvVM2W2pnXN6LYmvTjPfGGBPly01U48S8WI
 lhGLbAptXC8palze7KIAtW1+dIQWZ8uYV/G+Ouw
X-Received: by 2002:a05:6214:f0a:b0:8ac:7d7a:56fb with SMTP id
 6a1803df08f44-8cc7b53d578mr193189956d6.5.1779642360344; 
 Sun, 24 May 2026 10:06:00 -0700 (PDT)
Received: from
 runnervmg397c.zm1gstafu1aubcwruotojqkf4h.bx.internal.cloudapp.net
 ([74.235.134.165]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc8130a1a3sm86648046d6.37.2026.05.24.10.06.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 10:06:00 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Jinseok Kim <always.starving0@gmail.com>
Date: Sun, 24 May 2026 17:05:59 +0000
Message-ID: <20260524170559.3969-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260524154221.2064-1-always.starving0@gmail.com>
References: <20260524154221.2064-1-always.starving0@gmail.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] power_management: rewrite runpwtests04.sh in C
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

Hi Jinseok,

On Mon, 25 May 2026 00:42:20 +0900, Jinseok Kim wrote:
> power_management: rewrite runpwtests04.sh in C

[...]

> +static void verify_cpuidle(unsigned int i)
> +{
> +	int fd;
> +	char path[PATH_MAX];
> +	char buf[32];
> +
> +	snprintf(path, sizeof(path), "%s/%s", CPUIDLE_PATH, tcases[i].name);
> +
> +	fd = SAFE_OPEN(path, O_RDONLY);

SAFE_OPEN() on a non-existent file aborts the test with TBROK.  The
files `current_governor_ro` and `current_driver` may not exist on every
system that has a cpuidle directory (e.g. no cpuidle driver loaded, or
kernel lacks CONFIG_CPU_IDLE_GOV_*).  Use open() directly and convert
ENOENT to TCONF:

    fd = open(path, O_RDONLY);
    if (fd < 0) {
        if (errno == ENOENT)
            tst_res(TCONF, "%s not available", path);
        else
            tst_res(TFAIL | TERRNO, "open(%s) failed", path);
        return;
    }

> +static struct tcases {
> +	const char *name;
> +} tcases[] = {

Tag and variable share the same name.  LTP convention uses the singular
for the struct tag: `struct tcase { ... } tcases[] = {`.

[...]

The new test is named `pwtests01` while the shell test it replaces was
`runpwtests04`.  The commit message does not explain the rename.  If
`pwtests01` is intentional (e.g. start of a new naming series), please
document it briefly.

---
Note:

Our agent completed the review of the patch. The full review can be
found at: https://github.com/linux-test-project/ltp/actions

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
