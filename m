Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0799C433EF
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 11:32:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 99B413C7F1C
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 12:32:27 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AAF43C6F6F
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 12:32:16 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0F2531400B69
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 12:32:15 +0100 (CET)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id 1FE811F38B;
 Mon, 24 Jan 2022 11:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1643023935;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z7ne45qrR5edhGVtRzv0ae5kd429txIk1EvCnrqjKEI=;
 b=vyjkB02Fb0FGdCVy0zPHVkKmkECwWVkAvvzfbt9PP0Q1jucE1Yx4VQt96q0Nag1HJm/ku3
 9gAdt6C+U/VeV44VZ2qjMopOZJsZTmEIvBcVM6+xewOm2wIK8bXGygLV9qjsMbfC4SlvO1
 6jFSNNhh/XnYBUuh1nuyuCVYNqG4OKc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1643023935;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z7ne45qrR5edhGVtRzv0ae5kd429txIk1EvCnrqjKEI=;
 b=TXxSmdwllOnnUrQM792uisNB7VT2y4qdIAeCQEWlB95a7/HH4TeE0PZ2AmE9dzAQXS0FH9
 BkT2LNi4SqmOgFCw==
Received: from g78 (unknown [10.163.24.90])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay2.suse.de (Postfix) with ESMTPS id D47E5A3B84;
 Mon, 24 Jan 2022 11:32:14 +0000 (UTC)
References: <cover.1642601554.git.luke.nowakowskikrijger@canonical.com>
 <3e412686c9cd82cd58697b8200b6d961d7fe4af9.1642601554.git.luke.nowakowskikrijger@canonical.com>
User-agent: mu4e 1.6.10; emacs 27.2
From: Richard Palethorpe <rpalethorpe@suse.de>
To: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Date: Mon, 24 Jan 2022 11:16:24 +0000
In-reply-to: <3e412686c9cd82cd58697b8200b6d961d7fe4af9.1642601554.git.luke.nowakowskikrijger@canonical.com>
Message-ID: <87k0epz7wh.fsf@suse.de>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 01/16] API/cgroup: Modify
 tst_cgroup_print_config for easier parsing and consumption
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

> Prepare tst_cgroup_print_config to be more easily parsed and consumed by
> shell scripts and other programs.
>
> Also add any detected root information as well as the relevant state
> associated with the roots that would be needed by the test to properly
> cleanup.
>
> Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
> ---
> v2: Remove "mounted_drain_dir" as mounting ltp dir and drain dir happen
> at the same time
>
>  lib/tst_cgroup.c | 35 +++++++++++++++++++++++++++++++----
>  1 file changed, 31 insertions(+), 4 deletions(-)
>
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index 2ef599d9e..704e64030 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -301,12 +301,26 @@ opendir:
>  				  O_PATH | O_DIRECTORY);
>  }
>  
> +#define CONFIG_LTPDIR_KEY "Created_Ltp_Dir"
> +#define CONFIG_MOUNTROOT_KEY "Mounted_Root"
> +#define CONFIG_TESTID_KEY "Test_Id"
> +#define CONFIG_CTRL_REQUIRED "Required"
> +#define CONFIG_CTRL_HEADER "Detected Controllers:"
> +#define CONFIG_ROOT_HEADER "Detected Roots:"

Do we really need to configure these? Also why not just use the same
variable names as the C? It makes grepping them easier.

> +
> +/* Prints out the minimal internal state of the test to be consumed
> + * by tst_cgroup_load_config().
> + *
> + * The config keeps track of the minimal state needed for tst_cgroup_cleanup
> + * to cleanup after a test and does not keep track of the creation of
> + * test cgroups that might be created through tst_cgroup_group_mk().
> + */
>  void tst_cgroup_print_config(void)
>  {
>  	struct cgroup_root *root;
>  	const struct cgroup_ctrl *ctrl;
>  
> -	tst_res(TINFO, "Detected Controllers:");
> +	printf("%s\n", CONFIG_CTRL_HEADER);
>  
>  	for_each_ctrl(ctrl) {
>  		root = ctrl->ctrl_root;
> @@ -314,11 +328,24 @@ void tst_cgroup_print_config(void)
>  		if (!root)
>  			continue;
>  
> -		tst_res(TINFO, "\t%.10s %s @ %s:%s",
> +		printf("%s %s @ %s %s\n",
>  			ctrl->ctrl_name,
> -			root->no_cpuset_prefix ? "[noprefix]" : "",
>  			root->ver == TST_CGROUP_V1 ? "V1" : "V2",
> -			root->mnt_path);
> +			root->mnt_path,
> +			ctrl->we_require_it ? CONFIG_CTRL_REQUIRED : "");
> +	}
> +
> +	printf("%s\n", CONFIG_ROOT_HEADER);
> +
> +	for_each_root(root) {
> +		printf("%s %s=%s %s=%s %s=%s\n",

Perhaps we could just use tab separated values? The first row could be
the column names.

> +			root->mnt_path,
> +			CONFIG_MOUNTROOT_KEY,
> +			root->we_mounted_it ? "yes" : "no",
> +			CONFIG_LTPDIR_KEY,
> +			root->ltp_dir.we_created_it ? "yes" : "no",
> +			CONFIG_TESTID_KEY,
> +			root->test_dir.dir_name ? root->test_dir.dir_name : "NULL");
>  	}
>  }


-- 
Thank you,
Richard.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
