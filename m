Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4186C5475B
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 20:46:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 085923D004C
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 21:46:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 510B53CB5FB
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 21:46:27 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6FDBA1000C1D
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 21:46:25 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 588B75D6DA;
 Fri,  8 Mar 2024 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709915592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6FSlouFTb8vvCMEE1zy6N+bbSZ9OoOxX/ihrHtMziRI=;
 b=uYmKuOs0s3DzT8Y5mrmq3flUYuIBplsOa2leKvCdb70iAPMithEOf5Ugn3/9oUs81H9F3J
 oL99QoYHP3s5mTow8OID8J+UQDvekTH+eOQg0LgzF32g/45W6sl4xtbIG9fjJJQkDD84t5
 WpQQiuzkjae7z0MwxQVAxuxKnCp5bXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709915592;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6FSlouFTb8vvCMEE1zy6N+bbSZ9OoOxX/ihrHtMziRI=;
 b=K0AoqS9pa3DYalJtQWVOdo2lRElWR+u2AgA1KjS7fGhfIyY7On0K1txDMM6sLLXwHS4+Nj
 A7P87LQw+AkZTpDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709915592; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6FSlouFTb8vvCMEE1zy6N+bbSZ9OoOxX/ihrHtMziRI=;
 b=uYmKuOs0s3DzT8Y5mrmq3flUYuIBplsOa2leKvCdb70iAPMithEOf5Ugn3/9oUs81H9F3J
 oL99QoYHP3s5mTow8OID8J+UQDvekTH+eOQg0LgzF32g/45W6sl4xtbIG9fjJJQkDD84t5
 WpQQiuzkjae7z0MwxQVAxuxKnCp5bXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709915592;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6FSlouFTb8vvCMEE1zy6N+bbSZ9OoOxX/ihrHtMziRI=;
 b=K0AoqS9pa3DYalJtQWVOdo2lRElWR+u2AgA1KjS7fGhfIyY7On0K1txDMM6sLLXwHS4+Nj
 A7P87LQw+AkZTpDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 41D0113310;
 Fri,  8 Mar 2024 16:33:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id zHj1Dsg962X8WAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 08 Mar 2024 16:33:12 +0000
Date: Fri, 8 Mar 2024 17:31:01 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <Zes9RTFfzvKJsf4N@rei>
References: <20240308045230.3106549-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240308045230.3106549-1-liwang@redhat.com>
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=uYmKuOs0;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=K0AoqS9p
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Queue-Id: 588B75D6DA
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] kconfig: add funtion to parse /proc/cmdline
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
> +/**
> + * Macro to initialize a tst_kcmdline_param structure with a specified parameter
> + * name and an empty value. This is useful for setting up an array of parameter
> + * structures before parsing the actual command-line arguments.
> + */
> +#define TST_KCMDLINE_INIT(paraname) { \
> +	.key = paraname, \
> +	.value = "" \
> +}
> +
> +/* Structure for storing command-line parameter key and its corresponding value */
> +struct tst_kcmdline_param {
                       ^
		       maybe var as short for variable would be better
		       name
> +	const char *key;
> +	char value[128];
> +};
> +
> +/**
> + * Parses command-line parameters from /proc/cmdline and stores them in params array
> + * params: The array of tst_kcmdline_param structures to be filled with parsed key-value pairs
> + * params_len: The length of the params array, indicating how many parameters to parse
> + */
> +void tst_kcmdline_parse(struct tst_kcmdline_param params[], size_t params_len);
> +
>  #endif	/* TST_KCONFIG_H__ */
> diff --git a/lib/tst_kconfig.c b/lib/tst_kconfig.c
> index 595ea4b09..f79dea5c6 100644
> --- a/lib/tst_kconfig.c
> +++ b/lib/tst_kconfig.c
> @@ -565,3 +565,44 @@ char tst_kconfig_get(const char *confname)
>  
>  	return var.choice;
>  }
> +
> +void tst_kcmdline_parse(struct tst_kcmdline_param params[], size_t params_len) {
> +	FILE *proc_cmdline;
> +	char cmdline[4096];
> +	char *token, *key, *value;
> +
> +	proc_cmdline = fopen("/proc/cmdline", "r");
> +	if (proc_cmdline == NULL)
> +		tst_brk(TBROK | TERRNO, "Failed to open /proc/cmdline for reading");
> +
> +	if (fgets(cmdline, sizeof(cmdline), proc_cmdline) == NULL) {
> +		fclose(proc_cmdline);
> +
> +		if (feof(proc_cmdline))
> +			tst_brk(TBROK, "End-of-File reached on /proc/cmdline without reading any data");
> +		else
> +			tst_brk(TBROK | TERRNO, "Failed to read from /proc/cmdline");
> +	}
> +	fclose(proc_cmdline);

Uff, this is ugly. We have FILE and then use it as if we had fd and read
it as a whole. The whole point of FILE is that glibc manages the buffers
and reads so that we can access it character by character without being
slow. It would be way cleaner if we just read the file character by
character building up the key and value while we do that.

Something as (bevare untested):

	char buf[128];
	size_t buf_pos = 0, i;
	int var_id = -1;

	f = fopen("/proc/cmdline", "r");

	while ((c = fgetc(f)) != EOF) {
		switch (c) {
		case '=':
			buf[buf_pos] = 0;

			for (i = 0; i < vars_len; i++)
				var_id = i;
		break;
		case ' ':
			buf[buf_pos] = 0;

			if (var_id >= 0)
				strcpy(vars[var_id].val, buf);

			var_id = -1;
		break;
		default:
			if (buf_pos+1 >= sizeof(buf))
				//warning?

			buf[buf_pos++] = c;
		break;
		}
	}


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
