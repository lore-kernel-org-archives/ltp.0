Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DEF1C35FFF
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 10:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742553639; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=SqaGbGOMub5bDRvnz/rHYB9BMjFMfH9ZJ8FrAGIfGsg=;
 b=p/mQpsSSrwO/+dfE9qQ9iMXXmry9r1ZMTbblZSAx1+lXsBld33CHaGrnr02eZIzQSNF9L
 ICO50aSt961OucNc7yyBU4zUJgdhONiStkA5Sj/OlPLObbw7A9H4z9P4YGMa9TKyFpZ6aT9
 EqNe41xXkIjoNyJURVoNW2XSVcZEKQk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F40C3CAF13
	for <ltp@archiver.kernel.org>; Fri, 21 Mar 2025 11:40:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A0753CAEED
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 11:40:18 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7285C100037D
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 11:40:17 +0100 (CET)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3912d2c89ecso1622257f8f.2
 for <ltp@lists.linux.it>; Fri, 21 Mar 2025 03:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742553617; x=1743158417; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ixNuLvanyaco0wQA7vSAFL278mg24lB5E/26HJbUbOk=;
 b=Fa8DASiCUoJJmWSUtUP5eduto1uUOBrMyg6a26htF1mEFhlWdrAnt7/qGWJ5Gb/ioD
 zekrFCdMVhZbi1nEbI8YQpeNvoCVn2Uv+fZPz0N2Bp7dnjujR3eYgLYTA1cDidTSNyr5
 S75YBeP0+g6dVq4QGdigPTNCCHrItjbGI4JY/HR2qm9uniJKk+o2n/66qLqiodgLRnQ1
 IQdSzri0yRr+MB+aSUDfUmEUA5wAI6ZooIoSNJ5Hk1gGhdKObAk4RLA2GFwqOoBHAEJI
 2GzOBQqNrMBfaXzPckQLZfnH+cY5EIFaZxks/NcIguXvhUV0USA88uHMTgpv7Z/91otr
 7/cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742553617; x=1743158417;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ixNuLvanyaco0wQA7vSAFL278mg24lB5E/26HJbUbOk=;
 b=KzodEsgvhGm3YiyTb0C4Y7L6RanS27VNQgeoMbG6JsS3+QIPrsUbQxqK7GZgx0fbsG
 bPfvRC59e0rGCA+zQJGV+ilnlTQbTZ4Feq91o99Et7dCIuptllVouSbsDHEpQMuv1Glo
 EVnATilTvsNNjngGbC8nMAhrp2GyRNzR1kaDuPzbkXNvTM5xi74fP3jDmLj+Im/uls2q
 uOyMd9pqc/pAWED/DwaQI00voOrlsl2pAgAMdwFqgRAM0YIFcoSaUh/bEGwmhbjCyEba
 2XXsPg24QdauiVXBQqkEPg42tokWeEHB54H+nVrktXyruqworiPHCW16ajbaw89NdWbe
 7l6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPEYwTOZ8ffP85goxAY6lXDiC4y0f6rT6xhFOxaWywPbrC3fI4k7teYqx1DMqKOdg0B5o=@lists.linux.it
X-Gm-Message-State: AOJu0YyPwZDh5vY3EIRVdIdp/C2zv4ioXLHFdOaB781QlADtej6DHVy1
 z3pUJM6I0ay95vwI8ZOzCF2F7UeIPgPoAJiqWsaGW/0loAoQumhrLkprgThEQLc=
X-Gm-Gg: ASbGncvhb2SrSchUv9RdPqB0gzx1XBgH+4rxejMK/FapAudrUlLNHEmCgCcifW0S+y6
 6tKnx0/eVXgkOFJ42dyF361ikmN4BW1ZZLarkaX3QNOSv5tRGmE67rUu/sLLONjyDe1h7N82VHH
 lCyM4vcVAxrMSoz9j8fdUWgt1SCu47u5UOL3RXlqT6vQoB3r6cbmFFik2AgCjNTebi7KkRnhcpx
 p2VHBtc/h/Meb8Dy8w7k1nCKveREETd5gmFSyTXvQpohdAFpp1wDLhlrEV/MDSLzT6RkuAJoilX
 Yp7QCZItUWz890iUFTFY4IlmihQJZ+uhp5dcwHfpte/6Dfwdsa/+o000Ij7h65dfZcCCGebiGC+
 OwEvWqKV0m6elvkZobYbv3OSlU2DYPtpe+FEhEtaKchjeVSmXJ1fpjjyHet1PAofTSTN6sym/1n
 AhZjPAv0rvo07khTulBA==
