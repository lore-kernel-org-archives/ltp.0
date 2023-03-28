Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EB15C76196
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 03:50:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 800AF3CCDAA
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 05:50:30 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 511C83CB238
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 05:50:18 +0200 (CEST)
Received: from Atcsqr.andestech.com (60-248-80-70.hinet-ip.hinet.net
 [60.248.80.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 66EAA6006DC
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 05:50:14 +0200 (CEST)
Received: from mail.andestech.com (ATCPCS16.andestech.com [10.0.1.222])
 by Atcsqr.andestech.com with ESMTP id 32S3o2jb040449;
 Tue, 28 Mar 2023 11:50:02 +0800 (+08)
 (envelope-from ycliang@andestech.com)
Received: from atcfdc88.andestech.com (10.0.15.158) by ATCPCS16.andestech.com
 (10.0.1.222) with Microsoft SMTP Server id 14.3.498.0;
 Tue, 28 Mar 2023 11:49:57 +0800
Date: Tue, 28 Mar 2023 11:50:14 +0800
From: Leo Liang <ycliang@andestech.com>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Message-ID: <20230328035014.GA31403@atcfdc88.andestech.com>
References: <20230323160442.671164-1-teo.coupriediaz@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230323160442.671164-1-teo.coupriediaz@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [10.0.15.158]
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 32S3o2jb040449
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ipc/msgstress03: Assume all forks will run
 concurently
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Mar 23, 2023 at 04:04:42PM +0000, Teo Couprie Diaz wrote:
> It appears that msgstress03 doesn't account for all PIDs that its children
> can use, as it expects the tasks will terminate quickly and not reach
> the PID limit.
> On some systems, this assumption can be invalid and the PID limit
> will be hit.
> Change the limit to account for all possible children at once, knowning
> that each child will fork as well.
> 
> Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
> Reviewed-by: Richard Palethorpe <rpalethorpe@suse.com>
> ---
> This patch was already reviewed as part of a larger series[0]. The rest of
> the series needs a large rework to be merged, but I felt this patch was a
> simple and independnt enough to warrant a resend.
> No changes were made.
> 
> CI Build: https://github.com/Teo-CD/ltp/actions/runs/4502197808
> 
> [0]: https://lists.linux.it/pipermail/ltp/2023-February/033007.html
> 
>  testcases/kernel/syscalls/ipc/msgstress/msgstress03.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

LGTM!
Reviewed-by: Leo Yu-Chi Liang <ycliang@andestech.com>

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
