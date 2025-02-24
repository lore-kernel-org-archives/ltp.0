Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9C0EC021B2
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 01:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740361515; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Yq4ipZzbDTMUKyzdnJ9urd/tiCe8nQUfDACRbLtQXL0=;
 b=qZPDxjx/PvIq2rBSa5bf8SIbL+qq+6HbDovLPxw6HlTdEA6ETYQpzRfmcrqxvk07bev/o
 +w/3sMXpKPfdzoDR+OMf0nZHvzDrZFhVw7KaLDQGqXXgntMdB2N8l0MwiQnX2+LjMg4Xzhx
 qS/DIDJQuCD73HPZmyaWMk+wRfiRovw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D6F63C7B2B
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 02:45:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 51AF33C2365
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 02:44:52 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2C9DF1BC4FAC
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 02:44:51 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43989226283so25826535e9.1
 for <ltp@lists.linux.it>; Sun, 23 Feb 2025 17:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740361490; x=1740966290; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FaNdergxpXgHc7FEp+Cm3uCHHomUdxbf+4L0DBuKrmc=;
 b=UbKayZ0lp/hfDGWFEfj8ttKh8UjuZn9RI8HNvlbmWOotzN5a6rxkovWIVGckTNGb8M
 uNecu13ibJAUWmQpZQh91x9Ys/3RHkfJIv1y0x8K5fwhWTtQuwi1Q2VjfIJhEmHldaYp
 mxcc23DBR36PLydmCfVdx/K7k52dXfUpszHwKQWVVxX9AodxpNqUHDQSRpDFUzDPwsVR
 1/U9FpwwBo1TnSTfOxtQS8gCnS2hOs91P5aohxnoz70P68N3TwKP/3qudGvi84/DtvYm
 e85P0OUhXmanvfIlo4RnzFud43c81t3nhXEqgDUD+CIM07TAyWwcOBBy9qaLE8apW75r
 4Itg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740361490; x=1740966290;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FaNdergxpXgHc7FEp+Cm3uCHHomUdxbf+4L0DBuKrmc=;
 b=GsJOh4uCgrwh2tWAWb0jSybFjmWaMbTncHBzLTYmZKdizdVLayXl+AsT+mFZVgxRiC
 mFI9s7XNyCy71/zcIfqgAE3qovMhbTOVO9TdjlQdGQ3phntd74Ee3ZRfCEkun8L4VlzY
 bcdP30f+jexaHjBVidQOFNh/4ePuJv7BW7Rn0UuLEnB5mDXfP4cmNGXra7GY9+EdagIE
 ZC4rTEresDIeyJQ8YSFTcgjag8ZkS93+DvLA+NdwHquo3yAx9CPSWM5PKEAOBLCMhLdy
 ig1HdXJE8LmVbQm2KEdqR7nbdNiltFLF6wq15tUkOKOVy+dBafZTMHLpq4DneBbe4o0O
 s2tg==
X-Gm-Message-State: AOJu0YxVFmYmd9aW6C69AA47VyP/mGs4MXb3pQuJL0PeEGZO5JYCWrE+
 tbBOecmlSq9O7YWRhYgCLQFCODSIAl2C4PtbezlPYvjA2RSmqcf8rylYSttpsg==
X-Gm-Gg: ASbGncvvRMjXOW1L6Gg1jAcMtv95yec1Xnqj3S8sQzInSfojehI27Ju6jtlDxhO9s/m
 0mTydFiChm/96XYaUWRgEscIRXEsdzl4znGvd3aeqTE3mhjx2Kl+s2FkBREOSaTn6Ymd9a2AFDp
 /5ukgYg8giI5G3TeO0YR31RA1JkUywcElCoyJiEycQrki4PzJ/rxyuW8FC2y0x/kKCepbteMCN3
 01DSxTz3+5shTGSxIubxg247R3YHzj3d9qMZd0Uc16YUXIW8xb7IkH2qdOhBJWgYDNse1YBG6eB
 zaaMjNoF/UIJ0ePLxDg6
X-Google-Smtp-Source: AGHT+IEYPRJj2tnYCVnPy7ntdDA/0a+c+x7B4jvnzZq7sPOxiRXglz3tFP4moSXpFlUDMWOb2K6mEQ==
X-Received: by 2002:a05:600c:1e23:b0:439:987c:2309 with SMTP id
 5b1f17b1804b1-439ae221d7dmr87336345e9.27.1740361490544; 
 Sun, 23 Feb 2025 17:44:50 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-439b0367507sm92688895e9.28.2025.02.23.17.44.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Feb 2025 17:44:50 -0800 (PST)
Date: Sun, 23 Feb 2025 20:44:44 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z7vPDGJbgSNmIhd0@wegao>
References: <20250217020423.31602-1-wegao@suse.com>
 <20250219082954.23552-1-wegao@suse.com>
 <20250221125458.GA2784225@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250221125458.GA2784225@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mount_setattr02.c: Check mount_setattr
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

