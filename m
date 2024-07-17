Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6DBC3DA4B
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 08:29:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C26233D1ACB
	for <ltp@archiver.kernel.org>; Wed, 17 Jul 2024 10:29:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB81C3D1AB2
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 10:28:47 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2C40F610227
 for <ltp@lists.linux.it>; Wed, 17 Jul 2024 10:28:46 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1D1B51FB66;
 Wed, 17 Jul 2024 08:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721204926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJ07uIqw96X4U9SqrxZYl8aPwyojvXyeOhQs6B+A1vg=;
 b=DNKQ1G+6qKZYlFamFWdf4CtN26SDA/tgMVmjNhJ4NUQNkRfa16U0U7zOkE78zkskxX22T8
 QsY5QFe1TiEE/fqCJXt4yWUZIDY775rupIGCHXtD58MaB+bOUIYJgWt8hs4YJbB3jLTdoV
 v6iIYELsAtMoHHpavgCUDNdV75tQoQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721204926;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJ07uIqw96X4U9SqrxZYl8aPwyojvXyeOhQs6B+A1vg=;
 b=tcquKbf0BJkL1T1UAyUun9JolD0ALptyJyTat5YOlTAfGL+M2Zlp6l+BdHpwWMzYNWMXwt
 HNeLrQyvLKLgiNDA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=DNKQ1G+6;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tcquKbf0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721204926; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJ07uIqw96X4U9SqrxZYl8aPwyojvXyeOhQs6B+A1vg=;
 b=DNKQ1G+6qKZYlFamFWdf4CtN26SDA/tgMVmjNhJ4NUQNkRfa16U0U7zOkE78zkskxX22T8
 QsY5QFe1TiEE/fqCJXt4yWUZIDY775rupIGCHXtD58MaB+bOUIYJgWt8hs4YJbB3jLTdoV
 v6iIYELsAtMoHHpavgCUDNdV75tQoQA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721204926;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tJ07uIqw96X4U9SqrxZYl8aPwyojvXyeOhQs6B+A1vg=;
 b=tcquKbf0BJkL1T1UAyUun9JolD0ALptyJyTat5YOlTAfGL+M2Zlp6l+BdHpwWMzYNWMXwt
 HNeLrQyvLKLgiNDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C74A1368F;
 Wed, 17 Jul 2024 08:28:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NdEGAr6Al2YXEwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 17 Jul 2024 08:28:46 +0000
Date: Wed, 17 Jul 2024 10:31:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <ZpeBVwXDVbJwLFu7@rei>
References: <20240705031502.9041-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240705031502.9041-1-liwang@redhat.com>
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 1D1B51FB66
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] perf_event_open: improve the memory leak detection
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
> +		/*
> +		 * Every 1200000 iterations, calculate the difference in memory
> +		 * availability. If the difference is greater than 10 * 1024 (10MB),
> +		 * increment the sample counter and log the event.
> +		 */
> +		if ((i % 1200000) == 0) {
> +			mem_avail = SAFE_READ_MEMINFO("MemAvailable:");
> +			diff = mem_avail_prev - mem_avail;
> +			diff_total += diff;
> +
> +			if (diff > 20 * 1024) {

Shouldn't this be 10 * 1024 or possibly slightly less than 10 * 1024?

> +				sample++;
> +				tst_res(TINFO, "MemAvailable decreased by %ld kB at iteration %d", diff, i);
> +			}
> +
> +			mem_avail_prev = mem_avail;
> +		}
> +	}
>  
> -	if (diff > 50 * 1024)
> -		tst_res(TFAIL, "Likely kernel memory leak detected");
> +	if ((sample > 5) || (diff_total > 100 * 1024))

Maybe this can rather be if ((sample > 5) && (diff_total > 100 * 1024))

That means that the available memory has been eaten by something and
that it happened more or less in a linear fashion when the program was
running.

> +		tst_res(TFAIL, "Likely kernel memory leak detected, total decrease: %ld kB", diff_total);
>  	else
>  		tst_res(TPASS, "No memory leak found");
>  }
> -- 
> 2.45.2
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
