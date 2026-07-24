Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EFE5C531FA
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 09:26:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A2C53E557D
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 11:26:17 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4B223E1C91
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 11:26:01 +0200 (CEST)
Received: from mail-qv2-x00.google.com (mail-qv2-x00.google.com
 [IPv6:2607:f8b0:4864:33::])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 68C8020034C
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 11:26:01 +0200 (CEST)
Received: by mail-qv2-x00.google.com with SMTP id
 6a1803df08f44-8ee27aa897fso1066796d6.1
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 02:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784885160; x=1785489960; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GkbPltV2pijbfmBt+KnAGKd5G4WV9QWt8Hz5dsulMGQ=;
 b=nKYoH3eYJyw4/e9GT6OgDk6t/FhftKCNTEuUkRbPCO/Szl49jfYveIfSg6GvNs6LBT
 F4tdChTokr5hrBQm7b5Zdfxg+DBpO2+/go2i8kTeP8hdwmYZnKQaTq+G6wzSZk0vwnrS
 zS1Pl+6yfrfIQmb3hs2N5Zp1eaExotNCSAWo6jhicJwV2kNqIw4KJnR9D6ut3wZVj56S
 cYROHnfXZJ7e/typ0B+ZqTT4tqbn3xfILZUgmwYeK66HSJmr5sJw15xJwx40hLhwfTqF
 HyLO7hfJZ5AsOJRqXy9nmTKimkK5OULkNBUkdnU4iBN7botLQ+phpbM5iTtiVCMnfvrz
 OteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784885160; x=1785489960;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=GkbPltV2pijbfmBt+KnAGKd5G4WV9QWt8Hz5dsulMGQ=;
 b=mzZfK8ARSu8q3n/nAgr/38r9l81wFL9Vb87oBeGXoJLSVLgA3i2Yz7f5m/0KCjWHV9
 1iUViBZFdZlrHuSx52HvnhySiA+xcC47eEvAgKgF11Px3nOjUMUlbN4SjKfAbGxmyNVK
 L2o1v2XY/sa5gOKQLmwKP47rA7gK1zofKdLYm+pJYkbkEo0hgOJwnTnvkaUvdVdbEsLt
 OL1DaIPqf7Yj/rfAuDw2KJUj9hDycxQJZ+QFAUyXo0IHEQ1VOfSyLKv0x4enU5uq/5Yi
 nET4K6smHN4mtbdyXW3Oo7OKVeKXN/IQF8S+aTFMx6uDgEmFW9YNtVpulsBnaAwA4ILu
 Bn/w==
X-Gm-Message-State: AOJu0Yx+M5souM/DjwNwfyIb6KVWuPMW7sCzU8ZPaM3q8/CBqY45DLR2
 s0g8aV5+ogTtIxy2ScEmvk6HamzjV/ykGdulQr3VlsHuLO3AMzA1x8BP
X-Gm-Gg: AR+sD13s0v65eASbn3+iqKihpytQiZyKwse0KnzxepicFG63vNIfYeiDFQn9ulNOFGZ
 4bq83WPrGX9wQRorKJ3Ef5t7C7mLQGEXYRFifzJjimMTYMi1OfyDXoPowSoFmAhHdL6+tEUmnyz
 kPyJAGltDNZh8MjLT02HV+zgy0yzzeSoCBIDrGty8wOUsjKK05LNhmgyogtLKiNR/kRmoiZ4nXw
 EgB9Q2OvGZTU6/cmBAAvyeBSFHvbx5tw+e7syZMZ+Pkr0DKHQ7mxAti7yIyvsj6LQkEbzKpLZHe
 0j0/qaLdSV3SNaXBSS/XS1XQhBYdrhLeNUeqkjqWNcjlDVynDwjQ3vzqFzRnzCjIgpdO1FCr//k
 uixQKBMWztUh85Y7/JWXsasoFUEwxdcujokXsbpl0/B+NDo1sfxMDAJ/DVrIWFApGFrXhyN07u9
 mI2PXqNpF1QnOV8yGI5TYEcVnc4ZYcUxSwidK6bl42AgYiMjOyZ6tLG+ffq3G/zvmsPuAOHoTXL
 4rNLEuz0iUecy6fgDm4vAJu3OcP6no=
X-Received: by 2002:a05:6214:21ed:b0:8f1:323a:fc45 with SMTP id
 6a1803df08f44-907ca572fdbmr73199906d6.15.1784885160060; 
 Fri, 24 Jul 2026 02:26:00 -0700 (PDT)
Received: from
 runnervmvrwv9.x5tmtygwvjbubadbq1y1idathh.bx.internal.cloudapp.net
 ([172.190.126.119]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-907ba9e13d1sm65075626d6.28.2026.07.24.02.25.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jul 2026 02:25:59 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Andrea Cervesato <andrea.cervesato@suse.de>
Date: Fri, 24 Jul 2026 09:25:58 +0000
Message-ID: <20260724092558.4078-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260724-cve-2026-64600-v1-1-8fa214385d2e@suse.com>
References: <20260724-cve-2026-64600-v1-1-8fa214385d2e@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] cve: reproducer for cve-2026-64600
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

On Fri, 24 Jul 2026, Andrea Cervesato wrote:
> cve: reproducer for cve-2026-64600

> diff --git a/testcases/kernel/fs/xfs/Makefile b/testcases/kernel/fs/xfs/Makefile
> new file mode 100644
> +top_srcdir			?= ../../../..
> +
> +include $(top_srcdir)/include/mk/testcases.mk
> +
> +LDLIBS			+= -lpthread
> +
> +include $(top_srcdir)/include/mk/generic_leaf_target.mk

Every existing standalone CVE reproducer named cve-<id>.c
(cve-2014-0196, cve-2016-7042, cve-2025-38236, cve-2026-46331, ...)
already lives under testcases/cve/, whose Makefile builds every
target from a wildcard and already carries per-target LDLIBS/CFLAGS
overrides (e.g. "-pthread" for other threaded reproducers), plus its
own .gitignore.

Is there a reason this one needs a brand-new
testcases/kernel/fs/xfs/ directory instead of adding
"cve-2026-64600: LDLIBS += -lpthread" to the existing
testcases/cve/Makefile?

Separately, this Makefile is also missing the
"SPDX-License-Identifier: GPL-2.0-or-later" + Copyright header that
every leaf Makefile is expected to start with.

> diff --git a/testcases/kernel/fs/xfs/cve-2026-64600.c b/testcases/kernel/fs/xfs/cve-2026-64600.c
> +	.filesystems = (struct tst_fs []) {
> +		{.type = "xfs"},
> +		{}
> +	},

testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c's xfs entry sets
.min_kver = "4.16", .mkfs_ver = "mkfs.xfs >= 1.5.0" and .mkfs_opts =
{"-m", "reflink=1", NULL}, since reflink is only guaranteed once the
xfsprogs version/format enables it. Here the xfs entry has none of
that. On a system where mkfs.xfs does not default to reflink=1,
would setup() just TCONF through the EOPNOTSUPP/EINVAL/ENOSYS branch
instead of exercising the race, or is the plain default considered
reliable enough these days?

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
