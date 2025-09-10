Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6618CA0FED
	for <ltp@archiver.kernel.org>; Wed, 10 Sep 2025 01:35:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757468140; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=xx2EtjZB9b4ITvl68SpQdwMMo/4wIhE7TKB2dfhFPyQ=;
 b=GK9imM9VO1OFXnlLAew8tzG2NZ4XCX7cdqN2HnnwnKpjAf/tZolA6ypewoqKlmPBAx9r7
 SboJyf7SCI34vwdrzmXPQAAYE6KsBmP5227vT68HJRGYLLTY/9wTF6Ah/jmVpQIr0jBAXy5
 z0z+VV7Urim25f7ol8n+MHB7MHx3c1Y=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85ED03CD783
	for <ltp@archiver.kernel.org>; Wed, 10 Sep 2025 03:35:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F189C3C7A25
 for <ltp@lists.linux.it>; Wed, 10 Sep 2025 03:35:20 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0167C600740
 for <ltp@lists.linux.it>; Wed, 10 Sep 2025 03:35:19 +0200 (CEST)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-afcb7322da8so1172209966b.0
 for <ltp@lists.linux.it>; Tue, 09 Sep 2025 18:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1757468119; x=1758072919; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Y/NqnWjLd8Mc8mIA1D2vZ3USBHk5C2FZ7g55f1PPNk0=;
 b=CwiGAijO89A+Vm3yHJin6Nj/Ta+M/aqJnQrimpzDZxaPvebp75e45DxbqZ6uUHRAZT
 VOYewNLO3JBpcC1d13s58d1EorOpoM8+b5tjcUGLdBd7VOxTDWSdgtJM3dCzz640mdJe
 SjHZbDk/vyvpcvjmX6ulsgoTnDsirKoqvPIljrp8oEa+Quuv9DXEFZX7Qs2/VXV+v+jZ
 gJ69v97rY7MLu+3MXQDhjDvX6FO1TPMDHOJYQ3ibdtNFLQbbDmDrjajHLaRtVyQIoNk1
 rzT0tGrGuWVMeb+Mu/s8H9X3ExBRd/DSEZ1qFeHNg205V/yr4gtq2t82gT+FeIR66xA8
 VyYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757468119; x=1758072919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y/NqnWjLd8Mc8mIA1D2vZ3USBHk5C2FZ7g55f1PPNk0=;
 b=MNk8C3ek9+TjdYC/sFvvp/xSBvfeMVdavmW3kDj4H5rdptZ+w0gKZHNTDZJF4/54zm
 kP3urL8h57nN3UGOtUJePSI0utyduxgTNdIiVawHpOn0I4NNd7IAxMXx6qHx8/pJFthw
 +693et45O1W6U1Jwo8rWbnsSnZhad91DmfvHgR2/vPOGVBXyD/i6YOMdWSAOWJjvbNsl
 ed+L2xPWHQS2WnyINCVZjH9ujNG3sfVbjyy6OhgBJbx7QNa5T5neVoh1JB6eIz5NbnQu
 axPLeQtyRrXFRxUlX3KjLcDf5kabZ1BdRxqobhSx+VXtLRsw90+cWYUqo79mp158GUf9
 ievw==
X-Gm-Message-State: AOJu0YzJ/i4YBbx6oKw3ncScQENCRPa7Bwmyew1CwysrBvRWEOUEidRP
 vdv4dBpx2MaGgZf6aTYlRLcnky+YgwtXoU6AL5ZC72TOOHy8x0PcMURTilnxOL9LeA==
X-Gm-Gg: ASbGnctaWq0RXhNXwggJxfLBquaTLF83zPVhJqQJr/gObsgbReHbjQV72EYBxvsz4lu
 yuZdNqIH1spye5xsNrTXHEnH5PwvYjbl5905Oe/rCOXl6SE/HlUdaIqI6lI0CX+cMkzePLg14b4
 qZzfLJ306xFNC/5VH0tm0OMwUoOejV05BtrY7o5U1NtMQovCU6IaTUsoy9Vyu65We3zD2rKa3Q/
 AEUD9sG2jb1/xbB3o2n4uDdynExfIaAmZxXrcNk6OUpsjT2gSoA453M1f8fuSSLhJwNToHf8ScY
 bI6C8wLcQZCA3qgWBqrX1+UhAMuR1JICrCB3qI17BejcpQ5gMKsC1omdFeg3/86Xwgk5syGzHsk
 4yDx/ErIeQIBStq/e+uKAlImiL9u/3QAJ4RzxKNsXttK/ifPQ1MCxug==
