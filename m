Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A91D4CFD37D
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 10:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764065657; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=AxNjpsq64Hg9G0PFjAwqL2uaMqYsW9QxyYlJccldxUI=;
 b=aZVeP4khegaABfTAR0Z1S4a+H2t8ZP+yck3yXIRavemPmVwEeTk5FHCnVI9YnXkmyUxZF
 bzlDjlVBj16w53F48jYOUuioDFjlTR2HUn5Da4gSw6aWn5T+TwP24RjjhxsTDRrCgW2XYqg
 fQCuITnY19VpKFdFtVxixX1t6xGaS2s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 001473CC753
	for <ltp@archiver.kernel.org>; Tue, 25 Nov 2025 11:14:16 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B03BC3C560F
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 11:13:55 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A5CD11A0089B
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 11:13:54 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-47775fb6cb4so34708675e9.0
 for <ltp@lists.linux.it>; Tue, 25 Nov 2025 02:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1764065634; x=1764670434; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=akkccM3IvNNQmmkmFRy2a+JX92ormoEOBN5rH1qdfnI=;
 b=Ieo/fD7Il/V4nE/BqLF54vXLFdKCVCSjd1YBbVf5ZKNaN/MycscMOy3q7AhtlvFWyK
 AyISGTPKhfctT4frdBVn5ayRaoSQq12+m/0GPUpSfiPvjR+yIk617XB1PGhL6UaFg6iT
 HzxQaXTLXxEpA8VANi9n6KXlguL4Lz1edPA6fbzSF0HfFofmjN1RpRGiaYEYcC9tdSaS
 Hi9Qx/1SCsQPaS1wVFII8OA6gZm69cCj11o9LfZJ/I5JYWR/vuRvZWXWzJvf9Xdyd5Ve
 OzaxnzrMYZcj4fyz+Yqent59XbWQWFtqGGHeB9/I1G8HJVDsICP0QtpxQMrPtbPsMBmr
 Z0oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764065634; x=1764670434;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=akkccM3IvNNQmmkmFRy2a+JX92ormoEOBN5rH1qdfnI=;
 b=Wr0XeNZf+2oRGEN01M3CH09Huw3RHabyXs2tJIIT/ILfA5p4HepF4fi5uzhdbVuXFy
 F/Dy6241gbYTURxjjuUEcZZlSNdVehaUacow8dG7UB1Cz6IMlqXeDtA4DS/Sxdwyh4IR
 pRRG7fMqSxoayOUDZ4bFpUziQRVYSYpFnkPhBI+1+PglRb6y3hUmLQV1ZGoNI5xrGRu2
 OU/YLm6KAHMxnkOGxq9JKDz55I679uUamJwwopCfNTuO8OlU+jfYVvebrCDN/30OZ3Tg
 eRnWofmViHYL86Xz6ZyAcKyWlyG9JZ1cTLDgmXZ6bs0Dj18+1Fl3k12bfj4uykUbgegy
 K/Ww==
X-Forwarded-Encrypted: i=1;
 AJvYcCVzsInIhoF+R6rmGctN8BtbWM8hInB96kAagMIGpXAm8lN19v6HzFnpKqQApOvNmMAn24s=@lists.linux.it
X-Gm-Message-State: AOJu0Yye9TfFH4DAsT/LG/I//v3qCmPIEerPSyEEZpsUZIDlnhM+p5BQ
 HSnykB1rAai3AK9BQgbGGtfb4zOdb1EJa66ZOEP55+vcqs+Tz5wDl+X6qa1k3E6yyw==
X-Gm-Gg: ASbGncvJqFG6x0G/c25FdnB5cFIRW9MXElB4fblfkIl68tSFkWFUUZAEIypcZBgnUgJ
 /kB36Ghm2ZVFs6c9Dd9hrcQvOQDSaFl5aa5E1qEl5veGETjKesSKTJxv2kMi34KIrF2cPRUIMBA
 d3isXlzSmOTqcx3z2IxJdoATUBelcW09FhukaPhPGjcX3ydvQA8TuCmmm4r9Bvs7/Z1wftp7Rh0
 My3PRqpDPESyhqKW34Gmvhwk3qsqBT7DuXOJvZFW0RM/fSimuYFTyrcuNkmqEuGDo0lwFQNOhqK
 7K4FI+pj5TG+i/m7vhbKJx/CZHi6Xi2vUFR9qnHJnTvW9MtzImiRHxJlyowf3XaCZnLZjFGyWNg
 8L3Z0CjgnyiXg+Io2vUDJxdzTzxg3enbYfyle0UcrKcunUzNWe8Cqikfx+jPFmzyHu7g6hl3xmj
 8Xrf9npxs5ExpyddqHrdyMZdcPZysu
