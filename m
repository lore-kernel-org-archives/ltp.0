Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE25EC19F32
	for <ltp@archiver.kernel.org>; Thu,  6 Mar 2025 02:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741227879; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=6gwd48Mk4b2uaeiCZrKpcn2qX+LtzdibQj/JRMPQCTA=;
 b=DzYRs6Vcl+QQFsUfvAUoiTUgouKWnDYH/bcSxMrM/ZkrXv2zR3Z7gxNdD8VNeUcqoJibm
 0ajV1Ivdn9DDO+yLixuOKRtO4gK2iT6jNfMieStpy/VXQ1p/t2bVsS337POJETdxbhdpvQ1
 VedxOfNgsbCHAKqL0tJV85CQ+gyQCMU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE69B3CA09D
	for <ltp@archiver.kernel.org>; Thu,  6 Mar 2025 03:24:39 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A46A43C72E9
 for <ltp@lists.linux.it>; Thu,  6 Mar 2025 03:24:18 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0AF5F14000FB
 for <ltp@lists.linux.it>; Thu,  6 Mar 2025 03:24:18 +0100 (CET)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43bc63876f1so774565e9.3
 for <ltp@lists.linux.it>; Wed, 05 Mar 2025 18:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1741227857; x=1741832657; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=S+5KTioPyHfZnZ4q3IIuFQNy/7f0kN44o5ff9QCUWiw=;
 b=UU5OYL071aOhj5CLldupFlT/IzE4vV6KAr53V089tgMXmKENRbnn020DACa0avElIm
 c6UMeQzjJe+EIxOydDMvhL3vAK0Dq+/XAcDbHYVxsLRO4oe8rLAUO+i4wBQq3iM+XLyW
 syiy8MctdexxQWjj6uhfbYYFZu8Aj0RZWiz0PfkjIy+8g7RtRSQ87/khuOf23KM7p5EW
 gAfGuKcX0cUZaG4L7zQfKZKNl06gMedSYW5wtHi2xFdyS8LeNWQmcFv4PdaY+mJF6A2C
 xdBHbQhvUPwb9CiZtYgCA+/CASYhLwkoL2FopPGZ5jmCeWQwXW7laN3mihPCZg243C1s
 9SEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741227857; x=1741832657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S+5KTioPyHfZnZ4q3IIuFQNy/7f0kN44o5ff9QCUWiw=;
 b=ZYQY0Il19wDwdBf6q7Tm+yUppt+2Osr+YTYRpjpi+JUXzCCTf9fH1FTC24Rwn6XsPT
 DjUopDrkadm83IlEoBT4t8LCbUJCTUUGDU+GruVHWhGzWWSLO11dQXldYs+ZF2mmqUoV
 XRp3VDalzyRfV6dtJYqWMNC+7CgSGODFozzmT7d33UvTuwPFc4SQzbvSl9ZP9n8ORPlK
 YWyQTVSGUsVQhQ8c07ERZqO4ev+07qPsPE2A1alU7k1JZC30cyCVU8zQNCRtRoP3Fhoa
 w9eQSRsVqm8Y9oBnvk1dsXNFiMvDhnVHMK/dg5x+4hdL/0K92mx5Ub+/6Wt7WWTxtA2x
 ecpg==
X-Gm-Message-State: AOJu0YwfcOkIIKkrdyiVymhoBDWBuicrsQySG2iMGQ8Hc02FPYiKMxpU
 01BAJinApkaOBchfP4Oxzgc9E265P11jfhjR1SMaXumIPQjaOeKcSu5mm4RNjQ==
X-Gm-Gg: ASbGnctIJP6ESgRoZEjINOWRi71h8TeP4VfMTwzrNw4hZHTYghj2O3gLgJhbyn/ZOgP
 tsbKvAWI7uLJDawFhU73S43nq7VtbEBVNPKvZJeKh3MNjvI4rIMskK8h1oUtcOwhPhTUwffJ2mb
 XiyZoktSdFUap226fKU1PXN/yPMMDVuIL1HIRjJ5klGWJW+JeuNtbgdTVBrNGz5tiiwm16PrL+q
 z1cJSUduORLaxwuIORsfgjAtTmk2VSfovNXML6C65o4IDIFtZsA+TIx0uo97qIxksqgwSdX726y
 3Cvave4wQLS1ucImZP2MqqX8g+A2ISHTJ7bciv8=
X-Google-Smtp-Source: AGHT+IHT9UIsmvqHigUNc3WqPTfq9abGaiKW0GyCN7mTzbjD115DI0/hOjDNxYGYiERykthCxONnaA==
X-Received: by 2002:a05:600c:4ece:b0:43b:ce3c:19d0 with SMTP id
 5b1f17b1804b1-43bd2adba48mr41663765e9.29.1741227857474; 
 Wed, 05 Mar 2025 18:24:17 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912bfdff57sm385157f8f.37.2025.03.05.18.24.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 18:24:17 -0800 (PST)
Date: Wed, 5 Mar 2025 21:24:11 -0500
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Z8kHSwZscoA0fUAu@wegao>
References: <20250304034348.23389-1-wegao@suse.com>
 <20250304040601.23920-1-wegao@suse.com>
 <361f2b39-3deb-462d-90fe-4f2ee2de9b60@suse.com>
 <Z8f3fbHD56aJrsMk@wegao>
 <777ccd32-5b2c-42c8-aec5-8abaa3884751@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <777ccd32-5b2c-42c8-aec5-8abaa3884751@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] unshare03.c: Add test coverage for dup_fd()
 failure handling in unshare_fd()
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Mar 05, 2025 at 01:11:20PM +0100, Andrea Cervesato wrote:
> Hi,
> 
> On 3/5/25 08:04, Wei Gao wrote:
> > > > +	if (!SAFE_CLONE(&args)) {
> > > > +		SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open);
> > > > +		TST_EXP_FAIL(unshare(CLONE_FILES), EMFILE);
> > > > +		TST_CHECKPOINT_WAKE(0);
> > > There's no need to use synchronization mechanisms because at the end of the
> > > test we call tst_reap_children() waiting for all the children to be
> > > completed.
> > There are some race condition happen and trigger failure sometimes if you do not
> > use this synchronization(Currently no idea why this happen).
> > Rerun case 30 times can trigger 2 or 3 cases failed if not use synchronization in my env.
> 
> I'm really trying to reproduce this issue, but I can't. Run the test with
> 100000 iterations and it didn't stuck. Can you please check again? I tried
> on TW.

I have retest on my local machine with following builds, issue seems not happen:
* openSUSE Leap 15.5 5.14.21-150500.53-default
* Debian 6.12.0-rc4-00047-gc2ee9f594da8-dirty

so i suppose we can merge my latest v5 patch without sync.

> 
> Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
