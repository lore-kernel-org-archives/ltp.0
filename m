Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ACA6C8303D
	for <ltp@archiver.kernel.org>; Wed,  2 Jul 2025 01:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1751419158; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=pc1m3VtbdeDm2e0JUNFdJG/qW4UwvdMgJ2tIJtMHDl8=;
 b=ZcgrvvCcPoHKBNEqT+CLZTccEkmx5yLe7btEwlzexx7nmiRQDgOw9w3Tr8hUIK24ok84K
 VEjfEKIRyA0ZNUCDG6oxbI6w/Pnp6rX2tBai5NIPaN0VWrlpo1pDjqJahs75t14hj6lICoG
 c5Q+rybqj9A2HSd6KeTkvV3qDT2sYdk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB6333C8613
	for <ltp@archiver.kernel.org>; Wed,  2 Jul 2025 03:19:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2DDC33C6B80
 for <ltp@lists.linux.it>; Wed,  2 Jul 2025 03:18:57 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id ED84D1400B6A
 for <ltp@lists.linux.it>; Wed,  2 Jul 2025 03:18:55 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a548a73ff2so5598137f8f.0
 for <ltp@lists.linux.it>; Tue, 01 Jul 2025 18:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1751419135; x=1752023935; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=FH7nIEyhivxvhCqJUs5lcdZf1OE2GQ3Q4WG9TZDZvg4=;
 b=cLkOuswhIJMW2d1+QhlGx/hnLzZJy28G8mGo3EBLtlOUE2UYzS5uM6/tbKFDwHGG7O
 XYFhJR2efcdn5KzeKsMI+wO7vx8455YLdaiGT0hHFNUoojVSArPbJcHRuyJHBcf/MNWL
 IVFHkhBRFUH/4iyysShweA7aQ17gao2FaJdiKxGXC2wk2x2PM23juUHU+qWWI92kQqs3
 OblTt/dvMfSwU9DBsFh8f3LzFN9d6nnBiN1Mgj4ajPzk4i1lFqSiLgMR+y5c5RSdnWxw
 BHmhqjP8VKk3HmIPbqf9y51RsInZD/wR18hnkiD7dkP2gDQtlN67WCUH+NnnU5H24qJe
 /xmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751419135; x=1752023935;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FH7nIEyhivxvhCqJUs5lcdZf1OE2GQ3Q4WG9TZDZvg4=;
 b=JWjzpueW6/vQwPi+UxSuFEp13QZyC62HFqyoWNSAo8wkjx7rNXmiIBVKuxLuLoHtFp
 MLTHwKupjon7wntD3bcpirTZ8zzLgOxtm68SDz2Bo/dosVxnMmlLhV/UyS4YyY5ZZZTi
 I2Q86TlzPCjsD0VwhTZrj3K0GCzGbTpbNKu8h6SUVHrI1F1TjrnCZLckK7bej51Q+Oao
 z1+Sc5w9B+UbJyafrA9QOB2MMqC8L35qSOpoRsJMw9pO4oPtORNduphy1rL8NJf4zoTu
 +qSekgwBIcJhcb6hFYSSTPasUXG96hHxCqMgsdl+JV7KrNujx766ecrZYuJoPVm7CMv/
 11EQ==
X-Gm-Message-State: AOJu0YxtDl3B8q1y9XyQMvhK9k6xq+/0bIjiBBQ0e5Nlmk5tMPEnzyfs
 W+fld3lep2GSELHdX9C+NFA0eZKsaMlYqDqd7tzMh+uCuoxQmbLAuleFREe4cwU6zw==
X-Gm-Gg: ASbGnctcV/5aUSHKuR0PhUwXduuiQ8U4viiOHBVeHFEZMrjsYRYfk5lTG4UTSByRR23
 4I8FLg+CHR5p+lcRbMZRSqwsnQn8E5/J6Myp9UQHKx58JVrGO2cGZN2aKfsNHC8opuBEEDBCQH7
 lZSNMQVGflmkzn7VKrxQoHrvBe7dCpmNYGXkIHVzGyZukpY3TmNvVvvN0PCpM0ND6x911jSU9db
 7l3s4QDFPWTe3hmIQ4ATj2BJDE8ihkniJhcDu6iBPO5xOAF8XNpa9KBmRS0fcSFEbpT0irIGH5H
 wlWXGPqkD/G1HZCIiwZ8ttDJ+oQDX1MY0IE+3Ys2fjzVkp0+MOjgkFsfTjHMYQ==
X-Google-Smtp-Source: AGHT+IHyQ+Psj/Cyov8ueLCLUt+meTeMuWQqxVA7fXbarREgUKpTMWZXur4FhijxbLGQm3xyOPkDFg==
X-Received: by 2002:a05:6000:43d4:20b0:3a4:d722:5278 with SMTP id
 ffacd0b85a97d-3b20067a807mr253655f8f.39.1751419135205; 
 Tue, 01 Jul 2025 18:18:55 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74af55c5f38sm13262861b3a.108.2025.07.01.18.18.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Jul 2025 18:18:54 -0700 (PDT)
Date: Wed, 2 Jul 2025 09:18:19 -0400
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aGUxm-Sgsi7U8NWA@MiWiFi-CR6608-srv>
References: <20250630153205.19017-1-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250630153205.19017-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] lib: Add is_fuse flag to SAFE_MOUNT() and
 tst_device
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

