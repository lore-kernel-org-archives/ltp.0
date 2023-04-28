Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B9AAC77B60
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 07:59:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4B4E3CBA2E
	for <ltp@archiver.kernel.org>; Fri, 28 Apr 2023 09:59:30 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DB863CB36F
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 09:59:20 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D068F1400343
 for <ltp@lists.linux.it>; Fri, 28 Apr 2023 09:59:18 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7ED1C1FFF7;
 Fri, 28 Apr 2023 07:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682668758;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tw1MKuSneUb2mBwlYbEOQD0JWZijuH+JwdFrfz969RE=;
 b=zVRGuiGeQy35kUqBWSpikUnMLHfDMBROsHEGDGM9hc3tcn3Uf45JR26kaGlXijQG++MWDX
 QyWpKWx45Te/tFNy5kMHXnOY1YuZ+yJU7abMQmvBJLaFUt/Sd5XGcUfLeubp9NK6SQiVI+
 P+GK+U0w/ZLb4qnrJT89mq91u7pNtRg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682668758;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Tw1MKuSneUb2mBwlYbEOQD0JWZijuH+JwdFrfz969RE=;
 b=TUm6Dj9IR0FIdtHt8vKrPD8mCwW0a6IfvhHb+6il5CXmnYm4RF6mvPpqYQBnv7kNSKYl8S
 Ed/HdETdIyhTm9AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 519E81390E;
 Fri, 28 Apr 2023 07:59:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 7PIHEtZ8S2TyZQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 28 Apr 2023 07:59:18 +0000
Date: Fri, 28 Apr 2023 09:59:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20230428075928.GA3191151@pevik>
References: <20230422135337.12087-1-wegao@suse.com>
 <20230428001701.31670-1-wegao@suse.com>
 <20230428001701.31670-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230428001701.31670-3-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v10 2/2] tst_cgroup.c: Add a cgroup base controller
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

>  lib/tst_cgroup.c | 47 ++++++++++++++++++++++++++++++++---------------
...
> @@ -798,6 +804,10 @@ void tst_cg_require(const char *const ctrl_name,
>  	const char *const cgsc = "cgroup.subtree_control";
>  	struct cgroup_ctrl *const ctrl = cgroup_find_ctrl(ctrl_name);
>  	struct cgroup_root *root;
> +	int base = !strcmp(ctrl->ctrl_name, "base");
> +
> +	if (base && options->needs_ver != TST_CG_V2)
> +		tst_brk(TCONF, "Base control only support needs_ver TST_CG_V2!");

>  	if (!ctrl) {
>  		tst_brk(TBROK, "'%s' controller is unknown to LTP", ctrl_name);
> @@ -827,6 +837,9 @@ void tst_cg_require(const char *const ctrl_name,
>  	if (options->needs_ver != TST_CG_V2)
>  		cgroup_mount_v1(ctrl);

> +	if (base)
> +		ctrl->ctrl_root = roots;
> +
>  	if (!ctrl->ctrl_root) {
>  		tst_brk(TCONF,
>  			"'%s' controller required, but not available",
> @@ -849,13 +862,13 @@ mkdirs:
>  			ctrl->ctrl_name);
>  	}

> -	if (cgroup_ctrl_on_v2(ctrl)) {
> +	if (cgroup_ctrl_on_v2(ctrl) && !base) {
>  		if (root->we_mounted_it) {
>  			SAFE_FILE_PRINTFAT(root->mnt_dir.dir_fd,
> -					   cgsc, "+%s", ctrl->ctrl_name);
> +					cgsc, "+%s", ctrl->ctrl_name);
This is just unneeded whitespace change, it should be reverted.
I guess you changed it just by accident, right?
>  		} else {
>  			tst_file_printfat(root->mnt_dir.dir_fd,
> -					  cgsc, "+%s", ctrl->ctrl_name);
> +					cgsc, "+%s", ctrl->ctrl_name);
Here as well.

Kind regards,
Petr
>  		}
>  	}
...


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
