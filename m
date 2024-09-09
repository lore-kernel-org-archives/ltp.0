Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9D8DECE577
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 16:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725898910; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=J4uoetViglZWGsqKQb6kBKL1p34IvSE0zrx1qakyTFo=;
 b=hcpTUnpKIiTfKA5TgtPrueEcJFhIjh36uEc4W5v1dyl8YfUlqoxSbqRnsBKx9sDSVLyyr
 Sj8PlI4y3gLeBzMuyCfUmBWzin0Rw9D1cn0pjtTWkeggTX8Y3xrmvMUVBC1xZ0A5NigstWB
 +7HOla+mhmOOw6YoYz2m1GPR+mABpRw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3C6DC3C1829
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 18:21:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BD8F3C0F94
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 18:21:29 +0200 (CEST)
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D80381A01452
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 18:21:28 +0200 (CEST)
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-53660856a21so2227534e87.2
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1725898888; x=1726503688; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PaLlaxk5Q9CNsdhF/vXlkItBrFkeQMRpUPFAUW/ks+Q=;
 b=ej53s5PYo0GzZkt1V9udjLR5SfrA6ci0MBBsAormBX4eeJB9KWbXftBORVAdkiISto
 wtp4WkHPBeyCV/V7v71D2l1ICnMlA2W1bjfzcLnjq/BCYsBkqSB1cqe30oQNFV2Cm40J
 arvDSDB9t42YsYtC33qxNDpKlOpU8vJmWNbTCn9ExoigCZz5ixJ2uRVQQW9Aj2rseYQ6
 Ls2OAaX00ZGFO5xcAPsvOBfYs0+0OKcSqgiPulO2iLUFofZ1vPxSdSwJ5meL2s4j5o9+
 Q3cr/5IiAciREjaw/XnycxeWcOxXB74OADqzmcAwS8snCMQp2g0H3MqTa5Drfw2zp/Ha
 9Lhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725898888; x=1726503688;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PaLlaxk5Q9CNsdhF/vXlkItBrFkeQMRpUPFAUW/ks+Q=;
 b=dhqE7MYVcP+/eseY/Pi+prHbcgC1X5KsM8zAshC5jb9zDUjZLelvgKMuwKbhOx5wPr
 9vntdI2nh0bz1OoC+3tqh7ypM9hVIiU100fevShLLWDLxvUDnNWd59petl2tJKLKf6BP
 woWRT9bgeAVqK3IzYz78UyvTx+KGWzPDb6zayfiBQxT47qmshX88v8ChS8mxbxx43TLt
 GxJaBLkvunYcLhz9IYuJVU84+9YzBTIXBRrC1eIZWMTIFTmsEX9zNoggEUHNGenn0oYI
 9pA9LMO9ZGqSqikkTFplrVQVZgG86hP/RsmTaNeAFLrJEL8difsyUzmFRC6HxI2thq6S
 aa5w==
X-Gm-Message-State: AOJu0YxhW+EhCLWBSQjyWPLrP6zzibEtjYv9dibdyEU/oUBKNiG/JMxI
 k9nZloXqJ2mjMwcUz1C/6ZoMAoLtrL4O1G1L0pY2VPfxrFBYWojYJaXBfJEgxYvfGmCUZwyFpCK
 AJQ+cyA==
X-Google-Smtp-Source: AGHT+IHrwEaTuF1/z18goPTYeO7GEtOuyZV4kXLiiRthCAy0NT1sz1MeDe2A0UgCDzpZyGZs7zWWWQ==
X-Received: by 2002:a05:6512:3f12:b0:535:645b:fb33 with SMTP id
 2adb3069b0e04-536587a7738mr9044057e87.2.1725898886948; 
 Mon, 09 Sep 2024 09:21:26 -0700 (PDT)
