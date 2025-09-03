Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA243CA1009
	for <ltp@archiver.kernel.org>; Wed,  3 Sep 2025 08:43:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D97CB3CD39F
	for <ltp@archiver.kernel.org>; Wed,  3 Sep 2025 10:43:21 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24DD93CC058
 for <ltp@lists.linux.it>; Wed,  3 Sep 2025 10:43:06 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7AC881A002C5
 for <ltp@lists.linux.it>; Wed,  3 Sep 2025 10:43:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B02EB216E0;
 Wed,  3 Sep 2025 08:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756888983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PDEncW7ws8pmjfbJea1ZMqkTfb68pVH8r/wA+d2Louc=;
 b=wxrZMG3MWHLaQjVG0++3soxaOIIhsp2OSUHr2pwgN6ISxdlDxIqSGQdRlr0zgeL627gT96
 YiuxKMvq8dz3KF9LmmRpCOccN1bPG2PS0uh1dPeCF2DCNE3V94NonUcSyeBgxESh71pPUO
 WJ5jh7qaEj+71t8qK8f2nUrIN5vnJcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756888983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PDEncW7ws8pmjfbJea1ZMqkTfb68pVH8r/wA+d2Louc=;
 b=DHNdWZOQM7x4uCOocgvnhhf5iO/oRiPBGj34mm3FC8omD3JzaZ6IIIEfTbVmMvcYgOaYFd
 A36WjAMcgRh3PLCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1756888983; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PDEncW7ws8pmjfbJea1ZMqkTfb68pVH8r/wA+d2Louc=;
 b=wxrZMG3MWHLaQjVG0++3soxaOIIhsp2OSUHr2pwgN6ISxdlDxIqSGQdRlr0zgeL627gT96
 YiuxKMvq8dz3KF9LmmRpCOccN1bPG2PS0uh1dPeCF2DCNE3V94NonUcSyeBgxESh71pPUO
 WJ5jh7qaEj+71t8qK8f2nUrIN5vnJcE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1756888983;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PDEncW7ws8pmjfbJea1ZMqkTfb68pVH8r/wA+d2Louc=;
 b=DHNdWZOQM7x4uCOocgvnhhf5iO/oRiPBGj34mm3FC8omD3JzaZ6IIIEfTbVmMvcYgOaYFd
 A36WjAMcgRh3PLCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9339113888;
 Wed,  3 Sep 2025 08:43:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wqOpIpf/t2g7WQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 03 Sep 2025 08:43:03 +0000
Date: Wed, 3 Sep 2025 10:43:40 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aLf_vLC4FV3HjZHp@yuki.lan>
References: <20250902135117.6222-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250902135117.6222-1-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 MISSING_XM_UA(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] tst_sys_conf.c: Report TCONF if read path
 trigger error such as EOPNOTSUPP
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
> We encounter EOPNOTSUPP error when read path in old sle power test env, the reason is
> hugepages are disabled. Detail error information such as:
> TEST cpuset02:
> tst_sys_conf.c:103: TBROK: Failed to read anything from '/proc/sys/vm/nr_hugepages': EOPNOTSUPP (95)
> 
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  lib/tst_sys_conf.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/lib/tst_sys_conf.c b/lib/tst_sys_conf.c
> index 80cd83569..30b0b67a8 100644
> --- a/lib/tst_sys_conf.c
> +++ b/lib/tst_sys_conf.c
> @@ -99,7 +99,8 @@ int tst_sys_conf_save(const struct tst_path_val *conf)
>  		if (conf->flags & TST_SR_IGNORE_ERR)
>  			return 1;
>  
> -		tst_brk(TBROK | TERRNO, "Failed to read anything from '%s'",
> +		ttype = conf->flags ? TBROK : TCONF;

This is wrong for two reasons:

We have to make sure to use the correct flag here. I suppose that we can
treat the EOPNOTSUPP the same as the file to be missing. So we would
change the outcome based on the TST_SR_*_MISSING flags.

All errnos but EOPNOTSUPP should be treated as a TBROK as they were
before.

> +		tst_brk(ttype | TERRNO, "Failed to read anything from '%s'",
>  			conf->path);
>  	}
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
