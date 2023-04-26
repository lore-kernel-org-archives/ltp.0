Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9AA9C77B60
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 22:12:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D86183CE4D3
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 00:12:42 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 616703CBB54
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 00:12:26 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AF5DD10009BD
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 00:12:25 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DB3A561D08;
 Wed, 26 Apr 2023 22:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34D0CC433EF;
 Wed, 26 Apr 2023 22:12:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682547143;
 bh=5FoLnKi5ooObjuFhB9CHDnYkuu+osDnVo4CPjy3qyKI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=JIjHrOxfklwQS+kwK9K/4dQ8iwZY7GF7/AGvD0b+f8X6OqX3flNWXYZhwpOsT3vU2
 kVi/tVNj8Bq2qsy2+VvoUro5OSvNp8dr3lXNITLbZrPs+mZ5S3ojNBPDX86WkXdE2P
 XxzpLLuTnC4nANLRx7iF7UwO7ygZ5k1YuoyQ1jpSRodClpLCX1ge7PCzNEpMoBFNul
 qCbUE2CY/nIVcPNMsBYyXGUabGnOA0VlEXX+u6nqiZ9MGQuKV6QURrHfSanaqvT8oz
 V+C8P0/kLNSZUIsurT+VNzHqwq+hx8tnAfvONbdJipkoXlf0szhk0k0tnhmBuFELBL
 EYQXfCy7Yxmkg==
Date: Wed, 26 Apr 2023 15:12:21 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230426221221.GE58528@sol.localdomain>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680759622-8738-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1680759622-8738-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Apr 06, 2023 at 01:40:21PM +0800, Yang Xu wrote:
> +static void verify_statx(void)
> +{
> +	struct statx buf;
> +
> +	memset(&buf, 0, sizeof(buf));

It is not necessary to memset struct statx to 0 before calling statx().

> +#ifdef HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN

Again, this looks wrong.  If the system headers are outdated, then LTP should
use its in-tree header instead.

> +static void setup(void)
> +{
> +	char *dev_name;
> +
> +	dev_name = basename((char *)tst_device->dev);

This is modifying a const string, which seems problematic.

> +	sprintf(sys_bdev_logical_path, "/sys/block/%s/queue/logical_block_size", dev_name);
> +	while (access(sys_bdev_logical_path, F_OK) != 0) {
> +		dev_name[strlen(dev_name)-1] = '\0';
> +		sprintf(sys_bdev_logical_path, "/sys/block/%s/queue/logical_block_size", dev_name);
> +	}

What is this code doing?  Is it trying to strip off the partition number of the
block device name?  If so, it is incorrect because it assumes the partition
number is only 1 digit long, which is not guaranteed.

How about just using /sys/class/block/%s/queue, which works for partitions?

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
