Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E43C531FA
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 09:05:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24AEF3E5568
	for <ltp@archiver.kernel.org>; Fri, 24 Jul 2026 11:05:40 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8AE7E3E1C91
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 11:05:24 +0200 (CEST)
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::b8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C0C9E600296
 for <ltp@lists.linux.it>; Fri, 24 Jul 2026 11:05:23 +0200 (CEST)
Date: Fri, 24 Jul 2026 17:05:15 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1784883922;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OnL5F8IgysThXtWS3f8iCQhVDFlvcDQ6P1fn3w4CTSE=;
 b=GmYyDz3YI5izo+qdYq2woxJnaapbOyMZIO2fYQFMRqqac8qhSKTzA+/2bqbBpalRyWXV6B
 ZDHFz+vXfd861wC4L24rv73izJmd3jfnequjBur1IOd7JAOoMOsRd2lGj4pO2MCfqraP9P
 u821F5gN1LR0V9Ul+dg0dLVSyA/FqEI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Wei Gao <wegao@suse.com>
Message-ID: <amMqy0LXX7LFurPo@linux.dev>
Mail-Followup-To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20260723075319.4920-1-wegao@suse.com>
 <20260723094647.5051-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260723094647.5051-1-wegao@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] madvise09: Scale cgroup memory/swap limits
 dynamically with page size
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

Wei Gao via ltp wrote:

> +	mem_limit = 16 * PAGES * page_size;
> +	swap_limit = 2 * mem_limit;
> +

> +	if (swap_accounting_enabled && (tst_available_swap() < swap_limit / 1024)) {
> +		tst_brk(TCONF, "System needs at least %lldMB free swap to run this test",
> +			swap_limit / TST_MB);

I suspect this available swap size comparison is duplicated with
.min_swap_avail, and perhaps we can remove BASE_SWAP_LIMIT and
.min_swap_avail from the test directly.

>  static struct tst_test test = {
> @@ -291,6 +301,6 @@ static struct tst_test test = {
>  	.test_all = run,
>  	.needs_root = 1,
>  	.forks_child = 1,

> -	.min_swap_avail = SWAP_LIMIT / TST_MB,
> +	.min_swap_avail = BASE_SWAP_LIMIT / TST_MB,

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
