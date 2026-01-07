Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2B7CCD5822
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 09:58:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E5DB3C2DB6
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 10:58:53 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D6F503C298C
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 10:58:36 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 368C61A004E2
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 10:58:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 37B995BEAB;
 Wed,  7 Jan 2026 09:58:35 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 260393EA63;
 Wed,  7 Jan 2026 09:58:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CzIXCEsuXmnmOQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 07 Jan 2026 09:58:35 +0000
Date: Wed, 7 Jan 2026 10:59:42 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aV4ujjfb7JBB2zaQ@yuki.lan>
References: <20251110024805.31070-1-wegao@suse.com>
 <20251223020836.9439-1-wegao@suse.com>
 <20251223020836.9439-3-wegao@suse.com> <aVzdrAgv9qdxZSt_@yuki.lan>
 <aV36R8E-KMD_dTf8@autotest-wegao.qe.prg2.suse.org>
 <20260107080957.GD727950@pevik> <20260107082727.GE727950@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260107082727.GE727950@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 37B995BEAB
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 2/4] tst_test.c: Add tst_cmd_present check if a
 command is present
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
> 1) tst_brk for not checked command at the end.
> 2) tst_brk for NULL otherwise we get segfault. Maybe check also for empty
> command before attempting to do anything else.

Technically the empty command will end up in the tst_brk() at the end,
so I would add only the NULL check.

> index bf92e6cc92..cf67c2a9f0 100644
> --- lib/tst_test.c
> +++ lib/tst_test.c
> @@ -1379,12 +1379,16 @@ bool tst_cmd_present(const char *cmd)
>  {
>  	struct tst_cmd *pcmd = tst_test->needs_cmds;
>  
> +	if (!cmd || cmd[0] == '\0')
> +		tst_brk(TBROK, "Invalid cmd");
> +
>  	while (pcmd->cmd) {
>  		if (!strcmp(pcmd->cmd, cmd))
>  			return pcmd->present;
>  
>  		pcmd++;
>  	}
> +	tst_brk(TBROK, "'%s' not checked", cmd);
>  	return false;
>  }
>  
> 
> 3) Shouldn't we use tst_brk_() to point to the code in the test instead of
> tst_brk()? If yes, we probably want to have tst_cmd_present_() as library
> internal (static, with const char *file, const int lineno parameters) which
> calls tst_brk_() and tst_cmd_present() as public (the only with signature in
> header).

I do not think that this is that important to have, the
tst_cmd_present() calls are going to be quite rare and hence easy to
locate in the sources.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
