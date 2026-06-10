Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6734CD98C7
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 10:06:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C479E3E5E9A
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 12:06:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15A4E3C230D
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 12:06:13 +0200 (CEST)
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com
 [IPv6:2607:f8b0:4864:20::743])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5ECAB6010F5
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 12:06:13 +0200 (CEST)
Received: by mail-qk1-x743.google.com with SMTP id
 af79cd13be357-91591f19716so804821685a.3
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 03:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781085972; x=1781690772; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AgtQ6vsYmXZQz2hQh6+6gdiWcTnmelwmRV8qto/aoCI=;
 b=Jh324YqZeyWm2QupF+dFpsJyKCpWVR5BiuP7CG0XEVjhH416M7xwnUk5tumjjxUE29
 MmkGyxMVg8WosJ+m+hahgF6/oeNelXNkQNQ/zI9R8jnoVulIlLWMLwTp/kGsBCKudxqf
 nW1Chrb216k1/3qmmA5X6jhPezI6WWGBSMxlj0eZadaMCSdDwQB3/4k+TYH6IiS5oI9J
 abNQmoqnTZemfA6oTK4+vkq6XM5Tw76/FppDjYguT5zyNdlDqaTUp0dxacbzuocuido8
 02iDGlLRHiyRM89SRtvnjvmXR/+1JWa4gUZ6pytG2fsGdmwRpJJXq1Q+4NLppnMZ0Zl9
 zLsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781085972; x=1781690772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=AgtQ6vsYmXZQz2hQh6+6gdiWcTnmelwmRV8qto/aoCI=;
 b=OUw1ddiaejnFDpLsQcO+2gtbAhTtFfdUZeVXVBzDdwX7Ewv2ATOFHst7RiZJ4hUV+T
 6EQic2Eson2vmHdMKYgWw+SUjwuAipAruj+BHmrpfFwHhHe6rSjYq98jUm52asVqJBa1
 42I0ZO6eLsbMqeWkP7EBrszaD14uad9Mg5R6xEz68jsyDd8oFo7bKNx62/wu1RyjSCXp
 Pk7EhR/FTmrbTQFeRMUW0k+vA01cpo0V4Ov7eZ5/GWdvKiBroFwhMtvpl+9V59i7nsRo
 Bu7Eov1ZfwWGrDkicHtOVObLS/QFE0WEVlOowDbLEN1nW174vKBFwVAJW9Ais3ByX1bG
 Z1iA==
X-Gm-Message-State: AOJu0YzlCDpLa+gpFOnI4n0XxzQ8A3ph+kkj1gk63pY0OBahHx6CaDHI
 JBQr0bb4VhOOGvJBAwXv/+w9A/RC3wbidqhV9zUbVamwgqbrb+ApqHzQ
X-Gm-Gg: Acq92OHz5L4m+HjYbR2/CjI89CqmDgByKWK1atMnz25bLebSrmT/l8p2bFPJVAIdWKP
 D4EJo0J7FKhPwpeJ0k79HKcZAVGRjNd9ZcCtRBaEuzJ66a+/VlbBuhjDbajL6fJ4ikX8ZZeKHC/
 FQEG9sQFOTJuZ+z1ES7+0hmBJXtDInYLxdcZWOdNCAi4pJSz/64T7sworfJc+jG9Rv4MkfjtbOa
 u2D+KUWgOvaWw3XVcpky0EOmAu3wKrmS1pTZcsOt20WXtu98hc4/WSMOws6jmZPRtCOO9Jm8SS8
 TN++f3naAZtDGzjxL2LEg40YPvLvaVAWP1BC7SrVFMS4BNuj3vL53sVxJvJ6YE/xMxLhyn1h4/n
 TZfzgkPInBsoOTvRM2Sz6xvHnvPA1sY3+HtUBrWvhl7oxAwzjlfEkxp6Z59gXx5TZt2DC+3Ub7o
 Etwk86taYbWtGo2+JqFgvH2Emwl40dk5ZzASKTzWDu+AR10dTVc5EvL8jdcaNBLuGcsucH31WxT
 Br6Y4kSGIyyAds719TQzp94zLY9REVFQDCg2uElhaWaR7moOA==
X-Received: by 2002:a05:620a:f0e:b0:915:673a:62eb with SMTP id
 af79cd13be357-915a9c4b680mr3647869885a.2.1781085971906; 
 Wed, 10 Jun 2026 03:06:11 -0700 (PDT)
Received: from
 runnervm3jyl0.2xrq0wyeyqxelezmophrvlasqb.bx.internal.cloudapp.net
 ([172.172.157.2]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a37c645sm2321512385a.30.2026.06.10.03.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 03:06:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed, 10 Jun 2026 10:06:10 +0000
Message-ID: <20260610100611.4082-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610052132.2727-1-wegao@suse.com>
References: <20260610052132.2727-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
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

On Wed, 10 Jun 2026 05:21:25 +0000, Wei Gao wrote:
> fsconfig04: Check FSCONFIG_SET_PATH

> +	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", dev0, 0));
> +	if (TST_RET == -1) {
> +		tst_res(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");
> +		SAFE_CLOSE(fd);
> +		return;
> +	}

FSCONFIG_SET_STRING is not the subject of this test -- it is
infrastructure needed before the FSCONFIG_SET_PATH call under test.
If it fails, the test cannot proceed, so it should be reported as
TBROK, not TFAIL.

Using tst_brk(TBROK | TTERRNO, ...) would also simplify this block
because cleanup() already closes fd, making the explicit SAFE_CLOSE
unnecessary:

	TEST(fsconfig(fd, FSCONFIG_SET_STRING, "source", dev0, 0));
	if (TST_RET == -1)
		tst_brk(TBROK | TTERRNO, "fsconfig(FSCONFIG_SET_STRING) failed");

> +	unsigned int major, minor, device_num;
> +	unsigned int found = 0;
> +
> +	SAFE_SSCANF(dev2, "/dev/%s", loop_name);
> +
> +	snprintf(path, sizeof(path), "/sys/block/%s/dev", loop_name);
> +	SAFE_FILE_SCANF(path, "%u:%u", &major, &minor);
> +	device_num = (major << 8) | minor;
> +	snprintf(device_str, sizeof(device_str), "0x%04x", device_num);

The encoding (major << 8) | minor only matches the kernel's
new_encode_dev() when minor < 256. For minor >= 256 the kernel
stores (minor & 0xff) | (major << 8) | ((minor & ~0xff) << 12),
which is what tune2fs prints.

On a system with many loop devices in use the test could get a
loop device with minor >= 256, causing the computed string to
differ from tune2fs output and producing a false TFAIL.

Consider something like:

	device_num = (minor & 0xff) | (major << 8)
		| ((minor & ~0xff) << 12);

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
