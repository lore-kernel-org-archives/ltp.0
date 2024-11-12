Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39652D41D68
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 08:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1731400004; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=5tPJXa2Ir8dJuLwaDJ6C4wxXJSSUl6BMmGXJJZSUc8M=;
 b=Worr+BbixrI+uYuCbEXgV9rel5WVxDbfr1HB4/EuxVYzvgMuAFi1DsbJcptvSU5f7zysL
 Kd7UFZ/fvssPoOrXfFA4FRr2ZU8qWYUUyHtOkfMzSbnShm2+gdImN3xTmOALqsNaH4hAjVj
 uIS1zvvM66y/BS0jZjR9N+dBfPl6GTU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 70BA73D5A9F
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 09:26:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 200843D5A0C
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 09:26:24 +0100 (CET)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 734EF20B0E0
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 09:26:22 +0100 (CET)
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-539d9fffea1so5357905e87.2
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 00:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1731399982; x=1732004782; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Gm6gMykRDoeX5Qhk7sBUxdhp62PFsYpuahg2wSXlLIU=;
 b=J0tl+oTJBRGdf7PNsz+AM73sOc5fE3BAeLlPt3up2jLWpfLBenYh5st8mZIk0rUpKL
 u/SprlO9sfxgDckMnoHRS3PTne/sheSXXXSJOmsFk6pWrrXz51qQlsEFDAyRMxgqLUGs
 UbWNw8+vKhCLZCiqpeU56AuWjojeqBJg2+GDlFpEQB7urvQqFVhbqr5g8SKeTswa3/4S
 wPPzYuhqzkBLLoAw20DR/QuRqvIWqcJVzlCLGE5vE8TvJwKGp673RATZLeu+wbwh9mlS
 DTMzifvQjGZKPPmvAiXB52n9Ny2PiIIyB4Aa1I8VivPjyuZZwm9Hg4GwvAK4zjMIn7Bw
 bGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731399982; x=1732004782;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gm6gMykRDoeX5Qhk7sBUxdhp62PFsYpuahg2wSXlLIU=;
 b=Ri+EQN4GlxvJkkOuolS4yi4DUGjFf2KAiGzGMpcu+xssvEWrLeEY2iPNbPrc2O1e2M
 qgVhMIUQ7E9Wx0nA9n8vDpy03Q6GU1KOfft2NXG276Lo0cJLmUFDlY+MWu70cezYeStK
 Q03WLhlCj5W7E7CUOeUdmWyB7SLvXZ8jjNwR2Odz4UcgnH9WhR24pziBxReq9Uxi5XTr
 rcz8GAyqeGMssGYXSnnDrAuXyHaOO5H7kaUwEuAiXkKVMCz8towhgKFuEGL5Wr7c7x5m
 83V11rd53BeheUyU1Y1/S2eqxDVnUo5J335sHAB4GmYXmX71BlyfHArENWSjjxp20d7T
 DkQw==
X-Gm-Message-State: AOJu0YxHdqvftlUUzlmJRTh3tlU0D3iPEBN/F3e2EOF/kw+36RD3aSUf
 OZHjSBvI9cpBGWDWS8GRzOVtBDjfcCNXwPyjuLPZM5BSL3zzsx+M5rptATOdyw==
X-Google-Smtp-Source: AGHT+IHVSRlnDnfmiyvD09FpiSe5SVkdKn4asrbySpExaCi7kzcOZhwT9lrTvMadnV/VVKV/5cZkvA==
X-Received: by 2002:a05:6512:3403:b0:53b:2114:92a7 with SMTP id
 2adb3069b0e04-53d862f359cmr7701122e87.52.1731399981537; 
 Tue, 12 Nov 2024 00:26:21 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f41f65ba92sm9869614a12.80.2024.11.12.00.26.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 00:26:21 -0800 (PST)
