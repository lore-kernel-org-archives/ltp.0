Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6215C021A4
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 12:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1740400205; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Lax77VVnI0fNVr5PEEO2BIDmxHaaTZv11WGbWGbbt5I=;
 b=rLa6y6wUGwIVsi9o8VNl/XVHpZEqokEH72I3cdFtZYUy406GRoE0KOTXpgiS9gE4/+fHw
 OSImfwHm+tlhd88DF/u7Jf911VXEawx+nfBg8G+9NigkwHagdT5seQB6BxEPyFIRCGNBsac
 F8doYM+hyrlKU4OQI0bXZtK8uIOcETs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 090113C9931
	for <ltp@archiver.kernel.org>; Mon, 24 Feb 2025 13:30:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C7333C988C
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 13:29:42 +0100 (CET)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 46CA6600F3D
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 13:29:41 +0100 (CET)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-abbdc4a0b5aso801092566b.0
 for <ltp@lists.linux.it>; Mon, 24 Feb 2025 04:29:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1740400180; x=1741004980; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BTT2DC+DNnUjj+gu/nekUH7Bw5wGZkcrHdw/tA608ck=;
 b=UOYllzIyNip2OcPC2UgmXfIPBHAggewtYL8lKF3vcpWNXDGQyfXLNjm4Lbgj12imE7
 r0zUu0jkxAYjeklhcJ5LRWcwEZ/Z53p3MCAPI0jUIM0+DDnFEV6gRtppjfWHpQnm1jYp
 cYvF6FClgu5R/SmKcqwFE3oCGkziqpzKSPsG72FdwS3MoFCNHdsJhCUXrlr6EXrDTRXT
 1CCkTuNZ1QiHKRCFK5qv9YXjQfmpOJhw54vJZHRpO+zDdcSGpHdmMYGHfRW1veX0o+ye
 k5iACnl4W6qXfxpxo3jarMoXhMHC19CH/JCmSGrnnEmMjPnIGIdTrtftogpq/GQqG5rn
 Zdgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740400180; x=1741004980;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BTT2DC+DNnUjj+gu/nekUH7Bw5wGZkcrHdw/tA608ck=;
 b=APlRMHOBjLs8SKaRVaCygAfGG2vE+n5E9OcPt8Rk7VzSQiCH2MDK9Xw8Y24ZanAfQ5
 mKbZr5ETM+qiDFNbd1NETNp/Kmi2WNnhQxs66QmY7AAYmGuVb2rf+I3pyBc7yJQNM1U/
 9cn5/GhlIiDyDMx9Ez1vtZz1lk/rbVov52AjOk4C/6m8UgW3rAtFDVuGjyiYeEdcr5BQ
 AnPA5XtXHvqcU13N+dTEfTmpeIopXa9uQFXr2LiUbVz6cM1U9hP5dvg7BTLIVTQE0S3o
 xszI1QR5XNxrgd1A66MJYjwfOem1uHl0T3g3BRwWMFoLtwvxgB3Q2pBuax4Wv9UP99Sw
 xqJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwNqBkwQun+6nB9xEN0HFVMEQw0at7DzVILQqNlVqjmCMad4n9tLo431F8b9Yucl+eO70=@lists.linux.it
X-Gm-Message-State: AOJu0Yy6X0IlJD6WXmzGWg8o2/erlgDYtFaK0IGLtGgZ2RQvLzhz0vGh
 I3DjxeiclcdnHkq/dSMnEWLnt2iMF4wVl13swessUML0NoJ7S1N4dUaWpVEhjC0=
X-Gm-Gg: ASbGncuAP2wP2tE1k6JDmO598QPBbZz6oMcxDoP7NKG7G3X8/I7Ry4Uo7HOr9cHc9fJ
 m/hhnu/2LbmiFx99YH8iMdZOSV4ilXkMk73Hh3xF1L2qr5yZavnevoRKr/bFFSycbgL4zyQo80L
 F2GtA/VeV4e9yjLpP36vuPqOPu2AD3nT/cdiwf0rszGmimK3LtEV14tkicu2mQgqigoCiUJ68Ah
 DX5oQTJ4Xm6bMxhM28zkGg4OG4macZ5RDFaSeIEVB7OchQ34yN78HCZTK1aN6L3ZSA8Y0x2PQCY
 +UmUdKkRdqX7U/Wwzha3jc1RY6O26FQmhhg=
