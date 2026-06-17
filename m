Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A87CD98E4
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 14:59:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781708378; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=x/Wf/0ddQ44oVGud5JD3Gx3qPiMiqvQPB89GnSow/6U=;
 b=aG8ZjPICCBA68SF9Jnew0llRrFhne5b8qOdb3b+vtCDd23bIsHoSNM0VPjfP62EOgNuzs
 UI+ivfkaOz2lw0JW1raGiTZoX9uJqb4UErCojDjzPKX2rKOxNEXC7nfGPZMCDSQxEggyTSn
 cpuZ7wxF2rqGCC1Ev7p8muh3QgcAuMg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D39BF3E593A
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 16:59:38 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 336FC3E5920
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 16:59:18 +0200 (CEST)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A37FB1400DB8
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 16:59:17 +0200 (CEST)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-490b4a8e28bso44674045e9.1
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781708357; x=1782313157; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=gh9+rHNqwoGJ1OodC9K0pCIi/NSxo5KpX+aS1M2jTbI=;
 b=HkU6K8CyHzR0mDr+W9Y9vy9N9S9S7drIFdyMo/c4RVQSSiAI7QGzeGj+kZRpW0mw2v
 qC8fOs6wqTZ5t8Wgg0Cjpzc36K+5UM4ym0mFgblyHJlvvpErdr8uEfEiXPriBF6OjJeS
 W+DWXMZ50GlJOcK4LfBFLWwPC6VkHOU/xL+tZ8XnsAUsX0KugcCYPP2qmvloiOqsY/4D
 scl4j6+MBVwCjFi9hvdUk/sOpfoIUddfyzG7tbyLWRH2fSaERBRPAXpdMh9W36VmyRKi
 zWbuLXr6NRcSHw25MYbWjZ188sU3bExqxzBgJ6yDPLmng0TyKCjAnIFWIh4PPLYl2Mdb
 pXng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781708357; x=1782313157;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gh9+rHNqwoGJ1OodC9K0pCIi/NSxo5KpX+aS1M2jTbI=;
 b=MKzYLE8KHGassy+tX0ioC7b5MlfbDhIqH/TGJaLggmowJYHFFpLeHnV2+zdf3wv2tW
 CwtcTPlSmuWs0M5nU+wReXt+/jGbxS2dS27kk2BW//sOPUNT4hsAmaamahXtRGGQpziT
 vB8pwaVw5z3jcyatdyMZ8/l1pBOOFP1Aw6+ZjReuXzQuMu3XoTgvFTFM8nJ9AKdDjQlI
 gU07vaEGMgG8GMHDt9L/iKIS5CzIciAlFeCbeTTc1+NFGv1w/GcWcy2GK67cjhGFbnGU
 drr5DI7heFQ3u7C8TT/iSr9lRQGrHEX4AHqnJV0zHRY6QdyO4VURukTNdKITbhOKA5Bs
 TQlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9CQ7VjfGbTUSgwckxXXlS6UpxbVDA8GroHGZWzVX8i7ZMmwPxmHoxtda9B1pEaNH88zEE=@lists.linux.it
X-Gm-Message-State: AOJu0Yzz1ELaaUaDIfenRgDH3ZrqLSYRqJ5clRe/EZAvzasZhMEtm8xT
 LZTS0inmeaCUC829phwKyHMgVwDL+xRodmWSgquCX+2nM+oWMs+DH2vilJq39NhxVas=
X-Gm-Gg: Acq92OHcLjWtRmscYU9tmnkf1qcSGlMVeZplImRwAtiOnt6YQGxR+9gT/rFsLF3V0g9
 Dq8GUueVkOSPABCP8hcfZp94CTfw/THjDDoKXLrfgxVBMU5gkzDdjWOAaXgMl6bsX0cJgf1+34d
 RCwUO1Q6/+BNa94uWe240H5oXm2OEC4Yavpk/vt4QiBXPBTysp/RgBxexJjzXrNxEnd32QM3MDH
 D/OFl+Pn4y4gbS1l5d+Io34Z8GnTQ45HJCkqZ8S37PdKbaDfRu3PDZ74FdfrRDW78jr9qUAkLxS
 zG6eAR8nr9rfe2V0h7QJUcXGOThvjLjPMPQwgKP1QwGIZqU/q2OgZ35LCPrzQCTuV/62agDqZMS
 /QRLNw0sWSI3hMm3FNZF99HDssuBXYYtZu17IecF9HrS+H8Ubz56dSmVg//ViCa2vHwXeUrPBhv
 nmcaqoav3FjCtAKHuJJc7Zq0MKLDlqGhH6vPZbToZ82QJxFHpys16CCzOTNPyh3g==
X-Received: by 2002:a05:600c:8b58:b0:490:3d62:f5e1 with SMTP id
 5b1f17b1804b1-4923341fd3cmr63623415e9.22.1781708356755; 
 Wed, 17 Jun 2026 07:59:16 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922f9cd140sm158317375e9.0.2026.06.17.07.59.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:59:16 -0700 (PDT)
Message-ID: <6a32b644.f32a6769.150c63.1270@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>
In-Reply-To: <6a32a771.5e46ca1c.2772d7.360b@mx.google.com>
Date: Wed, 17 Jun 2026 14:59:15 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] swap: Add exfat to filesystems requiring
 tst_fill_file
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

An update. I had to go through the code to understand if we are having
issues from our side. Indeed, there's a commit which is responsible for
this exfat behaviour and it's causing a regression-like issue:

bf1797960c20 - exfat: add fallocate FALLOC_FL_ALLOCATE_RANGE support

tst_prealloc_size_fd() is called by make_swapfile() which is called by our
swapon/swapoff testing suites. Inside it we use fallocate() that is now
supported by exfat and returns 0 after the kernel patch.

This naturally falls down into the next:

	/* Fill the file if needed (specific to old xfs filesystems) */
	if (tst_fs_type(swapfile) == TST_XFS_MAGIC) {
		if (tst_fill_file(swapfile, 0, blk_size, blocks) != 0)
			tst_brk_(file, lineno, TBROK, "Failed to fill swapfile");
	}

but there's no data written and we get EINVAL at the end of the tests
because swapon() is using a file created with fallocate() instead.

The Jan assumption is correct and the patch as well, but it's strange
we can't reproduce it. The EINVAL is the expected behaviour in this case.

I'm just wondering how to implement it better.

First of all, we should mention the commit that introduced fallocate()
support into exfat inside the patch commit message.

Secondly, since the code was already working before v7.1, maybe we should
fill the file in exfat only for kernel >= 7.1. But I don't want to touch
the core library.

@Cyril WDYT?

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
