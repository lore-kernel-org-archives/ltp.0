Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A303C54E58
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 07:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1710488703; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0mgNHvM0IjiV9ZPnnW4iHWA61VOwLMPrD/onhDhtffQ=;
 b=hHlIiptNA03ZL+6KkTNahWCufVyzuMA+C73UWKzxT3/oRBxyHtGDWkO4Yc5E3CnVvxZQO
 B06h1LM0lOieWzDk6duet7crwqCMWPKMqmU2CcRGjPezzHldJOcKDcOfttJg/eET4kHXwPJ
 UShSKsWV8uw50IJWb1IxgJg8kVmjrNw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 96D223CE748
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 08:45:03 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AE9AD3CE748
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 08:44:41 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20::631])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 20FED617E7A
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 08:44:40 +0100 (CET)
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a466e53f8c0so214159466b.1
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 00:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710488679; x=1711093479; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=I0u00Pn5uYkfpRwR0KRTd7avEm6er+XC41bTh7t3E/c=;
 b=PSuo1Y/EFs/xyNtH6o48reZHWEAoKBGjgC08688aJIm81pHrgRZwUuy51EW5bOHlbP
 7XuYByY8tDiI6zzSBXQO6qJ7dsNCZmRLL/WdgLhQKxThcuT9Y5+dNqQ45LO3y6Ni0RKn
 yYs3LFE+ty6abQ210MqZRT02i2mqxRYsN8HXHwv4z2IN6uZyAii6SXFR5tV95eA58SPz
 MBEE53+96v1GMxDJu7TswEYu1STEB4xVqOV2YbShReWWXkmHyoNJ2/oV9FaSBjLwz83y
 HbYQQH1S25E8SbBefSCnEh3SKTdcaf3S4Wz9fmXBMxA6FOPAVNlNsITEai26jPBRuFRU
 GhNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710488679; x=1711093479;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I0u00Pn5uYkfpRwR0KRTd7avEm6er+XC41bTh7t3E/c=;
 b=YkNgqI98HCLOooAUzQvKdbUd1uhOIrC7VjsiU84YSaW3e8FlZrJz26RDBWEcBfaCSq
 uBG5sfkh2ueyQp8PquSyt+FSe9Ml9LjC14r4BfcFsqlR4oBrk/dGSRiz1P0Efm+iAiH5
 mgg0MXkuM7yWoo0dEnbtwdP17o8vD1e7ij0KFQ9i8proEQXGXjX4hSmbT+14paZ8cIO1
 gi3s39YNM50JDi/eVADiS4MH4Vzjfq34cdNmyas8lJCPtnMT0q6U4VYX/5gfOsFiaKvu
 2iOKtIpMPzrDw6uZclMK81FYhgQbHl9z0Td12Bkw3FlUYwBEcTXom5JQWgc6zEkhlUzd
 kctQ==
X-Gm-Message-State: AOJu0Yz+bHDI5mUfORbO31ama8RXR0IQL4lq6ou6U37ZAA8j5yt7PVcQ
 WirzRoX14XBKZmmaQHV2M2hHJW7EZH0J3zKP4Umxi9RwN7gaJ3e1qNsWuxg9gw==
X-Google-Smtp-Source: AGHT+IHLAu1fry73Agcugsk1JTzl0lf2jBZ5pd5tN3LS1UjMUuknHI5o9zuV74m800v39JSOHDt+SA==
X-Received: by 2002:a17:907:6b88:b0:a45:5328:8432 with SMTP id
 rg8-20020a1709076b8800b00a4553288432mr3491938ejc.50.1710488679408; 
 Fri, 15 Mar 2024 00:44:39 -0700 (PDT)
Received: from wegao.29.253.26 ([81.95.8.245])
 by smtp.gmail.com with ESMTPSA id
 f19-20020a17090624d300b00a462e4d7216sm1442119ejb.76.2024.03.15.00.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Mar 2024 00:44:39 -0700 (PDT)
