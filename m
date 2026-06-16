Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C928CD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 12:13:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C1AE83E59A4
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 14:13:48 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B6B763E2AAB
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 14:13:34 +0200 (CEST)
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::ad])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5C1DA200767
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 14:13:32 +0200 (CEST)
Date: Tue, 16 Jun 2026 20:13:18 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1781612012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ndEUquiHL4nl8CJAx1FysJDFOrjtdi4zAgopQFUH4g=;
 b=XztJgtlaOuUrt0Qu69BFhSyq72z1RzrqjueyR4DxrnSSyCGrhJMvg0TrS1AiXNzfwDErgx
 Og6iFKVPD6kBZVa2U0pqtYNScTQv3Ow1ITWxj0G63P1mrklgTnN8otn+y5e7mBS4XIxVtm
 E2XDtbhHv1medo7TsFnYtcGuRWktNpY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Li Wang <li.wang@linux.dev>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ajE93jNipmY0ki3Y@linux.dev>
Mail-Followup-To: Andrea Cervesato <andrea.cervesato@suse.de>,
 Linux Test Project <ltp@lists.linux.it>
References: <20260616-fix_pids_errors-v2-0-a1e1d377f8b7@suse.com>
 <20260616-fix_pids_errors-v2-2-a1e1d377f8b7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260616-fix_pids_errors-v2-2-a1e1d377f8b7@suse.com>
X-Migadu-Flow: FLOW_OUT
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] tst_cgroup: tolerate ESRCH in
 cgroup_drain()
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

On Tue, Jun 16, 2026 at 10:30:07AM +0200, Andrea Cervesato wrote:
> From: Andrea Cervesato <andrea.cervesato@suse.com>
> 
> A process can die between reading cgroup.procs and writing its PID
> to the destination cgroup. When this happens, the kernel returns
> ESRCH which is a normal race condition, not a test infrastructure
> failure.
> 
> Skip ESRCH errors instead of aborting with TBROK.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>

Reviewed-by: Li Wang <li.wang@linux.dev>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
