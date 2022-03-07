Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7649C433FE
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 11:29:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AD0523C1BC2
	for <ltp@archiver.kernel.org>; Mon,  7 Mar 2022 12:29:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46D533C07BD
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 12:29:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C99CF600145
 for <ltp@lists.linux.it>; Mon,  7 Mar 2022 12:29:27 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out1.suse.de (Postfix) with ESMTP id E71BE210F4;
 Mon,  7 Mar 2022 11:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1646652566;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UO9LOASYmVdrvEDSJVx5TpE8gRxTe68DQ7I3xQWZp3w=;
 b=mKCvA729jbAZO7koyVcexRnxexIXUHwRfH4X2h0Fdawv+maDQ58btFzdy81gCL+0INap4Q
 Na8ae7PSPzL9KY0+IzNNS6ZgKSzz/hG3wup938sk7+d+Oy3WPZnVfNSUpcWQjKwJxrofIo
 O1n//FIdMeI2LRDgZF391znK3QkIN6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1646652566;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UO9LOASYmVdrvEDSJVx5TpE8gRxTe68DQ7I3xQWZp3w=;
 b=shlwQS2kKPWdnEeCMgM5MHACI/naZnEaVzafqtrwxYPawleZhhKI1enCk+C1/xdW711oH0
 5Io6loaqghDO37AA==
Received: from g78 (unknown [10.163.24.138])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id AE5CFA3B8C;
 Mon,  7 Mar 2022 11:29:26 +0000 (UTC)
References: <cover.1646434670.git.luke.nowakowskikrijger@canonical.com>
 <4384f778b2664a0ceb561c0b3eac7be42e7cd269.1646434670.git.luke.nowakowskikrijger@canonical.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Mon, 07 Mar 2022 11:24:20 +0000
In-reply-to: <4384f778b2664a0ceb561c0b3eac7be42e7cd269.1646434670.git.luke.nowakowskikrijger@canonical.com>
Message-ID: <87pmmym25m.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 05/16] API/cgroup: Add more controllers to
 tst_cgroup
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
Reply-To: rpalethorpe@suse.de
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello Luke,

Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com> writes:

> Add the rest of the controllers that are tested in LTP controller tests
> so that they can be mounted using the cgroup api.
>
> Control files should be added on an as needed basis.
>
> Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> ---
> v2: remove rdma controller as that is not used in any LTP tests.
> Remove control files that should be added on an as needed basis.
>
>  lib/tst_cgroup.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 91 insertions(+), 1 deletion(-)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 90d91d94e..4e14a2895 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -83,8 +83,19 @@ enum cgroup_ctrl_indx {
>  	CTRL_MEMORY = 1,
>  	CTRL_CPU,
>  	CTRL_CPUSET,
> +	CTRL_IO,
> +	CTRL_PIDS,
> +	CTRL_HUGETLB,
> +	CTRL_CPUACCT,
> +	CTRL_DEVICES,
> +	CTRL_FREEZER,
> +	CTRL_NETCLS,
> +	CTRL_NETPRIO,
> +	CTRL_BLKIO,
> +	CTRL_MISC,
> +	CTRL_PERFEVENT

I think we need the debug controller as cgroup_fj_function is called
with that in runtest/controllers.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
