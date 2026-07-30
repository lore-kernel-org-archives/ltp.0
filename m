Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9494C55162
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 11:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785412027; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=gLRLhOl7mRBJEsQp5XWO/ISJMr5tQiNCNO7UGJdDkwM=;
 b=g9F2qk7r1WajA5dzL2Vq4wm5+Eh5IFXlwH13vr1EYO0DkFyHX/kqA1W6SRv3bVq6mieq5
 nzabKqTTdHOTskh/veKRKYG8tz9xIi+XUjngtM0cbDxqdi2LBBnT8wUlIDMDTKIhrUXgvFU
 0Rln3HwsnzUxrLKsaxX0mNKqbBcD6jg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1ABE3E7282
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:47:07 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 993413E2037
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:46:47 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B0D901A000BE
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 13:46:46 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4728c12ba97so1302932f8f.0
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 04:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785412006; x=1786016806; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lN2rT93QKlaRAaVmVOZwEds/K59U2m6lU8G7pC2XzTw=;
 b=FkgsswjqG8b/mGiPPPKMKsCCiAA2Rn8TIOCdJ8/Hq952ERAW12yfDak1yLr1iyFh0L
 aJ5ceJwNHHCMO2f8JtoO5KxpcU+OBlZB3j7nlekzhxmmf8QvL1y/F8XR/4eeMw47OKJ4
 VHIE2Win+dALKK5+b0Zzj5cz3EvPhd8jy3A4/YiKkhlq/Raxe7kJTRsqUtX6nFgfjbeE
 yPa1Ntg86a+Y4Wc0N9m/K8wNc5p0LAAAQr+5p9+UAQctTIaCSelVZZv0paKGuvN5DbfL
 TgpE1UIQqv3HoFxGdDId+s+u/Wtjm+nj5zp6z3XlV7v20a61yZo1mqo4xU49b1D++a4/
 veFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785412006; x=1786016806;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lN2rT93QKlaRAaVmVOZwEds/K59U2m6lU8G7pC2XzTw=;
 b=RfxWjIQNokZ1rqRQQR5kgQi+OID4ysyi/KqDhzvJtOF5yu+a+ywyzu+pjGgzeGVe3o
 VBZ1xMISvdGi905EDBP/aCUMbEWmmYA2xtEu4ltuSe8h/S9voD7ibri5+oA4pfegvJsS
 b7BKirfnWQ/GkORGEOuECV1s7TXliEkttbLavDCbq0HmoCl73n3kCVGBdpbY/OoPnVsH
 xitbvDE7tte/vrEtIiUmCCf9Xo3HDHy343GgBDFeBreqQE6274asyUDLCkNAnLoQpfqs
 ijGMXemSwqF//LN+CdhrWMILm34SN6OM/1m5ihk4me7jVsBm9WRsRV3u9L71gPDkZFl0
 bwIw==
X-Gm-Message-State: AOJu0YzcwLQ+hE+a03v1r/iilZ2Avclsklzp07+t+XawppXgt4KYC2u/
 dQMiy2LRVz1yATHIp8xU1A3nIzkR02IW3j1l34XRtPNcEglMY00bp5LoTbcZURokN2k=
X-Gm-Gg: AR+sD11LMrzy8GWOxoXlwLg/GvnxzCHPlL42mW6ntwk8JiByYJZNjRIUWUGLnX25oiu
 agfir1Nbg7CvEYBKn3WbyHDnUjZUPTz7xuYJ2xD9I+EXup2RXU45f8tLNkkNQvNytsRMgOVrYky
 X0687vJgpkF4ixUyj79DOCnXXqP1n4tQzCpBABXOpUgDH/ZQNrjxo3lcZsqfKQaskvp5k8bJKsW
 qQUNYHeSxVCunDZYwrgDsPjJ5c7stjnbgsNnLTm8+EAkj4HDSJpwhP56LavwM27s1EU+z8uFagK
 t2ng1lDOYq6HTwZvKyjS14JnPEYNyoa0NtmVbmKxGZau3nD5gKFyOsYuwd+2yR4XnOW/Uz+l0RO
 G8SBFGIkOlfbDLa+49yHokkzgllGSGZIcA32BpdferWxI8od3iBjd12hKAuj++rrkYF0U1PgjTq
 siGyZIXIyF7z3AqK484aXWIAkHz/B98E6H046Pal5gGTvE2OIqBCJ0Xf9QmdnW0J9CzIb0B6j57
 /FxpHs9rGC/7Rkyv8i33xvmdMlRe7z30cSdzN/BSnWx2DIyWg==
X-Received: by 2002:a05:6000:2910:b0:474:530:9d with SMTP id
 ffacd0b85a97d-47fc81f5604mr3501960f8f.13.1785412005904; 
 Thu, 30 Jul 2026 04:46:45 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fc8941717sm5662072f8f.34.2026.07.30.04.46.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 04:46:45 -0700 (PDT)
Message-ID: <6a6b39a5.be490abf.19f263.7d13@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260702134553.98581-2-piotr.kubaj@intel.com>
Date: Thu, 30 Jul 2026 11:46:44 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] rfim: add new test for verifying RFIM sysfs
 interface
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

sorry for the delay.

> +/*\
> + * Validate presence and permissions of RFIM attributes.
> + * The kernel exposes the dvfs, fivr and dlvr attribute groups
> + * independently, gated on per-device feature bits, so the test checks
> + * whichever of the three groups the hardware presents.
> + *
> + * Permissions are verified by opening each node: read-only attributes
> + * must accept O_RDONLY and reject a write open, while read-write ones
> + * must accept O_RDWR. For sysfs nodes the mode bits alone are not
> + * authoritative - the kernel can still refuse the open in the file's
> + * own syscall handler - so open() is what actually exercises access.

Pleae use :manpage:`open(2)` and `O_RDONLY` and `O_RDWR`.

> + *
> + * The test requires root because the read-write RFIM attributes are
> + * root-owned and created mode 0644, so only the owner holds the write
> + * bit. An unprivileged user could read them but would get EACCES when
> + * opening them O_RDWR, which the read-write check would misreport as a

Same here for EACCESS and O_RDWR.

In this way we will have a certain consistency inside LTP documentation.

The rest looks ok.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
