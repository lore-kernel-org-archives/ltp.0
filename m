Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AE96C6FD19
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 12:22:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B044B3CD5C1
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 13:22:07 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCA153C1047
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 13:21:57 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 42C37100067C
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 13:21:56 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 36BDC22A5D;
 Mon, 13 Mar 2023 12:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1678710116; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DWMrvaI6N4B+3uv83yJ4/6qY1d9UZ7zwscfIU931aVQ=;
 b=DEdiBjMdN+vJtG8ji5zRlCA+THr30RPh/lLC4+BGh/L2UEYNynKp/wfMdBsx8yvwaC9mpT
 SQFYioBW2sKpcMcY5bHAfdGL80s9fq+ZKSBI+xKn+RxSPfCygR1UqwgpfQR3inqu2Kqcht
 I/2Z6r/r5Arh7Ni+1dXbxDxAQ+0GacQ=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1E5C913582;
 Mon, 13 Mar 2023 12:21:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id uilqM2IVD2SWAgAAMHmgww
 (envelope-from <wegao@suse.com>); Mon, 13 Mar 2023 12:21:54 +0000
Date: Mon, 13 Mar 2023 08:21:00 -0400
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230313122100.GA12608@localhost>
References: <20230311023343.25177-1-wegao@suse.com>
 <20230312004420.16457-1-wegao@suse.com> <ZA7qq15aeKS+ZeJR@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZA7qq15aeKS+ZeJR@yuki>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Mar 13, 2023 at 10:19:39AM +0100, Cyril Hrubis wrote:
> Hi!
> >  /* Find and open the <debugfs>/hwpoison/unpoison-pfn special file */
> >  static int open_unpoison_pfn(void)
> >  {
> > @@ -300,7 +324,7 @@ static int open_unpoison_pfn(void)
> >  	struct mntent *mnt;
> >  	FILE *mntf;
> >  
> > -	if (!find_in_file("/proc/modules", HW_MODULE))
> > +	if (!find_in_file("/proc/modules", HW_MODULE) && !is_builtin(HW_MODULE))
> >  		hwpoison_probe = 1;
> 
> That does not solve the problem completely though, if we have a kernel
> where the hwpoinson_inject is set to N in config the test will attempt
> to rmmod it and get different error.


I have tested on the kernel which set to N in config and the test will report:
tst_test.c:1180: TCONF: hwpoison_inject driver not available

I think it should caused by following configuration of test case:
        .needs_drivers = (const char *const []) {
                HW_MODULE,
                NULL
        },

So the scenario of "N in kernel config" already handled by LTP framework, i have
to say LTP frame work already do a lot of things which i have no idea... xD

> 
> I suppose that the easiest solution would be:
Yes, indeed your solution is more easy and no need extra check function.
I can make your solution as patch v4. 

> 
> diff --git a/testcases/kernel/syscalls/madvise/madvise11.c b/testcases/kernel/syscalls/madvise/madvise11.c
> index 7e291d571..7c0bef157 100644
> --- a/testcases/kernel/syscalls/madvise/madvise11.c
> +++ b/testcases/kernel/syscalls/madvise/madvise11.c
> @@ -300,12 +300,12 @@ static int open_unpoison_pfn(void)
>         struct mntent *mnt;
>         FILE *mntf;
> 
> -       if (!find_in_file("/proc/modules", HW_MODULE))
> -               hwpoison_probe = 1;
> -
>         /* probe hwpoison only if it isn't already there */
> -       if (hwpoison_probe)
> +       if (!find_in_file("/proc/modules", HW_MODULE)) {
>                 SAFE_CMD(cmd_modprobe, NULL, NULL);
> +               if (find_in_file("/proc/modules", HW_MODULE))
> +                       hwpoison_probe = 1;
> +       }
> 
>         /* debugfs mount point */
>         mntf = setmntent("/etc/mtab", "r");
> 
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
