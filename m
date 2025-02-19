Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3E39C021AB
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 08:47:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739954861; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=LRupSrtNnXbidAomPwipUaNt1JxQf0Ra4Umpdg+VsRc=;
 b=mpiqJqXlmGV3Z1cFnBG5p39NOoGTuTw4/9Suu0CwqAZDdu+JBumpciubqI5ht5akVje24
 hBCZRj8KEE9O34sYxj/MwDUD76f52yjoVTxS2wXmGcLFoGvWMhQFbqC9QTtfkNjfIHcAgq+
 ZtiTiksrkIHeqGmj35JHLX9vBRSlqPA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 30F053C29B6
	for <ltp@archiver.kernel.org>; Wed, 19 Feb 2025 09:47:41 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 63F6D3C1BE9
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 09:47:17 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9C02365176D
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 09:47:16 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4398e3dfc66so22701965e9.0
 for <ltp@lists.linux.it>; Wed, 19 Feb 2025 00:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739954836; x=1740559636; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=sc0qTqdZNPpLorNMCsTAtljrFLVkhQFUa4s6DZzDOTo=;
 b=Xlr/x8aAsU4J2OukKwdDTOhuKLhb0lb8AVdEcFKQnPmzsP5tpYjcHnYfjtfp+j8P4P
 vDSDYYwQq5+EjmyJ53MYWToz2zYLDI5DcDSMo3qrtVxbiIC/3tj2rsVoHuvbJCFqw5eL
 FMj7mHPP/nfe5ifS5Tw6hdY6sub5eUxlHz3krgMqX/Bc+WxARt6nlgqUmFtGBYY9DKOX
 rwBXCSVypmMj/rgP9jPr6zo3yN6ryIIuf/pfV8cq7N7E7NlRv2hDKltQEkVHNAxa03Bm
 1/p7/vqba6dqk8c/37if9NcCRSJ0Nq0MI27S0XtBSC1zYciAl37XOTVNbY1Oli09BpX6
 /W7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739954836; x=1740559636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sc0qTqdZNPpLorNMCsTAtljrFLVkhQFUa4s6DZzDOTo=;
 b=hZHDcBXlcMe6WEYZTCyu3QZi79DfVBBAvEPbzGo/f0hp+r1imyCBYkV6T6DF87mrfZ
 ZAeLKB/u23yBXKkhkxiIX9wDTGaWH4FDDUfMjOlZ+VEjxX2+Q8i4pVXGa3huAazScIfB
 YrKbGEfglrjjiH6oHbI9ypNhrzk8APUCLkhTbkHMzDsFM+dgXknmWh6ZyhAgWx7nB9BK
 cvolZdGEjzYy6Hrrzt4+qP7aZ14LkQGtQDmwI7VVwE7FDLF+dycqMwxIcrJNI0myWyeS
 xM2pKOUbZdEoebjGw1+BZBFWg+1wTdQgzCtz/C8c5hytR9O6AnkvbBLIrcBBxMvOzAyu
 2tLQ==
X-Gm-Message-State: AOJu0Yx3d9E6I5lBlLzybMExeyElkq+UWzpyQAk5U8Pjm/BCvDZ1Dccs
 COlJgwANNnOzx9CGqqqQU77ZHwKXlKlv/0aFeocDcmSfFuGwLJmbKBCQgw2uUUiXLvOI5SLSBB4
 =
X-Gm-Gg: ASbGncvYUN8XKI87IefZ47MTrbpx+1ndYG9R42kmG70HlQr408iNgj0uBq2/iLY+OYc
 2thHWfmFmjTn1ISpKfc/xbjqx9JTAhZUPQOk0Ezn7t4AM60SjF/cBcmKLuLxGU9fgQ35rK1cXLD
 bxbbq8UlN8TAzumMD7Zp/uWOMNnWJYvHLk8ZiJKad2+IjcQ+8LAotBcK80ACJ5FYIYlpWp9COxD
 Jb01UZXUYEJ5eXkT5bEo3JQCJI9Xm8gUQ/mZKvhQOnoE3A5Rd7N4s2fkX6gCPm6aJ94HWx1au0=
X-Google-Smtp-Source: AGHT+IFQkOWOomF07ew6zVYD580ioTzwKJDUiMEWeJ5MSFCS6YCvdRTz5ZfHuwiSxawgpa5VsPZzig==
X-Received: by 2002:a05:600c:3150:b0:439:8e3d:fb58 with SMTP id
 5b1f17b1804b1-43999d8b5c4mr29283215e9.11.1739954835862; 
 Wed, 19 Feb 2025 00:47:15 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4398e35c522sm58714395e9.34.2025.02.19.00.47.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Feb 2025 00:47:15 -0800 (PST)
