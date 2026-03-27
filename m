Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51F0F10ED655
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 10:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774607993; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=g8eycSJWorLUDyLLDGufM7PejjQ1LVO+tIbek3X8+Yo=;
 b=fzj87kaKNKJNKIo6h2sL76ptWBEvYDdJAc22qH22XBX2N28gQrliPu32lGMJVGVmH91Hg
 kRHRNT69DCTYg1hlODh5JDqKaZ2KgUJVxojVztDwdaJ+waPEV3ma9a9AjGqX4LDem0E232g
 72twbtL6FN88tW8cWqIXgo3wzlawRsY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A7CEE3CC6A9
	for <ltp@archiver.kernel.org>; Fri, 27 Mar 2026 11:39:53 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DF653C2756
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 11:39:31 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A8F0C140162B
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 11:39:30 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-486fba7ce4cso20134525e9.3
 for <ltp@lists.linux.it>; Fri, 27 Mar 2026 03:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774607970; x=1775212770; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=5fbRKBeMbgDdBIy8OYRSkbQxLbTqE4YS2EUfTDiHAO8=;
 b=eRAGzzyeGNC3zltCkcuB+8Q5IifLBdC6zArMhku3pfqlRfwuiYfOh5ZKwIOX0Q3qpQ
 Bnp6rJelaXc1GzYKpGEkqxqpClz89ZJIzllvsg9cCadBLoVr7HwEtqBzaUv2w9cQSTM9
 UXR0zkqHy18OdNbjz/JJdENHb0HUNjsI5VsGd1IMxMeXRrlQj/UCk0guXA5n9m5cL77C
 MXetT5EDP8fwEmPud2ZhoRGk/d1+F4UjY/bsXtuEXl4+Euz2F8zs5SMNUhUjEwiFZRGW
 tT4Qu5WAYabYKVECNS1uio+vm0p/HV4eh9kMmFY3DxTa5GBjw/lFk41CHm/xDH2XP6Lk
 gHIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774607970; x=1775212770;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5fbRKBeMbgDdBIy8OYRSkbQxLbTqE4YS2EUfTDiHAO8=;
 b=W0aVewq6FxIyhEVhDF5hJ8psTyHbiRWqHVsSTpYX+YGfLaqfa4Miq3iIwR0vrdhZDo
 pBQI+hGxs/v/UwjdK96pw/FK2/nA6lX6ezGucIQnj35ERPTerZM/KRPw3fJi44UTQB7i
 GiqCdVmpdi3MZTNzZEJdJZRsRme/7uY6FJspiYU84xbAxWvP6X32wtGQbMvKnQ+sjXAG
 0+vvCXIUuZIXNgFtjKdMXtUxqFvTGxQD3z7Sg+by//TTrJ4D00hJMh66bDVKp5syaBr0
 r2xobXyjs5OiIEaCYyPh4mhamE7MnUu4NN8ynmLoHdULIxMwW/7oCAiUfBozFvmEPzq/
 lyPA==
X-Gm-Message-State: AOJu0YyegXA4TNvhT7ky0UPNsX52gwjFZh5Gco4bFFdDXmiO9NBxa+NP
 VVjChdJtO0H9apqa1hxK+Tz4jcywlP5Keex2Q8qrxIYq6XB60PwZD1kAFQUlQ0zn59k=
X-Gm-Gg: ATEYQzyKwN0UZR000DEG9yAYjLNtjmfZhcu5imj7vyoxH6fMLm0n6mAQO/DtSP+jbsL
 +5JMgtgf5JkGwrY7e1Ypqe6tNT8Awg1HzDvnMolWCfGlD3lHKucvLMICfS+WbArVbxN5B4ALzDJ
 d1iYUeW8wozgpliYQCqXduQNn+zCB+o8uHtDF/a0CaRCjMCkYlsyemBKHYS/13DTR77waTseKLj
 f1Ch4qgFoSovsJEeIzZzuRl3iBG7MkEDx94y2eZ64B9D2q27ir2/A7k2GD5Z64AZYsoPSJp+NZG
 FA3dqnVVC4bGjBrCDTabAIwjxBADqDRtQtqiT0vkPS/1X7vuwoWfyOCgMulFbEuSMmmlIsX7g8J
 eSARR3lvN9dvtvHg02mmmTez3yjRubPQ9Xwsj0cIYcUKTY5FuMaDm1Gy7VFyZGwEDWN2H1+fj0V
 VJHw3r6xsZMvVXzMxyr2bNJomQzNvTR1Dp5KRFhjVWO4gt2MkFAo77cVWEg2ppLPH9f3OC1ip+4
 Nngh/8D1HB9px9+r4T4d/Qw71eMb9f8TMwY0h1DHhoI6ZTdTNQlaLmPvy5pfrggYkaNWRVyWq76
 bF20LRqm44pA
X-Received: by 2002:a05:600c:3b24:b0:483:6a8d:b2f9 with SMTP id
 5b1f17b1804b1-48727d5a329mr34519885e9.5.1774607969893; 
 Fri, 27 Mar 2026 03:39:29 -0700 (PDT)
Received: from p200300ef2f4fc90094f4c5ce75c4603f.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48725fd18b7sm14855265e9.13.2026.03.27.03.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 03:39:27 -0700 (PDT)
Message-ID: <69c65e5f.050a0220.19109e.1a43@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260326170435.22566-1-pvorel@suse.cz>
Date: Fri, 27 Mar 2026 10:39:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/3] lib: LTP_DEBUG cleanup
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

Patches 1/3 and 2/3 look good. Patch 3/3 has a regression
and a couple of nits.

> [PATCH 3/3]
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> +	{"D::", "-D[1,2]  Prints debug information (can be overwriten by LTP_DEBUG"},

Typo: "overwriten" -> "overwritten". Also missing closing ')'.

[...]

> 	case 'D':
> +		if (!getenv("LTP_DEBUG")) {

This undoes the empty-string fix from patch 1/3. When
LTP_DEBUG="" is set, getenv() returns "" (non-NULL), so -D is
skipped here. But in do_setup() the tdebug_env[0] != '\0'
check also skips it. Net result: LTP_DEBUG= ./test -D2
silently produces no debug output.

Should be something like:

	char *env = getenv("LTP_DEBUG");
	if (!env || !env[0]) {

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