X-Google-Smtp-Source: AGHT+IH4ne2PUAPr8dLgre8C5bL84splsaUm8UWiZZjI2u4boSgj1KH56t5QP796axv6yFDboTewDA==
X-Received: by 2002:a17:907:9989:b0:abb:daa7:f769 with SMTP id
 a640c23a62f3a-abbed5b21b4mr1680817666b.0.1740400180523; 
 Mon, 24 Feb 2025 04:29:40 -0800 (PST)
Received: from [192.168.1.91] ([151.71.237.5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb9de73d1csm1531068066b.140.2025.02.24.04.29.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 04:29:40 -0800 (PST)
Message-ID: <8af6f692-a21e-485c-84af-a746339701d6@suse.com>
Date: Mon, 24 Feb 2025 13:29:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250224100016.2857704-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250224100016.2857704-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_test: Add $LTP_SINGLE_ITERATION to limit
 variant
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

Hi Petr,

thanks for this patch. Implementation looks good to me and it would be 
beneficial for debugging purposes when we need to explore the reasons 
why test is failing.

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

On 2/24/25 11:00, Petr Vorel wrote:
> Allow to test only single struct tst_test->test_variants.
> This is a similar feature to $LTP_SINGLE_FS_TYPE.
>
> Value is ignored when test does not specify test_variants.
> When value is higher than test_variants value lastest variant is used.
>
> 	# LTP_SINGLE_VARIANT=0 LTP_SINGLE_FS_TYPE=ext4 ./getdents02
> 	..
> 	tst_test.c:1918: TINFO: WARNING: testing only variant 0 of 3
> 	tst_supported_fs_types.c:161: TINFO: WARNING: testing only ext4
> 	tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
> 	tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
> 	tst_test.c:1834: TINFO: === Testing on ext4 ===
> 	tst_test.c:1171: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
> 	mke2fs 1.47.2 (1-Jan-2025)
> 	tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_getx2HrGH/mntpoint fstyp=ext4 flags=0
> 	getdents.h:148: TINFO: Testing the SYS_getdents syscall
> 	tst_buffers.c:57: TINFO: Test is using guarded buffers
> 	getdents02.c:77: TPASS: fd=-5 dirp=0x7f0587803ee9 size=279 : EBADF (9)
> 	getdents02.c:77: TPASS: fd=3 dirp=0x5641617a31e8 size=1 : EINVAL (22)
> 	getdents02.c:77: TPASS: fd=4 dirp=0x7f0587803ee9 size=279 : ENOTDIR (20)
> 	getdents02.c:77: TPASS: fd=5 dirp=0x7f0587803ee9 size=279 : ENOENT (2)
> 	getdents02.c:77: TPASS: fd=3 dirp=0x7f0587802000 size=279 : EFAULT (14)
>
> 	# LTP_SINGLE_VARIANT=2 LTP_SINGLE_FS_TYPE=ext4 ./getdents02
> 	...
> 	tst_test.c:1918: TINFO: WARNING: testing only variant 2 of 3
> 	tst_supported_fs_types.c:161: TINFO: WARNING: testing only ext4
> 	tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
> 	tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
> 	tst_test.c:1834: TINFO: === Testing on ext4 ===
> 	tst_test.c:1171: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
> 	mke2fs 1.47.2 (1-Jan-2025)
> 	tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_getWtBnGE/mntpoint fstyp=ext4 flags=0
> 	getdents.h:157: TCONF: libc getdents() is not implemented
>
> 	# LTP_SINGLE_VARIANT=99 LTP_SINGLE_FS_TYPE=ext4 ./getdents02 # higher value is max value
> 	tst_test.c:1918: TINFO: WARNING: testing only variant 3 of 3
> 	tst_supported_fs_types.c:161: TINFO: WARNING: testing only ext4
> 	tst_supported_fs_types.c:97: TINFO: Kernel supports ext4
> 	tst_supported_fs_types.c:62: TINFO: mkfs.ext4 does exist
> 	tst_test.c:1834: TINFO: === Testing on ext4 ===
> 	tst_test.c:1171: TINFO: Formatting /dev/loop0 with ext4 opts='' extra opts=''
> 	mke2fs 1.47.2 (1-Jan-2025)
> 	tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_get1fX70n/mntpoint fstyp=ext4 flags=0
> 	getdents.h:162: TINFO: Testing libc getdents64()
> 	tst_buffers.c:57: TINFO: Test is using guarded buffers
> 	getdents02.c:77: TPASS: fd=-5 dirp=0x7fcf140f3ee8 size=280 : EBADF (9)
> 	getdents02.c:77: TPASS: fd=3 dirp=0x55a76e4531e8 size=1 : EINVAL (22)
> 	getdents02.c:77: TPASS: fd=4 dirp=0x7fcf140f3ee8 size=280 : ENOTDIR (20)
> 	getdents02.c:77: TPASS: fd=5 dirp=0x7fcf140f3ee8 size=280 : ENOENT (2)
> 	getdents02.c:77: TPASS: fd=3 dirp=0x7fcf140f2000 size=280 : EFAULT (14)
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi all,
>
> Andrea wanted to run only single variant.
>
> Kind regards,
> Petr
>
>   lib/tst_test.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)
>
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 3823ea109e..6edc310209 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -581,6 +581,7 @@ static void print_help(void)
>   	fprintf(stderr, "LTP_DEV              Path to the block device to be used (for .needs_device)\n");
>   	fprintf(stderr, "LTP_DEV_FS_TYPE      Filesystem used for testing (default: %s)\n", DEFAULT_FS_TYPE);
>   	fprintf(stderr, "LTP_SINGLE_FS_TYPE   Testing only - specifies filesystem instead all supported (for .all_filesystems)\n");
> +	fprintf(stderr, "LTP_SINGLE_VARIANT   Testing only - specifies tst_variant to be run\n");
>   	fprintf(stderr, "LTP_TIMEOUT_MUL      Timeout multiplier (must be a number >=1)\n");
>   	fprintf(stderr, "LTP_RUNTIME_MUL      Runtime multiplier (must be a number >=1)\n");
>   	fprintf(stderr, "LTP_VIRT_OVERRIDE    Overrides virtual machine detection (values: \"\"|kvm|microsoft|xen|zvm)\n");
> @@ -1887,6 +1888,7 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>   	int ret = 0;
>   	unsigned int test_variants = 1;
>   	struct utsname uval;
> +	const char *only_variant;
>   
>   	lib_pid = getpid();
>   	tst_test = self;
> @@ -1899,7 +1901,6 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>   
>   	tst_res(TINFO, "LTP version: "LTP_VERSION);
>   
> -
>   	uname(&uval);
>   	tst_res(TINFO, "Tested kernel: %s %s %s", uval.release, uval.version, uval.machine);
>   
> @@ -1908,10 +1909,20 @@ void tst_run_tcases(int argc, char *argv[], struct tst_test *self)
>   
>   	set_overall_timeout();
>   
> -	if (tst_test->test_variants)
> +	if (tst_test->test_variants) {
>   		test_variants = tst_test->test_variants;
> +		only_variant = getenv("LTP_SINGLE_VARIANT");
> +		if (only_variant && only_variant[0] != '\0') {
> +			tst_variant = MIN(SAFE_STRTOL((char *)only_variant, 0, INT_MAX),
> +							  test_variants - 1);
> +			tst_res(TINFO, "WARNING: testing only variant %d of %d",
> +					tst_variant, test_variants - 1);
> +			test_variants = tst_variant + 1;
> +		}
> +	}
> +
> +	for (; tst_variant < test_variants; tst_variant++) {
>   
> -	for (tst_variant = 0; tst_variant < test_variants; tst_variant++) {
>   		if (tst_test->all_filesystems || count_fs_descs() > 1)
>   			ret |= run_tcases_per_fs();
>   		else

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
