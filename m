Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05ABEC77B60
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 13:11:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B65A73CBB5B
	for <ltp@archiver.kernel.org>; Wed, 26 Apr 2023 15:11:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0145E3CAA20
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 15:11:10 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0EBF12009A9
 for <ltp@lists.linux.it>; Wed, 26 Apr 2023 15:11:09 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 328691FDC9;
 Wed, 26 Apr 2023 13:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682514669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ZfSflGTDrJL0ap7yOQtuAe1IoJKJdbSWSKw9RzBazo=;
 b=O2nRKAmR+LF5N18at2ZfjNVm32OHxNnQr7CPeYZM5Suh+a4j5+UP0NH6LCwgaaOpsBfnlS
 ABUD6AKe5fLBzeJ8Iv65AOgM0jUjxUc7I7bjQCfHjREZGAkMeG6axU3J1ONGCQ5tTu9W5k
 PxXCrzIvqn38L/w0ok550gmzgu/OgYc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682514669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9ZfSflGTDrJL0ap7yOQtuAe1IoJKJdbSWSKw9RzBazo=;
 b=p1JGN3clC415MyOXJ80XXtWmS8mrSQM6tcJGuGGlbbIM4TsM9dXZnrORtSlJquxa1YWzEw
 bIc7eb2w+yA8ZOCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D2C8138F0;
 Wed, 26 Apr 2023 13:11:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qrpTBe0iSWT/NQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 26 Apr 2023 13:11:09 +0000
Date: Wed, 26 Apr 2023 15:12:12 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZEkjLAyLblqfvWIK@yuki>
References: <20230421012642.16625-1-wegao@suse.com>
 <20230422135337.12087-1-wegao@suse.com>
 <20230422135337.12087-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230422135337.12087-3-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 2/2] tst_cgroup.c: Add a cgroup pseudo
 controller
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

Hi!
> For new test case such as kill01.c no need specific controller, it just
> need LTP cgroup library start work, so we need add a "cgroup" pseudo
> controller.

Can we please call it "base" controller? Or something better fitting?

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  lib/tst_cgroup.c | 47 ++++++++++++++++++++++++++++++++---------------
>  1 file changed, 32 insertions(+), 15 deletions(-)
> 
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 77575431d..ed3e0758f 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -94,9 +94,10 @@ enum cgroup_ctrl_indx {
>  	CTRL_MISC,
>  	CTRL_PERFEVENT,
>  	CTRL_DEBUG,
> -	CTRL_RDMA
> +	CTRL_RDMA,
> +	CTRL_PSEUDO
>  };
> -#define CTRLS_MAX CTRL_RDMA
> +#define CTRLS_MAX CTRL_PSEUDO
>  
>  /* At most we can have one cgroup V1 tree for each controller and one
>   * (empty) v2 tree.
> @@ -259,6 +260,10 @@ static const struct cgroup_file rdma_ctrl_files[] = {
>  	{ }
>  };
>  
> +static const struct cgroup_file pseudo_ctrl_files[] = {
> +	{ }
> +};
> +
>  #define CTRL_NAME_MAX 31
>  #define CGROUP_CTRL_MEMBER(x, y)[y] = { .ctrl_name = #x, .files = \
>  	x ## _ctrl_files, .ctrl_indx = y, NULL, 0 }
> @@ -282,6 +287,7 @@ static struct cgroup_ctrl controllers[] = {
>  	CGROUP_CTRL_MEMBER(perf_event, CTRL_PERFEVENT),
>  	CGROUP_CTRL_MEMBER(debug, CTRL_DEBUG),
>  	CGROUP_CTRL_MEMBER(rdma, CTRL_RDMA),
> +	CGROUP_CTRL_MEMBER(pseudo, CTRL_PSEUDO),
>  	{ }
>  };
>  
> @@ -798,6 +804,10 @@ void tst_cg_require(const char *const ctrl_name,
>  	const char *const cgsc = "cgroup.subtree_control";
>  	struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);
>  	struct cgroup_root *root;
> +	int pseudo = !strcmp(ctrl->ctrl_name, "pseudo");
> +
> +	if (pseudo && options->needs_ver != TST_CG_V2)
> +		tst_brk(TCONF, "pseudo control only support needs_ver TST_CG_V2!");
>  
>  	if (!ctrl) {
>  		tst_brk(TBROK, "'%s' controller is unknown to LTP", ctrl_name);
> @@ -827,6 +837,9 @@ void tst_cg_require(const char *const ctrl_name,
>  	if (options->needs_ver != TST_CG_V2)
>  		cgroup_mount_v1(ctrl);
>  
> +	if (pseudo)
> +		ctrl->ctrl_root = roots;
> +
>  	if (!ctrl->ctrl_root) {
>  		tst_brk(TCONF,
>  			"'%s' controller required, but not available",
> @@ -849,13 +862,13 @@ mkdirs:
>  			ctrl->ctrl_name);
>  	}
>  
> -	if (cgroup_ctrl_on_v2(ctrl)) {
> +	if (cgroup_ctrl_on_v2(ctrl) && !pseudo) {
>  		if (root->we_mounted_it) {
>  			SAFE_FILE_PRINTFAT(root->mnt_dir.dir_fd,
> -					   cgsc, "+%s", ctrl->ctrl_name);
> +					cgsc, "+%s", ctrl->ctrl_name);
>  		} else {
>  			tst_file_printfat(root->mnt_dir.dir_fd,
> -					  cgsc, "+%s", ctrl->ctrl_name);
> +					cgsc, "+%s", ctrl->ctrl_name);
>  		}
>  	}
>  
> @@ -864,15 +877,17 @@ mkdirs:
>  	else
>  		root->ltp_dir.ctrl_field |= root->mnt_dir.ctrl_field;
>  
> -	if (cgroup_ctrl_on_v2(ctrl)) {
> -		SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
> -				   cgsc, "+%s", ctrl->ctrl_name);
> -	} else {
> -		SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
> -				   "cgroup.clone_children", "%d", 1);
> +	if (!pseudo) {
> +		if (cgroup_ctrl_on_v2(ctrl)) {
> +			SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
> +					cgsc, "+%s", ctrl->ctrl_name);
> +		} else {
> +			SAFE_FILE_PRINTFAT(root->ltp_dir.dir_fd,
> +					"cgroup.clone_children", "%d", 1);
>  
> -		if (ctrl->ctrl_indx == CTRL_CPUSET)
> -			cgroup_copy_cpuset(root);
> +			if (ctrl->ctrl_indx == CTRL_CPUSET)
> +				cgroup_copy_cpuset(root);
> +		}
>  	}
>  
>  	cgroup_dir_mk(&root->ltp_dir, cgroup_ltp_drain_dir, &root->drain_dir);
> @@ -1050,8 +1065,10 @@ static void cgroup_group_add_dir(const struct tst_cg_group *const parent,
>  		if (!parent || dir->dir_root->ver == TST_CG_V1)
>  			continue;
>  
> -		SAFE_CG_PRINTF(parent, "cgroup.subtree_control",
> -				   "+%s", ctrl->ctrl_name);
> +		if (strcmp(ctrl->ctrl_name, "pseudo")) {
> +			SAFE_CG_PRINTF(parent, "cgroup.subtree_control",
> +					"+%s", ctrl->ctrl_name);
> +		}
>  	}
>  
>  	for (i = 0; cg->dirs[i]; i++)
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
