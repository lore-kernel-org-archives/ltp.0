Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84E6DC00140
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 09:22:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1426A3C95F9
	for <ltp@archiver.kernel.org>; Mon, 15 Aug 2022 11:22:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 641613C01CC
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 11:22:03 +0200 (CEST)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C100F200227
 for <ltp@lists.linux.it>; Mon, 15 Aug 2022 11:22:01 +0200 (CEST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 97B3660FC9;
 Mon, 15 Aug 2022 09:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A05C433D6;
 Mon, 15 Aug 2022 09:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660555318;
 bh=i9Hd1HNRIu92fOf8NS8lLyBX1w3DdxO8Np4oDf/RTM0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=nyM8ITmWVSkOBWOOkcIUw02UqNAB4pSw0woLOEU7DfdspKMLI9SQT+pm4HjeiU56x
 jquX/Y7umjmlUIjex+YPF/MofHp5+d+uX+3uTUhRzhVEKzrRwW7uUCIV+/b/LeDLcj
 ZMjABo3NP30hY8XTInu0DSltaUMGm/hhU274zQ5f3S7lew3ejihAbUZZqbl32V7u4c
 ZQO23a0gummDosKXYWh1iE9xnpyxW+oPe13NIf2lOn5LxWAiT2p67/NFge2Bbrp0xw
 H8k1ZCGR80nRnO8icct2z4z5WGPK/jXWUfNzrApOUQcsKiWEeyPXgVS7kT9lVQIXhc
 OVhaJR4P6IWPw==
Date: Mon, 15 Aug 2022 11:21:53 +0200
From: Christian Brauner <brauner@kernel.org>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20220815092153.fig2whemvtow6gtb@wittgenstein>
References: <c266e389-c6f4-502f-523d-6d51fbf3ed58@suse.cz>
 <1660555627-2269-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1660555627-2269-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] syscalls/creat09: Add umask test condition
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

On Mon, Aug 15, 2022 at 05:27:06PM +0800, Yang Xu wrote:
> A kernel patch set that fix setgid strip logic under umask(S_IXGRP) found by
> this case has been merged into 6.0-rc1 kernel[1].
> 
> I will add acl and umask test[2] in xfstests because there is more suitable
> to do this.

I just realized that before I added the idmapped mounts testsuite into
xfstests which tests setgid inheritance in ~April 2021 tests like this
didn't exist in LTP apparently as well. Interesting. I was wondering why
setgid inheritance bugs hadn't been caught by it. :)

Great to expand them!

> 
> Here I just only add umask test condition simply.
> 
> [1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1639a49c
> [2]https://patchwork.kernel.org/project/fstests/list/?series=662984
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

>  testcases/kernel/syscalls/creat/creat09.c | 30 +++++++++++++++++++++--
>  1 file changed, 28 insertions(+), 2 deletions(-)
> 
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
> +
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
Mailing list info: https://lists.linux.it/listinfo/ltp
