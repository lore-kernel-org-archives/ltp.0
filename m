Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DF95EB64DA
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 14:33:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 63C913CEB31
	for <ltp@archiver.kernel.org>; Tue, 18 Jul 2023 16:33:54 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 786CB3C98F6
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 16:33:42 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0C7EB60096A
 for <ltp@lists.linux.it>; Tue, 18 Jul 2023 16:33:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5953E1F45A;
 Tue, 18 Jul 2023 14:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1689690821; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vquKTeteQJybdqU1TI7OfPRcm2A7Aa0R72s4vXcZUG4=;
 b=A735UOJOgbMA+1nGLr+ATVSzVr91klaau8iIMfaLzC2SJdLWjQWhGWDAqMvjYnGcuxLqJN
 noXUYOoioRl/i6q7rW4YfDHu9Sv1+txKpLvz8eddv/ccp6x3gpAsJw7Myy+QtNgYrAfeK/
 9moWWImDw75p2VJXJEaPODld08FS1Ck=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1689690821;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vquKTeteQJybdqU1TI7OfPRcm2A7Aa0R72s4vXcZUG4=;
 b=5w/2DsoSJbh8Mrs6Yp3cIlAX3YG3JNQo/ckvGRP0cPYYlXls7fDU/Af5U638b6rbplLVWy
 HXkzEsERXJVOQ0Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26E55134B0;
 Tue, 18 Jul 2023 14:33:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CRA0B8WitmTIDAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 18 Jul 2023 14:33:41 +0000
Message-ID: <23241907-fdfa-f1c0-7979-4680aae40252@suse.cz>
Date: Tue, 18 Jul 2023 16:33:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To: Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20230717125413.1123587-1-pvorel@suse.cz>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230717125413.1123587-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] statx09: Format filesystem with page size
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,
Reviewed-by: Martin Doucha <mdoucha@suse.cz>

On 17. 07. 23 14:54, Petr Vorel wrote:
> This fixes statx09.c for kernel < 6.3. Previously test was skipped:
> statx09.c:126: TCONF: fs-verity not supported on loopdev, due the
> default block size, which is for our 300 MB loop device 1024.
> 
> This is a follow up of previous fix 2e582e743 ("statx09: Set fs-verity
> blocksize to FS blocksize") for kernel >= 6.3.
> 
> Suggested-by: Martin Doucha <mdoucha@suse.cz>
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>   testcases/kernel/syscalls/statx/statx09.c | 10 ++++++++--
>   1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/statx/statx09.c b/testcases/kernel/syscalls/statx/statx09.c
> index 7211d8393..6e75ff3ec 100644
> --- a/testcases/kernel/syscalls/statx/statx09.c
> +++ b/testcases/kernel/syscalls/statx/statx09.c
> @@ -20,6 +20,7 @@
>   #define _GNU_SOURCE
>   #include <sys/mount.h>
>   #include <stdlib.h>
> +#include <stdio.h>
>   #include "tst_test.h"
>   #include "lapi/fs.h"
>   #include "lapi/fsverity.h"
> @@ -120,6 +121,12 @@ static void flag_setup(void)
>   
>   static void setup(void)
>   {
> +	char opt_bsize[32];
> +	const char *const fs_opts[] = {"-O verity", opt_bsize, NULL};
> +
> +	snprintf(opt_bsize, sizeof(opt_bsize), "-b %i", getpagesize());
> +	SAFE_MKFS(tst_device->dev, tst_device->fs_type, fs_opts, NULL);
> +
>   	TEST(mount(tst_device->dev, MNTPOINT, tst_device->fs_type, 0, NULL));
>   	if (TST_RET) {
>   		if (TST_ERR == EINVAL)
> @@ -147,10 +154,9 @@ static struct tst_test test = {
>   	.setup = setup,
>   	.cleanup = cleanup,
>   	.needs_root = 1,
> +	.needs_device = 1,
>   	.mntpoint = MNTPOINT,
> -	.format_device = 1,
>   	.dev_fs_type = "ext4",
> -	.dev_fs_opts = (const char *const []){"-O verity", NULL},
>   	.needs_kconfigs = (const char *[]) {
>   		"CONFIG_FS_VERITY",
>   		NULL

-- 
Martin Doucha   mdoucha@suse.cz
SW Quality Engineer
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