X-Google-Smtp-Source: AGHT+IFCqrz8IcuX+/4i1bYx5eOZ2uB/Ha8J127JzYPmP+M7dpcQDBa++6sQn9yPNG9LbJAG+/olcw==
X-Received: by 2002:a5d:47a5:0:b0:390:f699:8c27 with SMTP id
 ffacd0b85a97d-3997f902e3dmr2570376f8f.12.1742553616661; 
 Fri, 21 Mar 2025 03:40:16 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d440ed4cbsm74522575e9.34.2025.03.21.03.40.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Mar 2025 03:40:16 -0700 (PDT)
Message-ID: <2136af4d-d224-440d-85b9-2abaaac501c2@suse.com>
Date: Fri, 21 Mar 2025 11:40:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250321100320.162107-1-pvorel@suse.cz>
Content-Language: en-US
In-Reply-To: <20250321100320.162107-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] ioctl_ficlone03: Require 5.10 for XFS
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
Cc: linux-xfs@vger.kernel.org, Gao Xiang <hsiangkao@redhat.com>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, fstests@vger.kernel.org,
 Allison Collins <allison.henderson@oracle.com>,
 Dave Chinner <dchinner@redhat.com>, Jan Kara <jack@suse.cz>,
 Christoph Hellwig <hch@lst.de>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

thanks for checking and finding the issue of the test, it was really 
helpful.
Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

Kind regards,
Andrea Cervesato

On 3/21/25 11:03, Petr Vorel wrote:
> Test fails on XFS on kernel older than 5.10:
>
>      # ./ioctl_ficlone03
> 	...
>      tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_ioc6ARHZ7/mnt fstyp=xfs flags=0
>      [   10.122070] XFS (loop0): Superblock has unknown incompatible features (0x8) enabled.
>      [   10.123035] XFS (loop0): Filesystem cannot be safely mounted by this kernel.
>      [   10.123916] XFS (loop0): SB validate failed with error -22.
>      tst_test.c:1183: TBROK: mount(/dev/loop0, mnt, xfs, 0, (nil)) failed: EINVAL (22)
>
> This also causes Btrfs testing to be skipped due TBROK on XFS. With increased version we get on 5.4 LTS:
>
>      # ./ioctl_ficlone03
>      tst_test.c:1904: TINFO: Tested kernel: 5.4.291 #194 SMP Fri Mar 21 10:18:02 CET 2025 x86_64
>      ...
>      tst_supported_fs_types.c:49: TINFO: mkfs is not needed for tmpfs
>      tst_test.c:1833: TINFO: === Testing on xfs ===
>      tst_cmd.c:281: TINFO: Parsing mkfs.xfs version
>      tst_test.c:969: TCONF: The test requires kernel 5.10 or newer
>      tst_test.c:1833: TINFO: === Testing on btrfs ===
>      tst_test.c:1170: TINFO: Formatting /dev/loop0 with btrfs opts='' extra opts=''
>      [   30.143670] BTRFS: device fsid 1a6d250c-0636-11f0-850f-c598bdcd84c4 devid 1 transid 6 /dev/loop0
>      tst_test.c:1183: TINFO: Mounting /dev/loop0 to /tmp/LTP_iocjwzyal/mnt fstyp=btrfs flags=0
>      [   30.156563] BTRFS info (device loop0): using crc32c (crc32c-generic) checksum algorithm
>      [   30.157363] BTRFS info (device loop0): flagging fs with big metadata feature
>      [   30.158061] BTRFS info (device loop0): using free space tree
>      [   30.158620] BTRFS info (device loop0): has skinny extents
>      [   30.159911] BTRFS info (device loop0): enabling ssd optimizations
>      [   30.160652] BTRFS info (device loop0): checking UUID tree
>      ioctl_ficlone03_fix.c:49: TPASS: invalid source : EBADF (9)
>      ioctl_ficlone03_fix.c:55: TPASS: invalid source : EBADF (9)
>
> Fixing commit is 29887a2271319 ("xfs: enable big timestamps").
>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
> Hi all,
>
> I suppose we aren't covering a test bug with this and test is really
> wrong expecting 4.16 would work on XFS. FYI this affects 5.4.291
> (latest 5.4 LTS which is still supported) and would not be fixed due a
> lot of missing functionality from 5.10.
>
> Kind regards,
> Petr
>
>   testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> index 6a9d270d9f..e2ab10cba1 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_ficlone03.c
> @@ -113,7 +113,7 @@ static struct tst_test test = {
>   		{.type = "bcachefs"},
>   		{
>   			.type = "xfs",
> -			.min_kver = "4.16",
> +			.min_kver = "5.10",
>   			.mkfs_ver = "mkfs.xfs >= 1.5.0",
>   			.mkfs_opts = (const char *const []) {"-m", "reflink=1", NULL},
>   		},

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
