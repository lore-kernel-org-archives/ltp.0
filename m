Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11626CA0FF6
	for <ltp@archiver.kernel.org>; Thu, 28 Aug 2025 23:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756422555; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=E90YWZUgdwFIbaHuYExCxrWMW19UZ4Bz5rHNrowg7d4=;
 b=Dh1sTJlw2p0jnS484hj4Esp1sizB9vYHI/FXCWYDxma70s9PrBGzZAY4UMhHLORrYhL36
 ht1BRuk9mOdGwaRG9a80uBtzJ+PBoOI1tVbfUG+GgHP4TU9lblNsw+aWN05BBQjAxvi8L43
 rr4GJsihgnhdrMW1Vxuyti8taMUyUKA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7312E3CD060
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 01:09:15 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 273C43CC7E8
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 01:08:53 +0200 (CEST)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9D22E2005E6
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 01:08:51 +0200 (CEST)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-aff0365277aso9452966b.1
 for <ltp@lists.linux.it>; Thu, 28 Aug 2025 16:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756422531; x=1757027331; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Z+AVLaF93vnaOdG+jfBn01IQypoUh2SX9ycHu6PeWSM=;
 b=FOI4H+OrG2NbJSOZzAWdACOiML+1siTgLLoghXkRPN0JOonqOMqmgE+H2CvMuMGXd6
 yB6lRITakY8vhaFJviG5jdj4BlIDf1cvhReWPGFj6U6HEkNojjaKUXHDZH0xliR18PAi
 iObZ1U/65hBG7qhP3XKUxauYzWpqLy4knxUNPKm+xLLXIYpW+bkbgPRo9Oe4r7U9OEgC
 1YA7smIMKAz0AfIER9mY3hZSk06I5cMz0fs3yXiPhAIkoJqyiaJSuNowLqLKT1Zfl0hv
 lSmrWk4qBvaZKhD4kOYNsC2N7WFEdQmHbUuvTGXARU2XlGmUWD1q2LO+KPGFt0uKnK34
 y96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756422531; x=1757027331;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z+AVLaF93vnaOdG+jfBn01IQypoUh2SX9ycHu6PeWSM=;
 b=hxw9pdgfx9gAmBh52g5AVSnmmTsRMQ2AbyFeTC0lEJD7zRdw0zBmyb9xxg9tHNeVa0
 zMOLutKPrJwgGJVoR2RL4sVKQ/Q4FgVynIdE9D2u+YgysPU4G+uH6+V7QZ+e8T3lY1Vx
 8d8lWKWfCbYKkYbGR+PAJkj5zaD9s6lzjKs2CZbd7m9Uio5wFHa9+8bTPee7nHW3GKyL
 Vexhqybd0oJB+PST2gkBIE3m7rPveAKeSm4SFi0kBG3G0xG3jfPr/x0fzLqVT4aNbSwD
 7bgBjJUWWHANtYikjZNAulSVN1o2NGzEep/8boLAsyZxcSx5TRax4bN8JE0VYbHDwktU
 Fzwg==
X-Gm-Message-State: AOJu0Yxx6NYS6eSuXXkJzIAGF9hq9+JVgUZx14zYX5tqrEanNxXZKJtZ
 tkg7SNcm6EpZE/XyDvNkYzBE8FKKb3JsVNs1F/aa2avk79WmHkpKBn/zKqIDoRid0z72cQM2tCV
 ZTVY=
X-Gm-Gg: ASbGncuYpiUltpTiVfAA8NzuOaaPodUh3svT7X0iCiDiP6CLXn45/3OJTTsUOg0Prrf
 k3ELp3HtHgCS2HGlyqTLzGt5z33t4t0BnapOefVuTZWAKdVMur/Yc7yrRQpUqtFa7/RuQ1irsCZ
 vAO8QwwLK4Ub8K0BUI34SvjcwxAUsUDJrYiEyPK+dnTYQPLWZB4mAeOcuxQRMQGTIjqm/uALOxb
 wtlSJ4jwl0GcS9x5w+KsAM6fYK1VHnuc+vDjScAIMQOo3SKvk0HH+ZTxBrZhh7SjEKdckYlEfxT
 xF3Q1F0J5TugvI4Qgl6mgrMsak3EjPNeqlIMu+BTSTsi1WDnT+YSb3SgiKlNlGNqX1wxbpMgh47
 TCuythr0wAS7bbKYZTPePVFQ0ykl1WQrbDf9VY3Q8O3U/dPiLdRUj6g==
X-Google-Smtp-Source: AGHT+IEa/qhsKyFiXQ+5AIItafOgZANenav99aAgLllRL/5danz3QFaXgwYB1qzz82WXg75Wpk4VTg==
X-Received: by 2002:a17:906:7311:b0:afe:8bd8:e2c3 with SMTP id
 a640c23a62f3a-afeafec8398mr1127831666b.0.1756422530923; 
 Thu, 28 Aug 2025 16:08:50 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afefc7edf5bsm59656466b.10.2025.08.28.16.08.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 16:08:50 -0700 (PDT)
Date: Thu, 28 Aug 2025 23:08:48 +0000
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aLDhgFRA8ppAmYlH@localhost>
References: <20250828-open_tree_attr-v1-0-f339a0e51e22@suse.com>
 <20250828-open_tree_attr-v1-2-f339a0e51e22@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250828-open_tree_attr-v1-2-f339a0e51e22@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] mount_setattr01: add open_tree_attr variant
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

