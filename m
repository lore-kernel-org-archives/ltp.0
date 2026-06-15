Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8598BCD98CF
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 13:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781529721; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=0Vj4g1SAJqAUpDSoQhADKDHWLIMqjtKX5vsg9v0grVI=;
 b=TEBTgkOcNnE8FhitZjbDo1Rl55Wy9y7PxvO21JWmFVtG6ncVWCUlg+yFCQd0y4aCZpICR
 FfCKGLm4O3RS514edc0DJ6wk3cIQ8lA3y57GCANtKYQ+NV1w0E7jydizKdzBYQu6fWv9wjG
 dfZCe+lJZdByecnW4VnKQ37PWAJ95gw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06BE53E6CC8
	for <ltp@archiver.kernel.org>; Mon, 15 Jun 2026 15:22:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2880E3E5BE2
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 15:21:41 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A999F10005D5
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 15:21:40 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45ef6565cfdso1542633f8f.0
 for <ltp@lists.linux.it>; Mon, 15 Jun 2026 06:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781529700; x=1782134500; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Vxs54VuHuE0SbKoriUNFXcEDslX12LqclS04ecnYc4o=;
 b=ZyJm0STpTQaHM2giYDBrIfEo3h7EBd4mJyTkVv0UwDWItJJANSSpJ2HTL8J/TLUaR+
 iIF0ybtSxxFEgAecYqNV4EzOjuLCa1gJcfPYHmkEIYlK4rq4thnQp010nTyuju6fxW4o
 oSsAKvbRAKf1g9vLe/6fGA4/R/330yCnYJsmHmswud+v08UFC4lhyY5nSKzCVnDd7waW
 7MT6pWXp01/bOd9W/1ar7g+Mv2YpLN67yYA22JsOjPyVbCT+rJC4M5HUNIRygyuQtNa2
 A81QrKVIwFCFFbJxtzKRSAcLPH6WJxsN3eqLzmb/PLPOmLio2ATxQ6R8nvyOKwBO4zrb
 Z1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781529700; x=1782134500;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Vxs54VuHuE0SbKoriUNFXcEDslX12LqclS04ecnYc4o=;
 b=kqbhJhHpekzidUvb5PKVA09Ey008SgSxrCtSDtqvs4morLuSJR+ud5FSQVziVdrRYQ
 8FbrhP97uc7N3AtRLaJyrVkE//KswQ5Y1tUs0LR2CnKxWIt3cUgXaFN/2U6RBHYJPMq4
 W/+wZWPZ6rPn7HA63wuqyo4Xil64SIxr5AoBpamRix5wYdkNFkRgRz1WUu5VRZxOurTa
 ZXlcGW0mvcNkm1WNnYbZTviemtRVowIfwDqqf9b1rhQN5KxK1rw37OjngXrfPHzWprms
 TvVt2Q287XY6WgeWqEdqTqUrUVPZcOqYd1AcZJhzH7Fboq9jm7hknbHxaojJHBAACktN
 bWvg==
X-Gm-Message-State: AOJu0Yzf+kVP0k7Is9X/+a0/C/HhS5RbPyNl69614kzTKPo5SGMkP5lP
 fRYzct00SkuldUR3+pcu5pTK+jA+bNQulX0WM85Rr5lRAAETN0SumLfEgq3QA10T8Bcw3SWWuxb
 t+57eWAJMvg==
X-Gm-Gg: Acq92OHtFVpdf8G78u79D8irjaEplD28PFV8sEjTL0N5Q4B35xtFc/bAm+s09Bbieff
 hGpivsoh4ElpoMjC0hkSZQJrdUVQu2tz21PCAzRRKvn2NnbEGP7v1iVCVp4Pm1ax+mjXTnbu7D3
 gJJPuhvULeeCTWM6AAjh3dREC0W4hVjsbEPg77EFPAx45jbUEPQgcRt02s9nYVOmZKNM4xVElV4
 RHU0baq/nF4PjXeuWlRXMa124rsrkHMlBdRy6iAezGb5rZZ/NetTBcxfUf66yi+ceu5BwWPrDSp
 BlPffCpLABD+yLcmWkcI2kA9BJmdpmSXWlr9ZEM7VypzVZg07EiBi1+eqrWhT8oG4XttwArRkA2
 ddhGdEaGoYq8op0UqQYUUaQGdpGaEC4Ys6kbXiMi0DS78/biWSx5qbDIUwRbpDQOsVik0gjqGwF
 NbiGg/vybRS5J5vZYtJ9sTEkpZ0hQQxMA/JQXiPiGT4FGQkKpjh2NXz9ZbdDvawRVJcQLMhYWt
X-Received: by 2002:a05:6000:1889:b0:460:3233:beed with SMTP id
 ffacd0b85a97d-4606dbb6c90mr20080880f8f.41.1781529699977; 
 Mon, 15 Jun 2026 06:21:39 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f450sm37419003f8f.10.2026.06.15.06.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jun 2026 06:21:39 -0700 (PDT)
Message-ID: <6a2ffc63.a08f2e7b.13a326.ef06@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260604142029.2077-2-always.starving0@gmail.com>
Date: Mon, 15 Jun 2026 13:21:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 2/2] fstat: add test for multiple file types
 using fstat
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

Hi Jinseok,

> +	int flags = O_RDONLY | O_NONBLOCK;

consider using O_PATH instead of O_RDONLY | O_NONBLOCK for device
nodes. fstat() works correctly on O_PATH file descriptors and returns
the right st_mode, without needing the underlying driver to be
present. Please use it in the SAFE_OPEN().

> +
> +	if (tc->exp_type == S_IFDIR)
> +		flags |= O_DIRECTORY;
> +
> +	int fd = SAFE_OPEN(tc->path, flags);

The test does not gate on CONFIG_BLK_DEV_LOOP via .needs_kconfigs,
so SAFE_OPEN will TBROK on systems without loop support.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
