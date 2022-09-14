Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 901B1ECAAD8
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 11:26:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4C463CAC40
	for <ltp@archiver.kernel.org>; Wed, 14 Sep 2022 13:26:34 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3738D3CAAEF
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 13:26:25 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6153114012B3
 for <ltp@lists.linux.it>; Wed, 14 Sep 2022 13:26:23 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7857F1F96E;
 Wed, 14 Sep 2022 11:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663154783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+TNsNoRSau+63j7qAzmyh6dn2GlgR9qkTWV52XcaHc=;
 b=V1yKzxCS0RdO8p1XUn4SJx56Tu0iO93IizS7+gbc2EOE6GYzI5opxkCLYuf92rQyHX/Q77
 JoGwCoo/kzldvRp+7LoC2mi2sKbL2/k9jh5KPCNNXNyzVh1vnQD2gXh99iNIVVvckuMDXS
 XmY9RhhPvFFhBDspg4amt4WTMi4FKIE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663154783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5+TNsNoRSau+63j7qAzmyh6dn2GlgR9qkTWV52XcaHc=;
 b=Ln5Y2Z9TXA0ARXeMOq69EOSWpTHZuE4jOgvTJH/LX3g6rxHCIohSN2su13frfS1e8hDmww
 fZN2ayXhyg1eY0Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 661DA13494;
 Wed, 14 Sep 2022 11:26:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IliJF1+6IWO/YAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 14 Sep 2022 11:26:23 +0000
Date: Wed, 14 Sep 2022 13:28:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YyG61JHO7iDAfJ1N@yuki>
References: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1663143142-2283-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] syscalls/creat09: Add umask test condition
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
Cc: brauner@kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
> index bed7bddb0..d583cceca 100644
> --- a/testcases/kernel/syscalls/creat/creat09.c
> +++ b/testcases/kernel/syscalls/creat/creat09.c
> @@ -28,6 +28,16 @@
>   *  Date:   Fri Jan 22 16:48:18 2021 -0800
>   *
>   *  xfs: fix up non-directory creation in SGID directories
> + *
> + * When use acl or umask, it still has bug.
> + *
> + * Fixed in:
> + *
> + *  commit 1639a49ccdce58ea248841ed9b23babcce6dbb0b
> + *  Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> + *  Date:   Thu July 14 14:11:27 2022 +0800
> + *
> + *  fs: move S_ISGID stripping into the vfs_*() helpers
>   */
>  
>  #include <stdlib.h>
> @@ -47,6 +57,14 @@
>  static gid_t free_gid;
>  static int fd = -1;
>  
> +static struct tcase {
> +	const char *msg;
> +	int mask;
> +} tcases[] = {
> +	{"under umask(0) situation", 0},
> +	{"under umask(S_IXGRP) situation", S_IXGRP}
> +};
> +
>  static void setup(void)
>  {
>  	struct stat buf;
> @@ -94,8 +112,14 @@ static void file_test(const char *name)
>  		tst_res(TPASS, "%s: Setgid bit not set", name);
>  }
>  
> -static void run(void)
> +static void run(unsigned int n)
>  {
> +	struct tcase *tc = &tcases[n];
> +
> +	umask(tc->mask);
> +	tst_res(TINFO, "Testing setgid behaviour when creating file %s",
> +			tc->msg);

This can be shorter and more to the point, something as:

	tst_res(TINFO, "File created with %s", tc->msg);

And the msg could be just "umask(0)" and "umask(S_IXGRP)".


Otherwise it's fine and I can fix the messages before applying if you
want.

>  	fd = SAFE_CREAT(CREAT_FILE, MODE_SGID);
>  	SAFE_CLOSE(fd);
>  	file_test(CREAT_FILE);
> @@ -115,13 +139,14 @@ static void cleanup(void)
>  }
>  
>  static struct tst_test test = {
> -	.test_all = run,
> +	.test = run,
>  	.setup = setup,
>  	.cleanup = cleanup,
>  	.needs_root = 1,
>  	.all_filesystems = 1,
>  	.mount_device = 1,
>  	.mntpoint = MNTPOINT,
> +	.tcnt = ARRAY_SIZE(tcases),
>  	.skip_filesystems = (const char*[]) {
>  		"exfat",
>  		"ntfs",
> @@ -132,6 +157,7 @@ static struct tst_test test = {
>  		{"linux-git", "0fa3ecd87848"},
>  		{"CVE", "2018-13405"},
>  		{"linux-git", "01ea173e103e"},
> +		{"linux-git", "1639a49ccdce"},
>  		{}
>  	},
>  };
> -- 
> 2.23.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
