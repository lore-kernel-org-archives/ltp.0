Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7860C54E60
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 03:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1710732079; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=GPgcVowFC19/h9x5L4MFCK+q3MSCk1QKnKz89t3uWHU=;
 b=SrK2kQHX1qqWjhWxFTOtCgA4+Nn5Vc8MYW+L6lZtYwMvManuGGAXxoNa2BEMhkC/E+y1S
 4gMcMSgIA6Wnb4RozYMvZVMfhGprlI5TfIQaAPJjwqwcenSvmV6xImSegHaxr19NJeuNJSY
 CmfHnSPEEZSlyl6aYxbC/lTpjFjGtxU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A92233D00FE
	for <ltp@archiver.kernel.org>; Mon, 18 Mar 2024 04:21:19 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48D7E3CCFB8
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 04:20:54 +0100 (CET)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B4B4B1000BE3
 for <ltp@lists.linux.it>; Mon, 18 Mar 2024 04:20:52 +0100 (CET)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-41413b42c8dso99635e9.1
 for <ltp@lists.linux.it>; Sun, 17 Mar 2024 20:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1710732052; x=1711336852; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qFmL4WdDXYwNYxI+xUYlX42g+5cmVE3I6JmQr6RTiRU=;
 b=RHWw5QLAkvkHUilLy170Qu2SJRnTcLIN7/VyIH+WNShjPtVxt26V74uwoljlyRBx7V
 s3v+q9Cd/9rD4hg7maO/c6qky79kxn/JqhTjtRKOmiHjLJ9yYzHfangvMdT+QCzo63ug
 V+TnWQcn8EJ2OzYihVm9dh3YO95Z4YBHDrQC257IeA7PpgQLC7nlkOiAiG0UgJ5tZk5i
 rnMmI/R4s24ztAEGg2WbOppkCDEdnLcwX1wgCMXGbD7Tdqayoyr/3HdtVOVwEenvKCOl
 LPMSUgP3EndkdjY4f4SWIGFYMr+bbBfNCN8qWDV1XNCxO8vhYTfTf1YuViI0CbjUuW6e
 rHDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710732052; x=1711336852;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qFmL4WdDXYwNYxI+xUYlX42g+5cmVE3I6JmQr6RTiRU=;
 b=G8uyXU6Q0D8B9DihfbQsSvQqqrRsFUi10tgQLWQ3gGzqJ/+oq2igc3Tzyc87D/USiZ
 TBeJCYgoleeI1L6u0rC8azT5LrFawQSf8WRW2eOtwslDf3N9oMFgOggTFFzR1mhwTTe5
 qjO96XkiKKJZl/y6nk35QSv4qNt6+CZ2jJ05OD8J5QQQCp6xxLrfdSSWnXE04OdlFnKo
 9dKUyISBWAQaDluLaaReUZ9DIc76NmZOKq0Oxeg7/uUIPfT0bG6YmlQO1a0NwNRXX1aW
 OksQ5wAGm/+Km2ygr91YNcYIgeUTkGX8jAcOy+hjZgnPHJD4HBr47iHgadMzuJz31zh/
 +OmQ==
X-Gm-Message-State: AOJu0Yz3t8dka9Ikn/1dTq31+AcqcWdhfaeNqDtNjDG8BQKS1zfjeRk+
 Y4CexS2GjCeqKtAMEb3bUk5XJM+rKVVr1hT9IdB2iVnt8AZA2s7xgifQzdhdzw==
X-Google-Smtp-Source: AGHT+IF6rblG7mtT9JeDWxnekYjlh0tKRf1Gy/Yh5riZT9hNzx5exP5JkdI6eQrSbXUlX4lZ0FKKpw==
X-Received: by 2002:a05:600c:690f:b0:414:113b:36a6 with SMTP id
 fo15-20020a05600c690f00b00414113b36a6mr744509wmb.25.1710732052023; 
 Sun, 17 Mar 2024 20:20:52 -0700 (PDT)
Received: from wegao.215.20.80 ([81.95.8.245])
 by smtp.gmail.com with ESMTPSA id
 dz18-20020a0560000e9200b0033e73c58678sm8713148wrb.15.2024.03.17.20.20.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Mar 2024 20:20:51 -0700 (PDT)
