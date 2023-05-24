Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9470EC7EE2C
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 11:26:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0CDB83CEFC1
	for <ltp@archiver.kernel.org>; Wed, 24 May 2023 13:26:15 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D38D23CAC01
 for <ltp@lists.linux.it>; Wed, 24 May 2023 13:23:23 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6938660071B
 for <ltp@lists.linux.it>; Wed, 24 May 2023 13:23:22 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-3f603ff9c02so6942155e9.2
 for <ltp@lists.linux.it>; Wed, 24 May 2023 04:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684927402; x=1687519402;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=XnHfsKcNH/cNGJ6XNCOWz/0q5ZKOE9Q1MtdFrXQQHlg=;
 b=HP1A3H0LJ3yGNLAb/iW11BhivBLLgjUIeGYq0rXzNJnrb8iiey3QkvYn1SYsziMNLw
 s+gOaE3U7WNFm0ChMlLJ/d4XzPHRSrKhEc3nI90nt8TaFhOtbohRVKRUwJyi+3ZMrwa7
 OyzjT7n42Um1ezPKnOWUEqzfPEoqtP9Jy1B9knhtDQRG4eoOFAssdIMHPGz4Ty9ynHPi
 2ODWAy4wTo5Z9scvqLUjg29hHX9AHT920fVBiQt6acbMXpxh4HnnMz6suc+MBYPXGpWa
 sDTOhlLEkcxVjd2C0CUsNDQ2rH6AWgk5uy3YgFtOSPhC0T6yoUfgRL6j81ikJ3+UARD/
 +/MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684927402; x=1687519402;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XnHfsKcNH/cNGJ6XNCOWz/0q5ZKOE9Q1MtdFrXQQHlg=;
 b=fSVOCL0jaTgS2xc8sS5z2pQasHfdn9viPVrXQbYdlsGax4tma+HuU85IQXGz0wvgNI
 jKAiEEVK2+kQ5h+8EVlMpX0SmE3tApE2Ubc9f8wvaQWO4yURsNBtIQP7IEtZ5UAYsl58
 GHmimeoPiXlfuSGsZ5IsSMs/txhamaEUQqM91OyeApGvsH+E5LRMmhr+bCoGPeghMN37
 F6lBdbEI2bl8mnIzfRdWm7V7gWSllmb0rZRtgudH9dU5UWX4Qa6Ef7tsaa1JRYKgsZyR
 lOq8oo2CFCIf/WA8tJn4MFOT/MD298MRcwCzCCiNA125CIvjN4A7jL4BrzdNV+9n6Jxe
 uA6w==
X-Gm-Message-State: AC+VfDwrtRLcIvQoEKDyMUWVIqanFZMFrV4ic0MTUmyVwWUUwYkIJr+y
 jxWPAXDEpngItNIWspqpWAMpjw==
X-Google-Smtp-Source: ACHHUZ4MJroqG+izF3TpvDWSMNs8ThwUAbnXvlX+TBLtv5iVz+aYg4Q/LNEqQCuFBIUxNT0Gc2Fh5Q==
X-Received: by 2002:a1c:cc1a:0:b0:3f5:fc21:5426 with SMTP id
 h26-20020a1ccc1a000000b003f5fc215426mr8660954wmb.41.1684927401874; 
 Wed, 24 May 2023 04:23:21 -0700 (PDT)
Received: from localhost ([102.36.222.112]) by smtp.gmail.com with ESMTPSA id
 2-20020a05600c020200b003f50e29bce3sm1968526wmi.48.2023.05.24.04.23.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 04:23:20 -0700 (PDT)
