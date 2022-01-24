Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 306C0C433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 11:58:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85F813C8F8A
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 12:58:51 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6CC7C3C65E6
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 12:58:41 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9C2D9600807
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 12:58:40 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id E0B9C1F38B;
 Mon, 24 Jan 2022 11:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643025519;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6rq2dM/BpwNg9b4dvUzkFE87x0VOA15jjUVE5wOJuVc=;
 b=p4NbxZl/aXL2QX2ux3f4jbOv6dFwKfvwx4B9JIZ8wjS+IhE3v9CbOXUHVVhhhXa4vb8Ggv
 kahJZ1v0LIzN+MwH5RFdQ2C+hOT3I3x9Ac6AbXFqZsiWRJpNqJsMFvqCdM9xeLvIBHzwOf
 A9IXHnQGgewnugldR8mA+h/dhoPb/5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643025519;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6rq2dM/BpwNg9b4dvUzkFE87x0VOA15jjUVE5wOJuVc=;
 b=aMXSOnkefPKWlNUr4pnu69RR8vHNTg7qe+icRLM+abwqOdG8yuWyMHN0UoezoLGdQmBxDJ
 PRdYZORIZPJpZqAQ==
Received: from g78 (unknown [10.163.24.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id 9CF78A3B81;
 Mon, 24 Jan 2022 11:58:39 +0000 (UTC)
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <b000b664ed74dc8e52c7afe0061471c7f8e20d10.1642601554.git.luke.nowakowskikrijger@canonical.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Mon, 24 Jan 2022 11:36:24 +0000
In-reply-to: <b000b664ed74dc8e52c7afe0061471c7f8e20d10.1642601554.git.luke.nowakowskikrijger@canonical.com>
Message-ID: <87fspdz6oh.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 05/16] API/cgroup: Add more controllers to
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

> Add more controllers so that they can be mounted and used using the
> cgroup C api.
>
> Most of the controllers used in controllers tests are added and a
> reasonable working set of the controller control files that I came
> across are added as well.
>
> Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> ---
>  lib/tst_cgroup.c | 153 ++++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 152 insertions(+), 1 deletion(-)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index df541d26a..3d56a3364 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -84,8 +84,20 @@ enum cgroup_ctrl_indx {
>  	CTRL_MEMORY = 1,
>  	CTRL_CPU,
>  	CTRL_CPUSET,
> +	CTRL_IO,
> +	CTRL_PIDS,
> +	CTRL_RDMA,
> +	CTRL_HUGETLB,
> +	CTRL_CPUACCT,
> +	CTRL_DEVICES,
> +	CTRL_FREEZER,
> +	CTRL_NETCLS,
> +	CTRL_NETPRIO,
> +	CTRL_BLKIO,
> +	CTRL_MISC,
> +	CTRL_PERFEVENT
>  };
> -#define CTRLS_MAX CTRL_CPUSET
> +#define CTRLS_MAX CTRL_PERFEVENT
>  
>  /* At most we can have one cgroup V1 tree for each controller and one
>   * (empty) v2 tree.
> @@ -181,6 +193,109 @@ static const struct cgroup_file cpuset_ctrl_files[] = {
>  	{ }
>  };
>  
> +static const struct cgroup_file io_ctrl_files[] = {
> +	{ "io.state", NULL, CTRL_IO },
> +	{ "io.cost.qos", NULL, CTRL_IO },
> +	{ "io.cost.model", NULL, CTRL_IO },
> +	{ "io.weight", NULL, CTRL_IO },
> +	{ "io.max", NULL, CTRL_IO },
> +	{ "io.pressure", NULL, CTRL_IO },
> +	{ }
> +};
> +
> +static const struct cgroup_file pids_ctrl_files[] = {
> +	{ "pids.max", "pids.max", CTRL_PIDS },
> +	{ "pids.current", "pids.current", CTRL_PIDS },
> +	{ }
> +};
> +
> +static const struct cgroup_file rdma_ctrl_files[] = {
> +	{ "rdma.max", "rdma.max", CTRL_RDMA },
> +	{ "rdma.current", "rdma.current", CTRL_RDMA },
> +	{ }
> +};

Please don't add stuff we don't have an immediate requirement for!

We don't have any tests for RDMA yet. I can't even find the "rdma|RDMA"
in the LTP codebase. We may never test most of these controllers, it's
just dead code that will have to be rewritten if/when we have to
implement a more complex V1/V2 compatability layer. Also, as with blkio
and io, you may be adding the same controllers twice under V1 and V2
names.

Just add the exact things we need for existing tests.

-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