Date: Sun, 17 Mar 2024 23:20:45 -0400
To: Li Wang <liwang@redhat.com>
Message-ID: <ZfezDUSKwUdoSamA@wegao.215.20.80>
References: <CAEemH2cTzLuJ1uTBNbUB-E7kJPeHjx3sPi1crkqTCJ6h4DgSbg@mail.gmail.com>
 <20240315062448.3181177-1-liwang@redhat.com>
 <ZfP8YEwKpLGweAe1@wegao.29.253.26>
 <CAEemH2e5BB=L6-uT25ppcjGnXqJu7U-MmTCNdFsu8FE3sGv=Lw@mail.gmail.com>
 <ZfQoVC7xBfGHNsgI@wegao.157.234.177>
 <CAEemH2d_DgJwFrnu2e91ip6FhdDPjYddCQNsqnf=dA5QjuW_qg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2d_DgJwFrnu2e91ip6FhdDPjYddCQNsqnf=dA5QjuW_qg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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

On Sun, Mar 17, 2024 at 05:52:01PM +0800, Li Wang wrote:
> Hi Wei,
> 
> Can you try this one and post the test log here?
> 
> And again, it'd be helpful to know the config of your SUT.
> e.g. `free -h`  `lscpu`  `uname -r`  infoformation
> 
> 
> --- a/testcases/kernel/syscalls/swapon/swapon01.c
> +++ b/testcases/kernel/syscalls/swapon/swapon01.c
> @@ -37,11 +37,20 @@ static void verify_swapon(void)
> 
>  static void setup(void)
>  {
> +       tst_enable_oom_protection(0);
>         is_swap_supported(SWAP_FILE);
> -       make_swapfile(SWAP_FILE, 10, 0);
> +       make_swapfile(SWAP_FILE, 1024, 0);
> 
>         SAFE_CG_PRINTF(tst_cg, "cgroup.procs", "%d", getpid());
>         SAFE_CG_PRINTF(tst_cg, "memory.max", "%lu", TESTMEM);
> +
> +       if (SAFE_CG_HAS(tst_cg, "memory.swap.max"))
> +               SAFE_CG_PRINTF(tst_cg, "memory.swap.max", "%ld", TESTMEM *
> 2);
> +}
> +
> +static void cleanup(void)
> +{
> +       tst_disable_oom_protection(0);
>  }
> 
>  static struct tst_test test = {
> @@ -51,5 +60,6 @@ static struct tst_test test = {
>         .all_filesystems = 1,
>         .needs_cgroup_ctrls = (const char *const []){ "memory", NULL },
>         .test_all = verify_swapon,
> -       .setup = setup
> +       .setup = setup,
> +       .cleanup = cleanup
>  };
> 
> 
localhost:~ # free -h <<<< before running case
               total        used        free      shared  buff/cache   available
Mem:           3.8Gi       478Mi       3.3Gi       9.0Mi       346Mi       3.4Gi
Swap:             0B          0B          0B
localhost:~ # lscpu
Architecture:            x86_64
  CPU op-mode(s):        32-bit, 64-bit
  Address sizes:         46 bits physical, 48 bits virtual
  Byte Order:            Little Endian
CPU(s):                  2
  On-line CPU(s) list:   0,1
Vendor ID:               GenuineIntel
  BIOS Vendor ID:        QEMU
  Model name:            Intel(R) Xeon(R) Gold 5218R CPU @ 2.10GHz
    BIOS Model name:     pc-i440fx-7.1  CPU @ 2.0GHz
    BIOS CPU family:     1
    CPU family:          6
    Model:               85
    Thread(s) per core:  1
    Core(s) per socket:  1
    Socket(s):           2
    Stepping:            7
    BogoMIPS:            4190.15
    Flags:               fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ss syscall nx pdpe1
                         gb rdtscp lm constant_tsc arch_perfmon rep_good nopl xtopology cpuid tsc_known_freq pni pclmulqdq vmx ssse3 fma cx16
                         pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnow
                         prefetch cpuid_fault ssbd ibrs ibpb stibp ibrs_enhanced tpr_shadow flexpriority ept vpid ept_ad fsgsbase tsc_adjust b
                         mi1 hle avx2 smep bmi2 erms invpcid rtm mpx avx512f avx512dq rdseed adx smap clflushopt clwb avx512cd avx512bw avx512
                         vl xsaveopt xsavec xgetbv1 xsaves arat vnmi umip pku ospke avx512_vnni md_clear arch_capabilities
Virtualization features:
  Virtualization:        VT-x
  Hypervisor vendor:     KVM
  Virtualization type:   full
Caches (sum of all):
  L1d:                   64 KiB (2 instances)
  L1i:                   64 KiB (2 instances)
  L2:                    8 MiB (2 instances)
  L3:                    32 MiB (2 instances)
NUMA:
  NUMA node(s):          2
  NUMA node0 CPU(s):     0
  NUMA node1 CPU(s):     1
Vulnerabilities:
  Gather data sampling:  Unknown: Dependent on hypervisor status
  Itlb multihit:         Not affected
  L1tf:                  Not affected
  Mds:                   Not affected
  Meltdown:              Not affected
  Mmio stale data:       Vulnerable: Clear CPU buffers attempted, no microcode; SMT Host state unknown
  Retbleed:              Mitigation; Enhanced IBRS
  Spec rstack overflow:  Not affected
  Spec store bypass:     Mitigation; Speculative Store Bypass disabled via prctl
  Spectre v1:            Mitigation; usercopy/swapgs barriers and __user pointer sanitization
  Spectre v2:            Mitigation; Enhanced / Automatic IBRS, IBPB conditional, RSB filling, PBRSB-eIBRS SW sequence
  Srbds:                 Not affected
  Tsx async abort:       Mitigation; Clear CPU buffers; SMT Host state unknown
localhost:~ # uname -r
6.4.0-9-default

swapon01                                                                                                                                      100%  851KB 386.5KB/s   00:02
tst_device.c:97: TINFO: Found free device 0 '/dev/loop0'
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
tst_test.c:1118: TINFO: Formatting /dev/loop0 with ext2 opts='' extra opts=''
mke2fs 1.47.0 (5-Feb-2023)
tst_test.c:1132: TINFO: Mounting /dev/loop0 to /tmp/LTP_swakWRRNY/mntpoint fstyp=ext2 flags=0
tst_ioctl.c:26: TINFO: FIBMAP ioctl is supported
swapon01.c:27: TPASS: tst_syscall(__NR_swapon, SWAP_FILE, 0) passed
Test timeouted, sending SIGKILL!
tst_test.c:1680: TINFO: If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
tst_test.c:1681: TBROK: Test killed! (timeout?)

Summary:
passed   1
failed   0
broken   1
skipped  0
warnings 0
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try  1...
tst_device.c:413: TINFO: Likely gvfsd-trash is probing newly mounted fs, kill it to speed up tests.
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try  2...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try  3...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try  4...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try  5...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try  6...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try  7...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try  8...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try  9...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 10...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 11...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 12...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 13...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 14...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 15...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 16...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 17...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 18...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 19...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 20...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 21...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 22...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 23...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 24...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 25...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 26...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 27...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 28...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 29...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 30...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 31...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 32...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 33...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 34...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 35...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 36...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 37...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 38...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 39...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 40...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 41...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 42...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 43...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 44...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 45...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 46...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 47...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 48...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 49...
tst_device.c:409: TINFO: umount('mntpoint') failed with EBUSY, try 50...
tst_device.c:419: TWARN: Failed to umount('mntpoint') after 50 retries
tst_device.c:264: TWARN: ioctl(/dev/loop0, LOOP_CLR_FD, 0) no ENXIO for too long
tst_tmpdir.c:343: TWARN: tst_rmdir: rmobj(/tmp/LTP_swakWRRNY) failed: unlink(/tmp/LTP_swakWRRNY/mntpoint/swapfile01) failed; errno=1: EPERM


localhost:~ # free -h <<<< after running case
               total        used        free      shared  buff/cache   available
Mem:           3.8Gi       480Mi       3.3Gi        32Mi       395Mi       3.4Gi
Swap:          3.0Mi          0B       3.0Mi


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
