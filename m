Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C07BC0218C
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 12:08:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6DD8F3C4C99
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 13:08:52 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4C083C26CA
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 13:08:35 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CBCCD1BE4D30
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 13:08:33 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4CEDE21167;
 Thu, 23 Jan 2025 12:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737634112;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LyvYD5VoSyccnCu41QMA4TSTVeFp/YC29haiIA6lFuk=;
 b=ra8p7Zt1fITQkX+7hY82y+V7FXTZ5BAunApek889DJ94p6/qF8NTz/N2EcYterKDUbmRd4
 VI8p5oCp31t0+Jr0m/FzIh36YBDURe4gFp41dbIkvBAYsBECQ1xc3QA5by6cKjSkH49yqB
 zf7UW2Wl12uRS1cxTfCsjAk3w6i0T4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737634112;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LyvYD5VoSyccnCu41QMA4TSTVeFp/YC29haiIA6lFuk=;
 b=snqzuq4sn3xWK+WxKK2bBu/BdVwJpwo8uW1nKw5IAIa0afEeHD8KTBjjDku8vNd9wgO5X7
 kPiPQcGVdSEJ5BAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737634112;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LyvYD5VoSyccnCu41QMA4TSTVeFp/YC29haiIA6lFuk=;
 b=ra8p7Zt1fITQkX+7hY82y+V7FXTZ5BAunApek889DJ94p6/qF8NTz/N2EcYterKDUbmRd4
 VI8p5oCp31t0+Jr0m/FzIh36YBDURe4gFp41dbIkvBAYsBECQ1xc3QA5by6cKjSkH49yqB
 zf7UW2Wl12uRS1cxTfCsjAk3w6i0T4k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737634112;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LyvYD5VoSyccnCu41QMA4TSTVeFp/YC29haiIA6lFuk=;
 b=snqzuq4sn3xWK+WxKK2bBu/BdVwJpwo8uW1nKw5IAIa0afEeHD8KTBjjDku8vNd9wgO5X7
 kPiPQcGVdSEJ5BAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA9C91351A;
 Thu, 23 Jan 2025 12:08:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jqoeNj8xkmfqOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 Jan 2025 12:08:31 +0000
Date: Thu, 23 Jan 2025 13:08:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Attila Fazekas <afazekas@redhat.com>
Message-ID: <20250123120822.GA81149@pevik>
References: <20250123111854.28412-1-afazekas@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250123111854.28412-1-afazekas@redhat.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[4]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] realtime/librttest: get_numcpus() fix leak
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

Hi Attila,

> As pointed out on the mailing list this function has
> a memory leak, fixing it.

Good catch, thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Actually old problem, IMHO:

Fixes: 591c56b045 ("realtime/prio-preempt: take cpu isolation into consideration")

I'll wait little longer and merge.

Kind regards,
Petr

> Signed-off-by: Attila Fazekas <afazekas@redhat.com>
> ---
>  testcases/realtime/lib/librttest.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

> diff --git a/testcases/realtime/lib/librttest.c b/testcases/realtime/lib/librttest.c
> index 03566f36d..99ce78b33 100644
> --- a/testcases/realtime/lib/librttest.c
> +++ b/testcases/realtime/lib/librttest.c
> @@ -768,11 +768,13 @@ int get_numcpus(void)
>  {
>  	long numcpus_conf = sysconf(_SC_NPROCESSORS_CONF);
>  	size_t size = CPU_ALLOC_SIZE(numcpus_conf);
> +	int cpu_count;
>  	cpu_set_t *cpuset = CPU_ALLOC(numcpus_conf);

>  	CPU_ZERO_S(size, cpuset);
>  	/* Get the number of cpus accessible to the current process */
>  	sched_getaffinity(0, size, cpuset);
> -
> -	return CPU_COUNT_S(size, cpuset);
> +	cpu_count = CPU_COUNT_S(size, cpuset);
> +	CPU_FREE(cpuset);
> +	return cpu_count;
>  }

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
