Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8F69C19F2A
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 15:47:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 573FD3C9456
	for <ltp@archiver.kernel.org>; Thu,  4 Aug 2022 17:47:13 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C67063C933F
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 17:47:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AE90B100117A
 for <ltp@lists.linux.it>; Thu,  4 Aug 2022 17:47:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A795D33E0A;
 Thu,  4 Aug 2022 15:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659628021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+DGoORU76cAm2US3yb164V5wMdsv6JcRCLSuq8RWD0s=;
 b=ApDGSbxdLvPw2yA9MjotxdRcPBpZXIGeEtymgClZ1e0+73pYydLo7M/UBf2j8ckVZX+btB
 z4RQ6Cgpmi4BdRMUqgpMK25QyoL/fhyrk3JwpSyzMP32NBhpW4E9WbB1/6LL/f7AXfBU1S
 C+zUctMej4caaEPeS7niFhkgbEPS/ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659628021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+DGoORU76cAm2US3yb164V5wMdsv6JcRCLSuq8RWD0s=;
 b=UEC4CsMmDmbLR35WVGRl9AIjiLOb9NKNB3LjJn2fmfzjVhgM46zU2ky6BLGN43tWbP5AvC
 Ai8TBvwJcgYBjRDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7FB4913434;
 Thu,  4 Aug 2022 15:47:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id F4oRHvXp62K5GQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 04 Aug 2022 15:47:01 +0000
Message-ID: <fb04488d-cf67-b419-2249-e9b844e5ab3d@suse.cz>
Date: Thu, 4 Aug 2022 17:47:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Yang Xu <xuyang2018.jy@fujitsu.com>, ltp@lists.linux.it
References: <1659497063-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <1659497063-2212-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Cc: brauner@kernel.org, martin.doucha@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 03. 08. 22 5:24, Yang Xu wrote:
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

It'd be much cleaner to use an array of testcase structures and then call:
tst_res(TINFO, testcase_list[n].name);
umask(testcase_list[n].mask);

...

.tcnt = ARRAY_SIZE(testcase_list),

See also creat04 for example.

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


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