Date: Tue, 12 Nov 2024 03:26:17 -0500
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZzMRKZdtyIbsy0cN@wegao>
References: <20241112-lsm-v1-0-e293a8d99cf6@suse.com>
 <20241112-lsm-v1-1-e293a8d99cf6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241112-lsm-v1-1-e293a8d99cf6@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/7] Add fallback definitions of LSM syscalls
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

On Tue, Nov 12, 2024 at 08:15:32AM +0100, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> Fallback definition for the following syscalls:
> 
> - lsm_get_self_attr
> - lsm_set_self_attr
> - lsm_list_modules
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  configure.ac       |   3 +-
>  include/lapi/lsm.h | 172 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 174 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index 6992d75ca300ccc4cc21a45a916f6b3be1a3b8fe..99c00d1b9b4cda48cb0ce07af03b97855dcdfd36 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -62,6 +62,7 @@ AC_CHECK_HEADERS_ONCE([ \
>      linux/ioprio.h \
>      linux/keyctl.h \
>      linux/landlock.h \
> +    linux/lsm.h \
>      linux/mempolicy.h \
>      linux/module.h \
>      linux/mount.h \
> @@ -196,7 +197,7 @@ AC_CHECK_TYPES([struct ipc64_perm],,,[#include <sys/ipcbuf.h>])
>  AC_CHECK_TYPES([struct loop_config],,,[#include <linux/loop.h>])
>  AC_CHECK_TYPES([struct landlock_path_beneath_attr],,,[#include <linux/landlock.h>])
>  AC_CHECK_TYPES([struct landlock_net_port_attr],,,[#include <linux/landlock.h>])
> -
> +AC_CHECK_TYPES([struct lsm_ctx],,,[#include <linux/lsm.h>])
>  AC_CHECK_TYPES([struct mmsghdr],,,[
>  #define _GNU_SOURCE
>  #include <sys/types.h>
> diff --git a/include/lapi/lsm.h b/include/lapi/lsm.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..a37ed0175289c420040ea744e4eaa524d17cbe7d
> --- /dev/null
> +++ b/include/lapi/lsm.h
> @@ -0,0 +1,172 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2024 SUSE LLC Andrea Cervesato <andrea.cervesato@suse.com>
> + */
> +
> +#ifndef LAPI_LSM_H__
> +#define LAPI_LSM_H__
> +
> +#include "config.h"
> +
> +#ifdef HAVE_LINUX_LSM_H
> +#include <linux/lsm.h>
> +#endif
I guess s/#endif/#else ?
> +
> +#include <stdint.h>
> +#include "lapi/syscalls.h"
> +
> +#ifndef HAVE_STRUCT_LSM_CTX
> +
> +/**
> + * struct lsm_ctx - LSM context information
> + * @id: the LSM id number, see LSM_ID_XXX
> + * @flags: LSM specific flags
> + * @len: length of the lsm_ctx struct, @ctx and any other data or padding
> + * @ctx_len: the size of @ctx
> + * @ctx: the LSM context value
> + *
> + * The @len field MUST be equal to the size of the lsm_ctx struct
> + * plus any additional padding and/or data placed after @ctx.
> + *
> + * In all cases @ctx_len MUST be equal to the length of @ctx.
> + * If @ctx is a string value it should be nul terminated with
> + * @ctx_len equal to `strlen(@ctx) + 1`.  Binary values are
> + * supported.
> + *
> + * The @flags and @ctx fields SHOULD only be interpreted by the
> + * LSM specified by @id; they MUST be set to zero/0 when not used.
> + */
> +struct lsm_ctx {
> +	uint64_t id;
> +	uint64_t flags;
> +	uint64_t len;
> +	uint64_t ctx_len;
> +	uint8_t ctx[4096];
> +};
> +#endif
> +
> +/*
> + * ID tokens to identify Linux Security Modules (LSMs)
> + *
> + * These token values are used to uniquely identify specific LSMs
> + * in the kernel as well as in the kernel's LSM userspace API.
> + */
> +#ifndef LSM_ID_UNDEF
> +# define LSM_ID_UNDEF		0
> +#endif
> +
> +#ifndef LSM_ID_CAPABILITY
> +# define LSM_ID_CAPABILITY	100
> +#endif
> +
> +#ifndef LSM_ID_SELINUX
> +# define LSM_ID_SELINUX		101
> +#endif
> +
> +#ifndef LSM_ID_SMACK
> +# define LSM_ID_SMACK		102
> +#endif
> +
> +#ifndef LSM_ID_TOMOYO
> +# define LSM_ID_TOMOYO		103
> +#endif
> +
> +#ifndef LSM_ID_APPARMOR
> +# define LSM_ID_APPARMOR	104
> +#endif
> +
> +#ifndef LSM_ID_YAMA
> +# define LSM_ID_YAMA		105
> +#endif
> +
> +#ifndef LSM_ID_LOADPIN
> +# define LSM_ID_LOADPIN		106
> +#endif
> +
> +#ifndef LSM_ID_SAFESETID
> +# define LSM_ID_SAFESETID	107
> +#endif
> +
> +#ifndef LSM_ID_LOCKDOWN
> +# define LSM_ID_LOCKDOWN	108
> +#endif
> +
> +#ifndef LSM_ID_BPF
> +# define LSM_ID_BPF		109
> +#endif
> +
> +#ifndef LSM_ID_LANDLOCK
> +# define LSM_ID_LANDLOCK	110
> +#endif
> +
> +#ifndef LSM_ID_IMA
> +# define LSM_ID_IMA		111
> +#endif
> +
> +#ifndef LSM_ID_EVM
> +# define LSM_ID_EVM		112
> +#endif
> +
> +#ifndef LSM_ID_IPE
> +# define LSM_ID_IPE		113
> +#endif
> +
> +/*
> + * LSM_ATTR_XXX definitions identify different LSM attributes
> + * which are used in the kernel's LSM userspace API. Support
> + * for these attributes vary across the different LSMs. None
> + * are required.
> + */
> +#ifndef LSM_ATTR_UNDEF
> +# define LSM_ATTR_UNDEF		0
> +#endif
> +
> +#ifndef LSM_ATTR_CURRENT
> +# define LSM_ATTR_CURRENT	100
> +#endif
> +
> +#ifndef LSM_ATTR_EXEC
> +# define LSM_ATTR_EXEC		101
> +#endif
> +
> +#ifndef LSM_ATTR_FSCREATE
> +# define LSM_ATTR_FSCREATE	102
> +#endif
> +
> +#ifndef LSM_ATTR_KEYCREATE
> +# define LSM_ATTR_KEYCREATE	103
> +#endif
> +
> +#ifndef LSM_ATTR_PREV
> +# define LSM_ATTR_PREV		104
> +#endif
> +
> +#ifndef LSM_ATTR_SOCKCREATE
> +# define LSM_ATTR_SOCKCREATE	105
> +#endif
> +
> +/*
> + * LSM_FLAG_XXX definitions identify special handling instructions
> + * for the API.
> + */
> +#ifndef LSM_FLAG_SINGLE
> +# define LSM_FLAG_SINGLE	0x0001
> +#endif
> +
> +static inline int lsm_get_self_attr(uint32_t attr, struct lsm_ctx *ctx,
> +				    uint32_t *size, uint32_t flags)
> +{
> +	return tst_syscall(__NR_lsm_get_self_attr, attr, ctx, size, flags);
> +}
> +
> +static inline int lsm_set_self_attr(uint32_t attr, struct lsm_ctx *ctx,
> +				    uint32_t size, uint32_t flags)
> +{
> +	return tst_syscall(__NR_lsm_set_self_attr, attr, ctx, size, flags);
> +}
> +
> +static inline int lsm_list_modules(uint64_t *ids, uint32_t *size, uint32_t flags)
> +{
> +	return tst_syscall(__NR_lsm_list_modules, ids, size, flags);
> +}
> +#endif
> 
> -- 
> 2.43.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