Date: Fri, 15 Mar 2024 03:44:32 -0400
To: Li Wang <liwang@redhat.com>
Message-ID: <ZfP8YEwKpLGweAe1@wegao.29.253.26>
References: <CAEemH2cTzLuJ1uTBNbUB-E7kJPeHjx3sPi1crkqTCJ6h4DgSbg@mail.gmail.com>
 <20240315062448.3181177-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240315062448.3181177-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] swapon01: swapon01: prevent OOM happening in swap
 process
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

On Fri, Mar 15, 2024 at 02:24:48PM +0800, Li Wang wrote:
> Here we take many ways to prevent the OOM happening with
> run the swapon test:
> 
>   * shrink the pollute memory size
>   * increase swapfile size
>   * setting swap max for Cgroup
>   * setting test oom_score_adj to -1000
> 
> Reproted-by: Wei Gao <wegao@suse.com>
> Signed-off-by: Li Wang <liwang@redhat.com>
> ---
> 
> Notes:
>     Hi Wei,
>     
>        Could you please test this patch and post the output messages?
tst_device.c:97: TINFO: Found free device 1 '/dev/loop1'
tst_test.c:1741: TINFO: LTP version: 20240129-94-g8f14b06e0
tst_test.c:1627: TINFO: Timeout per run is 0h 00m 30s
tst_supported_fs_types.c:97: TINFO: Kernel supports ext2
tst_supported_fs_types.c:62: TINFO: mkfs.ext2 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports ext3
tst_supported_fs_types.c:62: TINFO: mkfs.ext3 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports xfs
tst_supported_fs_types.c:62: TINFO: mkfs.xfs does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports btrfs
tst_supported_fs_types.c:62: TINFO: mkfs.btrfs does exist
tst_supported_fs_types.c:105: TINFO: Skipping bcachefs because of FUSE blacklist
tst_supported_fs_types.c:97: TINFO: Kernel supports vfat
tst_supported_fs_types.c:62: TINFO: mkfs.vfat does exist
tst_supported_fs_types.c:97: TINFO: Kernel supports exfat
tst_supported_fs_types.c:58: TINFO: mkfs.exfat does not exist
tst_supported_fs_types.c:128: TINFO: Filesystem ntfs is not supported
tst_supported_fs_types.c:97: TINFO: Kernel supports tmpfs
tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
tst_test.c:1701: TINFO: === Testing on ext2 ===
tst_test.c:1118: TINFO: Formatting /dev/loop1 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1132: TINFO: Mounting /dev/loop1 to /tmp/LTP_swafHGLPe/mntpoint fstyp=ext2 flags=0
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
swapon01.c:27: TPASS: tst_syscall(__NR_swapon, SWAP_FILE, 0) passed
swapon01.c:30: TINFO: SwapCached: 0 Kb
tst_test.c:1701: TINFO: === Testing on ext3 ===
tst_test.c:1118: TINFO: Formatting /dev/loop1 with ext3 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1132: TINFO: Mounting /dev/loop1 to /tmp/LTP_swafHGLPe/mntpoint fstyp=ext3 flags=0
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
swapon01.c:27: TPASS: tst_syscall(__NR_swapon, SWAP_FILE, 0) passed
swapon01.c:30: TINFO: SwapCached: 0 Kb
tst_test.c:1701: TINFO: === Testing on ext4 ===
tst_test.c:1118: TINFO: Formatting /dev/loop1 with ext4 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1132: TINFO: Mounting /dev/loop1 to /tmp/LTP_swafHGLPe/mntpoint fstyp=ext4 flags=0
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
swapon01.c:27: TPASS: tst_syscall(__NR_swapon, SWAP_FILE, 0) passed
swapon01.c:30: TINFO: SwapCached: 0 Kb
tst_test.c:1701: TINFO: === Testing on xfs ===
tst_test.c:1118: TINFO: Formatting /dev/loop1 with xfs opts='' extra opts=''
tst_test.c:1132: TINFO: Mounting /dev/loop1 to /tmp/LTP_swafHGLPe/mntpoint fstyp=xfs flags=0
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
swapon01.c:27: TPASS: tst_syscall(__NR_swapon, SWAP_FILE, 0) passed
swapon01.c:30: TINFO: SwapCached: 0 Kb
tst_test.c:1701: TINFO: === Testing on btrfs ===
tst_test.c:1118: TINFO: Formatting /dev/loop1 with btrfs opts='' extra opts=''
tst_test.c:1132: TINFO: Mounting /dev/loop1 to /tmp/LTP_swafHGLPe/mntpoint fstyp=btrfs flags=0
libswap.c:42: TINFO: FS_NOCOW_FL attribute set on mntpoint/swapfile01
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:125: TINFO: File 'mntpoint/swapfile01' is not contiguous
libswap.c:42: TINFO: FS_NOCOW_FL attribute set on mntpoint/swapfile01
swapon01.c:27: TPASS: tst_syscall(__NR_swapon, SWAP_FILE, 0) passed
swapon01.c:30: TINFO: SwapCached: 0 Kb
tst_test.c:1701: TINFO: === Testing on vfat ===
tst_test.c:1118: TINFO: Formatting /dev/loop1 with vfat opts='' extra opts=''
tst_test.c:1132: TINFO: Mounting /dev/loop1 to /tmp/LTP_swafHGLPe/mntpoint fstyp=vfat flags=0
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
swapon01.c:27: TPASS: tst_syscall(__NR_swapon, SWAP_FILE, 0) passed
swapon01.c:30: TINFO: SwapCached: 0 Kb
tst_test.c:1701: TINFO: === Testing on tmpfs ===
tst_test.c:1118: TINFO: Skipping mkfs for TMPFS filesystem
tst_test.c:1098: TINFO: Limiting tmpfs size to 32MB
tst_test.c:1132: TINFO: Mounting ltp-tmpfs to /tmp/LTP_swafHGLPe/mntpoint fstyp=tmpfs flags=0
tst_ioctl.c:21: TINFO: FIBMAP ioctl is NOT supported: EINVAL (22)
libswap.c:214: TCONF: Swapfile on tmpfs not implemented