X-Google-Smtp-Source: AGHT+IHB7JZ+W1LQWPUuF7U86bcQpTu/wFSd810ileVYUELdQBsU/NR/hG7clbVq/GLZYK50zzeOxw==
X-Received: by 2002:a17:907:6d0d:b0:ae3:8c9b:bd61 with SMTP id
 a640c23a62f3a-b04b13fb3d7mr1331619666b.12.1757468119265; 
 Tue, 09 Sep 2025 18:35:19 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b07830451a0sm77646566b.21.2025.09.09.18.35.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 18:35:18 -0700 (PDT)
Date: Wed, 10 Sep 2025 01:35:17 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aMDV1aTCZ--ElqfY@localhost>
References: <20250902031236.5719-1-wegao@suse.com>
 <20250902111809.6071-1-wegao@suse.com> <aMAUhpxi1GaDBfGF@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aMAUhpxi1GaDBfGF@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ioctl_loop01.c: Use proper device for
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

On Tue, Sep 09, 2025 at 01:50:30PM +0200, Cyril Hrubis wrote:
> Hi!
> >  .../kernel/syscalls/ioctl/ioctl_loop01.c      | 34 ++++++++-----------
> >  1 file changed, 15 insertions(+), 19 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> > index c9137bf1e..b70e9fc22 100644
> > --- a/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> > +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop01.c
> > @@ -78,7 +78,21 @@ static void check_loop_value(int set_flag, int get_flag, int autoclear_field)
> >  
> >  static void verify_ioctl_loop(void)
> >  {
> > +	int ret;
> > +	const char *const cmd_parted[] = {"parted", "-s", dev_path, "mklabel", "msdos", "mkpart",
> > +					"primary", "ext4", "1M", "10M", NULL};
> > +
> > +	tst_fill_file("test.img", 0, 1024 * 1024, 10);
> >  	tst_attach_device(dev_path, "test.img");
> > +
> > +	ret = tst_cmd(cmd_parted, NULL, NULL, TST_CMD_PASS_RETVAL);
> > +	if (!ret)
> > +		parted_sup = 1;
> > +	else if (ret == 255)
> > +		tst_res(TCONF, "parted binary not installed or failed");
> > +	else
> > +		tst_res(TCONF, "parted exited with %i", ret);
> 
> The test should have needs_cmds set to parted (we do that properly in
> ioctl09.c) then we do not have to handle the 255 exit code here since
> the test would be skipped if it's missing.

If we use needs_cmds all the check will be skipped in this case.

Current test case will still continue do some check even parted is
missing. Such as following test log:

tst_tmpdir.c:316: TINFO: Using /tmp/LTP_iocxxPKhg as tmpdir (ext2/ext3/ext4 filesystem)
tst_test.c:2004: TINFO: LTP version: 20250130-399-g47167e082
tst_test.c:2007: TINFO: Tested kernel: 6.11.0-1027-oem #27-Ubuntu SMP PREEMPT_DYNAMIC Tue Jul 22 06:12:35 UTC 2025 x86_64
tst_kconfig.c:88: TINFO: Parsing kernel config '/lib/modules/6.11.0-1027-oem/build/.config'
tst_test.c:1825: TINFO: Overall timeout per run is 0h 00m 31s
tst_device.c:98: TINFO: Found free device 14 '/dev/loop14'
tst_buffers.c:57: TINFO: Test is using guarded buffers
ioctl_loop01.c:92: TCONF: parted binary not installed or failed
ioctl_loop01.c:98: TPASS: /sys/block/loop14/loop/partscan = 0
ioctl_loop01.c:99: TPASS: /sys/block/loop14/loop/autoclear = 0
ioctl_loop01.c:100: TPASS: /sys/block/loop14/loop/backing_file = '/tmp/LTP_iocxxPKhg/test.img'
ioctl_loop01.c:56: TPASS: get expected lo_flag 12
ioctl_loop01.c:58: TPASS: /sys/block/loop14/loop/partscan = 1
ioctl_loop01.c:59: TPASS: /sys/block/loop14/loop/autoclear = 1
ioctl_loop01.c:62: TINFO: Current environment doesn't have parted disk, skip it
ioctl_loop01.c:104: TINFO: Test flag can be clear
ioctl_loop01.c:56: TPASS: get expected lo_flag 8
ioctl_loop01.c:58: TPASS: /sys/block/loop14/loop/partscan = 1
ioctl_loop01.c:59: TPASS: /sys/block/loop14/loop/autoclear = 0
ioctl_loop01.c:62: TINFO: Current environment doesn't have parted disk, skip it

Summary:
passed   9
failed   0
broken   0
skipped  1
warnings 0

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
