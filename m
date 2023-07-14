Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5689C0015E
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 03:41:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 76F643CDEAB
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 05:41:06 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E023F3C999C
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 05:40:53 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E2FAB600BFE
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 05:40:52 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C861B61BD2;
 Fri, 14 Jul 2023 03:40:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BBBCC433C7;
 Fri, 14 Jul 2023 03:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689306050;
 bh=eL3bwIO5VV7vCSVgK3blGqRHUroi6FMpTDRsXGrAE8Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HQcS7HiXIo6ZyeEw+AvWila8WhXXdwZeHQzm604R9uQ+UhYUK8lllUZIoyYz8g16S
 f6uw6ajw4L7L9UII1L4bSTFGxZo+tftdOrD+cpNVG5Qdat2uu0C1jWrfvFYVpou7Bt
 QJn2/qlrswfh8tIUwfBU3C9ceJ8LZQCq/oZw56auFhuW4OjBE5mGAnjZ35ge8qPlWG
 PVioUKMi+8OBGZfXDNYzzwhS3nocryqnxgV8BGVO5st4jJRh5slJq7QnuAiE/A4Gih
 FlmnfHxx1H6v0J8oM7BPVab4a5obI/iXbTcvMbEfH/XCAcRINeuwerApNhNZfWXBlk
 54lQ87ThbWtvg==
Date: Thu, 13 Jul 2023 20:40:48 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20230714034048.GA913@sol.localdomain>
References: <20230713132901.28660-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230713132901.28660-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] statx09: Reduce fs-verity blocksize to 1024
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

Hi Martin,

On Thu, Jul 13, 2023 at 03:28:52PM +0200, Martin Doucha wrote:
> The kernel requires that fs-verity blocksize must be at most equal
> to the filesystem blocksize. Testing on small loop device means that
> mkfs.ext4 will very likely default to blocksize of 1024. Set fs-verity
> blocksize to the minimum possible value (1024) to avoid blocksize
> mismatch.
> 
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
> 
> Alternatively, we could add "-b 4096" to .dev_fs_opts.
> 
>  testcases/kernel/syscalls/statx/statx09.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
> index c03d2c91e..dc9786c76 100644
> --- a/testcases/kernel/syscalls/statx/statx09.c
> +++ b/testcases/kernel/syscalls/statx/statx09.c
> @@ -94,7 +94,7 @@ static void flag_setup(void)
>  	memset(&enable, 0, sizeof(enable));
>  	enable.version = 1;
>  	enable.hash_algorithm = hash_algorithms[0];
> -	enable.block_size = 4096;
> +	enable.block_size = 1024;
>  	enable.salt_size = 0;
>  	enable.salt_ptr = (intptr_t)NULL;
>  	enable.sig_size = 0;
> -- 

Support for Merkle tree block sizes less than the page size didn't exist until
kernel version 6.3.  Please see the documentation for FS_IOC_ENABLE_VERITY
(https://www.kernel.org/doc/html/latest/filesystems/fsverity.html#fs-ioc-enable-verity):

    "block_size is the Merkle tree block size, in bytes. In Linux v6.3 and
    later, this can be any power of 2 between (inclusively) 1024 and the minimum
    of the system page size and the filesystem block size. In earlier versions,
    the page size was the only allowed value."

There are a few different approaches you could take.  One would be the one you
mentioned: just add "-b 4096".  Though, note that systems with non-4K pages and
kernel older than v6.3 can't mount an "-O verity -b 4096" filesystem.

Or you could query the filesystem block size (that resulted from mkfs.ext4 with
unspecified block size) and use that as the Merkle tree block size.

Or you could simply make the test depend on kernel v6.3, I suppose.

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
