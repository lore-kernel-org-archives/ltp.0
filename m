Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEAFCD6E4A
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 11:37:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBF293E60A8
	for <ltp@archiver.kernel.org>; Thu,  4 Jun 2026 13:37:30 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 873113C2CA3
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 13:37:14 +0200 (CEST)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0F9712002B8
 for <ltp@lists.linux.it>; Thu,  4 Jun 2026 13:37:14 +0200 (CEST)
Received: by mail-qt1-x841.google.com with SMTP id
 d75a77b69052e-5176fc0cc72so6887551cf.1
 for <ltp@lists.linux.it>; Thu, 04 Jun 2026 04:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780573033; x=1781177833; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V0opm3GlN0lXwFlqeBnjRpbak+Da5Ki7O0UksN8LG1Q=;
 b=YD5kRRv8O+O6rnTt6CVOdo34SAkoj1B7P5Hy/W48X8Qda6v/6A2eC9qgyulywS8d3N
 RErNnQrswJxCBxmmO4dK+JzWDZa23oYAtdxJO39D58kDTQ7oEMUr6yRfzxoi8mEDeJ58
 CP+s0GBO2vjZcY0U35a/eQ/W4VmD2jgjRukFQ8w5JkQSOkkL+UbDLUoBPhvh63slMBG/
 vB2VrAyGOuYfZ8klxebDdf2J3upkjKDCQOvMXA4NJyfGGqECJqaFJEupFLozGW+MQ3O9
 FmhK7+cwrJtIOtlj0R9ZaKwOHtU/2Q+kfFBbJIqatumQZvE1qPnoQK/GmGTBh9nqTB14
 3rLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780573033; x=1781177833;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=V0opm3GlN0lXwFlqeBnjRpbak+Da5Ki7O0UksN8LG1Q=;
 b=QwI7KQU/pQlsNPoHg7DclbTxedll4/A14wOZdZSMQwpKrR3CqEvHJP5n/OmZ3WasmG
 ALLwxZZATQCdBv4RdpzpHbmpA4r9Ix12pSEnaLY6lai9uhFGNFE7ezJlpp+PBSyoFLJq
 m49SBfBEMP3jEB3l2YcTlIYlu1TV4ggDhL3GjjnYeX92O929rJQZgX6cPc8enzw4Ad7F
 Wwj+ag3wbaiHTQ3VmWxWyzL+JCpNnU5D6pQXx2v6HZrQHNmDy1kJT3hOnvxVXhu0kcr7
 Sk1EScDYEbOKcesznQNNY51szORA0BhjqnA3cnviYkKlMlghKgS5zM6ZM/5aSAObwC8H
 KALg==
X-Gm-Message-State: AOJu0YwQcUof/t5YjfPLe4LsHyGh8dqba6amdGZU1BSObvL0cDS8MJdO
 nNaWKIMvhANEb727YDnqwL4i8P5XRhTPTwlkESDFwF2p3tFL3t/AvJjQrrAf544j
X-Gm-Gg: Acq92OHMgN39kja84OFlvEAu9QN1IMwH9VkbYekPdMTXIO7wxHUybqgR3sU9xQDxNS8
 PYaKkKcIprBVPgE6pn2Pr3KQeYBnRhDssADvEmunhou8/jmQ+sEKJD/dEorxxKJyfDwUEGSz6En
 BjXtfyvfhX7B+hEuLjskKoya7ZBDnT+NwgebKHbVThr9NxmsRqQNV/WW49bNJrG4OEGkm4ANMwj
 haFBqkmIcHv1QCwB1kPX5TbP1WA4cquZpGmMEfQf3RAHAKazlHEQd8cinCINcwdGx/pzPo/g+lB
 YIhKVdG9iR0uGIi+0D6d6/seGpvXYFUC3gxkdnm9EjIQL0/Am8fsu2dZ7c1m30vugG/OF3ob8J0
 EDsbZoNrAWdgzaOBH7fJuB1tx9r/iCKL99JhjLCxY6RWBdkcO4YWr4odwbY/hX1EAvP53n9bcFX
 s4JPbC0XDVR3mJfe5XYKPJvgL1ijkR9YaKKp1TMhkWnNnAgE3QF8kq3FUTAjasd9ZRRW0Lil8q8
 4fh2KmKcH+h7TUYY1rFCHFHPRngEFgi0oESerYZz56LNDcWBvc=
X-Received: by 2002:ac8:59c7:0:b0:517:8e65:68e2 with SMTP id
 d75a77b69052e-5178e656f8emr12543221cf.49.1780573032815; 
 Thu, 04 Jun 2026 04:37:12 -0700 (PDT)
Received: from
 runnervm3jyl0.fep4lis5yrsu3hkwtiiopce0wc.bx.internal.cloudapp.net
 ([172.190.93.133]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cecd2629cesm48428666d6.41.2026.06.04.04.37.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2026 04:37:12 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Li Wang <li.wang@linux.dev>
Date: Thu,  4 Jun 2026 11:37:11 +0000
Message-ID: <20260604113711.4258-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604094200.21643-1-li.wang@linux.dev>
References: <20260604094200.21643-1-li.wang@linux.dev>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lib: Introduce tst_path_defs.h to consolidate system paths
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

Hi Li,

On Thu Jun 4 17:41:59 2026 +0800, Li Wang wrote:
> lib: Introduce tst_path_defs.h to consolidate system paths

--- [PATCH 1/2] ---

> -		sprintf(g_hpage_path, "%s/%s/%s", PATH_HUGEPAGE,
> +		sprintf(g_hpage_path, "%s/%s/%s", PATH_MM_HUGEPAGES,
>  				ent->d_name, "nr_hugepages");

PATH_MM_HUGEPAGES is defined as "/sys/kernel/mm/hugepages/" (with a
trailing slash). The format string "%s/%s/%s" then adds another slash
between the first and second arguments, producing a path like:

  /sys/kernel/mm/hugepages//hugepages-2048kB/nr_hugepages

The old PATH_HUGEPAGE had no trailing slash, so this double slash is
a regression introduced by the patch.

Linux resolves double slashes transparently, so there is no runtime
failure, but the path is technically wrong. The fix is to drop the
extra slash from the format string:

  sprintf(g_hpage_path, "%s%s/%s", PATH_MM_HUGEPAGES,
                  ent->d_name, "nr_hugepages");

Verdict: Needs revision

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
