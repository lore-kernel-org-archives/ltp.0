Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03A16C61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 09:38:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 783323D69E8
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:38:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AF2363C6EBE
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:38:07 +0200 (CEST)
Received: from mta1.migadu.com (out-184.mta1.migadu.com
 [IPv6:2001:41d0:203:375::b8])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3F2361A0011C
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 11:38:03 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=kAuUcwnvXbyUBjQ6++HaOjZHor/Igo2003y0wRSoYSA=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787909882; v=1; x=1788514682;
 b=FwJtdSKw3bm4AJhKzgh7tkdOfWQpHsoHOsNU6pLifjOS0TUKq1LZJ4Lw8TLLWlkl9/538Sn5
 zzRWAvWD8X6u7sWGOOxDp3474SPcyvPDQWGMvBHyu7LtfBnencXvt/+HpzteARkwOridonSzs6H
 7vrgX1ANGtmLtsKA8AR9ovEY=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 4052e744394a6f31;
 Fri, 28 Aug 2026 09:37:52 +0000
X-Mizu-Trace-ID: 4052e744394a6f31
X-Migadu-Flow: FLOW_OUT
Date: Fri, 28 Aug 2026 17:37:49 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <apFW1UGbwKuhPyoU@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>,
 Andrea Cervesato <andrea.cervesato@suse.com>
References: <20260828-swapon_discard_coverage-v2-0-e55a86dad729@suse.com>
 <20260828-swapon_discard_coverage-v2-2-e55a86dad729@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260828-swapon_discard_coverage-v2-2-e55a86dad729@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] swapon04: Add test for discard flags
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Andrea Cervesato wrote:

> +static void verify_swapon(unsigned int n)
> +{
> +	struct tcase *tc = &tcases[n];
> +	int fd;
> +	struct stat st;
> +	blkcnt_t blocks_before, blocks_after;
> +	const char *const mkswap_argv[] = {"mkswap", loop_dev, NULL};
> +
> +	tst_res(TINFO, "Testing swapon(%s, %s)", loop_dev, tc->desc);
> +
> +	tst_fill_file(BACKING_FILE, 'A', TST_MB, SWAP_SIZE_MB);
> +

Or, we need to confirm with an XFS developer/expert whether this
should be treated as a minor bug or is worth fixing on 6.6.

If not, then the code comment below is needed.

	/*
	 * Flush the backing file to disk before formatting it with mkswap.

	 * XFS uses delayed allocation, and without fsync the blocks written
	 * by tst_fill_file() may remain as unwritten extents in page cache.
	 * If swapon(2) with SWAP_FLAG_DISCARD is called while such extents
	 * are still pending, the discard request may not cover the whole
	 * swap area, causing the test to fail spuriously.
	 *
	 * This is especially visible on kernel 6.6, where the XFS/swap
	 * discard path does not force delalloc extents to be resolved.
	 */

> +	fd = SAFE_OPEN(BACKING_FILE, O_RDONLY);
> +	SAFE_FSYNC(fd);
> +	SAFE_CLOSE(fd);

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