On Thu, Aug 28, 2025 at 03:11:25PM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> This patch simply introduces a new variant to the mount_setattr01
> test, in order to verify that open_tree_attr() works correctly.
> The open_tree_attr() syscall has been introduced in the kernel v6.15 by
> commit "c4a16820d901 - fs: add open_tree_attr()".
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  .../syscalls/mount_setattr/mount_setattr01.c       | 69 ++++++++++++++++------
>  1 file changed, 52 insertions(+), 17 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
> index eb32cd91a7fcb4cb303e184dd40d5e10a280874c..bede26318a6985339b5b4bbb2db4a91744110eda 100644
> --- a/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
> +++ b/testcases/kernel/syscalls/mount_setattr/mount_setattr01.c
> @@ -3,10 +3,11 @@
>   * Copyright (c) 2022 FUJITSU LIMITED. All rights reserved.
>   * Author: Dai Shili <daisl.fnst@fujitsu.com>
>   * Author: Chen Hanxiao <chenhx.fnst@fujitsu.com>
> + * Copyright (C) 2025 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
>   */
>  
>  /*\
> - * Basic mount_setattr() test.
> + * Basic mount_setattr()/open_tree_attr() test.
>   * Test whether the basic mount attributes are set correctly.
>   *
>   * Verify some MOUNT_SETATTR(2) attributes:
> @@ -22,7 +23,8 @@
>   * - MOUNT_ATTR_NODIRATIME - prevents updating access time for
>   *   directories on this mount
>   *
> - * The functionality was added in v5.12.
> + * The mount_setattr functionality was added in v5.12, while the open_tree_attr
> + * functionality was added in v6.15.
>   */
>  
>  #define _GNU_SOURCE
> @@ -41,6 +43,7 @@
>  	}
>  
>  static int mount_flag, otfd = -1;
> +struct mount_attr *attr;
>  
>  static struct tcase {
>  	char *name;
> @@ -66,35 +69,59 @@ static void cleanup(void)
>  static void setup(void)
>  {
>  	fsopen_supported_by_kernel();
> -	struct stat st = {0};
>  
> -	if (stat(OT_MNTPOINT, &st) == -1)
> +	if (access(OT_MNTPOINT, F_OK) != 0)
>  		SAFE_MKDIR(OT_MNTPOINT, 0777);
>  }
>  
> +static int open_tree_variant1(struct mount_attr *attr)
> +{
> +	tst_res(TINFO, "Variant using open_tree() + mount_setattr()");
> +
> +	otfd = TST_EXP_FD(open_tree(AT_FDCWD, MNTPOINT,
> +			AT_EMPTY_PATH | OPEN_TREE_CLONE));
> +	if (otfd == -1)
> +		return -1;
> +
> +	TST_EXP_PASS(mount_setattr(otfd, "", AT_EMPTY_PATH,
> +			attr, sizeof(*attr)));
Duplicate mount_setattr? There is another mount_setattr after this
called.
> +	if (TST_RET == -1)
> +		return -1;
> +
> +	return otfd;
> +}
> +
> +static int open_tree_variant2(struct mount_attr *attr)
> +{
> +	tst_res(TINFO, "Variant using open_tree_attr()");
> +
> +	otfd = TST_EXP_FD(open_tree_attr(AT_FDCWD, MNTPOINT,
> +			AT_EMPTY_PATH | OPEN_TREE_CLONE,
> +			attr, sizeof(*attr)));
> +
> +	return otfd;
> +}
> +
>  static void run(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];
> -	struct mount_attr attr = {
> -		.attr_set = tc->mount_attrs,
> -	};
>  	struct statvfs buf;
>  
> -	TST_EXP_FD_SILENT(open_tree(AT_FDCWD, MNTPOINT, AT_EMPTY_PATH |
> -		AT_SYMLINK_NOFOLLOW | OPEN_TREE_CLOEXEC | OPEN_TREE_CLONE));
> -	if (!TST_PASS)
> -		return;
> +	memset(attr, 0, sizeof(*attr));
> +	attr->attr_set = tc->mount_attrs;
>  
> -	otfd = (int)TST_RET;
> +	if (tst_variant)
> +		otfd = open_tree_variant1(attr);
> +	else
> +		otfd = open_tree_variant2(attr);
I am not sure this is perfect way loop the function, add function point into struct tcase
is better in my opinion.
>  
> -	TST_EXP_PASS_SILENT(mount_setattr(otfd, "", AT_EMPTY_PATH, &attr, sizeof(attr)),
> -		"%s set", tc->name);
> -	if (!TST_PASS)
> -		goto out1;
> +	if (otfd == -1)
> +		goto out2;
>  
>  	TST_EXP_PASS_SILENT(move_mount(otfd, "", AT_FDCWD, OT_MNTPOINT, MOVE_MOUNT_F_EMPTY_PATH));
I suppose we can also check mounts option take effect or not like:
https://patchwork.ozlabs.org/project/ltp/patch/20250828225157.982-1-wegao@suse.com/
>  	if (!TST_PASS)
>  		goto out1;
> +
>  	mount_flag = 1;
>  	SAFE_CLOSE(otfd);
>  
> @@ -123,9 +150,17 @@ static struct tst_test test = {
>  	.test = run,
>  	.setup = setup,
>  	.cleanup = cleanup,
> +	.test_variants = 2,
>  	.needs_root = 1,
>  	.mount_device = 1,
>  	.mntpoint = MNTPOINT,
>  	.all_filesystems = 1,
> -	.skip_filesystems = (const char *const []){"fuse", NULL},
> +	.skip_filesystems = (const char *const []) {
> +		"fuse",
> +		NULL
> +	},
> +	.bufs = (struct tst_buffers []) {
> +		{&attr, .size = sizeof(struct mount_attr)},
> +		{}
> +	}
>  };
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
