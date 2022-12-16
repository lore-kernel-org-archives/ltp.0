Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 598DDC001B2
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 13:13:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C09A3CBC66
	for <ltp@archiver.kernel.org>; Fri, 16 Dec 2022 14:13:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B80643C1C26
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 14:13:42 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 39C071000D1C
 for <ltp@lists.linux.it>; Fri, 16 Dec 2022 14:13:41 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 711F1340DB;
 Fri, 16 Dec 2022 13:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1671196421;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goXrbhYilZL/SgSD29zRZ6u123G4jiMBo4QeWf+uVm0=;
 b=ZCoWHHlMc3ICKyB9Tvco8ZeLzqvzMCUW9Hiul3K5+48S5025nYyJdYwZAtVXEk2vEiW1rx
 rfyuPUSRomnLjlhBjStCq80HIj6zd1xp9LNh++/b4RmxUJjKVMOjUDIpv+N93+AZXTr2v3
 BnP7aMLeUSykzdA2c4EDUz5YchI/ZaQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1671196421;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=goXrbhYilZL/SgSD29zRZ6u123G4jiMBo4QeWf+uVm0=;
 b=M9jB9ps+uOrsiXeCYDjJ0t+xi7GV845Z03CuievrMN+ZUAtynWasvB2VSCP08h9/Qa5RLH
 k1js/Fn1QgNSUpAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 376E2138FD;
 Fri, 16 Dec 2022 13:13:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zzOkCQVvnGONQgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 16 Dec 2022 13:13:41 +0000
Date: Fri, 16 Dec 2022 14:13:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it, Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Y5xvA6FvHtzrK6kU@pevik>
References: <20221216115052.30511-1-pvorel@suse.cz>
 <Y5xt5K1HWp8lHau8@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y5xt5K1HWp8lHau8@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> hm, it looks like it requires to skip tmpfs, as all tests TCONF:
> aiocp.c:231: TINFO: Maximum AIO blocks: 65536
> tst_device.c:541: TINFO: Use BTRFS specific strategy
> tst_device.c:559: TBROK: BTRFS ioctl failed. Is . on a tmpfs?: ENOTTY (25)

> I check if it'd work without
> e1b1ae66b2 ("tst_find_backing_dev: Get dev name from /sys/dev/block/*/uevent")

TMPDIR=/home/foo ./aiocp -b 1k -n 1 -f DIRECT # xfs
tst_test.c:1558: TINFO: Timeout per run is 0h 30m 30s
tst_test.c:1310: TINFO: xfs is supported by the test
aiocp.c:231: TINFO: Maximum AIO blocks: 65536
tst_device.c:585: TINFO: Use uevent strategy
aiocp.c:267: TINFO: Fill srcfile.bin with random data
aiocp.c:84: TBROK: write(3,0x7ffeccb9da00,60274) failed: EINVAL (22)

TMPDIR=/var/tmp ./aiocp -b 1k -n 1 -f DIRECT # ext4
tst_test.c:1558: TINFO: Timeout per run is 0h 30m 30s
tst_test.c:1310: TINFO: ext2/ext3/ext4 is supported by the test
aiocp.c:231: TINFO: Maximum AIO blocks: 65536
tst_device.c:585: TINFO: Use uevent strategy
aiocp.c:267: TINFO: Fill srcfile.bin with random data
aiocp.c:84: TBROK: write(3,0x7ffda9e14120,50530) failed: EINVAL (22)

uname -r
6.1.0-rc8-2.g2fb1790-default

=> even more things to investigate.

Kind regards,
Petr

> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
