Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D395CCA470
	for <ltp@archiver.kernel.org>; Tue, 30 Sep 2025 13:36:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3CDB43CE2E3
	for <ltp@archiver.kernel.org>; Tue, 30 Sep 2025 15:36:46 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47FD73CDEE4
 for <ltp@lists.linux.it>; Tue, 30 Sep 2025 15:36:30 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8EB3E1A00920
 for <ltp@lists.linux.it>; Tue, 30 Sep 2025 15:36:28 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DEAEF336F8;
 Tue, 30 Sep 2025 13:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759239387;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l2VMPOcx4TNxAF5wV74woKPq3oo7wzzSvvfpx8sUFYc=;
 b=WYTiVdMpA25Qttn7u5pzn0BEgJp+BKzJv3rEeuyjCwET62z0n9WaFIaRADwNqeF5SbHDxZ
 fzEQuyI3tZHRKgywGCm2TPlMk32W7ZqRCdp6Hzl1f8rRO4VCZpbn34PjQxTavLOD2l6rZf
 jSVlOeOO2g8vt+Ruj9piYB8ydLQVTdQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759239387;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l2VMPOcx4TNxAF5wV74woKPq3oo7wzzSvvfpx8sUFYc=;
 b=n9LEhXDbIMSpZz4j0onLzEVkqKhaFHjTrCub6sRSfB3KJ0mP3WCZarvpH4D10TKqIGuo2g
 V4AKacl90p9zh1BA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=1VKVvl7Z;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=BzbVVOLD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759239385;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l2VMPOcx4TNxAF5wV74woKPq3oo7wzzSvvfpx8sUFYc=;
 b=1VKVvl7Z0XjJuMhCgoLV07MrrjEJRXfEjl9X3TbjdODzDCoaqIdaUQ05VpZno+tA4Uq2fv
 bSRIZWGMjY4rnmUzmgDJDOVBDASTS2mdVnvbMQr+i6K41e2lpyasC6VGUw96YUJDMgEnRZ
 O/o7EYOCP07GjHCyW/eqQPz27zr5Zig=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759239385;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l2VMPOcx4TNxAF5wV74woKPq3oo7wzzSvvfpx8sUFYc=;
 b=BzbVVOLDtcEDW5M+QAv57jR4wgVHZeAs8OdJDMuJva97HmQxR5POgduF7WhEXvK5uO1EoN
 GoeoEvtEXcYmnlDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 869BA1342D;
 Tue, 30 Sep 2025 13:36:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JgxlG9nc22iFRgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 30 Sep 2025 13:36:25 +0000
Date: Tue, 30 Sep 2025 15:36:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250930133623.GB238065@pevik>
References: <20250926085021.22141-1-wegao@suse.com>
 <20250928232708.24007-1-wegao@suse.com>
 <20250928232708.24007-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250928232708.24007-2-wegao@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: DEAEF336F8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] lib: Add support option for .needs_cmds
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

Hi Wei,

...
> +++ b/include/tst_cmd.h
> @@ -16,6 +16,12 @@ enum tst_cmd_flags {
>  	TST_CMD_TCONF_ON_MISSING = 2,
>  };

> +struct tst_cmd {
> +	const char *cmd;
> +	unsigned int optional:1;
> +	unsigned int present:1;

Maybe s/present/available/ ?
> +};

Could you please add doc? Whole include/tst_cmd.h is documented, it's obvious
that new functionality should be documented.

And best would be if you use kerneldoc syntax.
https://docs.kernel.org/doc-guide/kernel-doc.html
https://www.sphinx-doc.org/en/master/usage/domains/c.html

> +
>  /*
>   * vfork() + execvp() specified program.
>   *
> diff --git a/include/tst_test.h b/include/tst_test.h
> index 9c21c1728..bef836525 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -617,7 +617,7 @@ struct tst_fs {

>  	const struct tst_tag *tags;

> -	const char *const *needs_cmds;
> +	struct tst_cmd *needs_cmds;

This effectively breaks build, because you haven't update any of these users (24
tests + 2 doc files.

>  	const enum tst_cg_ver needs_cgroup_ver;

> @@ -721,6 +721,12 @@ int tst_creat_unlinked(const char *path, int flags, mode_t mode);
>   */
>  const char *tst_get_tmpdir_root(void);

> +/*
> + * tst_cmd_present would loop over the tst_cmd array and return the supported flag

I'm not a native speaker, but I think:

s/would loop/loops/

> + * value.
> + */
Please use kernel doc syntax (see links above).

> +bool tst_cmd_present(const char *cmd);
> +
>  /*
>   * Validates exit status of child processes
>   */
> diff --git a/lib/tst_cmd.c b/lib/tst_cmd.c
> index 82d60497a..cfd38c31a 100644
> --- a/lib/tst_cmd.c
> +++ b/lib/tst_cmd.c
> @@ -265,7 +265,12 @@ int tst_check_cmd(const char *cmd, const int brk_nosupp)
>  	str = strtok_r(NULL, " ", &next);

>  	if (tst_get_path(cmd_token, path, sizeof(path)))
> -		tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
> +		if (brk_nosupp) {
> +			tst_brkm(TCONF, NULL, "Couldn't find '%s' in $PATH", cmd_token);
> +		} else {
> +			tst_resm(TCONF, "Couldn't find '%s' in $PATH", cmd_token);
> +			return 1;
> +		}

+1

...
> +++ b/lib/tst_test.c
> @@ -1353,6 +1353,19 @@ static const char *default_fs_type(void)
>  	return tst_dev_fs_type();
>  }

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
> +}
> +
>  static void do_setup(int argc, char *argv[])
>  {
>  	char *tdebug_env = getenv("LTP_ENABLE_DEBUG");
> @@ -1422,11 +1435,15 @@ static void do_setup(int argc, char *argv[])
>  		tst_brk(TCONF, "%dbit ABI is not supported", tst_test->needs_abi_bits);

>  	if (tst_test->needs_cmds) {
> -		const char *cmd;
> -		int i;
> +		struct tst_cmd *pcmd = tst_test->needs_cmds;

> -		for (i = 0; (cmd = tst_test->needs_cmds[i]); ++i)
> -			tst_check_cmd(cmd, 1);
> +		while (pcmd->cmd) {
> +			if (tst_check_cmd(pcmd->cmd, !pcmd->optional))
> +				pcmd->present = 0;
> +			else
> +				pcmd->present = 1;
very nit: use ternary operator?

				pcmd->present = tst_check_cmd(pcmd->cmd, !pcmd->optional) ? 0 : 1;

Kind regards,
Petr

> +			pcmd++;
> +		}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
