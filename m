Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83A05CD98E2
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 09:05:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B74CD3E592D
	for <ltp@archiver.kernel.org>; Wed, 17 Jun 2026 11:05:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8C6063E1FC1
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 11:05:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D3D6F200255
 for <ltp@lists.linux.it>; Wed, 17 Jun 2026 11:05:29 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CC5DE759E5;
 Wed, 17 Jun 2026 09:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781687129; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pIxBsP25iSHy2gRTGNXLxHZS+qnEbt9QJTqsk1hKo0c=;
 b=flBitnKrVj5rQWEAyZBC7RTw5MZ5u7NbtYzCkKmf341XcfBSekggGD8stFciAVN+7wvFxh
 HIououvj1o2EHPs31To76ZOoxMUmnIxGpkFSdiOmXoRM2rbvtxsYcPR1jdUau7xviwI6wp
 nUegibCPbWivjQkK/QfakuSKURj+g28=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781687129;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pIxBsP25iSHy2gRTGNXLxHZS+qnEbt9QJTqsk1hKo0c=;
 b=+wd8BTlHR8RrwaFVYcdXR3+9Zr3pTSPiyR8yGgnU+RG5jTlQFm4ppb3YxU3Guv/wNj7D/A
 96bVZSQpzkiWaZAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=rGv9zPI7;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/fOuiZZu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1781687128; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pIxBsP25iSHy2gRTGNXLxHZS+qnEbt9QJTqsk1hKo0c=;
 b=rGv9zPI7jQorweDFMxqHVVwh132S33gZ3qgYoVH1o8Fna/tYf1IW/Chleedf5w34/iioFF
 8MIu4R2E725byD2dYOzFj3vBGdEthL95tvKErqRjcOBVyR29z+/HMQD8CdXw02pcozNkgI
 pjTeKBql0y8AE+1CmIUhlhKKDXQr1ww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1781687128;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pIxBsP25iSHy2gRTGNXLxHZS+qnEbt9QJTqsk1hKo0c=;
 b=/fOuiZZuIj4KP+RDUXwElYSXmDO2DhUxPakdWdgmG5w7+zXp8pGNar35lIXqOT0ShizNAD
 kBtdy9qZ8ymgmxBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAA28779A8;
 Wed, 17 Jun 2026 09:05:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id w3o9LFhjMmr+UQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Jun 2026 09:05:28 +0000
Date: Wed, 17 Jun 2026 11:05:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ajJjWSYh9Q31uWRb@yuki.lan>
References: <20260616-fix_pids_errors-v2-0-a1e1d377f8b7@suse.com>
 <20260616-fix_pids_errors-v2-2-a1e1d377f8b7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260616-fix_pids_errors-v2-2-a1e1d377f8b7@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: CC5DE759E5
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_DN_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, yuki.lan:mid,
 imap1.dmz-prg2.suse.org:rdns, imap1.dmz-prg2.suse.org:helo, suse.cz:email,
 suse.cz:dkim, linux.it:url]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] tst_cgroup: tolerate ESRCH in
 cgroup_drain()
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> A process can die between reading cgroup.procs and writing its PID
> to the destination cgroup. When this happens, the kernel returns
> ESRCH which is a normal race condition, not a test infrastructure
> failure.
> 
> Skip ESRCH errors instead of aborting with TBROK.
> 
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  lib/tst_cgroup.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index a37bf1516aabfbcb9a02fedd6fddb98e85ecc653..f548c0e01cf60803ad4c1e898e7ec2d39dc33c84 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -974,8 +974,12 @@ static void cgroup_drain(const enum tst_cg_ver ver,
>  	for (tok = strtok(pid_list, "\n"); tok; tok = strtok(NULL, "\n")) {
>  		ret = dprintf(fd, "%s", tok);
>  
> -		if (ret < (ssize_t)strlen(tok))
> +		if (ret < (ssize_t)strlen(tok)) {
> +			if (ret < 0 && errno == ESRCH)
> +				continue;

Maybe we can print tst_res(TINFO, "Pid %s died during drain", tok);
here as well, so that when this happens we will have the information in
the test log.

Otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

>  			tst_brk(TBROK | TERRNO, "Failed to drain %s", tok);
> +		}
>  	}
>  	SAFE_CLOSE(fd);
>  }
> 
> -- 
> 2.51.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
