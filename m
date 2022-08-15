Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0862EC00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 09:32:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AF7943C97BD
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 11:32:46 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B2F3A3C01CC
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 11:32:36 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 56489680E35
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 11:32:34 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 536BC60FC7;
 Mon, 15 Aug 2022 09:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A6AC433D6;
 Mon, 15 Aug 2022 09:32:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660555952;
 bh=f0ZvJg2EroeNAwp2AqLZInryf0rT9QGD7qwkhGd7j2Q=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=GTTJQ1jBSIxDXH2R0zGUXJBWxFowDGr8FfDjkvSbPJt8yFFHqAHiJSEEmhuZsxyl2
 dos6IzvviXUxZPOf8WJ8PUVELajd7DuU1uvvAq9Y8YxbWr8E5D/6eEooJVXsrYAych
 Yu/VbT1aoB7oBweImjk/QMkHUtfhowhigb78owW/o+9tx9pyVtBxhzVn2wHrbNytc8
 3XsI5eca+ci6PD4jerLwYM18NWPmCdKYNUIbCl1ohJjeMhLjt4rwT1T1SRqOTpwANk
 1yz6O4zQwocS2ZtHrYAmTKeAVMQjv267AZKFpIHFNYJsjLFWh+9G1u3uFMYJljPFE0
 Zhbo9vRFCdgJw==
Date: Mon, 15 Aug 2022 11:32:28 +0200
From: Christian Brauner <brauner@kernel.org>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20220815093228.vf3o7cu4a7jexlv2@wittgenstein>
References: <1659497063-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1659497063-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] syscalls/creat09: Add umask test condition
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
Cc: martin.doucha@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Aug 03, 2022 at 11:24:22AM +0800, Yang Xu wrote:
> A kernel patch set that fix setgid strip logic under umask(S_IXGRP) found by
> this case has been merged into linux-next branch[1].
> 
> I will add acl and umask test[2] in xfstests because there is more suitable
> to do this.
> 
> Here I just only add umask test condition simply.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20220802&id=1639a49ccdce
> [2]https://patchwork.kernel.org/project/fstests/list/?series=662984
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Looks good to me,
Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>

> v1-v2:
> 1.update linux-next and xfstests url
> 2.use Ternary Operator instead of switch or if
>  testcases/kernel/syscalls/creat/creat09.c | 19 +++++++++++++++++--
>  1 file changed, 17 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
> index bed7bddb0..7077cbcff 100644
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
> @@ -94,8 +104,11 @@ static void file_test(const char *name)
>  		tst_res(TPASS, "%s: Setgid bit not set", name);
>  }
>  
> -static void run(void)
> +static void run(unsigned int n)
>  {
> +	umask(n ? S_IXGRP : 0);
> +	tst_res(TINFO, "under umask(%s) situation", n ? "S_IXGRP" : "0");
> +
>  	fd = SAFE_CREAT(CREAT_FILE, MODE_SGID);
>  	SAFE_CLOSE(fd);
>  	file_test(CREAT_FILE);
> @@ -115,13 +128,14 @@ static void cleanup(void)
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
> +	.tcnt = 2,
>  	.skip_filesystems = (const char*[]) {
>  		"exfat",
>  		"ntfs",
> @@ -132,6 +146,7 @@ static struct tst_test test = {
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
Mailing list info: https://lists.linux.it/listinfo/ltp
