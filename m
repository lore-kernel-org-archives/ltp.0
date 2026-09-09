Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18631C79F8C
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 08:01:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B425E3E4A68
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 10:01:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D98B63C99F9
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 10:00:55 +0200 (CEST)
Received: from mail-qk2-x01.google.com (mail-qk2-x01.google.com
 [IPv6:2607:f8b0:4864:34::1])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1B97020118B
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 10:00:55 +0200 (CEST)
Received: by mail-qk2-x01.google.com with SMTP id
 d75a77b69052e-53096696963so11631201cf.1
 for <ltp@lists.linux.it>; Wed, 09 Sep 2026 01:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788940854; x=1789545654; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EXv2+hNSudb37ENZO/cn4hWONaoSxKasMyGGuVy4IZI=;
 b=CoOjeGid6dOkUpyNw3c4t2XaevGCR2buhgPtArbzlKSQI7CDjSAAckFQw9bJeKZecu
 r1VdoobD0s2wNrWgEhJxcC6hJI1K/zLLxzZaYIZjcA7Da6Ludmht5onxx1H0jqLBAWU3
 I42DyhEZUMG12SsC4iNmwfSKGt0TfDg03iuvPYe74NLGZd1HsRwWjQHbi3f1Rn0MIEnz
 CN5KOvhfA6aOUhGC99vGUACZTfOOS7L4vkVz2xmJAG5DP7VX4jx2lFc7sfTW55PyL/FR
 L5+zGVL4zIE2MkgwwrufCZ4KIdWvCYlGYHBIixE7PJq9T+jtn6AJykRuLnfymwcP+Z60
 AgMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788940854; x=1789545654;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EXv2+hNSudb37ENZO/cn4hWONaoSxKasMyGGuVy4IZI=;
 b=OmgdtmaTEBeSiKLRBvkQw/gqEB7t5UV/Zl8I7FovdoPm70S2gxy7V6B+KcgVAzMTS9
 deMwoZBxpdiynqHOwo/drWA60PW1UP9DI2JhaCTVLDOGWz9Af/i351YVRQ2wbGQnCOVi
 t/67BEf0P7T/KKEUC2mnrp1ZxvXv53osJ5AWW8cVsbRYueD0Qtd26p4Eyrs9Rj8F24ho
 fVdj/Gb5XzqsezRlfQimjyobm+/i1AMfuv5ElZYi8Fzc0miZM6NSV3F8mhB8V52CQrwI
 3enbo0zVxCjYQo984slfqiH00iTOotaTRWxW1Q9aW9rYgMax8HI4uFMdWMRbvte7vhuY
 3gAA==
X-Gm-Message-State: AFuF++l0pqy1uQb2fFAqDE5e/nR4YIYRattwWPBZIzwMTwx0eHlu7g8p
 r/XXefTyEqT/jc0rMvdgLva+8X1L7+Z1dCL+8ykZzC4+5GeSTJ4ziEkz
X-Gm-Gg: AYBFou2JUuxV0pVa+Aj+zGyenZRQlU9OLS7n2/12l0ak4uIGD4+7a84lcImNm1iSTfN
 hkODm7g1uGSmei9eeTZCxmfAdFktPGyZcFJIE3rf98a6cYDmB6+AKVlQGcHNYzDWxVU0Lv2jpNA
 0ixDucwAC+47GYoIJ3/cWKZhh9UVwR39bqKNVp9HPl7tyTJitlPKnrQQr88Ak369IAZPnf+EJ3d
 kz0ETmrOAOn3yua6/6IMR42Gjl9mwy5JwzbpnKmXR25gkkQxsONiZG1KjZnU5bN7ReaMGHre+nf
 BX5Mou2qYpJo+hbkn9PqJNc9pJM4uBrELDs4cnYumxWhe8zbaPL5GEKYfstuJw6r1uOWpFLnr1j
 A+4Jjw2sm2JyHgcSLHPICrwYM9yzHkNbsnNjrtgWADRhHwI+Kk9qBkNvb0Z1UPXQF3CaBaDis5Q
 E79I7vezmAHIIhVTXr9scmHAXjqeRkrMYIjHtMv7qpf4iAVOykPFXMCouhOT5BEdfdV1lFvCl6x
 9zM0FFCT/SQNyEMmUhbO/GC0UgNeWY3SRfPuEr4P+o6nFi2B7MiRjb003KCXdMoOl3M0XcUCuug
 GJGMvWw5PCLl
X-Received: by 2002:a05:622a:14cd:b0:530:430e:8125 with SMTP id
 d75a77b69052e-53054a4a8b4mr421913841cf.46.1788940853569; 
 Wed, 09 Sep 2026 01:00:53 -0700 (PDT)
Received: from
 runnervmejwal.3o0hpsufxxkehjtylihp12zn3b.ex.internal.cloudapp.net
 ([135.232.225.23]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5305402a7b7sm134014661cf.3.2026.09.09.01.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 01:00:53 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Wei Gao <wegao@suse.com>
Date: Wed,  9 Sep 2026 08:00:52 +0000
Message-ID: <20260909080052.9005-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909033447.14302-1-wegao@suse.com>
References: <20260909033447.14302-1-wegao@suse.com>
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

On Wed Sep 9 03:34:31 2026 +0000, Wei Gao via ltp wrote:
> fsconfig04: Check FSCONFIG_SET_PATH

> +#define MNTPOINT	"mntpoint"

The test does not mount a filesystem. Remove MNTPOINT and .mntpoint.

> +static struct tst_test test = {
> +	.test_all = run,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_device = 1,
> +	.mntpoint = MNTPOINT,
> +	.needs_cmds = (struct tst_cmd []) {
> +		{.cmd = "tune2fs"},
> +		{}
> +	},
> +	.filesystems = (struct tst_fs []) {
> +		{.type = "ext3"},
> +		{.type = "ext4"},
> +		{}
> +	},
> +};

Add .needs_tmpdir = 1 since setup() creates backing files for the loop
devices via tst_prealloc_file(). Also remove .mntpoint = MNTPOINT.

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
