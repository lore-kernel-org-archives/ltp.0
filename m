Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6DDAC5AE59
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 09:40:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 038963CA2B3
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 11:40:45 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E279C3CA010
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 11:40:27 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 50F451000D0E
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 11:40:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 560E45BDFD;
 Thu,  5 Jun 2025 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749116425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tVzqAMO5mOC5fftvLlqmRVY+iIs4DTGTMfTot0HCfv0=;
 b=aPqgb72sQHj6CLOTo7+4S+SwYMWeVwYK4Cgqn3LcLIy32FuUB6o6Cm+8VwBmoRnwzgYgrE
 PV3dVC1kdQCt5Qlhgf3U61vhI+JtqYjW0ngDSOxD2svnj+TeaisoD4iPmWOy+gSchSpygy
 nEk3QCpGTieeKP/oW03FZZ5uQix/wDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749116425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tVzqAMO5mOC5fftvLlqmRVY+iIs4DTGTMfTot0HCfv0=;
 b=1CqfV7DkbTyTTahvLSLSTgv6RPrGlWqG+AvLQ/X/xjPOzRyD0butL539NRJQTpuwm2Vjga
 oW5Dmxl8x5uLI3Cw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=aPqgb72s;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1CqfV7Dk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749116425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tVzqAMO5mOC5fftvLlqmRVY+iIs4DTGTMfTot0HCfv0=;
 b=aPqgb72sQHj6CLOTo7+4S+SwYMWeVwYK4Cgqn3LcLIy32FuUB6o6Cm+8VwBmoRnwzgYgrE
 PV3dVC1kdQCt5Qlhgf3U61vhI+JtqYjW0ngDSOxD2svnj+TeaisoD4iPmWOy+gSchSpygy
 nEk3QCpGTieeKP/oW03FZZ5uQix/wDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749116425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tVzqAMO5mOC5fftvLlqmRVY+iIs4DTGTMfTot0HCfv0=;
 b=1CqfV7DkbTyTTahvLSLSTgv6RPrGlWqG+AvLQ/X/xjPOzRyD0butL539NRJQTpuwm2Vjga
 oW5Dmxl8x5uLI3Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20B501373E;
 Thu,  5 Jun 2025 09:40:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UGTCBglmQWgMXgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Jun 2025 09:40:25 +0000
Date: Thu, 5 Jun 2025 11:40:19 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250605094019.GA1206250@pevik>
References: <20250605142943.229010-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250605142943.229010-1-wegao@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; RCPT_COUNT_FIVE(0.00)[5];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 560E45BDFD
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] sched_rr_get_interval01.c: Put test process
 into absolute root cgroup (0::/)
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
Cc: cgroups@vger.kernel.org,
 Michal =?iso-8859-2?Q?Koutn=FD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei, all,

> When the CONFIG_RT_GROUP_SCHED=y config is set, test cases like sched_rr_get_interval01
> will failed since limitation of RT processes with cgroup v2 cpu controller.
> The limitation is RT processes have to be in the root cgroup before enabling cpu controller.
> By default the shell will not running in root cgroup "0::/" since systemd will put shell
> into 0::/user.slice/user-xx.slice/session-xx.scope, so ltp case run within shell will failed.
> We can use this patch to workaround above limitation. If we agree on this patch, i will
> continue do same patch to following cases:
> sched_rr_get_interval02
> sched_rr_get_interval03
> sched_setparam02
> sched_getscheduler01

Acked-by: Petr Vorel <pvorel@suse.cz>

LGTM.

@Michal @Li WDYT?

Kind regards,
Petr

> Fixes: https://github.com/linux-test-project/ltp/issues/1245
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  .../sched_rr_get_interval/sched_rr_get_interval01.c         | 6 ++++++
>  1 file changed, 6 insertions(+)

> diff --git a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> index b4d75bdcc..55516ec89 100644
> --- a/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> +++ b/testcases/kernel/syscalls/sched_rr_get_interval/sched_rr_get_interval01.c
> @@ -43,6 +43,12 @@ static void setup(void)

>  	tp.type = tv->ts_type;

> +	if (access("/sys/fs/cgroup/cgroup.controllers", F_OK) == 0) {
> +		int pid = getpid();
> +
> +		SAFE_FILE_PRINTF("/sys/fs/cgroup/cgroup.procs", "%d", pid);
> +	}
> +
>  	if ((sys_sched_setscheduler(0, SCHED_RR, &p)) == -1)
>  		tst_res(TFAIL | TERRNO, "sched_setscheduler() failed");

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
