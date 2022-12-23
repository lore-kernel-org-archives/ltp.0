Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8CD1C4332F
	for <ltp@archiver.kernel.org>; Fri, 23 Dec 2022 18:27:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6B3DB3CB988
	for <ltp@archiver.kernel.org>; Fri, 23 Dec 2022 19:27:38 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A9F523C0041
 for <ltp@lists.linux.it>; Fri, 23 Dec 2022 19:27:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DFE2214012DC
 for <ltp@lists.linux.it>; Fri, 23 Dec 2022 19:27:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DE57B8D049;
 Fri, 23 Dec 2022 18:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671820021;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HcH50fatDGBPfgGY2rd3d+DyI8ZDK9CMPTqNdGdSjrU=;
 b=b9QDoQ+EqCpb5JTTIcflDLx0njHuLZpLwixgs/CpSpg5JNycUJ1WDZZ0xlKl5/HWI6VLLZ
 r4d3cZuA44048k79Yc1GusmPZvUWqJN8sDwYItNyjkCv48pE7heqMUcKWD5VVeHjasavLf
 RmPazkS48iMmkLNV2v5r2F3QZEjmu1k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671820021;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HcH50fatDGBPfgGY2rd3d+DyI8ZDK9CMPTqNdGdSjrU=;
 b=83hFt0uYac1okAjk1DFezZH/FloB0gP+Tciermy5PjxHCO0W/fIuAFXCXzzDrycs7ankEq
 xpovv+9egXHgsxDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8512013913;
 Fri, 23 Dec 2022 18:27:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ajGlHfXypWMSQwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 23 Dec 2022 18:27:01 +0000
Date: Fri, 23 Dec 2022 19:26:59 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Y6Xy82HDbgARCeQr@pevik>
References: <20221216115052.30511-1-pvorel@suse.cz> <Y5xt5K1HWp8lHau8@pevik>
 <Y5xvA6FvHtzrK6kU@pevik> <Y6ApXksd2r5bY6MQ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y6ApXksd2r5bY6MQ@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] aiocp.c: TCONF on O_DIRECT on tmpfs
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > hm, it looks like it requires to skip tmpfs, as all tests TCONF:
> > > aiocp.c:231: TINFO: Maximum AIO blocks: 65536
> > > tst_device.c:541: TINFO: Use BTRFS specific strategy
> > > tst_device.c:559: TBROK: BTRFS ioctl failed. Is . on a tmpfs?: ENOTTY (25)

> > > I check if it'd work without
> > > e1b1ae66b2 ("tst_find_backing_dev: Get dev name from /sys/dev/block/*/uevent")

> > TMPDIR=/home/foo ./aiocp -b 1k -n 1 -f DIRECT # xfs
> > tst_test.c:1558: TINFO: Timeout per run is 0h 30m 30s
> > tst_test.c:1310: TINFO: xfs is supported by the test
> > aiocp.c:231: TINFO: Maximum AIO blocks: 65536
> > tst_device.c:585: TINFO: Use uevent strategy
> > aiocp.c:267: TINFO: Fill srcfile.bin with random data
> > aiocp.c:84: TBROK: write(3,0x7ffeccb9da00,60274) failed: EINVAL (22)

> > TMPDIR=/var/tmp ./aiocp -b 1k -n 1 -f DIRECT # ext4
> > tst_test.c:1558: TINFO: Timeout per run is 0h 30m 30s
> > tst_test.c:1310: TINFO: ext2/ext3/ext4 is supported by the test
> > aiocp.c:231: TINFO: Maximum AIO blocks: 65536
> > tst_device.c:585: TINFO: Use uevent strategy
> > aiocp.c:267: TINFO: Fill srcfile.bin with random data
> > aiocp.c:84: TBROK: write(3,0x7ffda9e14120,50530) failed: EINVAL (22)

> Ah, I suppose that this fails because we are wrongly passing the
> srcflags to the open() that fills the source file with random data and
> we end up passing O_DIRECT to the function that does not aling the
> buffers and sizes at all.

> Does this fix it?

Hi Cyril,

unfortunately the output is the same on all 3 tested filesystems.
Any other hint what could fix it?

Kind regards,
Petr

> diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
> index ee893ab11..a75da6a0c 100644
> --- a/testcases/kernel/io/ltp-aiodio/aiocp.c
> +++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
> @@ -263,7 +263,7 @@ static void setup(void)

>         tst_res(TINFO, "Fill %s with random data", srcname);

> -       srcfd = SAFE_OPEN(srcname, srcflags | O_RDWR | O_CREAT, 0666);
> +       srcfd = SAFE_OPEN(srcname, O_WRONLY | O_CREAT, 0666);
>         fill_with_rand_data(srcfd, filesize);
>         SAFE_CLOSE(srcfd);
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
