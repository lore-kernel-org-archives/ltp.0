Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AF92C4332F
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 12:06:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 56EBD3CBAFE
	for <ltp@archiver.kernel.org>; Mon, 19 Dec 2022 13:06:18 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B11CF3C6C93
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 13:06:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DAF6F600696
 for <ltp@lists.linux.it>; Mon, 19 Dec 2022 13:06:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D437D3786F;
 Mon, 19 Dec 2022 12:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671451567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TeMJivJfbArR4iEFDcPsryij7kM2ma6Q+N+FALF/LSA=;
 b=WiwBcLJ8KIfPM/mJj4FE66HqWC0HgLH5UzvuWyW0KcI/qGLh/QLj9eZ840EUtb+Rqq3yBA
 VXfXdHDus3gB6eNMzzkeu/y82/xfb0809gL+Gw/BID2sVhZ3kkz795Ko90JCsxqmQqnDRq
 SrngP/qvlqSNC573jPqBDLGud6+cAp8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671451567;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TeMJivJfbArR4iEFDcPsryij7kM2ma6Q+N+FALF/LSA=;
 b=t0QrignvHASeOGsQwgGQ+8LyaQOJDRJUxVOh5sAGLloCH5ZM3SDytZZbFt9E4O0p8+nkIu
 0iSXrHb6bpiOM8DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC5F013910;
 Mon, 19 Dec 2022 12:06:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id r7eULa9ToGOzbgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 19 Dec 2022 12:06:07 +0000
Date: Mon, 19 Dec 2022 13:07:21 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Y6ApXksd2r5bY6MQ@yuki>
References: <20221216115052.30511-1-pvorel@suse.cz> <Y5xt5K1HWp8lHau8@pevik>
 <Y5xvA6FvHtzrK6kU@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5xvA6FvHtzrK6kU@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > hm, it looks like it requires to skip tmpfs, as all tests TCONF:
> > aiocp.c:231: TINFO: Maximum AIO blocks: 65536
> > tst_device.c:541: TINFO: Use BTRFS specific strategy
> > tst_device.c:559: TBROK: BTRFS ioctl failed. Is . on a tmpfs?: ENOTTY (25)
> 
> > I check if it'd work without
> > e1b1ae66b2 ("tst_find_backing_dev: Get dev name from /sys/dev/block/*/uevent")
> 
> TMPDIR=/home/foo ./aiocp -b 1k -n 1 -f DIRECT # xfs
> tst_test.c:1558: TINFO: Timeout per run is 0h 30m 30s
> tst_test.c:1310: TINFO: xfs is supported by the test
> aiocp.c:231: TINFO: Maximum AIO blocks: 65536
> tst_device.c:585: TINFO: Use uevent strategy
> aiocp.c:267: TINFO: Fill srcfile.bin with random data
> aiocp.c:84: TBROK: write(3,0x7ffeccb9da00,60274) failed: EINVAL (22)
> 
> TMPDIR=/var/tmp ./aiocp -b 1k -n 1 -f DIRECT # ext4
> tst_test.c:1558: TINFO: Timeout per run is 0h 30m 30s
> tst_test.c:1310: TINFO: ext2/ext3/ext4 is supported by the test
> aiocp.c:231: TINFO: Maximum AIO blocks: 65536
> tst_device.c:585: TINFO: Use uevent strategy
> aiocp.c:267: TINFO: Fill srcfile.bin with random data
> aiocp.c:84: TBROK: write(3,0x7ffda9e14120,50530) failed: EINVAL (22)

Ah, I suppose that this fails because we are wrongly passing the
srcflags to the open() that fills the source file with random data and
we end up passing O_DIRECT to the function that does not aling the
buffers and sizes at all.

Does this fix it?

diff --git a/testcases/kernel/io/ltp-aiodio/aiocp.c b/testcases/kernel/io/ltp-aiodio/aiocp.c
index ee893ab11..a75da6a0c 100644
--- a/testcases/kernel/io/ltp-aiodio/aiocp.c
+++ b/testcases/kernel/io/ltp-aiodio/aiocp.c
@@ -263,7 +263,7 @@ static void setup(void)

        tst_res(TINFO, "Fill %s with random data", srcname);

-       srcfd = SAFE_OPEN(srcname, srcflags | O_RDWR | O_CREAT, 0666);
+       srcfd = SAFE_OPEN(srcname, O_WRONLY | O_CREAT, 0666);
        fill_with_rand_data(srcfd, filesize);
        SAFE_CLOSE(srcfd);
 }


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
