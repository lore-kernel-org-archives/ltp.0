Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75D17C7618E
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 22:07:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C891A3CC068
	for <ltp@archiver.kernel.org>; Thu, 27 Apr 2023 00:07:10 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4C6B3CBB54
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 00:06:59 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9EE071A0092F
 for <ltp@lists.linux.it>; Thu, 27 Apr 2023 00:06:58 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 12A0A63055;
 Wed, 26 Apr 2023 22:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60363C4339B;
 Wed, 26 Apr 2023 22:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682546816;
 bh=hO4x+U9JTbmKpKpL5kPCcDfOy0HFMW4YTX2U61aDmsU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=t6UpnTGyuv9QcQs90xGSEuoCg19GvVR5qSeQXhPJJINH46UoWJQ4ir0YW6awRPyCN
 ggVNzB/TBPpmmT/NtHxVuZK1g+4BdFzJuQK+blSpN9jqbBDJoQLoLF7YO2WuGKuev+
 mlV/fgm5KybZU+f6I33U8m8aoNLUQe9idM4omuL4CNm4wWAxacEgizIxFjPuOEzzCd
 cy1CiaU8fDb4DirB3CdRHS45xArm2TXyvCaL9Ai6ypxDxQTEA7TZFS+vHql5LunOFB
 qsPJFHYacop4e6BtlHG7bt35GvB5oNtqVslwDyBFXRtLrZ+g0/UbTVh3ONM8+eqG/7
 Dus+pWSQMeO+A==
Date: Wed, 26 Apr 2023 15:06:54 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20230426220654.GD58528@sol.localdomain>
References: <20230404215918.GA1893@sol.localdomain>
 <1680759622-8738-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1680759622-8738-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1680759622-8738-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] syscalls/statx10: Add basic test for
 STATX_DIOALIGN on regular file
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

On Thu, Apr 06, 2023 at 01:40:20PM +0800, Yang Xu wrote:
> + * On ext4, files that use certain filesystem features (data journaling,
> + * encryption, and verity) fall back to buffered I/O. But ltp doesn't use these
> + * features by default, So I think dio should not fall back to buffered I/O.

Does LTP create and mount the filesystem itself?

If not, then it wouldn't have control over this.

> +	if (!(buf.stx_mask & STATX_DIOALIGN)) {
> +		tst_res(TCONF, "STATX_DIOALIGN is not supported until linux 6.1");
> +		return;
> +	}

"Filesystem does not support STATX_DIOALIGN"

> +
> +#ifdef HAVE_STRUCT_STATX_STX_DIO_MEM_ALIGN

This looks wrong.  If the system headers are missing this field, then the
definition in the LTP source tree should be used instead.

> +	if (buf.stx_dio_mem_align != 0)
> +		tst_res(TPASS, "stx_dio_mem_align: %u", buf.stx_dio_mem_align);
> +	else
> +		tst_res(TFAIL, "don't get stx_dio_mem_align on supported dio fs");

For the failure case: "stx_dio_mem_align was 0, but DIO should be supported"

> +
> +	if (buf.stx_dio_offset_align != 0)
> +		tst_res(TPASS, "stx_dio_offset_align: %u", buf.stx_dio_offset_align);
> +	else
> +		tst_res(TFAIL, "don't get stx_dio_offset_align on supported dio fs");
> +#endif

For the failure case: "stx_dio_offset_align was 0, but DIO should be supported"

> +	SAFE_FILE_PRINTF(TESTFILE, "AAAA");
> +	fd = open(TESTFILE, O_RDWR | O_DIRECT);
> +	if (fd == -1 && errno == EINVAL) {
> +		SAFE_CLOSE(fd);
> +		tst_brk(TCONF, "The regular file is not on a filesystem that support DIO");
> +	}
> +	SAFE_CLOSE(fd);

The open() is not checked for error in all cases.

Also, this is closing the file descriptor even when it is -1.

> +static struct tst_test test = {
> +	.test_all = verify_statx,
> +	.setup = setup,
> +	.needs_root = 1,

Why does this test need root?

- Eric

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
