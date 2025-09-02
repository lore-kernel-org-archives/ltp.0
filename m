Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BCB1CA1007
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 02:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756779445; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=PUYlFRUH0v9UwM8+t/XdAK4n63XUGWwKAJgLVjC0Bt4=;
 b=dL72hPsXFbirWvHsURGcZsj2gissdbk+ZVmyi+be5uQk7ZMlu1++Cto2EmCKop5cjV2sg
 cNk9ZXBHhQT2hJkQpRdGS2x189o7bGBHfK+LqdczdLdq6Lg1gW5m1AfFxWFIVJY0/cQd7GH
 J8TmmNNHODqsMdvDaEkqf8PnafTLoXA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B97D3CD366
	for <ltp@archiver.kernel.org>; Tue,  2 Sep 2025 04:17:25 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F16F83CD2A0
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 04:17:03 +0200 (CEST)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2FE482003B3
 for <ltp@lists.linux.it>; Tue,  2 Sep 2025 04:17:02 +0200 (CEST)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-afeec747e60so753061066b.0
 for <ltp@lists.linux.it>; Mon, 01 Sep 2025 19:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756779421; x=1757384221; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=nw5RQ/rETGiePpnMyvi2BcJGELw5fz6rmnfqpNE1h4g=;
 b=GBgkorGAYb7+SGplj8VjrDdvFAvPBaHoa86BPUCocu2jebWBVjMSy+i9LWDgWbuJgU
 ESNS4PdYS+CRFtzKp3BSg5QmeCXDkoEcQ5YIgV57BWLr9BL0ZBMghs7t3w067BLMHywb
 ONgir322p9b59Edxbg7Myvpzey4V/FTuLCAODW6mVZgTCPBoxZulhNoDY3J0NVhGbg9x
 N3TH96Yz+ySVvpRlZl2QcjAdIetHTSp1nywUdWUKLnDXu2uU4XBcOk1PrKNPpLIrj91s
 B+Aal/YJy9QfDtsg8y8lLl9PaIzmHYa3BSA+dayJzyFvXfLH00l2lSxrqwHKtJVU528p
 1uvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756779421; x=1757384221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nw5RQ/rETGiePpnMyvi2BcJGELw5fz6rmnfqpNE1h4g=;
 b=Fq3Y8UbddD2I2GbP6T1QLO9VwYPIG0J4guWeJAqw3YllrtmXG905hwCK3uQPLNCwVv
 x5N76lozjyPb6/Ydn7NBfz6cxYIICyEKN96aIqsLyX2nzoNXrY3hh+xCCCfCJ1lNaf24
 0BKiSnkX9LZ5CXW68nGSS9JViJQ9t9iF4lRCgtfcXAAjVp32ckDyrL14xJKMMV2Yg6Fd
 nh8fCKLYamKlPm3/LvAXtv+lIpj9atznTM/03pAM3slzMiyklgzph5lOmgPUvCXEGVsr
 xis65sbfc7WoxsPlbs84Pb8M1FLSTR3GyJIYSpcl7Fs4DctZ/U703jMnjotMKwAbjsGN
 w1AA==
X-Gm-Message-State: AOJu0Yz/Qcg8DvWGsVqJQlzH5obyJLLfdqGSgIoectsFW4FtZlUxMfoD
 sD0iiQTxi+AiGNeuXkB0IWPi1MOMLjZ2We1yUREFY4vRuaf4NaXYqWN1zoCHgMpsfw==
X-Gm-Gg: ASbGncufiF0aZbgIw0rGRohZlR17b8jb2lg12UDN1qY9GP7BgkzIYBNv7+mwfvZ+QxE
 txMFanjpafs5TyYjJRsyjZkH3wDZ4571znGkGK5+Owp0A1M+edpH/7G1CYFviN/Zx+DiO9Rn2he
 qKRSqevvsVdOSDrV0NMeehHs6D6trekSRLKHiQ5kfsRFggpdw8JZ88rmHHKQc6SolUuqzkmwmGk
 P14iNodb/iuY67LvgbhUs/0eTi6wHWXnHWXTkoxYB6nLiThYHjPs1Dy+ifsVsFSXXe/HhLW+17v
 YfPCPSrKR5j8bODeajwZnWUUiHQNOY5WRyJOM3iRTE+YqFcuJ6dGWbriqjmh7LU/f47WLK+wGgY
 lT1mSX9LGJEshJ/frXt1XXlrs/HiQUsXL6PjmvSCzLISrMy+pZ/chJw==