On Mon, Jun 30, 2025 at 05:32:04PM +0200, Cyril Hrubis wrote:
> This allows us to adjust tests that need different expectations on FUSE
> based filesystems.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
Very nit: Reported-by: Jan Polensky <japo@linux.ibm.com>
Is there any issue link can be provide? 
> ---
>  include/old/safe_macros.h |  2 +-
>  include/safe_macros_fn.h  |  2 +-
>  include/tst_device.h      |  2 ++
>  include/tst_safe_macros.h |  7 ++++++-
>  lib/safe_macros.c         | 10 ++++++++--
>  lib/tst_test.c            |  4 ++--
>  6 files changed, 20 insertions(+), 7 deletions(-)
> 
> diff --git a/include/old/safe_macros.h b/include/old/safe_macros.h
> index fb1d7a110..307843ab0 100644
> --- a/include/old/safe_macros.h
> +++ b/include/old/safe_macros.h
> @@ -150,7 +150,7 @@
>  #define SAFE_MOUNT(cleanup_fn, source, target, filesystemtype, \
>  		   mountflags, data) \
>  	safe_mount(__FILE__, __LINE__, (cleanup_fn), (source), (target), \
> -		   (filesystemtype), (mountflags), (data))
> +		   (filesystemtype), (mountflags), (data), NULL)
>  
>  #define SAFE_UMOUNT(cleanup_fn, target) \
>  	safe_umount(__FILE__, __LINE__, (cleanup_fn), (target))
> diff --git a/include/safe_macros_fn.h b/include/safe_macros_fn.h
> index d256091b7..b4be482c1 100644
> --- a/include/safe_macros_fn.h
> +++ b/include/safe_macros_fn.h
> @@ -172,7 +172,7 @@ int safe_rename(const char *file, const int lineno, void (*cleanup_fn)(void),
>  int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
>  	       const char *source, const char *target,
>  	       const char *filesystemtype, unsigned long mountflags,
> -	       const void *data);
> +	       const void *data, int *is_fuse);
>  
>  int safe_umount(const char *file, const int lineno, void (*cleanup_fn)(void),
>  		const char *target);
> diff --git a/include/tst_device.h b/include/tst_device.h
> index 2597fb4e2..9ca802735 100644
> --- a/include/tst_device.h
> +++ b/include/tst_device.h
> @@ -15,6 +15,8 @@ struct tst_device {
>  	const char *dev;
>  	const char *fs_type;
>  	uint64_t size;
> +	/* If device was mounted by the test library this flag is set for fuse fileystems. */
> +	int is_fuse;
>  };
>  
>  /*
> diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> index 19504beb5..6d53c0bbc 100644
> --- a/include/tst_safe_macros.h
> +++ b/include/tst_safe_macros.h
> @@ -241,7 +241,12 @@ int safe_getgroups(const char *file, const int lineno, int size, gid_t list[]);
>  #define SAFE_MOUNT(source, target, filesystemtype, \
>  		   mountflags, data) \
>  	safe_mount(__FILE__, __LINE__, NULL, (source), (target), \
> -		   (filesystemtype), (mountflags), (data))
> +		   (filesystemtype), (mountflags), (data), NULL)
> +
> +#define SAFE_MOUNT2(source, target, filesystemtype, \
> +		    mountflags, data, is_fuse) \
> +	safe_mount(__FILE__, __LINE__, NULL, (source), (target), \
> +		   (filesystemtype), (mountflags), (data), (is_fuse))
>  
>  #define SAFE_UMOUNT(target) \
>  	safe_umount(__FILE__, __LINE__, NULL, (target))
> diff --git a/lib/safe_macros.c b/lib/safe_macros.c
> index 726c9ae8e..6d267522f 100644
> --- a/lib/safe_macros.c
> +++ b/lib/safe_macros.c
> @@ -907,11 +907,14 @@ static int possibly_fuse(const char *fs_type)
>  int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
>  	       const char *source, const char *target,
>  	       const char *filesystemtype, unsigned long mountflags,
> -	       const void *data)
> +	       const void *data, int *is_fuse)
>  {
>  	int rval = -1;
>  	char mpath[PATH_MAX];
>  
> +	if (is_fuse)
> +		*is_fuse = 0;
> +
>  	if (realpath(target, mpath)) {
>  		tst_resm_(file, lineno, TINFO,
>  			"Mounting %s to %s fstyp=%s flags=%lx",
> @@ -957,8 +960,11 @@ int safe_mount(const char *file, const int lineno, void (*cleanup_fn)(void),
>  			filesystemtype, mount_ro, source, target);
>  
>  		rval = tst_system(buf);
> -		if (WIFEXITED(rval) && WEXITSTATUS(rval) == 0)
> +		if (WIFEXITED(rval) && WEXITSTATUS(rval) == 0) {
> +			if (is_fuse)
> +				*is_fuse = 1;
>  			return 0;
> +		}
>  
>  		tst_brkm_(file, lineno, TBROK, cleanup_fn,
>  			"mount.%s failed with %i", filesystemtype, rval);
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 17ce91932..2130e4be8 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1273,8 +1273,8 @@ static void prepare_device(struct tst_fs *fs)
>  		mnt_data = limit_tmpfs_mount_size(fs->mnt_data,
>  				buf, sizeof(buf), tdev.fs_type);
>  
> -		SAFE_MOUNT(get_device_name(tdev.fs_type), tst_test->mntpoint,
> -				tdev.fs_type, fs->mnt_flags, mnt_data);
> +		SAFE_MOUNT2(get_device_name(tdev.fs_type), tst_test->mntpoint,
> +				tdev.fs_type, fs->mnt_flags, mnt_data, &tdev.is_fuse);
>  		context->mntpoint_mounted = 1;
>  	}
>  }
> -- 
> 2.49.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
