Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A2C3C02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 10:28:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A41073C7C2C
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 11:28:49 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA9FF3C7B69
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:28:32 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 46A2C11EFC60
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 11:28:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E0161F38E;
 Fri, 17 Jan 2025 10:28:31 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 424C6139CB;
 Fri, 17 Jan 2025 10:28:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MkWAD88wimeEMwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 17 Jan 2025 10:28:31 +0000
Date: Fri, 17 Jan 2025 11:28:25 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250117102825.GA750951@pevik>
References: <20250117084118.740225-1-pvorel@suse.cz>
 <Z4oln8S422XIUExH@yuki.lan> <20250117095742.GA749338@pevik>
 <Z4otgs7iVe3sZ63C@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z4otgs7iVe3sZ63C@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: 6E0161F38E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] lib: Multiply slow config only for a real
 tests
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

> Hi!
> > > This looks like there is something fundamentally wrong there. If there
> > > is a TST_NO_DEFAULT_MAIN defined in the test, the test does not call
> > > tst_run_tcases() and the timeout shouln't be set up.

> > FYI tst_test.c:510 safe_clone(): call tst_multiply_timeout()

> Found that one as well. I guess that we need to switch to tst_clone():

> diff --git a/testcases/lib/tst_ns_exec.c b/testcases/lib/tst_ns_exec.c
> index 6a8e39339..989bb8910 100644
> --- a/testcases/lib/tst_ns_exec.c
> +++ b/testcases/lib/tst_ns_exec.c
> @@ -100,7 +100,12 @@ int main(int argc, char *argv[])
>         for (i = 0; i < ns_fds; i++)
>                 SAFE_SETNS(ns_fd[i], 0);

> -       pid = SAFE_CLONE(&args);
> +       pid = tst_clone(&args);
> +       if (pid < 0) {
> +               printf("clone() failed");
> +               return 1;
> +       }
> +
>         if (!pid)
>                 SAFE_EXECVP(argv[3], argv+3);

Thanks, it works! Could you please merge it? Maybe update the comment?

-       .forks_child = 1, /* Needed by SAFE_CLONE */
+       .forks_child = 1, /* Needed by safe_clone() */

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Fixes: 893ca0abe7 ("lib: multiply the timeout if detect slow kconfigs")

Kind regards,
Petr


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
