Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98162C433FE
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 08:40:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 044183CD9A1
	for <ltp@archiver.kernel.org>; Mon,  7 Nov 2022 09:40:53 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 12AF23C0796
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 09:40:43 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5529B20074D
 for <ltp@lists.linux.it>; Mon,  7 Nov 2022 09:40:41 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 890BE1F891;
 Mon,  7 Nov 2022 08:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1667810439;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bzuswOF9LHruW/z0I4OveE/kD2IGMwPGua/0CzEnvFQ=;
 b=h4oR02JVSYQq7FrEMrkWmpVc4PbcKpd8Ymiob0i2L9Yowh/zCP0mMrJRaaS7+A6D58MHHq
 85Ya0JnewzrLl9+bpXHPok5cS+dcaMA7ax3R/u8ICCemt+FzMn/WIZLcXBOBzV1qpj3DAm
 9q4v9L92Ecl7bKWMnEhmETsm8AuEIUk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1667810439;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bzuswOF9LHruW/z0I4OveE/kD2IGMwPGua/0CzEnvFQ=;
 b=1UP7AdnvIhJMLbKXmXIjJI6evAo3tk3wNcjcHdUTWfvnhkKHXefvSuo1Ot/5mj1k0mhNsM
 Do+Kfnhc4oiT3UCA==
Received: from UNKNOWN (unknown [10.163.28.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 1529A2C141;
 Mon,  7 Nov 2022 08:40:38 +0000 (UTC)
References: <8735b0jos5.fsf@suse.de>
 <20221104044149.655317-1-alessandro.carminati@gmail.com>
User-agent: mu4e 1.8.11; emacs 28.1
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Alessandro Carminati <alessandro.carminati@gmail.com>
Date: Mon, 07 Nov 2022 08:12:33 +0000
Organization: Linux Private Site
In-reply-to: <20221104044149.655317-1-alessandro.carminati@gmail.com>
Message-ID: <87leonxim1.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Fix tst_find_backing_dev adding BTRFS support
 and /dev/root missing case
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
Reply-To: rpalethorpe@suse.de
Cc: acarmina@redhat.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello,

Alessandro Carminati <alessandro.carminati@gmail.com> writes:

> Hello Richard,
>
> Thanks for the detailed review.
> If in the future I want to contribute more to the LTP project, I need
> to provide myself with a CI pipeline like yours.

If you fork the project in Github and create a new branch then the CI
will run on the commits you push to GH.

> I appreciated the review that was very detailed, but I couldn't address
> a single comment.
>
>>> +		if (!ioctl(fd, BTRFS_IOC_FS_INFO, &args)) {
>>What happens if the test author allows this function to be called on
> tmpfs, rootfs, etc.? Or if the FS is valid, but has the same issue as
> BTRFS.
>
> I have gone thorough all the file systems supported by LTP at this stage,
> and I noticed that BTRFS is the only file system that owns this
> singularity.

tmpfs doesn't have a backing device and we support it? E.g.

40 60 0:38 / /tmp rw,nosuid,nodev shared:19 - tmpfs tmpfs rw,nr_inodes=1048576,inode64

So this function shouldn't be called on it and it is not in the test
currently effected[1]. However if the test author does it by accident (99%
chance of happening) then we want a sensible error message.

> In addition to this, I also dared to assume that if device major number
> is == 0 then the test is facing the BTRFS.
> This assumption might not be true in general, but I tested it to be
> true in the test supported file system.
> Is your comment referring to this?

I think it is absolutely correct that we shouldn't design for
requirements we presently don't have. However:

1. It's highly probable this function will be misused.
2. It's relatively easy to guard against.

>
>
> Alessandro Carminati (2):
>   tst_find_backing_dev: Get dev name from /sys/dev/block/*/uevent
>   c-test-api: Documentation updated
>
>  doc/c-test-api.txt |  7 ++--
>  lib/tst_device.c   | 87 ++++++++++++++++++++++++++++++----------------
>  2 files changed, 63 insertions(+), 31 deletions(-)

[1]: The test skips it

.skip_filesystems = (const char *const []) {
	"tmpfs",
	"overlayfs",
	NULL
},

Also note that you can run LTP on any filesystem. You just need to set
the appropriate env vars.


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
