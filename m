Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715BDC54E69
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 09:17:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E0EB73D09FE
	for <ltp@archiver.kernel.org>; Fri, 15 Mar 2024 10:17:27 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 934D33CF3A3
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 10:17:11 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A6E9E1BBCEEB
 for <ltp@lists.linux.it>; Fri, 15 Mar 2024 10:17:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3C3F921DB9;
 Fri, 15 Mar 2024 09:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710494229;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0G/TjT6HWvjVhACIK5ubqPst8tEsO1b0muI95RLH06I=;
 b=PM2RhQDoVIbBuwuOegESG2Kk6/yvk8DSt/MoLH42cShUuPRuigurtJfiiBraY2X5rsFG91
 x6pNs/cVaufjeZFzsppQ/1laSWrTft8qMh+nlpkjfUjZ4eOgGANyyrbRi9pGWQPpmos1gC
 cHOakzTrLgQH0YzEOyR9qfamMglTU7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710494229;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0G/TjT6HWvjVhACIK5ubqPst8tEsO1b0muI95RLH06I=;
 b=t0Ffaa5bbnYvgA9q/PuRY/8lfEwwMlrjLwJuClAW4gLDuZIvpiO3d1FAAxrSyjimP5V2dD
 hdyfsi+FOyHRtYAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710494229;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0G/TjT6HWvjVhACIK5ubqPst8tEsO1b0muI95RLH06I=;
 b=PM2RhQDoVIbBuwuOegESG2Kk6/yvk8DSt/MoLH42cShUuPRuigurtJfiiBraY2X5rsFG91
 x6pNs/cVaufjeZFzsppQ/1laSWrTft8qMh+nlpkjfUjZ4eOgGANyyrbRi9pGWQPpmos1gC
 cHOakzTrLgQH0YzEOyR9qfamMglTU7A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710494229;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0G/TjT6HWvjVhACIK5ubqPst8tEsO1b0muI95RLH06I=;
 b=t0Ffaa5bbnYvgA9q/PuRY/8lfEwwMlrjLwJuClAW4gLDuZIvpiO3d1FAAxrSyjimP5V2dD
 hdyfsi+FOyHRtYAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1724A1368C;
 Fri, 15 Mar 2024 09:17:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eLdaAxUS9GXzVQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 15 Mar 2024 09:17:09 +0000
Date: Fri, 15 Mar 2024 10:17:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240315091703.GC171573@pevik>
References: <20240308023312.25449-1-wegao@suse.com>
 <20240315033139.20557-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240315033139.20557-1-wegao@suse.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:url,suse.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.21)[71.92%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] memcontrol03: Using clean page cache to avoid
 dependency on IO rate
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

> Bad IO situation(storage bandwidth ~10MB/sec) will lead background
> writeback has uncertain progress for dirty page. So system can not
> reclaim enough memory for new process and finally lead a unexpected
> OOM.

Use fsync() to make sure that the pages from the file we wrote into are written
to a permanent storage.

> memcontrol03.c:218: TPASS: Expect: (A/B/E memory.current=0) ~= 0
> memcontrol03.c:116: TPASS: Child 1918 killed by OOM
> memcontrol03.c:224: TPASS: Expect: (A/B memory.current=52588544) ~= 52428800
> memcontrol03.c:129: TFAIL: Expected child 1944 to exit(0), but instead killed by SIGKILL

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
(Please do this yourself next time)

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Fixes: https://bugzilla.suse.com/show_bug.cgi?id=1218178

Kind regards,
Petr

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  testcases/kernel/controllers/memcg/memcontrol03.c | 1 +
>  1 file changed, 1 insertion(+)

> diff --git a/testcases/kernel/controllers/memcg/memcontrol03.c b/testcases/kernel/controllers/memcg/memcontrol03.c
> index 9c6c808e0..e2fc85cc8 100644
> --- a/testcases/kernel/controllers/memcg/memcontrol03.c
> +++ b/testcases/kernel/controllers/memcg/memcontrol03.c
> @@ -144,6 +144,7 @@ static void alloc_pagecache_in_child(const struct tst_cg_group *const cg,
>  	tst_res(TINFO, "Child %d in %s: Allocating pagecache: %"PRIdPTR,
>  		getpid(), tst_cg_group_name(cg), size);
>  	alloc_pagecache(fd, size);
> +	SAFE_FSYNC(fd);

>  	TST_CHECKPOINT_WAKE(CHILD_IDLE);
>  	TST_CHECKPOINT_WAIT(TEST_DONE);

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
