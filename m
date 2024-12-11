Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E171E7717D
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 10:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1733912970; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=FHO4cGvW16TJS0DCCyCV+fqZq1rb+Ds5OAvYJFpMcSo=;
 b=miEoeSbnN+PwoblnuejCQxl1rOowF8iXMooCXp2qnfbiYT9QOLu97R7XMdov6SmpBIJFe
 2qI6uWS7u3YTjLclXu1uulqbJteTpGnnt3qvBEKSf/srLil8hY4JujxCcA5etFPKhMuEZ5z
 VmImSmIUDxJXRIERpUIJJE1caHt+tQc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C9B53E7D38
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 11:29:30 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4B8B23E7D2F
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 11:29:10 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A65E6100114B
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 11:29:08 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-3862d16b4f5so299558f8f.0
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 02:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1733912948; x=1734517748; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1xsZb0CKbrC1fp/VNCH8qp2RyUT0swOKQTcTyi5Yrbw=;
 b=XBdcRYTsC8Lu7kapE2H5O9y3qLLMPNXqIMjtuf1+u09t1rLb9O2ecGN/qvE3lmAUy3
 Hd2LiIReuW7/R+Qwo9yPfVIC3A++Djin0LPqsmOko3RzwOUouZaSLjDUkmNZ64+4XrB3
 PlY1IDyo1UOGRHa8SMMPni+PZomX14WFYSSIhnROFFOR9ahNR0kqrJ5xU2K7YLKyNCR4
 Pq9CchF4QOvEX+OqWEqQWWWVJ3gXV0+PsgR/0t8oBUJxPUoG4TLCk4PKZDOkcLto8KVC
 FDKRPDqk/t2vkl4dpCbA/p0p/NO9gt0Xquq9uiQOWvI9+hwg3A6DMhVUZOy1A/SDPwXM
 V4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733912948; x=1734517748;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1xsZb0CKbrC1fp/VNCH8qp2RyUT0swOKQTcTyi5Yrbw=;
 b=Pisgn+l8upbR73LLoV9X4EbUtIIZQbJIfAdP8tkWADUIRveyiptvXruL3VEbhJG5Fw
 29YLbQDFjklagjaZpDTbfEjZ/a9K885gzTbawq3IaoGJaTgHhCtzVAkubxWFlbdqYCl+
 Cr657M5znhKF5mmQ2W3LdgR6cGWbpeQebMam6WgKsT9SSBkrkNMF2UKfYkZ5zGebVyne
 SKLfimerrvlGwmMMulYeI15ckqfB3yXHEC2l9suRuRTwcCeYkWRcF0o6kjTfDiq/RdIh
 xXp0HfPw2Pm3KGKtuvtiyrmEZeldfrQ1ktoe6l+voLV3EBCJji+W81l71jkW4iT2M1F4
 dI2A==
X-Gm-Message-State: AOJu0YyO5LdMvAt54dr5LVTzV6tREkMlF2qsnlWrSYTsjYDjXrwmhwPl
 HCaqwc5n2Y9Lwc78VFbKwEObPUi1riuWhWAUA2nxODq7wr/3l3W4GFcHGpIi/hPmc4ae7U76C8F
 A
X-Gm-Gg: ASbGncsAc7+gXXKE0kzPCyV7iG5DmZ5u5Pr7ltT8A/82xQ7MtPBz9aFs2Sfoi/mI4Xh
 IGOeHyeJidarT63AXvKEndlIeg1NHsnF8e71A+/fmXuDoTY+s21Dv0Oe6U5FLL7P4EbX+H2xvax
 gmKMvXzTy4oWXYA7w2B2FqJmXXugOlaQvi/G27iPot3I2hTpu7xoOK+IiGWROL74STnu+xT3YeN
 xsOmGPSE1QAdkT08DPfoF4GO/Kfv6pNKGF3zATZq5o=
X-Google-Smtp-Source: AGHT+IG1FAbqjVwkCZh6GKbxmXHUdo/cMxiYjqJz1cafZrlvM06x3D7lPJBAYa2Cq099bAPi2e4ALg==
X-Received: by 2002:a05:6000:2a2:b0:386:3d27:b4f0 with SMTP id
 ffacd0b85a97d-3864deb216cmr1652342f8f.14.1733912947701; 
 Wed, 11 Dec 2024 02:29:07 -0800 (PST)
Received: from localhost ([152.250.153.103]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ef45f9585dsm11220814a91.22.2024.12.11.02.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 02:29:07 -0800 (PST)
Date: Wed, 11 Dec 2024 07:29:04 -0300
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <heoebo5b4mslxrpopscllz7a2rfviwltnxsvtl6bvsd4h7gacz@kttzguhbtix2>
References: <20241210-convert_mmap01-v4-1-c2338a2ca071@suse.com>
 <20241211014710.GC383036@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241211014710.GC383036@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] mmap01: Convert to new API
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marliere" <rbm@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr!

On 11 Dec 24 02:47, Petr Vorel wrote:
> Hi Ricardo,
> 
> ...
> > +static void run(void)
> >  {
> > +	pid_t pid;
> > +
> > +	addr = SAFE_MMAP(NULL, page_sz, PROT_READ | PROT_WRITE,
> > +			 MAP_FILE | MAP_SHARED, fildes, 0);
> > +
> > +	/*
> > +	 * Check if mapped memory area beyond EOF are zeros and changes beyond
> > +	 * EOF are not written to file.
> > +	 */
> > +	if (memcmp(&addr[file_sz], dummy, page_sz - file_sz))
> > +		tst_brk(TFAIL, "mapped memory area contains invalid data");
> FYI test fails when run more iterations (e.g. -i2)
> 

Thanks for taking a look, but I don't see the issue here:

# /opt/ltp/testcases/bin/mmap01 -i4
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_mmaiVJsAq as tmpdir (fuse filesystem)
tst_test.c:1890: TINFO: LTP version: 20240930-73-g865be36ffce8
tst_test.c:1894: TINFO: Tested kernel: 6.11.0-virtme #1 SMP PREEMPT_DYNAMIC Fri Oct  4 13:39:48 -03 2024 x86_64
tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
mmap01.c:49: TPASS: Functionality of mmap() successful YES
mmap01.c:49: TPASS: Functionality of mmap() successful YES
mmap01.c:49: TPASS: Functionality of mmap() successful YES
mmap01.c:49: TPASS: Functionality of mmap() successful YES

Summary:
passed   4
failed   0
broken   0
skipped  0
warnings 0

I appended the "YES" just to make sure I wasn't running some outdated
code, can you please provide more details?


Thanks!
-	Ricardo.

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
