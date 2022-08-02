Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7E75C00140
	for <ltp@archiver.kernel.org>; Tue,  2 Aug 2022 17:26:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 915C43C91B1
	for <ltp@archiver.kernel.org>; Tue,  2 Aug 2022 19:26:56 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB5613C0CC0
 for <ltp@lists.linux.it>; Tue,  2 Aug 2022 19:26:45 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 08CBF200230
 for <ltp@lists.linux.it>; Tue,  2 Aug 2022 19:26:44 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA45037DC0;
 Tue,  2 Aug 2022 17:26:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659461203;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L0MmhH019ZC1OtwmYLzvBF75O0dKxkxqEIFw1tC+qIc=;
 b=KD63KkEZhf0lyM2FrSI2m7y2uSsHDqOMhwkFs9DydLYb+mqSDzED2miqvZCPXnmJXeUiN3
 EurGNeq+AKClDj4/HRVLTX3rvAsGsgvbfgx2NMCkcjJe6wZ3waVpR6wpqYOF6IAP0Xi8dE
 s/TN9YJi3Iki+y8nituDZohwL82CNz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659461203;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L0MmhH019ZC1OtwmYLzvBF75O0dKxkxqEIFw1tC+qIc=;
 b=NZqStrUthBSs0kHxTvVh7Y47TBmMVnaVnAckxOFjBwsOLaQhd9M4+uLV+6//ciTXadAenw
 9wK95ZKmLA98xTAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9E41113A8E;
 Tue,  2 Aug 2022 17:26:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kVQMJFNe6WIjPwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 02 Aug 2022 17:26:43 +0000
Date: Tue, 2 Aug 2022 19:26:41 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YuleUaVMAnGEQ8ov@pevik>
References: <1658485640-2188-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1658485640-2188-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/2] syscalls/creat09: Add umask condition
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
Cc: brauner@kernel.org, Martin Doucha <martin.doucha@suse.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Xu,

[ Cc Martin ]

> A kernel patch set that fix setgid strip logic under umask(S_IXGRP) found by
> this case has been merged into Christian Brauner for-next branch[1].

> I guess it will be merged into linux-next branch.

> I will add acl and umask test[2][3] in xfstests because there is more suitable
> to do this.

> Here I just only add umask condition simply.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> [1]https://git.kernel.org/pub/scm/linux/kernel/git/brauner/linux.git/log/?h=for-next
> [2]https://www.spinics.net/lists/fstests/msg19554.html
> [3]https://www.spinics.net/lists/fstests/msg19555.html

> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  testcases/kernel/syscalls/creat/creat09.c | 27 +++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)

> diff --git a/testcases/kernel/syscalls/creat/creat09.c b/testcases/kernel/syscalls/creat/creat09.c
> index bed7bddb0..04bc98d11 100644
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

>  #include <stdlib.h>
> @@ -94,8 +104,19 @@ static void file_test(const char *name)
>  		tst_res(TPASS, "%s: Setgid bit not set", name);
>  }

> -static void run(void)
> +static void run(unsigned int n)
>  {
> +	switch (n) {
> +	case 0:
> +		umask(0);
> +		tst_res(TINFO, "under umask(0) situation");
> +		break;
> +	case 1:
> +		umask(S_IXGRP);
> +		tst_res(TINFO, "under umask(S_IXGRP) situation");
> +		break;
> +	}
nit: Maybe just use if for to cases.
I also thought that .test_variants could be used for this kind of setup.

Kind regards,
Petr

> +
>  	fd = SAFE_CREAT(CREAT_FILE, MODE_SGID);
>  	SAFE_CLOSE(fd);
>  	file_test(CREAT_FILE);
> @@ -115,13 +136,14 @@ static void cleanup(void)
>  }

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
> @@ -132,6 +154,7 @@ static struct tst_test test = {
>  		{"linux-git", "0fa3ecd87848"},
>  		{"CVE", "2018-13405"},
>  		{"linux-git", "01ea173e103e"},
> +		{"linux-git", "1639a49ccdce"},
>  		{}
>  	},
>  };

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
