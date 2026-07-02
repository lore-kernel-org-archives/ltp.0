Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A45BC43458
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 13:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782997271; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=H1PRD+WcHOUa/ojTCLwoCXua5BevukTKb/JZEW+vK40=;
 b=rW3FzcXbr7ssIskQRYt6tZ3MVoKgPp8c08VVCW5kyMslBOK57GG9vZx7nvMwdO7qCIPiL
 ogsSm47gwjknbaJkdGp5nXQAf+KjnhgaR2cLFD5an717DlnkA31anEV1WFhgCggFnLXuOUh
 rHRIp9PGrDQZTFsbyRjLkocrbZW8s3M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C487C3E4A1E
	for <ltp@archiver.kernel.org>; Thu,  2 Jul 2026 15:01:11 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 105103E1459
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 15:00:51 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 73F9260064C
 for <ltp@lists.linux.it>; Thu,  2 Jul 2026 15:00:51 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-4629051c946so417139f8f.1
 for <ltp@lists.linux.it>; Thu, 02 Jul 2026 06:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782997251; x=1783602051; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sOhqU98KDS/0USUXV2aznYpW7We6GxezKZFNDExicKw=;
 b=dSE+B9M05CF4BEZ2kOuA3xlHcfmuFV5TR8QbIncwsfjOoXwkXByS6IIIX5vO7zTed2
 B8GjUS+cPz2DsgrnWAHTM5jPgIojeRLGQcVqAkIignn98GVK8000NAQJEJuKVaz5EIht
 wNJs9NPlwB8H5PMCINKu6xB/kNyPSXh3cIxAWjUj6zvN7e/XvVLkQdVJSIhnRx3m5ry5
 uXMhWBb4J0b9BW09jcERy9iFgSiggq8st9/3rW87JbCRBTMAa8YbimO84fPwGenAugPn
 WyNqzoMgDwotJwwRzlzqZh0hffAxyrvHuRdq3W3vlIAn6x4Bf1OHtC2lMckaZQ3ZVhhU
 T0ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782997251; x=1783602051;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sOhqU98KDS/0USUXV2aznYpW7We6GxezKZFNDExicKw=;
 b=CNR1kagJRHqf9rO5aEDvF1Xz6+Efq9m6dNwjMvMqyLSKeOJHHxxMhoulqpdi7uX5EO
 LOCxtjwPRjlk3NNI9UAVtBRzsE3Acgk1ki/5M9A0d4pigF7rGidoH/KwDovnRMvj2A54
 r5JzXgBjg99Awwo5JauiGl+Af5xwmlrY7iDt1Ll51lHd1/8GlQBODI6i9QyH7+o35xpj
 oYr96QXGUV0awIfZZIAqVkpIt+f1MuUgIGLY9nEWs/TGKRU2QSTz9iAjEFatuMSJhHTX
 rqCjJF1PVYSr8C7UU/0U9YNTKw/vpiYSjosTpU51HYVgnYEn2n+yBCTB0qzPNaYRTkih
 64pA==
X-Gm-Message-State: AOJu0Yw42Tu3xOrEeEFSbhxBhs9kaz/og2v9njPugg3uZKt0y58cNKlG
 VNg8QsqqXEEyP1juZ+OJbI4iFYa/iCBXyRshhd3LV+wMExmpIlxZWdryvRMLalk/9XjT/rE+pRO
 CRI8=
X-Gm-Gg: AfdE7clIDwJ1l06wjCh/G/D8Gv8kLGP5DG57yyXulFCGAtIGSjABSe1jfT6+YJ1BSDP
 b9jHI6Rj09kSNgfAJ8nous013RxSR822EffcwNev99IUPbtBIV2IraPCQ6Amq3splCL/xZqisuO
 BwPeykl08ZJ3+FkpPhi7na5htApNHpSlHuQFvrFL0L/+fFBPRIJLwHrA0yD9a7Yn1ct4MFZuQpa
 b7hcRka+GS9M3+9J68u6kftXnQFk+9m4bCN6JjyZazS94nyKca968PJ3g5JN+flTMZtV23RAcYW
 5RdK+Pa8e+Lqqg7dZYijodICWIiFs49chCYGmBqgx4b5c6G1+nsW9Lr5axR3WvZyzjfhlLs36nk
 BFiCIhyidv6MD0nNhesPie/eI6LJFvNfFRdF41TAsKkEzWa4QnAyI6Q7pTC9J6MySqDz1u1WDO+
 zPaI6UXK4NmyVe7yS60gBswROhVBijww==
X-Received: by 2002:a05:6000:707:b0:46f:1b89:999 with SMTP id
 ffacd0b85a97d-475e12a8405mr14581134f8f.30.1782997250849; 
 Thu, 02 Jul 2026 06:00:50 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477dd94ce4csm9284143f8f.17.2026.07.02.06.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:00:50 -0700 (PDT)
Date: Thu, 2 Jul 2026 13:00:48 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <akZhAFNlgvHvYbbU@autotest-wegao.qe.prg2.suse.org>
References: <6a464ecf.da15fda7.265c5d.795d@mx.google.com>
 <6a46501f.8509f64d.ec809.05c0@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a46501f.8509f64d.ec809.05c0@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] statx/statx04: Skip testing casefolded
 filesystems
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Wei Gao via ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

O
Thu, Jul 02, 2026 at 11:48:47AM +0000, Andrea Cervesato via ltp wrote:
> >    if (!strcmp(tst_device->fs_type, "vfat") || !strcmp(tst_device->fs_type, "exfat"))
> >        expected_mask &= ~(STATX_ATTR_APPEND | STATX_ATTR_IMMUTABLE | STATX_ATTR_NODUMP);
I guess we also need exclude STATX_ATTR_COMPRESSED?
expected_mask &= ~(STATX_ATTR_APPEND | STATX_ATTR_IMMUTABLE | STATX_ATTR_NODUMP | STATX_ATTR_COMPRESSED);

But when we do this, meaning the test runs but verifies nothing, just
TCONF is more clean.

> 
> One more thing: this is a snippet. Remember that we also need to filter
> out the right kernel version, which is the v7.1 at this point, since it
> has been released.
Adding a kernel version check with tst_kvercmp(7, 1, 0) is redundant here. Here is why:

On kernels < v7.1:
vfat/exfat do not support FS_IOC_GETFLAGS at all. The ioctl() call fails with ENOTTY, and the test is immediately skipped with TCONF at the beginning of setup():

if (TST_RET == -1 && TST_ERR == ENOTTY)
	tst_brk(TCONF | TTERRNO, "Inode attributes not supported");

So i suggest we just give fix like following, do you agree?
if (!strcmp(tst_device->fs_type, "vfat") || !strcmp(tst_device->fs_type, "exfat"))
     tst_brk(TCONF, "vfat and exfat filesystems do not support standard attributes");

> 
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
