Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAB90C77B73
	for <ltp@archiver.kernel.org>; Mon,  1 May 2023 17:49:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 085523CD934
	for <ltp@archiver.kernel.org>; Mon,  1 May 2023 19:49:17 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C800D3CCCD5
 for <ltp@lists.linux.it>; Mon,  1 May 2023 19:49:07 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AA28560019B
 for <ltp@lists.linux.it>; Mon,  1 May 2023 19:49:06 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id F1AC360FE8;
 Mon,  1 May 2023 17:49:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51AC8C433D2;
 Mon,  1 May 2023 17:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682963344;
 bh=kdmDtbGCSYpeX1AsGV+vtZTJYVaMqdZDtzMiPgIy8WQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=YN6WmNSgSAan8OPZZgJzwFTqwhSLUmNeEW+9HOCDShIpCLSmPu2lhedz2+M4ERHmO
 MEK6kPDwpPkA8TSkPGgsIrQbaxA6ODCRJsfpsfY6SW/TAgXIRAICrluSAwpw2F7ICX
 3qEuaPw6/TfFXQfctPromFC3Zq7U7yXEj+qc3PPcxI0nuWP8zTxAQItO9JQZtu17d+
 zzqimnQEv2dR2psDFB8exENvqc6CcwHD6BZ8Ucff1Ga04fWfzhfp062u+YfHgn8pvs
 j/v9NlgkL6iCANoSyWtg/sYLwBnAAJjRijTvQaCdMFNLYNqinuj9m37q7o3Z3ouxXa
 uOycQogXpaIVg==
Date: Mon, 1 May 2023 10:49:02 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>
Message-ID: <20230501174902.GC1224@sol.localdomain>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680759622-8738-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20230426221221.GE58528@sol.localdomain>
 <b33d70da-c629-0c4d-3be3-87a0611e5f9d@fujitsu.com>
 <ec7f64e2-2645-768f-85d3-63193339de38@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ec7f64e2-2645-768f-85d3-63193339de38@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/4] syscalls/statx11: Add basic test for
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Apr 27, 2023 at 03:50:25AM +0000, Yang Xu (Fujitsu) wrote:
> >>> +	sprintf(sys_bdev_logical_path, "/sys/block/%s/queue/logical_block_size", dev_name);
> >>> +	while (access(sys_bdev_logical_path, F_OK) != 0) {
> >>> +		dev_name[strlen(dev_name)-1] = '\0';
> >>> +		sprintf(sys_bdev_logical_path, "/sys/block/%s/queue/logical_block_size", dev_name);
> >>> +	}
> >>
> >> What is this code doing?  Is it trying to strip off the partition number of the
> >> block device name?
> > 
> > Yes.
> > 
> >> If so, it is incorrect because it assumes the partition
> >> number is only 1 digit long, which is not guaranteed.
> > 
> > I don't assume the partition number is only 1 digit long, this code has
> > a while circulate. Also, I try the /dev/vdb11 and it also works.
> > 
> > 
> >>
> >> How about just using /sys/class/block/%s/queue, which works for partitions?
> 
>   /sys/class/block/%s/queue for partitions does't exist.

Okay, sorry, I forgot that /sys/class/block/%s/queue doesn't exist for
partitions.

Please at least add a comment that explains what this code is doing, as it's
hard to understand.

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
