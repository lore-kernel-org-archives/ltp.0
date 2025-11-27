Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58C89D116E4
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 01:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764208276; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=SKllW88JRGy7OunyihGGXpMh5/eMBGuhCxSSYvbEfps=;
 b=g5QdKdWiJ0V7Xk3MQu5xC/p6Ryq4U9Ds/s+vFvvuxMS3TuosCp+E57V2Rb+PNH7RLhrCI
 /QQyCB0VBafnT+++/bCOCtMAWjyRx8dSWvXMkQkqI5WPsW5Bad9wFcHYjrfesU/uiyCmrpF
 wBveXDisyQWztx1IaxmOUD2cw2LzgYo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB7A23CAC1E
	for <ltp@archiver.kernel.org>; Thu, 27 Nov 2025 02:51:16 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B13D03C7F71
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 02:50:55 +0100 (CET)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C18C82003A2
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 02:50:54 +0100 (CET)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-477b5e0323bso8227655e9.0
 for <ltp@lists.linux.it>; Wed, 26 Nov 2025 17:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1764208254; x=1764813054; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=7f/NGt9PhiKtLJCrxLaPZKHO0hccYH7c0Hd/TG5qT70=;
 b=BP7dVcBT7dKg/+QgtD7I5j80J57dsnRTJNxu1QHFl040j11ExHoV2pviiKg6dR4uME
 kmumcC4JS9DrLJP8fGdIUCMQ5IpgC+BgYnRDY6M9IHO84nm3RvMptsmGbP/hiHqgctmk
 op64tJG9K/bYl/er/rXnKlkfaAR1UwtyoXW1ETZfkDf7fP9Lpu+2qB7E+J9Aabm9e1jt
 vNwdM1cgEXc9AS0B+bDJv2N++nO2i1QaV15qd24Fsx/MBadZKGTe43gIki+xyRYTUj6V
 BG682g/UZ175DmSFc/JEQcdcW3Tw/iKJCJkahUaZAAjaW9db2+EYDT4ITFscn151NDAA
 82XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764208254; x=1764813054;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7f/NGt9PhiKtLJCrxLaPZKHO0hccYH7c0Hd/TG5qT70=;
 b=M4j1aokiXqalKE5JmfpIq0/NEnjJvhOn8fAClykPBLZyGyZSCXgnCOsfNZW00nnWar
 TwsgM5Cw4cbmnkoFtkqO68Thq11peepwr/XinTgV1vCUxssH7Zdy0zmB3EVEW0JaI+rC
 /1jO7wgmcJ5+ltiP3JcNdG1xWRngJ2/7XMLFHLhcJ6yceaGLNa45VCJAl/b5KslDAMmU
 ozC3JQAVH80yrVCKBGJFOAzV6xilETvR/+WdJ16e9D1ybI90KYISpz8nQ1RdXu4MMI05
 GcLbe4m4yXu/l3jwGVDXUjAA1o2EtyNUhtUkIbuNXBwDCpharzgtBHUfFVnVGnIcNBCN
 PbIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUfC2ta+o0H5TpcU9xRbrx54fl1bqlFWlsvAyAg+T7Z9jjCNil/5PtIPWscfq2S6wU20vA=@lists.linux.it
X-Gm-Message-State: AOJu0Yxkp33h4BGBESVA7acT/aGMUAi4N8n7F36BidNgUtWkbV6ek/5P
 qp+q54jUmQNf5QYmVzeEu/9ji3QicDK5wpwlA9yQBc/Y5jRPd1GUUA4WwpvCjIyeCQ==
X-Gm-Gg: ASbGncto+6aPHtRnx4JsoyPOpSBzY4cCVOsuiB5DakjyrKpXlHB5ZLNyF6U9ChGQ/Ph
 UhGo6j9Tbd0P+n1MVImg5C7PPG8hpsEvuq1hCJt0rzlCTQ0lXyz17epCCaH8zBkG5A2eRZ8oTtS
 aDPuF3EpvkQQxs2c7jgAbLrdJVvf6nmpcB0vFv7ZndoCg3r1wnDwwLKqYjjuojj20XIcrpwLcpd
 sdawIfHFrwt/3OALa9LI3hZG/mPNfgBNfBF5y30MkN1ETQIA9cXg0SgMw0avEg5Eaqrhb6/7Sb5
 dxHz4+Lu+Z4hi1r2srOxqv066BUpqcmEtyZirS2KrGdl//ipOo9kUpdq/81JaUxFNgE25Cb3Uym
 jqduQ+NfJgrbE9LrQJaOcvLAqQrR82qlkXgxxDv7svxrfc9mIyvFRA/YuqDfRydtB52ozxdUZLW
 B+5oanPs1N5LSoM4mxn3x+jzAmyln0
X-Google-Smtp-Source: AGHT+IGqCP3dOwbVcqjH02MwzgXNn1K1WcY5QlK3LzfxtqgvJWUDJ6ePKE/B0PPmZH/5i943qt1wYA==
X-Received: by 2002:a05:600c:3ba7:b0:46e:59bd:f7e2 with SMTP id
 5b1f17b1804b1-477c05139c2mr280548915e9.11.1764208254168; 
 Wed, 26 Nov 2025 17:50:54 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-479111565a1sm5285835e9.5.2025.11.26.17.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 17:50:53 -0800 (PST)
Date: Thu, 27 Nov 2025 01:50:51 +0000
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <aSeue5UPBm3QGH8-@autotest-wegao.qe.prg2.suse.org>
References: <202511251629.ccc5680d-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202511251629.ccc5680d-lkp@intel.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linus:master] [fs/namespace] 78f0e33cd6:
 ltp.listmount04.fail
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 lkp@intel.com, linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev,
 Andrei Vagin <avagin@google.com>, linux-fsdevel@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Nov 25, 2025 at 04:33:35PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.listmount04.fail" on:
> 
> commit: 78f0e33cd6c939a555aa80dbed2fec6b333a7660 ("fs/namespace: correctly handle errors returned by grab_requested_mnt_ns")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on      linus/master fd95357fd8c6778ac7dea6c57a19b8b182b6e91f]
> [test failed on linux-next/master d724c6f85e80a23ed46b7ebc6e38b527c09d64f5]
> 
> in testcase: ltp
> version: 
> with following parameters:
> 
> 	disk: 1SSD
> 	fs: btrfs
> 	test: syscalls-06/listmount04
> 
> 
> 
LTP patch:
https://patchwork.ozlabs.org/project/ltp/patch/20251127143959.9416-1-wegao@suse.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