Date: Wed, 19 Feb 2025 03:47:10 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z7WajlVc0xMSztSe@wegao>
References: <20250217020423.31602-1-wegao@suse.com>
 <20250218151858.GA2492575@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250218151858.GA2492575@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mount_setattr02.c: Check mount_setattr
 attr.propagation
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

On Tue, Feb 18, 2025 at 04:18:58PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> nit: I guess you want to replace dot with space in subject.
You mean i s/attr.propagation/attr propagation ?
> 
> > +++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
> > @@ -0,0 +1,102 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2025 SUSE LLC Wei Gao <wegao@suse.com>
> > + */
> > +
> > +/*\
> > + * [Description]
> > + *
> > + * Basic mount_setattr() test.
> > + * Test basic propagation mount attributes are set correctly.
> > + */
> > +
> > +#define _GNU_SOURCE
> > +
> > +#include <sys/statvfs.h>
> > +#include "tst_test.h"
> > +#include "lapi/fsmount.h"
> > +#include "tst_safe_stdio.h"
> > +
> > +#define DIRA "/DIRA_PROPAGATION_CHECK"
> 
> Is it necessary to to use directory under root?
Yes. Otherwise failed will happen during mount_setattr.
But i have not check for detail.
> 
> ...
> > +static void cleanup(void)
> > +{
> 
> I guess this is due result of:
> SAFE_MOUNT(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> There should be either a proper detection whether this works or 
> 
> ../../../../include/lapi/fsmount.h:113: TCONF: syscall(442) __NR_mount_setattr not supported on your arch
> mount_setattr02.c:52: TWARN: rmdir(/DIRA_PROPAGATION_CHECK) failed: EBUSY (16)
> 
> 
> > +	SAFE_RMDIR(DIRA);
> 
> When running on old kernel (e.g. SLES based 4.12) it fails due TCONF:
> 
> ../../../../include/lapi/fsmount.h:197: TCONF: Test not supported on kernel version < v5.2
> mount_setattr02.c:52: TWARN: rmdir(/DIRA_PROPAGATION_CHECK) failed: ENOENT (2)
> 
> There should be a flag to remove dir only when it was created.
> 
> > +
> nit: please remove this new line (I have to keep asking this :( ).
Sorry, i need pay attention, thanks for point this out with great patient :).
> > +}
> > +
> > +static void setup(void)
> > +{
> > +	fsopen_supported_by_kernel();
> I wonder if this needed for detecting new mount API support. Because second
> SAFE_MOUNT also runs code which detects code unsupported:
> 
> ../../../../include/lapi/fsmount.h:113: TCONF: syscall(442) __NR_mount_setattr not supported on your arch
> mount_setattr02.c:52: TWARN: rmdir(/DIRA_PROPAGATION_CHECK) failed: EBUSY (16)
> 
> But I have no idea what would be needed to be done to cleanup result of the
> first SAFE_MOUNT().
> 
> > +
> > +	SAFE_MKDIR(DIRA, 0777);
> > +}
> > +
> > +static void run(void)
> > +{
> > +
> and here new line.
> > +	SAFE_UNSHARE(CLONE_NEWNS);
> > +	SAFE_MOUNT(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> > +	SAFE_MOUNT("testing", DIRA, "tmpfs", MS_NOATIME | MS_NODEV, "");
> Do these 2 needs to be in the run()? How about move them to setup()?
> 
> static int dir_created, mounted;
> 
> static void setup(void)
> {
> 	fsopen_supported_by_kernel();
> 
> 	SAFE_MKDIR(DIRA, 0777);
> 	dir_created = 1;
> 	SAFE_UNSHARE(CLONE_NEWNS);
> 	SAFE_MOUNT(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> 	SAFE_MOUNT("testing", DIRA, "tmpfs", MS_NOATIME | MS_NODEV, "");
> 	mounted = 1;
> }
> 
> static void cleanup(void)
> {
> 	if (mounted)
> 		SAFE_UMOUNT(DIRA);
> 
> 	if (dir_created)
> 		SAFE_RMDIR(DIRA);
> }
> 
> + I later create generic helper from is_shared_mount().
I sent v2 patch now, once your create generic helper i can do another patch together with
your generic helper.
> 
> Kind regards,
> Petr
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
