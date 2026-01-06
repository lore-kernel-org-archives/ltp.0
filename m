Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1AA8C47BDE
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 10:01:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B19E3C0E0A
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 11:01:42 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A25C3C0224
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 11:01:25 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id C5E231400063
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 11:01:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C99AA339D5;
 Tue,  6 Jan 2026 10:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767693677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kDf+D17Xb6BmK6S1KqI6iLTR8C/uHzIQjF5qaerUzK0=;
 b=AcSrwIpyyQ4m57S8nwwSXmc/XoMjxLoC7tLooxiuHT21MKD0NwTGGuhoEYAhuNe22jkhwV
 BgfLGxpJu1l4vuS+CqCkddQXbv4rbw1zdLGlAMq+jmLcrby11p6VyxCyPE+5KiU627c5EK
 x+SPmO99yLidl+irm5a54vIfvxIKJPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767693677;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kDf+D17Xb6BmK6S1KqI6iLTR8C/uHzIQjF5qaerUzK0=;
 b=GenLqcg3aLNBwwDNWo6xIletgoAcnLN64BalOBNbhUDU2KapGTt1hCOpbeo0q7aMMkvuSK
 506dSsUCiceNJmAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767693677; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kDf+D17Xb6BmK6S1KqI6iLTR8C/uHzIQjF5qaerUzK0=;
 b=AcSrwIpyyQ4m57S8nwwSXmc/XoMjxLoC7tLooxiuHT21MKD0NwTGGuhoEYAhuNe22jkhwV
 BgfLGxpJu1l4vuS+CqCkddQXbv4rbw1zdLGlAMq+jmLcrby11p6VyxCyPE+5KiU627c5EK
 x+SPmO99yLidl+irm5a54vIfvxIKJPo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767693677;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kDf+D17Xb6BmK6S1KqI6iLTR8C/uHzIQjF5qaerUzK0=;
 b=GenLqcg3aLNBwwDNWo6xIletgoAcnLN64BalOBNbhUDU2KapGTt1hCOpbeo0q7aMMkvuSK
 506dSsUCiceNJmAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AEB8A3EA63;
 Tue,  6 Jan 2026 10:01:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dvZaKW3dXGlmBwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 06 Jan 2026 10:01:17 +0000
Date: Tue, 6 Jan 2026 11:02:20 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aVzdrAgv9qdxZSt_@yuki.lan>
References: <20251110024805.31070-1-wegao@suse.com>
 <20251223020836.9439-1-wegao@suse.com>
 <20251223020836.9439-3-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251223020836.9439-3-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.991]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
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
>  /*
>   * Validates exit status of child processes
>   */
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 42a54621e..67553f65d 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -1365,6 +1365,19 @@ static const char *default_fs_type(void)
>  	return tst_dev_fs_type();
>  }
>  
> +bool tst_cmd_present(const char *cmd)
> +{
> +	struct tst_cmd *pcmd = tst_test->needs_cmds;
> +
> +	while (pcmd->cmd) {
> +		if (!strcmp(pcmd->cmd, cmd))
> +			return pcmd->present;
> +
> +		pcmd++;
> +	}
> +	return false;

For a third time, when we get here we asked for something that haven't
been tested for so we should tst_brk() here!

> +}
> +
>  static void do_setup(int argc, char *argv[])
>  {
>  	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
> -- 
> 2.52.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
