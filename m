Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8203DD6ACFB
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 13:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766064111; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=enBFG7RDkN7V89hTNoE/YAhyT1qW8Qo4rXZ6yaJIv84=;
 b=PmUqE1izpKCIAs8UDiNNPmTRlSV4dTYMWnJx88+HajLVRqR9j1Mu0qweZXpotbefkMc8B
 ICzkqOSwNgUVKVS/5ZxpAru48mSRxlyoHsOVnvIIzh9dBwfonEP4yXsYp72GyXYc814OSkR
 DvTXZF8pTApcGf71NdkhZ2qJumH2Vss=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 643D53CFB95
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 14:21:51 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 29E8C3CAA5A
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 14:21:29 +0100 (CET)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 7D66B60084A
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 14:21:24 +0100 (CET)
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-64175dfc338so1151572a12.0
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 05:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766064084; x=1766668884; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7FLatToEtH9fcosf6+m0a8hhrqjbKy4h265cQ/gxy1c=;
 b=cbojOQnMntc5yK92dh2BRJM6RTFRrPsfJL1kj19qC2TG3QfBNMxvhjSUVDX+2Ae/3L
 /qx2IR70Y56+lUBLmudE+yDKEVradQYRFbup55CWuzoJhF56YPJAuZfC214tEkS16dVR
 8TsKsGQtBhv09zI+EzdBQNq718eNu0nH31HG4ETjib5brxJ1jyvLCj+btW8QMlCGxc0V
 q8Hzkyy9x9P8fussJ30TMNno8JdCROqa8gqXcsJBiLOa4oJN8Tz/ZtMXHF51hyjo/tzk
 TA40AMCr4xhqCozjoU89RWo1QTFdqM5igajw/oe0Qq6IJMiPDBGgkG7qismvdli+fker
 ynJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766064084; x=1766668884;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7FLatToEtH9fcosf6+m0a8hhrqjbKy4h265cQ/gxy1c=;
 b=kHH9zHTbpSFN2BGT4B+GoQLhFa3diCbZM/bmGT2VcyVoIT+CL8+9KlIJOGwRPX1opS
 zt1KYGnluTO/9Nxq3/bW3d8YxGa5tZvEl5I+eYnVgKmJ+e4cZ67Z+7TqtbFrBPPtU0ym
 0gVx3dA582xgaTaNzL6KeliARaVlr1cl4u1DWmzog3NrWMsE/08dp+5QmacWJ+v0QHEw
 Mtl/kfAz4fbjGYC09tiUk4ImmdaSLZw5d4ApYpFvs9VTffOCrligKZkt+behSEw2bCjP
 IKn76ASungOUC6rTwL+lK/d7KHKc3zZFYJdwVO/X1QYmqDFqhxkyOqR8c/pW3ArZPZPq
 aBRg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI2nTcEUscHa+B5ACYK3xbrHdvr78jGgQxDzBymClVRh3sAMLYQPyx59w2yQlV+B64LnI=@lists.linux.it
X-Gm-Message-State: AOJu0YzMWVNH8Dvqwlvh7OE9s3HaRROcG0fXDpkYJTvQHdv4Bj1wWq5H
 jgnmllbIDlQ8Fm6k164LtYAE3/Fa47xVvEylcN/dnClUGtnO9Ro1J/PrDQaNXNn3yx7FADKb2Va
 6oj240RI=
X-Gm-Gg: AY/fxX4UOyxSmBfMopGcmgbWVIeeXR1yC2uEMrIe0EvhBis0YKFlK25qEtsjTBpeTlf
 eFsw/xOBvmwc5M9HMefMe8sO4I9bt4hFgOyYZMscgZoJanDd46GoOS7m9IcWwjtUB1dBSIiMcB+
 +dp6d0X9QpJjuWW7whQyHSC8QrGuv5GToUkB7uIkjcAisjCn34Shg+srlc62pO413PfThAc6dmo
 uWMcybkyI4Rn0Eaj4GcXhrOP21yBQ1SN64pJTIbmI3/H0b2Oo0dIzqk24dr39Y95mYOLQMfYwO9
 YofIJhebrHWvtLOEoFU4DFtl001HlRyTpGN3s38MVGdKilFwkz440F/bUdSvMBctDQ/vJADTT28
 YKZhrm5WMZCDKhRaoUzZHzYm9yrCy4fT6KDa1yTWcNUFr4lh9c4a5TlFVHQZyzrvThidYEy2WBD
 Z7/Y1hjHa3xv0TB0ZlocCSekljQQ==
X-Google-Smtp-Source: AGHT+IFK3vv6CoY+r9D5yRiDPP3dIASdIy6B/lj4tTsqrhukaL8W7RJh2v5ABkd7iNsNYgkGMwKRWQ==
X-Received: by 2002:a05:6402:13c7:b0:640:cdad:d2c0 with SMTP id
 4fb4d7f45d1cf-6499b312be7mr20752601a12.25.1766064083737; 
 Thu, 18 Dec 2025 05:21:23 -0800 (PST)
Received: from localhost ([153.19.102.214]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64b58891f54sm2606596a12.30.2025.12.18.05.21.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 05:21:23 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 18 Dec 2025 14:21:17 +0100
Message-Id: <DF1DGSWU0VDQ.124B4K0HIPJXD@suse.com>
To: "Wei Gao" <wegao@suse.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20231029012755.19969-1-wegao@suse.com>
 <20251022020509.6945-1-wegao@suse.com>
In-Reply-To: <20251022020509.6945-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] io_submit04: Add test case for RWF_NOWAIT flag
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

please take a look at the CI, we have a compile issue on opensuse 42.2
https://github.com/linux-test-project/ltp/actions/runs/18703432408/job/53336553104

We probably need a fallback attribute on `struct iocb`


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