Summary:
passed   6
failed   0
broken   0
skipped  1
warnings 0


>        Thanks!!
> 
>  testcases/kernel/syscalls/swapon/swapon01.c | 17 ++++++++++++++---
>  1 file changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/swapon/swapon01.c b/testcases/kernel/syscalls/swapon/swapon01.c
> index d406e4bd9..b4fc02d6e 100644
> --- a/testcases/kernel/syscalls/swapon/swapon01.c
> +++ b/testcases/kernel/syscalls/swapon/swapon01.c
> @@ -26,7 +26,7 @@ static void verify_swapon(void)
>  {
>  	TST_EXP_PASS(tst_syscall(__NR_swapon, SWAP_FILE, 0));
>  
> -	tst_pollute_memory(TESTMEM, 0x41);
> +	tst_pollute_memory(TESTMEM * 9/10, 0x41);
>  	tst_res(TINFO, "SwapCached: %ld Kb", SAFE_READ_MEMINFO("SwapCached:"));
>  
>  	if (TST_PASS && tst_syscall(__NR_swapoff, SWAP_FILE) != 0) {
> @@ -37,11 +37,21 @@ static void verify_swapon(void)
>  
>  static void setup(void)
>  {
> +	tst_enable_oom_protection(0);
>  	is_swap_supported(SWAP_FILE);
> -	make_swapfile(SWAP_FILE, 10, 0);
> +	make_swapfile(SWAP_FILE, 1024, 0);
>  
>  	SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
>  	SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
> +	if (TST_CG_VER_IS_V1(tst_cg, "memory"))
> +		SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%lu", ~0UL);
> +	else
> +		SAFE_CG_PRINT(tst_cg, "memory.swap.max", "max");
> +}
> +
> +static void cleanup(void)
> +{
> +	tst_disable_oom_protection(0);
>  }
>  
>  static struct tst_test test = {
> @@ -51,5 +61,6 @@ static struct tst_test test = {
>  	.all_filesystems = 1,
>  	.needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
>  	.test_all = verify_swapon,
> -	.setup = setup
> +	.setup = setup,
> +	.cleanup = cleanup
>  };
> -- 
> 2.40.1
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
