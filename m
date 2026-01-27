Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB5ADD2F038
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 14:31:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 384D73CAEAC
	for <ltp@archiver.kernel.org>; Tue, 27 Jan 2026 15:31:57 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 741DB3CAA87
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 15:31:39 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EC8202009E6
 for <ltp@lists.linux.it>; Tue, 27 Jan 2026 15:31:38 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C2FCA5BCE6;
 Tue, 27 Jan 2026 14:31:37 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E42D3EA61;
 Tue, 27 Jan 2026 14:31:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Qdf1JEnMeGnQRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 27 Jan 2026 14:31:37 +0000
Date: Tue, 27 Jan 2026 15:31:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260127143136.GA153805@pevik>
References: <20260127-fork_refactoring-v1-0-e3e21ff1a4f7@suse.com>
 <20260127-fork_refactoring-v1-1-e3e21ff1a4f7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260127-fork_refactoring-v1-1-e3e21ff1a4f7@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: C2FCA5BCE6
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] syscalls: refactor fork09 using new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

Generally LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> +	tst_res(TINFO, "Opening files from parent");
> +
> +	for (nfiles = 0; nfiles < file_open_max; nfiles++) {
> +		memset(name, 0, PATH_MAX);
> +		snprintf(name, PATH_MAX, "%s%lu", FILE_PREFIX, nfiles);

> -		/* clean up things in case we are looping */
> -		for (nf = first; nf < nfiles; nf++) {
> -			fclose(fildeses[nf]);
> -			sprintf(filname, "file%d.%d", nf, mypid);
> -			unlink(filname);
> +		f = fopen(name, "a");
> +		if (!f) {
nit: Although EMFILE meaning is quite obvious I found previous comment about
OPEN_MAX useful.

> +			if (errno == EMFILE)
> +				break;
> +
> +			tst_brk(TBROK | TERRNO, "fopen() error");
I suppose we are ok to not close these open files even if it fails close to
OPEN_MAX...

>  		}
> +
> +		open_files[nfiles] = f;
> +	}
> +
> +	totfiles = nfiles;
> +
> +	if (!totfiles)
> +		tst_brk(TBROK, "Parent couldn't open any file");
> +
> +	tst_res(TINFO, "Closing %lu files from child", totfiles);
> +
> +	if (!SAFE_FORK()) {
> +		for (nfiles = nfiles - 1; nfiles >= 0; nfiles--)
> +			SAFE_FCLOSE(open_files[nfiles]);
> +
> +		exit(0);
>  	}

> +	tst_reap_children();
> +
> +	tst_res(TPASS, "Child closed all parent's files");
> +

... because this is not in a cleanup.
> +	for (nfiles = 0; nfiles < totfiles; nfiles++) {
> +		memset(name, 0, PATH_MAX);
> +		snprintf(name, PATH_MAX, "%s%lu", FILE_PREFIX, nfiles);
> +
> +		SAFE_FCLOSE(open_files[nfiles]);
> +		SAFE_UNLINK(name);
> +	}

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