X-Google-Smtp-Source: AGHT+IHlGHUvuuiwqlHJ10okvlVE5vYQ/kbjtRBRvVcP8vLbidloM9pbYjWta+SX7gN9ngTKLqqWtw==
X-Received: by 2002:a17:907:944c:b0:afe:d49d:2888 with SMTP id
 a640c23a62f3a-b01f20e0d46mr953666866b.65.1756779421506; 
 Mon, 01 Sep 2025 19:17:01 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0410138d0asm591220566b.53.2025.09.01.19.17.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Sep 2025 19:17:01 -0700 (PDT)
Date: Tue, 2 Sep 2025 02:16:59 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aLZTmymGW8khKbVt@localhost>
References: <20250901074758.5094-1-wegao@suse.com>
 <20250901103805.GA30224@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250901103805.GA30224@pevik>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] ioctl_loop01.c: Use proper device for
 partitioning
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Sep 01, 2025 at 12:38:05PM +0200, Petr Vorel wrote:
> Hi Wei,
> 
> > This is same patch used on ioctl09,the page cache of loop0 can cache old
> > version of the partition table which is then used by the partitioning
> > code. Fix the problem by calling parted against the loop device directly.
> 
> > Link: https://lore.kernel.org/ltp/20250829141932.31997-1-jack@suse.cz/
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  testcases/kernel/syscalls/ioctl/ioctl_loop01.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> > diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> > index c9137bf1e..5ee7a474a 100644
> > --- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> > +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> > @@ -98,7 +98,7 @@ static void verify_ioctl_loop(void)
> >  static void setup(void)
> >  {
> >  	int ret;
> > -	const char *const cmd_parted[] = {"parted", "-s", "test.img", "mklabel", "msdos", "mkpart",
> > +	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
> >  	                                  "primary", "ext4", "1M", "10M", NULL};
> 
> Indeed I was able to trigger the same error:
> 
> [ 2642.979234] ioctl_loop01
> [ 2642.997424] loop8: detected capacity change from 0 to 20480
> [ 2643.015094]  loop8: p1
> [ 2643.040903] blk_update_request: I/O error, dev loop8, sector 20352 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> [ 2643.042105] blk_update_request: I/O error, dev loop8, sector 20352 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [ 2643.043361] Buffer I/O error on dev loop8p1, logical block 2288, async page read
> [ 2643.044539] __loop_clr_fd: partition scan of loop8 failed (rc=-16)
> [ 2643.097517] blk_update_request: I/O error, dev loop8, sector 20352 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0
> [ 2643.098175] blk_update_request: I/O error, dev loop8, sector 20352 op 0x0:(READ) flags 0x0 phys_seg 1 prio class 0
> [ 2643.098767] Buffer I/O error on dev loop8p1, logical block 2288, async page read
> [ 2643.109133] ioctl_ficlone02
> [ 2643.109824] loop8: detected capacity change from 0 to 614400
> [ 2643.175605] /dev/zero: Can't open blockdev
> [ 2643.307531] EXT4-fs (loop8): mounting ext2 file system using the ext4 subsystem
> [ 2643.312401] EXT4-fs (loop8): mounted filesystem without journal. Opts: (null). Quota mode: none.
> [ 2643.471527] EXT4-fs (loop8): mounting ext3 file system using the ext4 subsystem
> [ 2643.476826] EXT4-fs (loop8): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
> [ 2643.644734] EXT4-fs (loop8): mounted filesystem with ordered data mode. Opts: (null). Quota mode: none.
> 
> But you change introduces one TCONF:
> 
> --- old	2025-09-01 05:05:50.401105483 -0400
> +++ new	2025-09-01 05:05:01.925105483 -0400
> @@ -5,6 +5,7 @@
>  tst_kconfig.c:678: TINFO: CONFIG_FAULT_INJECTION kernel option detected which might slow the execution
>  tst_test.c:1827: TINFO: Overall timeout per run is 0h 02m 04s
>  tst_device.c:99: TINFO: Found free device 6 '/dev/loop6'
> +ioctl_loop01.c:119: TCONF: parted exited with 1
>  tst_buffers.c:57: TINFO: Test is using guarded buffers
>  ioctl_loop01.c:84: TPASS: /sys/block/loop6/loop/partscan = 0
>  ioctl_loop01.c:85: TPASS: /sys/block/loop6/loop/autoclear = 0
> @@ -12,18 +13,16 @@
>  ioctl_loop01.c:56: TPASS: get expected lo_flag 12
>  ioctl_loop01.c:58: TPASS: /sys/block/loop6/loop/partscan = 1
>  ioctl_loop01.c:59: TPASS: /sys/block/loop6/loop/autoclear = 1
> -ioctl_loop01.c:68: TPASS: access /dev/loop6p1 succeeds
> -ioctl_loop01.c:74: TPASS: access /sys/block/loop6/loop6p1 succeeds
> +ioctl_loop01.c:62: TINFO: Current environment doesn't have parted disk, skip it
>  ioctl_loop01.c:90: TINFO: Test flag can be clear
>  ioctl_loop01.c:56: TPASS: get expected lo_flag 8
>  ioctl_loop01.c:58: TPASS: /sys/block/loop6/loop/partscan = 1
>  ioctl_loop01.c:59: TPASS: /sys/block/loop6/loop/autoclear = 0
> -ioctl_loop01.c:68: TPASS: access /dev/loop6p1 succeeds
> -ioctl_loop01.c:74: TPASS: access /sys/block/loop6/loop6p1 succeeds
> +ioctl_loop01.c:62: TINFO: Current environment doesn't have parted disk, skip it
>  
>  Summary:
> -passed   13
> +passed   9
>  failed   0
>  broken   0
> -skipped  0
> +skipped  1
>  warnings 0
> 
> That means your change effectively disable that code. => NACK
> 
> in ioctl09.c uses the first command with "test.img", then loop device on the
> second run.
> 
> Surprisingly trying to attach helps 'parted' to use it, although it produces a
> warning:
> 
> +++ testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> @@ -106,6 +106,7 @@ static void setup(void)
>                 tst_brk(TBROK, "Failed to find free loop device");
> 
>         tst_fill_file("test.img", 0, 1024 * 1024, 10);
> +       tst_attach_device(dev_path, "test.img");
> 
>         ret = tst_cmd(cmd_parted, NULL, NULL, TST_CMD_PASS_RETVAL);
>         switch (ret) {
> 
> tst_device.c:99: TINFO: Found free device 9 '/dev/loop9'
> tst_buffers.c:57: TINFO: Test is using guarded buffers
> tst_device.c:176: TWARN: ioctl(/dev/loop9, LOOP_SET_FD, test.img) failed: EBUSY (16)
Thanks for your investigation.
You add tst_attach_device in setup, then second call tst_attach_device
in verify_ioctl_loop trigger this TWARN, I will send second patch.
> ioctl_loop01.c:84: TPASS: /sys/block/loop9/loop/partscan = 0
> ioctl_loop01.c:85: TPASS: /sys/block/loop9/loop/autoclear = 0
> ioctl_loop01.c:86: TPASS: /sys/block/loop9/loop/backing_file = '/tmp/LTP_iocfMLSpX/test.img'
> ioctl_loop01.c:56: TPASS: get expected lo_flag 12
> ioctl_loop01.c:58: TPASS: /sys/block/loop9/loop/partscan = 1
> ioctl_loop01.c:59: TPASS: /sys/block/loop9/loop/autoclear = 1
> ioctl_loop01.c:68: TPASS: access /dev/loop9p1 succeeds
> ioctl_loop01.c:74: TPASS: access /sys/block/loop9/loop9p1 succeeds
> ioctl_loop01.c:90: TINFO: Test flag can be clear
> ioctl_loop01.c:56: TPASS: get expected lo_flag 8
> ioctl_loop01.c:58: TPASS: /sys/block/loop9/loop/partscan = 1
> ioctl_loop01.c:59: TPASS: /sys/block/loop9/loop/autoclear = 0
> ioctl_loop01.c:68: TPASS: access /dev/loop9p1 succeeds
> ioctl_loop01.c:74: TPASS: access /sys/block/loop9/loop9p1 succeeds
> 
> Of course TWARN is also no-go.
> @Jan @Cyril @Li Any hint what am I missing.
> 
> Besides missing there is missing TST_CMD_TCONF_ON_MISSING on the flags (see
> today's fix [1]), but that's minor.
> 
> Kind regards,
> Petr
> 
> [1] https://github.com/linux-test-project/ltp/commit/9691c4b2bea4f772d61ca9e9a93d2087c88f6040

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
