Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 048C6C4167B
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 13:35:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B87923CDA9C
	for <ltp@archiver.kernel.org>; Tue, 28 Nov 2023 14:35:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9A2C63CB148
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 14:35:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0FDCD200248
 for <ltp@lists.linux.it>; Tue, 28 Nov 2023 14:35:35 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0F22821959;
 Tue, 28 Nov 2023 13:35:35 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DF35F139FC;
 Tue, 28 Nov 2023 13:35:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id HAQkNabsZWWwIAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 28 Nov 2023 13:35:34 +0000
Date: Tue, 28 Nov 2023 14:35:33 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Xiao Yang <yangx.jy@fujitsu.com>
Message-ID: <20231128133533.GA400459@pevik>
References: <20231110035648.167600-1-xuyang2018.jy@fujitsu.com>
 <ab0157cc-f7c5-29e0-f79d-14220d402370@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ab0157cc-f7c5-29e0-f79d-14220d402370@fujitsu.com>
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Queue-Id: 0F22821959
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] vma05.sh: Fix check for core file presence
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

Hi,

> Hi Yang

> On 2023/11/10 11:56, Yang Xu wrote:
> >   	rm -rf core*
> >   	{ vma05_vdso; } > /dev/null 2>&1
> > -	[ -f core ] || tst_brk TBROK "missing core file"
> > +	[ -f core* ] || tst_brk TBROK "missing core file"
This will not work in case of more files:

$ touch core.foo core.bar; [ -f core* ]
bash: [: core.bar: binary operator expected

> The root cause seems that the name of core file contains the pid number by
> default. I think the better solution is set /proc/sys/kernel/core_uses_pid
> to 0 before running vma05_vdso. Like this:

> diff --git a/testcases/kernel/mem/vma/vma05.sh
> b/testcases/kernel/mem/vma/vma05.sh
> index a09951462..e1ef1014e 100755
> --- a/testcases/kernel/mem/vma/vma05.sh
> +++ b/testcases/kernel/mem/vma/vma05.sh
> @@ -25,11 +25,13 @@ TST_NEEDS_CMDS="gdb"

>  CORE_LIMIT=$(ulimit -c)
>  CORE_PATTERN=$(cat /proc/sys/kernel/core_pattern)
> +CORE_USES_PID=$(cat /proc/sys/kernel/core_uses_pid)

>  setup()
>  {
>         ulimit -c unlimited
>         echo "core" > /proc/sys/kernel/core_pattern
> +       echo 0 > /proc/sys/kernel/core_uses_pid
>         unset DEBUGINFOD_URLS
>  }

> @@ -37,6 +39,7 @@ cleanup()
>  {
>         ulimit -c "$CORE_LIMIT"
>         echo "$CORE_PATTERN" > /proc/sys/kernel/core_pattern
> +       echo $CORE_USES_PID > /proc/sys/kernel/core_uses_pid
>  }

This patch looks better to me. Feel free to merge it with my RBT
Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> Best Regards,
> Xiao Yang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