Date: Wed, 24 May 2023 14:23:16 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 Joel Granados <j.granados@samsung.com>
Message-ID: <784b9a90-9d56-4e53-8f92-676e76e49665@kili.mountain>
References: <CA+G9fYvGM6a3wct+_o0z-B=k1ZBg1FuBBpfLH71ULihnTo5RrQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+G9fYvGM6a3wct+_o0z-B=k1ZBg1FuBBpfLH71ULihnTo5RrQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 24 May 2023 13:26:04 +0200
Subject: Re: [LTP] LTP: syscalls: statx06.c:138: TFAIL: Modified time >
 after_time
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
Cc: Christian Brauner <brauner@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
 LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I am pretty sure this is caused by commit 7eec88986dce ("sysctl:
Refactor base paths registrations").  Add Joel to the CC list.

Before we used to use register_sysctl_table() to register that table.

regards,
dan carpenter

On Wed, May 24, 2023 at 04:18:42PM +0530, Naresh Kamboju wrote:
> LTP syscalls statx06 fails on NFS mounted devices using external hard drives
> for testing and running on Linux next 6.4.0-rc3-next-20230524.
> 
> Test case fails on x86_64, i386 and arm64 Juno-r2.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> 
> Linux version 6.4.0-rc3-next-20230524 (tuxmake@tuxmake)
> (x86_64-linux-gnu-gcc (Debian 11.3.0-12) 11.3.0, GNU ld (GNU Binutils
> for Debian) 2.40) #1 SMP PREEMPT_DYNAMIC @1684908723
> ...
> 
> [    1.396191] Mountpoint-cache hash table entries: 32768 (order: 6,
> 262144 bytes, linear)
> [    1.397234] sysctl table check failed: kernel/usermodehelper Not a file
> [    1.398166] sysctl table check failed: kernel/usermodehelper No proc_handler
> [    1.399165] sysctl table check failed: kernel/usermodehelper bogus .mode 0555
> [    1.400166] sysctl table check failed: kernel/keys Not a file
> [    1.401165] sysctl table check failed: kernel/keys No proc_handler
> [    1.402165] sysctl table check failed: kernel/keys bogus .mode 0555
> [    1.403166] CPU: 0 PID: 0 Comm: swapper/0 Not tainted
> 6.4.0-rc3-next-20230524 #1
> [    1.404165] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
> 2.5 11/26/2020
> [    1.404165] Call Trace:
> [    1.404165]  <TASK>
> [    1.404165]  dump_stack_lvl+0x72/0x90
> [    1.404165]  dump_stack+0x14/0x20
> [    1.404165]  __register_sysctl_table+0x570/0x840
> [    1.404165]  __register_sysctl_init+0x29/0x60
> [    1.404165]  sysctl_init_bases+0x27/0x80
> [    1.404165]  proc_sys_init+0x37/0x40
> [    1.404165]  proc_root_init+0x7b/0x90
> [    1.404165]  start_kernel+0x403/0x6a0
> [    1.404165]  x86_64_start_reservations+0x1c/0x30
> [    1.404165]  x86_64_start_kernel+0xcb/0xe0
> [    1.404165]  secondary_startup_64_no_verify+0x179/0x17b
> [    1.404165]  </TASK>
> [    1.404165] failed when register_sysctl kern_table to kernel
> 
> ....
> ./runltp -f syscalls -d /scratch
> 
> ...
> 
> [ 1192.088987] loop0: detected capacity change from 0 to 614400
> tst_device.c:93: TINFO: Found free device 0 '/dev/loop0'
> tst_test.c:1093: TINFO: Formatting /dev/loop0 with ext4 opts='-I 256'
> extra opts=''
> mke2fs 1.46.5 (30-Dec-2021)
> [ 1192.337350] EXT4-fs (loop0): mounted filesystem
> dfe9283c-5d2f-43f8-840e-a2bbbff5b202 r/w with ordered data mode. Quota
> mode: none.
> tst_test.c:1558: TINFO: Timeout per run is 0h 05m 00s
> 
> statx06.c:140: TPASS: Birth time Passed
> statx06.c:138: TFAIL: Modified time > after_time
> statx06.c:140: TPASS: Access time Passed
> statx06.c:140: TPASS: Change time Passed
> 
> 
> links,
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230524/testrun/17171892/suite/ltp-syscalls/test/statx06/log
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230524/testrun/17171892/suite/ltp-syscalls/test/statx06/history/
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20230524/testrun/17171892/suite/ltp-syscalls/test/statx06/details/
> 
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