On Fri, Feb 21, 2025 at 01:54:58PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> nit: You did not change commit message subject (we talked about it).
Oh, if you check time of message, i sent v2 patch before we talked about this :)
> 
> > --- /dev/null
> > +++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
> > @@ -0,0 +1,103 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (C) 2025 SUSE LLC Wei Gao <wegao@suse.com>
> > + */
> > +
> > +/*\
> > + * [Description]
> NOTE: this '[Description]' should no longer be added.
> 
> See:
> https://github.com/linux-test-project/ltp/commit/a3e27df34d6cb49477c9bd6f9bbaa1ce4de155f9
> (it updated also examples in doc)
> 
> and follow ups
> https://github.com/linux-test-project/ltp/commit/63eceaa2a83bca41997edcd649eb62272622a100
> https://github.com/linux-test-project/ltp/commit/824f66ca72fc7505a31c30792334905b646c9d37
Got it, thanks your information.
> > + *
> > + * Basic mount_setattr() test.
> nit: here is better a blank line.
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
> Also, I found a way to test into TMPDIR. There is no need to touch a real root.
> It works even on separate /tmp.
> 
> If you agree, I merge with following diff.
> https://github.com/pevik/ltp/blob/wei/mount_setattr02.v2.fixes/testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
I agree. Great!
> 
> With changes below.
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr
> 
> +++ testcases/kernel/syscalls/mount_setattr/mount_setattr02.c
> @@ -4,9 +4,8 @@
>   */
>  
>  /*\
> - * [Description]
> - *
>   * Basic mount_setattr() test.
> + *
>   * Test basic propagation mount attributes are set correctly.
>   */
>  
> @@ -17,9 +16,9 @@
>  #include "lapi/fsmount.h"
>  #include "tst_safe_stdio.h"
>  
> -#define DIRA "/DIRA_PROPAGATION_CHECK"
> +static char *tmpdir;
>  
> -static int dir_created, mounted;
> +static int mounted;
>  
>  static bool is_shared_mount(const char *path)
>  {
> @@ -52,19 +51,15 @@ static bool is_shared_mount(const char *path)
>  static void cleanup(void)
>  {
>  	if (mounted)
> -		SAFE_UMOUNT(DIRA);
> -
> -	if (dir_created)
> -		SAFE_RMDIR(DIRA);
> +		SAFE_UMOUNT(tmpdir);
>  }
>  
>  static void setup(void)
>  {
> -	SAFE_MKDIR(DIRA, 0777);
> +	tmpdir = tst_tmpdir_path();
>  	SAFE_UNSHARE(CLONE_NEWNS);
> -	dir_created = 1;
>  	SAFE_MOUNT(NULL, "/", NULL, MS_REC | MS_PRIVATE, 0);
> -	SAFE_MOUNT("testing", DIRA, "tmpfs", MS_NOATIME | MS_NODEV, "");
> +	SAFE_MOUNT("testing", tmpdir, "tmpfs", MS_NOATIME | MS_NODEV, "");
>  	mounted = 1;
>  }
>  
> @@ -75,24 +70,24 @@ static void run(void)
>  		.attr_clr       = MOUNT_ATTR__ATIME,
>  	};
>  
> -	TST_EXP_PASS_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)));
> -	TST_EXP_EQ_LI(is_shared_mount(DIRA), 0);
> +	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
> +	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 0);
>  
>  	attr.propagation = -1;
> -	TST_EXP_FAIL_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)), EINVAL);
> -	TST_EXP_EQ_LI(is_shared_mount(DIRA), 0);
> +	TST_EXP_FAIL_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)), EINVAL);
> +	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 0);
>  
>  	attr.propagation = MS_SHARED;
> -	TST_EXP_PASS_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)));
> -	TST_EXP_EQ_LI(is_shared_mount(DIRA), 1);
> +	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
> +	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 1);
>  
>  	attr.propagation = MS_PRIVATE;
> -	TST_EXP_PASS_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)));
> -	TST_EXP_EQ_LI(is_shared_mount(DIRA), 0);
> +	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
> +	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 0);
>  
>  	attr.propagation = MS_SLAVE;
> -	TST_EXP_PASS_SILENT(mount_setattr(-1, DIRA, 0, &attr, sizeof(attr)));
> -	TST_EXP_EQ_LI(is_shared_mount(DIRA), 0);
> +	TST_EXP_PASS_SILENT(mount_setattr(-1, tmpdir, 0, &attr, sizeof(attr)));
> +	TST_EXP_EQ_LI(is_shared_mount(tmpdir), 0);
>  }
>  
>  static struct tst_test test = {
> @@ -100,4 +95,5 @@ static struct tst_test test = {
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.needs_root = 1,
> +	.needs_tmpdir = 1,
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
