Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CB28C282DE
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 22:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741906793; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=4f5fQtd49gZCmzypAP5XG95fReajnUSdsXNYn/ayfVA=;
 b=F95FLNjBQGW2NlaMhx7f2V41mCkMZtWRTGbbeRLf+SmCGL+BnHP0t4SUZMgKM5DW49igd
 HUMzTcHkYWBJWVnnB1XESgO8snv8OP95pgNnic+oodYbPpaEuwgjwvVWDhfJD7eoSNC/7sl
 W1z54ImTlqV/2aiG2XSfzHo6SySzRxE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B92D3CA58B
	for <ltp@archiver.kernel.org>; Thu, 13 Mar 2025 23:59:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ABCB43C2BFA
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 23:59:31 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.org (client-ip=2604:1380:4641:c500::1;
 helo=dfw.source.kernel.org; envelope-from=mcgrof@kernel.org;
 receiver=lists.linux.it)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DE0011A0091A
 for <ltp@lists.linux.it>; Thu, 13 Mar 2025 23:59:30 +0100 (CET)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6CC015C3478;
 Thu, 13 Mar 2025 22:57:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9505C4CEDD;
 Thu, 13 Mar 2025 22:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741906767;
 bh=oWuRxyt3MUiP1swKqllJs5wW6pdT5rmMytRbKhSHBWQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bdJNxZpe+TM+ddELHWgVHR4cJWwUnIoCrVw4wNYY86CpbV7+FP1ID585oxQ1W/Nc1
 eSPVYE1iT46ik4k4RtJfwRnihqcSKQnC4WX0zHQ9B1x0pbhV76MX2rnU7osCNtkuvJ
 uIpf+IjajEXErEqCQR4AypYEVWtdxVP16FwassxdsqimjHJrnXPLtHTjwlq2AZpd03
 j0Y0O9df9eGTksoLC6yReg4AOZK84Jd/o1ysri4Gqs5e6u6pAEKs8TnYl159q4GfMR
 MekW0voIP0lyRNyzH7RTBuCLEecUU2s+CEh3PyW/vSN6Zy3tY3RRktiPorCvqsHyla
 MU3kthIdlDnfw==
Date: Thu, 13 Mar 2025 15:59:26 -0700
To: Li Wang <liwang@redhat.com>
Message-ID: <Z9NjTtX3o15YDZ1w@bombadil.infradead.org>
References: <20250313092445.164616-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250313092445.164616-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl_loop06: update loopback block size
 validation
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
From: Luis Chamberlain via ltp <ltp@lists.linux.it>
Reply-To: Luis Chamberlain <mcgrof@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Mar 13, 2025 at 05:24:45PM +0800, Li Wang wrote:
> The kernel commit 47dd6753 ("block/bdev: lift block size restrictions to 64k")
> now supports block sizes larger than PAGE_SIZE, with a new upper limit of
> BLK_MAX_BLOCK_SIZE (64K). But ioctl_loop06 still assumes that PAGE_SIZE is the
> maximum allowed block size, causing failures on newer kernels(>= 6.14):
> 
>   ioctl_loop06.c:74: TINFO: Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE
>   ioctl_loop06.c:57: TFAIL: Set block size succeed unexpectedly
>   ...
>   ioctl_loop06.c:74: TINFO: Using LOOP_CONFIGURE with block_size > PAGE_SIZE
>   ioctl_loop06.c:57: TFAIL: Set block size succeed unexpectedly
> 
> This patch updates ioctl_loop06 to use BLK_MAX_BLOCK_SIZE instead of PAGE_SIZE
> for block size validation.
> 
> And, we give up the test size between (PAGE_SIZE, BLK_MAX_BLOCK_SIZE) even on
> old kernels becase it makes no sense.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Hannes Reinecke <hare@suse.de>
> ---
>  testcases/kernel/syscalls/ioctl/ioctl_loop06.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
> index 573871bc1..238a7c6f5 100644
> --- a/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
> +++ b/testcases/kernel/syscalls/ioctl/ioctl_loop06.c
> @@ -17,6 +17,8 @@
>  #include "lapi/loop.h"
>  #include "tst_test.h"
>  
> +#define BLK_MAX_BLOCK_SIZE 0x00010000 /* SZ_64K */

Today its SZ_64K, tomorrow another value. If you have an ifdef check for
kernel versions it may be good to do that. So if >= v6.15 then 64k
othersize PAGE_SIZE is fine.

> +
>  static char dev_path[1024];
>  static int dev_num, dev_fd, file_fd, attach_flag, loop_configure_sup = 1;
>  static unsigned int invalid_value, half_value, unalign_value;
> @@ -31,7 +33,7 @@ static struct tcase {
>  	"Using LOOP_SET_BLOCK_SIZE with arg < 512"},
>  
>  	{&invalid_value, LOOP_SET_BLOCK_SIZE,
> -	"Using LOOP_SET_BLOCK_SIZE with arg > PAGE_SIZE"},
> +	"Using LOOP_SET_BLOCK_SIZE with arg > BLK_MAX_BLOCK_SIZE"},
>  
>  	{&unalign_value, LOOP_SET_BLOCK_SIZE,
>  	"Using LOOP_SET_BLOCK_SIZE with arg != power_of_2"},
> @@ -40,7 +42,7 @@ static struct tcase {
>  	"Using LOOP_CONFIGURE with block_size < 512"},
>  
>  	{&invalid_value, LOOP_CONFIGURE,
> -	"Using LOOP_CONFIGURE with block_size > PAGE_SIZE"},
> +	"Using LOOP_CONFIGURE with block_size > BLK_MAX_BLOCK_SIZE"},
>  
>  	{&unalign_value, LOOP_CONFIGURE,
>  	"Using LOOP_CONFIGURE with block_size != power_of_2"},
> @@ -106,7 +108,7 @@ static void setup(void)
>  	tst_fill_file("test.img", 0, 1024, 1024);
>  	half_value = 256;
>  	pg_size = getpagesize();
> -	invalid_value = pg_size * 2 ;
> +	invalid_value = BLK_MAX_BLOCK_SIZE + 1;

I'd use BLK_MAX_BLOCK_SIZE * 2 as we use power of 2 values;

  Luis

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
