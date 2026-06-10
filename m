Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B479FCD8CA8
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 02:27:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4B003E6F41
	for <ltp@archiver.kernel.org>; Wed, 10 Jun 2026 04:27:37 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 922C53C196B
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 04:27:19 +0200 (CEST)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E616A1400BCF
 for <ltp@lists.linux.it>; Wed, 10 Jun 2026 04:27:17 +0200 (CEST)
Date: Wed, 10 Jun 2026 10:26:57 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1781058435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l7zppN4HZ/E5nYLJJWVUmQ8BRCeKm84QcWuKHfu6gIU=;
 b=RDMsMIIqe7MtOL+CoZ5+q5hYm97J6x7bxsmWUb5fMfh62AwpFlWdlV94hVGbYDK6xy/M5j
 vuEtyjoQc0LO3CPuJjX9tDXGLpTJ6P0b5/GQM1BfCrFKeGJ6avUhw6laEGR8MOcjs23XJk
 yhCBbTtTeedLFcn71ZDRqYJSegC2NTo=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Wei Gao <wegao@suse.com>
Message-ID: <aijLcXEZ44cVUNKl@linux.dev>
Mail-Followup-To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it,
 Petr Vorel <pvorel@suse.cz>,
 Andrea Cervesato <andrea.cervesato@suse.com>
References: <20260607045219.32729-1-wegao@suse.com>
 <20260608025234.1117-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260608025234.1117-1-wegao@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5] mmapstress06: Convert to new API
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

Wei Gao wrote:

> +
> +		mmapaddr = SAFE_MMAP(NULL, map_size, PROT_READ | PROT_WRITE,
> +				     MAP_ANONYMOUS | MAP_SHARED, -1, 0);
> +

> +		/*
> +		 * Disable Transparent Huge Pages (THP) for this mapping.
> +		 * Under tight cgroup memory limits (128 MB), allocating huge
> +		 * pages can easily trigger MemCG OOM-kills. Disabling THP forces
> +		 * standard 4 KB pages, ensuring stable swapping and avoiding
> +		 * premature OOM.
> +		 */
> +		if (madvise(mmapaddr, map_size, MADV_NOHUGEPAGE) < 0)
> +			tst_res(TWARN | TERRNO, "madvise(MADV_NOHUGEPAGE) failed");

The key point is that this is a MAP_ANONYMOUS | MAP_SHARED mapping.
Shared anonymous memory isn't backed by the normal anonymous-THP machinery,
it's backed internally by shmem/tmpfs.

THP behavior for shmem is governed by a separate knob:

  # cat /sys/kernel/mm/transparent_hugepage/shmem_enabled
  always within_size advise [never] deny force

basically all distro kernels this defaults to never.

So in the default configuration, no huge pages would ever be allocated for
this mapping, and the madvise(MADV_NOHUGEPAGE) is effectively a no-op.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