Received: from [192.168.178.49] ([212.86.51.89])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41ce2sm3182624a12.19.2024.09.09.09.21.26
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 09:21:26 -0700 (PDT)
Message-ID: <d13a2438-cbc2-4a67-8df0-61bc1ce26f5a@suse.com>
Date: Mon, 9 Sep 2024 18:21:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: ltp@lists.linux.it
References: <20240909-listmount_statmount-v4-0-39558204ddf0@suse.com>
 <20240909-listmount_statmount-v4-1-39558204ddf0@suse.com>
Content-Language: en-US
In-Reply-To: <20240909-listmount_statmount-v4-1-39558204ddf0@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 01/13] Add SAFE_STATX macro
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

read below...

On 9/9/24 12:00, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
>
> Reviewed-by: Avinesh Kumar <akumar@suse.de>
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>   compile_flags.txt                                  |   1 +
>   include/lapi/stat.h                                | 111 +++++++++++++++------
>   testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c |   2 +
>   3 files changed, 82 insertions(+), 32 deletions(-)
>
> diff --git a/compile_flags.txt b/compile_flags.txt
> new file mode 100644
> index 000000000..3e2e7607a
> --- /dev/null
> +++ b/compile_flags.txt

This is a file for configuring clangd. I guess I had a "git add ." in 
the folder. Please ignore this part of the patch.

Andrea

