Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87689EA4E3D
	for <ltp@archiver.kernel.org>; Mon,  2 Mar 2026 16:45:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7BC33D7EF9
	for <ltp@archiver.kernel.org>; Mon,  2 Mar 2026 17:45:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 612F13CEFD3
 for <ltp@lists.linux.it>; Mon,  2 Mar 2026 17:44:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E143D20015C
 for <ltp@lists.linux.it>; Mon,  2 Mar 2026 17:44:48 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B585B5BFAF;
 Mon,  2 Mar 2026 16:44:47 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ACD3C3EA69;
 Mon,  2 Mar 2026 16:44:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id W74rKn++pWmJSwAAD6G6ig
 (envelope-from <jack@suse.cz>); Mon, 02 Mar 2026 16:44:47 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 5A3A8A0AB1; Mon,  2 Mar 2026 17:44:39 +0100 (CET)
Date: Mon, 2 Mar 2026 17:44:39 +0100
From: Jan Kara <jack@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <xndaxo4bnjdwc2ir6ouvrtzka6e3rd2af4xtraju7tcnbsrxyj@a75ejwsgoup3>
References: <20260302144446.1291724-1-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260302144446.1291724-1-amir73il@gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B585B5BFAF
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify25: fix test failure on kernel with
 CONFIG_MODULES=n
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon 02-03-26 15:44:46, Amir Goldstein wrote:
> On a kernel built without modules loading support the test fails:
> fanotify25.c:61: TBROK: write(4,0x55a523b99160,31) failed: EINVAL (22)
> 
> Use another symbol which is less likely to be missing.
> 
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  testcases/kernel/syscalls/fanotify/fanotify25.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify25.c b/testcases/kernel/syscalls/fanotify/fanotify25.c
> index c982f3225..9b03fd9ab 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify25.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify25.c
> @@ -24,10 +24,10 @@ static const struct traceconfig {
>  	const char *filename;
>  	const char *wdata;
>  } trace_cmds[] = {
> -	{EVENTS_SYSFILE, "p:ltp_load_module_0 load_module"},
> -	{MNTPOINT "/events/kprobes/ltp_load_module_0/enable", "1"},
> -	{MNTPOINT "/events/kprobes/ltp_load_module_0/enable", "0"},
> -	{EVENTS_SYSFILE, "-:ltp_load_module_0"},
> +	{EVENTS_SYSFILE, "p:ltp_load_script_0 load_script"},
> +	{MNTPOINT "/events/kprobes/ltp_load_script_0/enable", "1"},
> +	{MNTPOINT "/events/kprobes/ltp_load_script_0/enable", "0"},
> +	{EVENTS_SYSFILE, "-:ltp_load_script_0"},
>  	{}
>  };
>  
> -- 
> 2.53.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
