Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 746EFC55172
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 04:18:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEEE23E90DC
	for <ltp@archiver.kernel.org>; Tue,  4 Aug 2026 06:18:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42EE13E2AB5
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 06:17:55 +0200 (CEST)
Received: from mail-pj2-x07.google.com (mail-pj2-x07.google.com
 [IPv6:2607:f8b0:4864:39::7])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CB3B02009C4
 for <ltp@lists.linux.it>; Tue,  4 Aug 2026 06:17:54 +0200 (CEST)
Received: by mail-pj2-x07.google.com with SMTP id
 98e67ed59e1d1-38dcd98e5easo2127551a91.0
 for <ltp@lists.linux.it>; Mon, 03 Aug 2026 21:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785817073; x=1786421873; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d//DOGzI7YOQL/kVB9JAo8yv7V/FIdrS9WpQ9JETMmw=;
 b=PSet8VLRQYxMhd9BvO+JFxEFpCVutciDRaw3JX/yfrxFzqOt3owwTunmJxIDhTEnG8
 88Xna/Nu4XUiYQpVQb1J2jRfZyHROkMah2ozizMTGSpOhvn/eC5ulJbze/oq16rEdclZ
 jG5TT7pUCFR7Giz/WICZAlyvs8jiblBarCYRdEuIzOHKqpPbycjxuw0sNdMxsLSYathZ
 qO+3O4Wsn8/acxd4s8i91uKww8fuoSOHmF5dIatkAxbj5f0ETXrt5KX9z+2DT3IBwqUy
 +OSbTG3Cny7PYcdxmqh3PSZf1UtDoRgK4hYGaC9aqlsGykm79AdkSM3HgNhJ4/XVt/WJ
 fNfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785817073; x=1786421873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d//DOGzI7YOQL/kVB9JAo8yv7V/FIdrS9WpQ9JETMmw=;
 b=mdYn8OU6v9owi2cgBMpHhUZML5PpGG2wAe3X//Nd8wei0jFG4PLEBpRldny5uhIz6R
 CCKJewf/wxkQHKe3kEG1kAUPQGsdzPxoelXFPAtEKS5zKy6nN8PhnkhXXCYG0lmA5/tP
 uBdQbTcHTE9ZrY3JRzSVprGePC2oLuEcZ6z2lX85ciQ92uxsBZsdtwDwMcjPURZf8bKR
 lA9NvG56VGknFJxjzdpggUyYpaRO/px8D2TfVEWNCUs/m9s8jLz37mAG0By8oh27466m
 PphQYykaQgSYw39MSlQIDR64KV13VLmViYRGjrvmrjdcVSJwGFk/aDS/0gKG+1E7lyKm
 loBQ==
X-Gm-Message-State: AOJu0YzMJaw1Q8LZckvq79FwH22y4i9eTd0KSjaRu6WC/Z7ldE0Pgwi0
 w5inh389gbotpdrfwA5uUHbW0+D8WN1/9ftCmfBm0rUsECXUssTjCpUeKfuz20D+
X-Gm-Gg: AR+sD11/HFo2qAKuWLRko8ZzZdOQZoUJQfqySZozAfE7RYBsFUELCAFgCY9zGow2Ajx
 xYfjHl/h4ycqhUX5EZuqJnmRCtWb9fPSuFueEVnznqX3HVo4TF6HfxJLXVa+vPOizOudR7iq2d/
 c36XL+YJyZXkFnQtV2VN0/yfnTbQx9WAqGNPss6wx6D+/SZpMz5zaBlb9BBhojyOBVKaLAXEgji
 zR1+bnhYCC86VxSNPReAx+qWoJ8ym/UHwSeUDPCuTBLHdQd9cJxNiKLknhyozvm7DqyFtd72JLV
 XVjNfwMUUl9voI3A97jwDbbBGwk56HJ8wWoK80WZeBGpiJnQqk3gngQni/J3XNHVVa1HuKJ+uae
 TChSFmsNaB0JuiLWVBYYT5BZrIIwfROhZg0Se/8zfuXHk7th2c0mG3zmHKAye789DeFJVx0jrPV
 sLVc8dlKt0Ht+Uv3+lb/NTd6snF4TgRoLJOYtHf5sqnokuu8IQWJ30OQDyw5cuwqe5irUzJUNGO
 m95jItALjYdPXD1zRdh/7CP6gh6UPg/eoUSllbZ2A1g7JJSlQab4jG6WCL43DS+XVSErXylscWh
X-Received: by 2002:a05:6a20:734b:b0:3c0:9c19:65b1 with SMTP id
 adf61e73a8af0-3c92a90cfcemr12033717637.73.1785817073180; 
 Mon, 03 Aug 2026 21:17:53 -0700 (PDT)
Received: from
 runnervmvrwv9.f1xv1mncpbgudbupmhhtsgwzag.phxx.internal.cloudapp.net
 ([57.154.5.72]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e18e70esm72638348eec.29.2026.08.03.21.17.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 21:17:52 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Tue,  4 Aug 2026 04:17:51 +0000
Message-ID: <20260804041751.8871-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260804010439.15195-1-wegao@suse.com>
References: <20260804010439.15195-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fsconfig04: Check FSCONFIG_SET_PATH
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

Hi Wei,

On Aug 4, 2026, Wei Gao wrote:
> fsconfig04: Check FSCONFIG_SET_PATH

> +	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "journal_path", dev2, 0));
> +	if (TST_RET == -1) {
> +		if (TST_ERR == EOPNOTSUPP)
> +			tst_brk(TCONF, "fsconfig(FSCONFIG_SET_PATH) not supported");
> +		else
> +			tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_PATH) failed");
> +	}

Could this test be gated with .min_kver = "7.2"?

Before Linux 7.2, ext4 declared journal_path as a string parameter, so
FSCONFIG_SET_PATH is rejected with EINVAL rather than EOPNOTSUPP. Since
fsopen_supported_by_kernel() only gates fsopen at Linux 5.2, those kernels
reach the else branch and report TFAIL instead of TCONF.

> +	SAFE_SSCANF(dev2, "/dev/%s", loop_name);
> +
> +	snprintf(path, sizeof(path), "/sys/block/%s/dev", loop_name);
> +	SAFE_FILE_SCANF(path, "%u:%u", &major, &minor);

Could the device number be obtained from stat(dev2).st_rdev instead?

tst_find_free_loopdev() also supports /dev/loop/N and /dev/block/loopN.
Those paths produce loop/N or block/loopN here, causing the test to read a
nonexistent sysfs path and terminate with TBROK.

> +	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev1, NULL);
> +}
> +
> +static void run(void)
> +{
> +	...
> +	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "journal_path", dev2, 0));

Could each iteration reset dev0 to dev1 or alternate the source and target
journal devices?

The first iteration persists dev2 in dev0's superblock. Every subsequent
-i iteration requests dev2 again, so it no longer exercises a dynamic
journal-device change.

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
