Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B8EC38A2D
	for <ltp@archiver.kernel.org>; Fri, 21 Oct 2022 22:14:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6624A3CB26B
	for <ltp@archiver.kernel.org>; Sat, 22 Oct 2022 00:14:07 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EFF223C8B2B
 for <ltp@lists.linux.it>; Sat, 22 Oct 2022 00:13:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 12C972000AB
 for <ltp@lists.linux.it>; Sat, 22 Oct 2022 00:13:55 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 26F8421910;
 Fri, 21 Oct 2022 22:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666390433;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uA7fkYde+1ssvKKnVerwEcQY1hf6spQb62NqG0lvzdo=;
 b=RRESewn+ilUBGM3Qwam6sCzkcjZkp77a7ibQGg6zdI2dUVfgvfbi/cNyxp9nS1lyIPmSet
 XOY1b7C1TYXXGxGMqvdvbXUY5CwkviePWkmRifWrwQM+ZegLw6KoCJWyazIPAHAalns/3Y
 PQyvAaVkaHR97acU7cz3423BGRInSNs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666390433;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uA7fkYde+1ssvKKnVerwEcQY1hf6spQb62NqG0lvzdo=;
 b=NZmHFKWW0FW54HgdBWuNsFBjTH71QZMOzVn+tPrNPw9TmsVOLEc/1xSimHjzhfJ60PDZfo
 9a+yJ6BWgu2QcVDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 098C31331A;
 Fri, 21 Oct 2022 22:13:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WK9WAKEZU2MgcAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Oct 2022 22:13:53 +0000
Date: Sat, 22 Oct 2022 00:13:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Y1MZnwFidi1eZoct@pevik>
References: <1666091413-7732-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1666091413-7732-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mount03: Add statfs f_flags member check
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

Hi Xu,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

>  static void run(unsigned int n)
>  {
>  	struct tcase *tc = &tcases[n];
> +	struct statfs stfs;

>  	tst_res(TINFO, "Testing flag %s", tc->desc);

> @@ -159,6 +160,11 @@ static void run(unsigned int n)
>  	if (tc->test)
>  		tc->test();

> +	SAFE_STATFS(MNTPOINT, &stfs);
> +	if (stfs.f_flags & (n == 3 ? MS_REMOUNT : tc->flag))
Wouldn't it be better to add another struct member for this check?
See patch below.

Kind regards,
Petr

> +		tst_res(TPASS, "statfs() gets the correct mount flag");
> +	else
> +		tst_res(TFAIL, "statfs() gets the incorrect mount flag");
>  	cleanup();
>  }

diff --git testcases/kernel/syscalls/mount/mount03.c testcases/kernel/syscalls/mount/mount03.c
index 297f89838..c4d3c110a 100644
--- testcases/kernel/syscalls/mount/mount03.c
+++ testcases/kernel/syscalls/mount/mount03.c
@@ -114,16 +114,18 @@ static void test_noatime(void)
 	TST_EXP_EQ_LI(st.st_atime, atime);
 }
 
-#define FLAG_DESC(x) .flag = x, .desc = #x
+#define FLAG_DESC(x) .flag = x, .flag2 = x, .desc = #x
+#define FLAG_DESC2(x) .flag2 = x, .desc = #x
 static struct tcase {
 	unsigned int flag;
+	unsigned int flag2;
 	char *desc;
 	void (*test)(void);
 } tcases[] = {
 	{FLAG_DESC(MS_RDONLY), test_rdonly},
 	{FLAG_DESC(MS_NODEV), test_nodev},
 	{FLAG_DESC(MS_NOEXEC), test_noexec},
-	{MS_RDONLY, "MS_REMOUNT", test_remount},
+	{MS_RDONLY, FLAG_DESC2(MS_REMOUNT), test_remount},
 	{FLAG_DESC(MS_NOSUID), test_nosuid},
 	{FLAG_DESC(MS_NOATIME), test_noatime},
 };
@@ -161,7 +163,7 @@ static void run(unsigned int n)
 		tc->test();
 
 	SAFE_STATFS(MNTPOINT, &stfs);
-	if (stfs.f_flags & (n == 3 ? MS_REMOUNT : tc->flag))
+	if (stfs.f_flags & tc->flag2)
 		tst_res(TPASS, "statfs() gets the correct mount flag");
 	else
 		tst_res(TFAIL, "statfs() gets the incorrect mount flag");

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