X-Google-Smtp-Source: AGHT+IEghEzgUX7Y0DHR7Corjv/jFDgAqklVg667PjjHhJI7QMm8NG+RfxT3xnDSPr2BmlCO19kDgg==
X-Received: by 2002:a05:600c:a08:b0:477:aed0:f401 with SMTP id
 5b1f17b1804b1-477c11254damr147976645e9.23.1764065633880; 
 Tue, 25 Nov 2025 02:13:53 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42cb7fb8ff3sm35140056f8f.29.2025.11.25.02.13.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 02:13:53 -0800 (PST)
Date: Tue, 25 Nov 2025 10:13:51 +0000
To: kernel test robot <oliver.sang@intel.com>
Message-ID: <aSWBX1urcixS1Fl8@autotest-wegao.qe.prg2.suse.org>
References: <202511251629.ccc5680d-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202511251629.ccc5680d-lkp@intel.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linus:master] [fs/namespace] 78f0e33cd6:
 ltp.listmount04.fail
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 lkp@intel.com, linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev,
 Andrei Vagin <avagin@google.com>, linux-fsdevel@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Tue, Nov 25, 2025 at 04:33:35PM +0800, kernel test robot wrote:
> 
> 
> Hello,
> 
> kernel test robot noticed "ltp.listmount04.fail" on:
> 
> commit: 78f0e33cd6c939a555aa80dbed2fec6b333a7660 ("fs/namespace: correctly handle errors returned by grab_requested_mnt_ns")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> [test failed on      linus/master fd95357fd8c6778ac7dea6c57a19b8b182b6e91f]
> [test failed on linux-next/master d724c6f85e80a23ed46b7ebc6e38b527c09d64f5]
> 
> in testcase: ltp
> version: 
> with following parameters:
> 
> 	disk: 1SSD
> 	fs: btrfs
> 	test: syscalls-06/listmount04
> 
> 
> 
> config: x86_64-rhel-9.4-ltp
> compiler: gcc-14
> test machine: 4 threads 1 sockets Intel(R) Core(TM) i3-3220 CPU @ 3.30GHz (Ivy Bridge) with 8G memory
> 
> (please refer to attached dmesg/kmsg for entire log/backtrace)
> 
> 
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <oliver.sang@intel.com>
> | Closes: https://lore.kernel.org/oe-lkp/202511251629.ccc5680d-lkp@intel.com
> 
> 2025-11-20 21:35:09 export LTP_RUNTIME_MUL=2
> 2025-11-20 21:35:09 export LTPROOT=/lkp/benchmarks/ltp
> 2025-11-20 21:35:09 kirk -U ltp -f temp_single_test -d /fs/sdb1/tmpdir
> Host information
> 
> 	Hostname:   lkp-ivb-d04
> 	Python:     3.13.5 (main, Jun 25 2025, 18:55:22) [GCC 14.2.0]
> 	Directory:  /fs/sdb1/tmpdir/kirk.root/tmp9k8rfwr2
> 
> Connecting to SUT: default
> 
> Starting suite: temp_single_test
> ---------------------------------
> [1;37mlistmount04: [0m[1;31mfail[0m  (0.016s)
>                                                                                                                                 
> Execution time: 0.085s
> 
> 	Suite:       temp_single_test
> 	Total runs:  1
> 	Runtime:     0.016s
> 	Passed:      7
> 	Failed:      1
> 	Skipped:     0
> 	Broken:      0
> 	Warnings:    0
> 	Kernel:      Linux 6.18.0-rc1-00119-g78f0e33cd6c9 #1 SMP PREEMPT_DYNAMIC Fri Nov 21 04:59:36 CST 2025
> 	Machine:     unknown
> 	Arch:        x86_64
> 	RAM:         6900660 kB
> 	Swap:        0 kB
> 	Distro:      debian 13
> 
> Disconnecting from SUT: default
> Session stopped
> 
> 
> 
> The kernel config and materials to reproduce are available at:
> https://download.01.org/0day-ci/archive/20251125/202511251629.ccc5680d-lkp@intel.com
> 
> 
> 
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

I guess LTP failed message is "listmount04.c:128: TFAIL: invalid mnt_id_req.spare expected EINVAL: EBADF (9) " ?  Since i have not find LTP failure log in this email thread.

Base on kernel change remove spare and add new mnt_ns_fd but LTP listmount04 still set spare.
I suppose LTP case need update base latest change of kernel?

Kernel:
  */
 struct mnt_id_req {
  __u32 size;
- __u32 spare;                                   <<<<<<<<
+ __u32 mnt_ns_fd;                          <<<<<<<<
  __u64 mnt_id;
  __u64 param;
  __u64 mnt_ns_id;

LTP case:
 {
.req_usage = 1,
.size = MNT_ID_REQ_SIZE_VER0,
.spare = -1,                                              <<<<<<<
.mnt_id = LSMT_ROOT,
.mnt_ids = mnt_ids,
.nr_mnt_ids = MNT_SIZE,
.exp_errno = EINVAL,
.msg = "invalid mnt_id_req.spare",
},


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
