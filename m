Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4766C76188
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 21:59:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 23C523CB7BF
	for <ltp@archiver.kernel.org>; Tue,  4 Apr 2023 23:59:32 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D964C3C0162
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 23:59:22 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 40DCC6007A2
 for <ltp@lists.linux.it>; Tue,  4 Apr 2023 23:59:21 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id AD7B763597;
 Tue,  4 Apr 2023 21:59:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0734DC433EF;
 Tue,  4 Apr 2023 21:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680645560;
 bh=QNgSjQvJITJMgoKj2i5Zz2ZqvZhvgavpxmMGI8Fys0w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=j9KJ+s0UbSDBxtjcNdUVRZydP68m6SIZEUB3BR8aNnQkw+BSEePmlHaqTdbqTSGDY
 44PPdXX+b0QO8hMmP5qEppst9RmolTO84W9IJphHBmoXPR2iBTB9MQMuzKlTPaV3ye
 5VEkGPMwZ7xJQZXHFrFY5tDn4vzvi4RkA+aK8Xq4AqRGn6m+fSjllz9OCszsfmWjXW
 GBoEMIhhSW9JYoeRNNgUVMUsMhiva8N3CBjeHixqwo0CiAxXe0J5Bl6Dm3Giu7artN
 IH9O+ttzX0u43gX+CkIoHTU55NFpxpfM1C5VUBgXSShFmIWwUjGSqqdQpcg1aka3oL
 OwFxi8zh2w+ng==
Date: Tue, 4 Apr 2023 14:59:18 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230404215918.GA1893@sol.localdomain>
References: <ZCsHKmFrUdBw3xEw@gmail.com>
 <1680593430-14728-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680593430-14728-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1680593430-14728-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] syscalls/statx11: Add basic test for
 STATX_DIOALIGN on block device
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Yang,

On Tue, Apr 04, 2023 at 03:30:29PM +0800, Yang Xu wrote:
> +	/*
> +	 * This test is tightly coupled to the kernel's current DIO restrictions
> +	 * on block devices. The general rule of DIO needing to be aligned to the
> +	 * block device's logical block size was recently relaxed to allow user buffers

Please don't use the word "recently" in code comments like this.  It is vague,
and what is "recent" now will no longer be recent in the future.

> +
> +	TST_EXP_PASS(statx(AT_FDCWD, tst_device->dev, 0, 0, &buf),
> +		"statx(AT_FDCWD, %s, 0, STATX_DIOALIGN, &buf)", tst_device->dev);
> +	TST_EXP_EQ_LU(buf.stx_dio_mem_align, 0);
> +	TST_EXP_EQ_LU(buf.stx_dio_offset_align, 0);

Like I mentioned on patch 2, this is not a valid test case because the contract
of statx() allows it to return information that wasn't explicitly requested.

> +static void setup(void)
> +{
> +	char *dev_name;
> +	int dev_fd;
> +
> +	dev_fd = SAFE_OPEN(tst_device->dev, O_RDWR);
> +	SAFE_IOCTL(dev_fd, BLKSSZGET, &logical_sector_size);
> +	SAFE_CLOSE(dev_fd);
> +
> +	if (logical_sector_size <= 0)
> +		tst_brk(TBROK, "BLKSSZGET returned invalid block size %i", logical_sector_size);
> +
> +	dev_name = basename((char *)tst_device->dev);
> +	sprintf(sys_bdev_lgs_path, "/sys/block/%s/queue/logical_block_size", dev_name);
> +	while (access(sys_bdev_lgs_path, F_OK) != 0) {
> +		dev_name[strlen(dev_name)-1] = '\0';
> +		sprintf(sys_bdev_lgs_path, "/sys/block/%s/queue/logical_block_size", dev_name);
> +	}

What does "lgs" stand for?

Why are both BLKSSZGET and /sys/block/%s/queue/logical_block_size being used?
Don't they provide exactly the same information?

> +	if (access(sys_bdev_dma_path, F_OK) != 0)
> +		tst_brk(TCONF, "dma_alignment syfsfile doesn't exist");
> +}

syfsfile => sysfs file

> +static void cleanup(void)
> +{
> +	if (fd > -1)
> +		SAFE_CLOSE(fd);
> +}

What is the purpose of the 'fd' variable?

> +static struct tst_test test = {
> +	.test_all = verify_statx,
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.needs_root = 1,
> +	.needs_device = 1,
> +};

Why does this test need root?

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
