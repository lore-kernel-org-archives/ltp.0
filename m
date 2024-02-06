Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CD6C4828D
	for <ltp@archiver.kernel.org>; Tue,  6 Feb 2024 11:51:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BECB03CF5D7
	for <ltp@archiver.kernel.org>; Tue,  6 Feb 2024 12:51:44 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E3E43C12A7
 for <ltp@lists.linux.it>; Tue,  6 Feb 2024 12:51:30 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4CA8C6018DC
 for <ltp@lists.linux.it>; Tue,  6 Feb 2024 12:51:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 34822220CF;
 Tue,  6 Feb 2024 11:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707220288;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+Kt6G5iWif55W1qm4UkCGJeZNn6PbquMBsX+ooinvM=;
 b=R32gv/ZBxjN6jkbzn18oqw6vTtAzeF59/6KgFKp5qnDtF5RuXjjqr8nBjbANSShzVURRe1
 rAWHad/ZRtrpp1PQXhADU4qKnvCjhRGcyEeXig3zM7bDecX4FJBdBqW+lFOmhuPlG7aOmB
 n9tWvJayPCwAsB+M7sx2AoJ+pdFgW3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707220288;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+Kt6G5iWif55W1qm4UkCGJeZNn6PbquMBsX+ooinvM=;
 b=aVUVuqMc8SNXB6ysDoi00r9/zQj6pSmRC/GSruD/PTtCf4fddhm6hj73BXkXY9fu3RDC50
 hFztFBbG0y2xxeBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707220288;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+Kt6G5iWif55W1qm4UkCGJeZNn6PbquMBsX+ooinvM=;
 b=R32gv/ZBxjN6jkbzn18oqw6vTtAzeF59/6KgFKp5qnDtF5RuXjjqr8nBjbANSShzVURRe1
 rAWHad/ZRtrpp1PQXhADU4qKnvCjhRGcyEeXig3zM7bDecX4FJBdBqW+lFOmhuPlG7aOmB
 n9tWvJayPCwAsB+M7sx2AoJ+pdFgW3k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707220288;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/+Kt6G5iWif55W1qm4UkCGJeZNn6PbquMBsX+ooinvM=;
 b=aVUVuqMc8SNXB6ysDoi00r9/zQj6pSmRC/GSruD/PTtCf4fddhm6hj73BXkXY9fu3RDC50
 hFztFBbG0y2xxeBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06046132DD;
 Tue,  6 Feb 2024 11:51:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CfMqOz8dwmXXHAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 06 Feb 2024 11:51:27 +0000
Date: Tue, 6 Feb 2024 12:51:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20240206115126.GF270992@pevik>
References: <20240205102653.2789879-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240205102653.2789879-1-liwang@redhat.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.53 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.03)[57.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] process_state: Enhancement of process state
 detection
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

Hi Li, Ian,

> The functions will be more robust against process names with
> unusual characters and will correctly read the state character
> from the /proc/[pid]/stat file. This is a necessary change
> because the process name, which is a free-form string, can
> contain spaces and other characters that would otherwise
> disrupt the simple parsing logic of the original format string.

> e.g.
>  $ cat /proc/792442/stat
>  792442 (Web Content) S 164213 4351 4351 0 -1 4194560 ...

> Reported-by: Ian Wienand <iwienand@redhat.com>
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Chunyu Hu <chuhu@redhat.com>
> ---
>  lib/tst_process_state.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

> diff --git a/lib/tst_process_state.c b/lib/tst_process_state.c
> index 08a9d0966..c15283c3d 100644
> --- a/lib/tst_process_state.c
> +++ b/lib/tst_process_state.c
> @@ -22,7 +22,7 @@ int tst_process_state_wait(const char *file, const int lineno,

>  	for (;;) {
>  		safe_file_scanf(file, lineno, cleanup_fn, proc_path,
> -				"%*i %*s %c", &cur_state);
> +				"%*[^)]%*c %c", &cur_state);

Obviously correct, thanks.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

But there is also the same issue in lib/tst_thread_state.c,
I guess it applies to that. Li, could you please also fix it before merge?

Also, Andrea, you added tst_thread_state_wait() and TST_THREAD_STATE_WAIT() for
futex_waitv0[23] related tests [1], but it's now not used anywhere due Jan's
changes [2] [3]. I wonder if it's still useful or whether we should remove it.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20220209091756.17245-2-andrea.cervesato@suse.de/
[2] https://lore.kernel.org/ltp/6c5b161bc3bcf753cbda92954ca3f47cb268c68f.1663665637.git.jstancek@redhat.com/
[3] https://lore.kernel.org/ltp/6bac7035adc2cfc8ab3800fe1d2d03223ec57ff5.1663662348.git.jstancek@redhat.com/

>  		if (state == cur_state)
>  			break;
> @@ -54,7 +54,7 @@ int tst_process_state_wait2(pid_t pid, const char state)
>  			return 1;
>  		}

> -		if (fscanf(f, "%*i %*s %c", &cur_state) != 1) {
> +		if (fscanf(f, "%*[^)]%*c %c", &cur_state) != 1) {
>  			fclose(f);
>  			fprintf(stderr, "Failed to read '%s': %s\n",
>  				proc_path, strerror(errno));

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
