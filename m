Return-Path: <SRS0=JaEE=OF=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47E18C433FE
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 10:51:05 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5325F6127A
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 10:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5325F6127A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0AB13C899B
	for <ltp@archiver.kernel.org>; Wed, 15 Sep 2021 12:51:01 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 873B73C23B8
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 12:50:50 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DF746200D55
 for <ltp@lists.linux.it>; Wed, 15 Sep 2021 12:50:49 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1A3462219D;
 Wed, 15 Sep 2021 10:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631703049;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MSyaQOmteuv3Es0/DMfLuovF1zjHLx+ZWYzg1EQE1ho=;
 b=1fj7M00igQjSuVH67BpM7Y1XK0H3H5n2hP/9sn6HTKJNn+auujB/k4m5zRGXDKMmpUJYIz
 hfiWQTMueJ0xNNLZEU0QiWyHvEhQIPhclU13FUcTjVLYBnDzrrp75VtOmy/HiSv8OBR+Fb
 YBVWDucfAhEGdHVaxP6iOZUgzW0kxcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631703049;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MSyaQOmteuv3Es0/DMfLuovF1zjHLx+ZWYzg1EQE1ho=;
 b=nO93tfl55ZcDk6CRvlwa1TAnoSi1basjW9y6wGCQUE01hq49Rsq4tIyiKSAPPfiSOgrs6i
 vYvGBWOJzPyT5yBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E5D6413C2F;
 Wed, 15 Sep 2021 10:50:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id b0iANgjQQWGABQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 15 Sep 2021 10:50:48 +0000
Date: Wed, 15 Sep 2021 12:50:47 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>
Message-ID: <YUHQByoKzIm/cMfz@pevik>
References: <1631699402-17607-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1631699402-17607-1-git-send-email-daisl.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] controllers/cpuacct: Fix deleting directories
 errors
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
Message-ID: <20210915105047.F-3rf67f6T8uCh-J5GhxYuDA_1eVpUmonCuhWE-eUzY@z>

Hi Dai, Xu,

> To remove a directory hierarchy on a normal file system you can use rm command to
> remove all files from each subdirectory and then remove the parent directories.
> But a cgroup which doesn't have any children and is associated only with zombie processes
> is considered empty and can not be removed by rm.
> The following errors will be reported.

> cpuacct 1 TINFO: removing created directories
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cgroup.procs': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpu.cfs_period_us': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpu.stat': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpuacct.usage_percpu_sys': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpu.shares': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpuacct.usage_percpu': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpuacct.stat': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/cpuacct.usage': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/subgroup_1/cgroup.procs': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/subgroup_1/cpu.cfs_period_us': Operation not permitted
> rm: cannot remove '/sys/fs/cgroup/cpu,cpuacct/ltp_cpuacct/subgroup_1/cpu.stat': Operation not permitted
> ...

> It's recommended to use rmdir command.

Sorry for introducing a regression and for correction.
I'll revert on your behalf commit d6cc08592 ("controllers/cpuacct: Simplify
deleting directories"), with your explanation.


Kind regards,
Petr


> [1] http://blog.tinola.com/?e=21
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/admin-guide/cgroup-v2.rst#n237

> Reviewed-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> Signed-off-by: Dai Shili <daisl.fnst@fujitsu.com>
> ---
>  testcases/kernel/controllers/cpuacct/cpuacct.sh | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

> diff --git a/testcases/kernel/controllers/cpuacct/cpuacct.sh b/testcases/kernel/controllers/cpuacct/cpuacct.sh
> index 99258c2..f526d0f 100755
> --- a/testcases/kernel/controllers/cpuacct/cpuacct.sh
> +++ b/testcases/kernel/controllers/cpuacct/cpuacct.sh
> @@ -122,7 +122,10 @@ cleanup()

>  	if [ "$testpath" ]; then
>  		tst_res TINFO "removing created directories"
> -		rm -rf $testpath
> +		if [ -d "$testpath/subgroup_1" ]; then
> +			rmdir $testpath/subgroup_*
> +		fi
> +			rmdir $testpath
>  	fi

>  	if [ "$mounted" -ne 1 ]; then

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
