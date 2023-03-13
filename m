Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D3D8C61DA4
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 09:18:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 93F833CD574
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 10:18:31 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 26A4B3C0925
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 10:18:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5CEB710005D4
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 10:18:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 45F451FE07;
 Mon, 13 Mar 2023 09:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678699099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w83LUbr1Vf1n3+YV43JH6rds6LxGhpHvY7sw0sWbM6s=;
 b=vVJUY2335WlJ9ac5e2lE1+D2OtUfE3pVrRJHfzURT7NxsNlC9+PjX52LhssmM+t6wAbwUl
 hPrSpprshgk2At2IRCq+zns4uIxRV3T/iFhx3Sl18Y8epsfVF2PU8MI23WdBYbUZdTaO+0
 dO0RzGdjYv9vgkDNvSr59rKFnuQs7Dk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678699099;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w83LUbr1Vf1n3+YV43JH6rds6LxGhpHvY7sw0sWbM6s=;
 b=kOProNZ9Trw1YI2DRMPajVfN5EUf4aH9+ID12G1kHOyM+iGxfi4bO72xqCpm9yWl6SDX9U
 /ZWP4XCiZzSJojAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3073913517;
 Mon, 13 Mar 2023 09:18:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NtiJClvqDmR/GAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 13 Mar 2023 09:18:19 +0000
Date: Mon, 13 Mar 2023 10:19:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <ZA7qq15aeKS+ZeJR@yuki>
References: <20230311023343.25177-1-wegao@suse.com>
 <20230312004420.16457-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230312004420.16457-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] madvise11.c:Check loadable module before rmmod
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

Hi!
>  /* Find and open the <debugfs>/hwpoison/unpoison-pfn special file */
>  static int open_unpoison_pfn(void)
>  {
> @@ -300,7 +324,7 @@ static int open_unpoison_pfn(void)
>  	struct mntent *mnt;
>  	FILE *mntf;
>  
> -	if (!find_in_file("/proc/modules", HW_MODULE))
> +	if (!find_in_file("/proc/modules", HW_MODULE) && !is_builtin(HW_MODULE))
>  		hwpoison_probe = 1;

That does not solve the problem completely though, if we have a kernel
where the hwpoinson_inject is set to N in config the test will attempt
to rmmod it and get different error.

I suppose that the easiest solution would be:

diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
index 7e291d571..7c0bef157 100644
--- a/testcases/kernel/syscalls/madvise/madvise11.c
+++ b/testcases/kernel/syscalls/madvise/madvise11.c
@@ -300,12 +300,12 @@ static int open_unpoison_pfn(void)
        struct mntent *mnt;
        FILE *mntf;

-       if (!find_in_file("/proc/modules", HW_MODULE))
-               hwpoison_probe = 1;
-
        /* probe hwpoison only if it isn't already there */
-       if (hwpoison_probe)
+       if (!find_in_file("/proc/modules", HW_MODULE)) {
                SAFE_CMD(cmd_modprobe, NULL, NULL);
+               if (find_in_file("/proc/modules", HW_MODULE))
+                       hwpoison_probe = 1;
+       }

        /* debugfs mount point */
        mntf = setmntent("/etc/mtab", "r");


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
