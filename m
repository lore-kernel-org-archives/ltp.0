Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79965CA5FFF
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 07:02:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 815F23E3046
	for <ltp@archiver.kernel.org>; Wed,  7 Oct 2026 09:02:06 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CA1F3E2C45
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 09:01:51 +0200 (CEST)
Received: from mta0.migadu.com (out-151.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::97])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 81F901A00A33
 for <ltp@lists.linux.it>; Wed,  7 Oct 2026 09:01:49 +0200 (CEST)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=GZ/JRtleCTAIo1abn9zsgvEkb/oaYIcrkZkMxXJ7hHc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791356508; v=1; x=1791961308;
 b=u60MZ/UHbQnPx8SQkZTdQgIsZydWZFFCamK+vte+RKF/icJRzYZFXGlh9OH0ht/v9HG4pJW2
 v0PMoCcGo9vWPllgE0VG8ERpA69uwmi8FgcQrd41VtbkK0CQ7CtH1o2kZm2jKWJ00ipnV6ejUti
 J/KEkzWSBp6qoKyYNc4Q6a2Y=
X-Envelope-To: ltp@lists.linux.it
Received: by smtp.migadu.com with ESMTPS id 9a0085d6d047c430;
 Wed, 07 Oct 2026 06:18:53 +0000
X-Mizu-Trace-ID: 9a0085d6d047c430
X-Migadu-Flow: FLOW_OUT
Date: Wed, 7 Oct 2026 14:18:44 +0800
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <asXkRD5wevW5v2zg@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20261006-fix_simple_bugs_core_lib-v1-0-c94199a46ec5@suse.com>
 <20261006-fix_simple_bugs_core_lib-v1-2-c94199a46ec5@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261006-fix_simple_bugs_core_lib-v1-2-c94199a46ec5@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/3] tst_memutils: Fix mapping overlap predicate
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

On Tue, Oct 06, 2026 at 03:02:38PM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> tst_mapping_in_range() checks whether either mapping endpoint falls
> inside [low, high). This misses existing mappings that completely
> enclose the requested range, and falsely treats an adjacent mapping
> ending exactly at low as an overlap.
> 
> Use the standard half-open interval overlap check
> (start < high && end > low).
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>

Reviewed-by: Li Wang <li.wang@linux.dev>

> ---
>  lib/tst_memutils.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/lib/tst_memutils.c b/lib/tst_memutils.c
> index e49684ba1..81467fef7 100644
> --- a/lib/tst_memutils.c
> +++ b/lib/tst_memutils.c
> @@ -202,11 +202,7 @@ int tst_mapping_in_range(unsigned long low, unsigned long high)
>  			tst_brk(TBROK | TERRNO, "Couldn't parse /proc/self/maps line.");
>  		}
>  
> -		if ((start >= low) && (start < high)) {
> -			fclose(fp);
> -			return 1;
> -		}
> -		if ((end >= low) && (end < high)) {
> +		if (start < high && end > low) {
>  			fclose(fp);
>  			return 1;
>  		}
> 
> -- 
> 2.51.0

This is a nice fix!

But after looking at tst_mapping_in_range(), I think there are still
places that need improvement:

1. feof() only returns true after a read attempt has failed.
   Using while (!feof(fp)) causes the last read to be processed twice.

2. If the end of file is reached, fscanf() returns EOF (-1),
   which is not a parsing error.

3. If the caller passes low > high, the function should report an error.
   Currently, it silently returns 0.

Something maybe better like:

int tst_mapping_in_range(unsigned long low, unsigned long high)
{
	FILE *fp;
	unsigned long start, end;
	int ret = 0;

	if (low >= high)
		tst_brk(TBROK, "invalid range [%lu, %lu)", low, high);

	fp = SAFE_FOPEN("/proc/self/maps", "r");

	while (fscanf(fp, "%lx-%lx %*[^\n]\n", &start, &end) == 2) {
		/*
		 * Standard half-open interval overlap check:
		 *   [start, end) intersects [low, high)
		 *     <=> start < high && end > low
		 */
		if (start < high && end > low) {
			ret = 1;
			break;
		}
	}

	fclose(fp);
	return ret;
}

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
