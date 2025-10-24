Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62CFDCCF9E0
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 17:26:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 308333CF2FB
	for <ltp@archiver.kernel.org>; Fri, 24 Oct 2025 19:26:02 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B88763CF122
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 19:25:47 +0200 (CEST)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 04EA0600BB5
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 19:25:46 +0200 (CEST)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-474975af41dso15896405e9.2
 for <ltp@lists.linux.it>; Fri, 24 Oct 2025 10:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761326746; x=1761931546; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=3KOk60fO7kYEDb7UTDWUXqd0We7oAZbnVmVvclksnW4=;
 b=BEozuujPFeLEPvGyqnIw3BRkUyJhVnhtme2I9291J3wsGhKCKsBT+z91j+UeWSgzIy
 KCW4p6wMoabesxlSw6ZAoyrn0rdrlx8nxpN3O66f373oZqwzxKuKmViEFixT0lB6ptGQ
 iWfU8Dj7mitrcx8N0wxe7+k3yJV5OwqPlKSXjLVX7qxu5Mdyt/G+8vfb/Kt9XI55u5NA
 tJ7kNPdo/MiOq9zifhy0Weh8BhfjkbCwI9l6qS6Jkz8xMmEFrWNcG72/CKchzzM3G5lt
 26+FxTjYF82zahTiP0ViHYFxAIg+yGDZxnqZgCS/7R1+WIoCua5JLT8x+fAFMrNsdyOv
 rTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761326746; x=1761931546;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3KOk60fO7kYEDb7UTDWUXqd0We7oAZbnVmVvclksnW4=;
 b=cntxUw3oStIflD8mBK2E+ZkMDY4z4x4cJqgS7sFtcy4aHFlyMF3+nKDFSVvsuxSwQq
 qvw9xoCAd1T0r181w+BnbHIpWM2vtJ6NlkbFGe8ZuP6x4WDv/DmWPHTNEIO9AOKjCSAU
 OCSR04c7gdQYTgE67AbQ2ksOXEibzMInV8l/HcSeMlYj4FbSP+NJ1wehx4ftz8JNDbk0
 iukC31VRpUru+2kR7uYyVrX2/+Sh2ERmnHQFF+b+hnR4/0ehu94zyv9dk/qIbHsqV+MY
 30T7zxGLTwF/pYXCnpeWHMDsZxvjwLNcHsKrK5ZZ7mVKGTpDPJr2HOfa4kheuU1FkGOC
 7twg==
X-Forwarded-Encrypted: i=1;
 AJvYcCViaqURSqBQpa61B+Qu95YNAq1z+cfPTWoCxS9currOI5iFjhGyd/t8GgYbefu9+N394HQ=@lists.linux.it
X-Gm-Message-State: AOJu0YzecjvBqPfnjjWiKSa0PVCI26zG7KRQIY041keVJ+3OHczLY6Le
 NOx6ncR/m8gKPNVIarGHcq6aWXs4Sv53LLdaLs3OcGvjlinbI9jog3EgpfgmMWZF84Y6ip7jTXb
 3tjRR
X-Gm-Gg: ASbGnctryHc08c/4Ff1oZGEzcMHqbrs4vPrBxWT4nItNB8eufgR2NJRcmd0JuCGy2Mr
 /GiY6+mC0XpnkQcoB6k+XwMZt/k0Yw3plMAI0v8801+oGUOXQ0EAaggCRWdaK/0Uc/IdZbo7lu4
 P9IVHxfFprCinDMinRmrcXsKyGnb77oSyt71ZZ8eI8DlCjWGqTaB37MA/CptSI9QcFgOgw/jTz3
 We4Ozhsu28BxBm7G1u6UpPR67wqOkuCiD53M1+14tPBWWyw3GeHqC49t3MfrVG/LNeKv63PeKnS
 e5CoTLkbgckFDBmK8X92UoYMAMa5hE1H4l4u+IFHaZnmpfEwjkhDypglI5ONj8Lxf439mi6BCFe
 ccjyz0w0obmXt3xcZhHaUwr2H+XSb0+686qa9l4RqJv4McBg5S5ldaChqg+9agyY0Pc2+5TE7wj
 GSDkvhIA==
X-Google-Smtp-Source: AGHT+IFWRNbuqVrA9m8noewk81LKAmeSYVsEL4TI81EMk8k4Xp7qk1TxxVegJdk4PG+Bm8Wj1F09Qg==
X-Received: by 2002:a05:600c:3b0c:b0:471:669:ec1f with SMTP id
 5b1f17b1804b1-471178785e1mr230400405e9.8.1761326746140; 
 Fri, 24 Oct 2025 10:25:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-475da7d24cbsm10737655e9.5.2025.10.24.10.25.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Oct 2025 10:25:45 -0700 (PDT)
Date: Fri, 24 Oct 2025 20:25:42 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aPu2lqXN8G7h4e7D@stanley.mountain>
References: <20251024125613.2340799-1-anders.roxell@linaro.org>
 <20251024133035.GA590258@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251024133035.GA590258@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] file_attr02: Add XFS kernel config requirement
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
Cc: benjamin.copeland@linaro.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Oct 24, 2025 at 03:30:35PM +0200, Petr Vorel wrote:
> > The file_attr02 test requires XFS filesystem support to properly
> > test the FS_IOC_FSSETXATTR ioctl with project quotas. Add the
> > XFS kernel configuration requirement to ensure the test can run
> > on systems with XFS support either built-in or as a module.
> 
> So you have problem on the kernel with CONFIG_XFS_FS=y?

No, on systems with CONFIG_XFS_FS=n.  We do have the utilities
installed and FUSE_FS enabled, but the test says XFS is not
supported.

tst_supported_fs_types.c:129: TINFO: Filesystem xfs is not supported

The log file is here:
https://storage.tuxsuite.com/public/linaro/lkft/tests/340jmxk7fPGUn5zJbqsn4Chrs88/logs.txt

Both file_attr02 and file_attr03 fail.

> I wonder why tst_get_supported_fs_types() from lib/tst_supported_fs_types.c did
> not detect it. Could you please post whole output?
> 
> Because if code in struct tst_test.filesystems does not work, many tests would
> be affected with this setup. I'm probably missing something, but I'd prefer to
> fix the detection in the library than force config (we don't have any CONFIG_.*_FS
> in testcases/).
> 

That's a fair point.  I'm not really very familiar with how LTP works.

On the other hand, even if we fixed the LTP framework to not run tests
on unsupported filesystems, we might want to still fix it in case someone
just ran it with kirk

./tools/kirk/kirk/kirk -c ./testcases/kernel/syscalls/file_attr/file_attr02

or even just directly `./file_attr02`

regards,
dan carpenter

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