> @@ -0,0 +1 @@
> +-Iinclude/
> diff --git a/include/lapi/stat.h b/include/lapi/stat.h
> index 030646a9e..1fa5f4eaf 100644
> --- a/include/lapi/stat.h
> +++ b/include/lapi/stat.h
> @@ -30,6 +30,7 @@ struct statx_timestamp {
>   	int32_t __reserved;
>   };
>   #endif
> +
>   /*
>    * Structures for the extended file attribute retrieval system call
>    * (statx()).
> @@ -67,39 +68,57 @@ struct statx_timestamp {
>    * will have values installed for compatibility purposes so that stat() and
>    * co. can be emulated in userspace.
>    */
> -#ifndef HAVE_STRUCT_STATX
> -struct statx {
> -	/* 0x00 */
> -	uint32_t	stx_mask;
> -	uint32_t	stx_blksize;
> -	uint64_t	stx_attributes;
> -	/* 0x10 */
> -	uint32_t	stx_nlink;
> -	uint32_t	stx_uid;
> -	uint32_t	stx_gid;
> -	uint16_t	stx_mode;
> -	uint16_t	__spare0[1];
> -	/* 0x20 */
> -	uint64_t	stx_ino;
> -	uint64_t	stx_size;
> -	uint64_t	stx_blocks;
> -	uint64_t	stx_attributes_mask;
> -	/* 0x40 */
> -	const struct statx_timestamp	stx_atime;
> -	const struct statx_timestamp	stx_btime;
> -	const struct statx_timestamp	stx_ctime;
> -	const struct statx_timestamp	stx_mtime;
> -	/* 0x80 */
> -	uint32_t	stx_rdev_major;
> -	uint32_t	stx_rdev_minor;
> -	uint32_t	stx_dev_major;
> -	uint32_t	stx_dev_minor;
> -	/* 0x90 */
> -	uint64_t	__spare2[14];
> -	/* 0x100 */
> + #define LTP_DEFINE_STATX_STRUCT(x) \
> + 	struct x { \
> +	uint32_t	stx_mask; \
> +	uint32_t	stx_blksize; \
> +	uint64_t	stx_attributes; \
> +	uint32_t	stx_nlink; \
> +	uint32_t	stx_uid; \
> +	uint32_t	stx_gid; \
> +	uint16_t	stx_mode; \
> +	uint16_t	__spare0[1]; \
> +	uint64_t	stx_ino; \
> +	uint64_t	stx_size; \
> +	uint64_t	stx_blocks; \
> +	uint64_t	stx_attributes_mask; \
> +	const struct statx_timestamp	stx_atime; \
> +	const struct statx_timestamp	stx_btime; \
> +	const struct statx_timestamp	stx_ctime; \
> +	const struct statx_timestamp	stx_mtime; \
> +	uint32_t	stx_rdev_major; \
> +	uint32_t	stx_rdev_minor; \
> +	uint32_t	stx_dev_major; \
> +	uint32_t	stx_dev_minor; \
> +	uint64_t	stx_mnt_id; \
> +	uint32_t	stx_dio_mem_align; \
> +	uint32_t	stx_dio_offset_align; \
> +	uint64_t	__spare3[12]; \
>   };
> +
> +LTP_DEFINE_STATX_STRUCT(statx_fallback);
> +
> +#ifdef HAVE_STRUCT_STATX
> +typedef struct statx ltp_statx_;
> +#else
> +LTP_DEFINE_STATX_STRUCT(statx);
> +
> +typedef struct statx_fallback ltp_statx_;
>   #endif
>   
> +/*
> + * This is the fallback statx that we pass to the safe_statx() syscall.
> + * The reason why we need it, is that statx struct is constantly changing
> + * inside the kernel and we need to extend its definition when structure
> + * changes in order to compile the tests.
> + */
> +struct ltp_statx {
> +	union {
> +		ltp_statx_ buff;
> +		struct statx_fallback data;
> +	};
> +};
> +
>   #ifndef HAVE_STATX
>   
>   /*
> @@ -108,9 +127,9 @@ struct statx {
>    * Returns: It returns status of statx syscall
>    */
>   static inline int statx(int dirfd, const char *pathname, unsigned int flags,
> -			unsigned int mask, struct statx *statxbuf)
> +			unsigned int mask, struct statx *st)
>   {
> -	return tst_syscall(__NR_statx, dirfd, pathname, flags, mask, statxbuf);
> +	return tst_syscall(__NR_statx, dirfd, pathname, flags, mask, st);
>   }
>   #endif
>   
> @@ -229,6 +248,10 @@ static inline int statx(int dirfd, const char *pathname, unsigned int flags,
>   # define STATX_ATTR_VERITY	0x00100000
>   #endif
>   
> +#ifndef STATX_MNT_ID_UNIQUE
> +# define STATX_MNT_ID_UNIQUE  0x00004000U
> +#endif
> +
>   #define SAFE_FCHMODAT2(dfd, filename, mode, flags) \
>   	safe_fchmodat2(__FILE__, __LINE__, (dfd), (filename), (mode), (flags))
>   
> @@ -251,4 +274,28 @@ static inline int safe_fchmodat2(const char *file, const int lineno,
>   	return ret;
>   }
>   
> +#define SAFE_STATX(dirfd, pathname, flags, mask, buf) \
> +	safe_statx(__FILE__, __LINE__, (dirfd), (pathname), (flags), (mask), (buf))
> +
> +static inline int safe_statx(const char *file, const int lineno,
> +	int dirfd, const char *pathname, int flags, unsigned int mask,
> +	struct ltp_statx *buf)
> +{
> +	int rval;
> +
> +	rval = statx(dirfd, pathname, flags, mask, &buf->buff);
> +
> +	if (rval == -1) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"statx(%d,%s,%d,%u,%p) failed", dirfd, pathname, flags, mask, buf);
> +	} else if (rval) {
> +		tst_brk_(file, lineno, TBROK | TERRNO,
> +			"Invalid statx(%d,%s,%d,%u,%p) return value %d",
> +			dirfd, pathname, flags, mask, buf,
> +			rval);
> +	}
> +
> +	return rval;
> +}
> +
>   #endif /* LAPI_STAT_H__ */
> diff --git a/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
> index a9932287c..f026b18df 100644
> --- a/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
> +++ b/testcases/kernel/syscalls/fchmodat2/fchmodat2_01.c
> @@ -12,6 +12,8 @@
>    * usage on symlinks will raise EOPNOTSUPP.
>    */
>   
> +#define _GNU_SOURCE
> +
>   #include "tst_test.h"
>   #include "tst_safe_file_at.h"
>   #include "lapi/fcntl.h"
>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
