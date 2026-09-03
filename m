Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A53C61DD3
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 17:22:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86BF93EB0A5
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 19:22:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BC2393EB095
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 19:21:58 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0D39660043A
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 19:21:57 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 438E91FEF2;
 Thu,  3 Sep 2026 17:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788456112;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RMd8IdGCwnq+gy4zBfMEIZRqLQzwpWzexL3DOc2IjU4=;
 b=l8DM6OMc4gZ2CRz8oRhXz2D8ZMedE+D4U7pNvCQd+X9aTyaL1htQnsjFU+HNqgvdvXde99
 yZhVLkqY3ZZJdwDa4Mw9neXTa+54AG9mcaK2uf8q2mB/7JWecKUjyXVvSTY7iX3cIV4YE/
 WCQo1LHuOTpIKDWkDQA9sEl7jEeUHgg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788456112;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RMd8IdGCwnq+gy4zBfMEIZRqLQzwpWzexL3DOc2IjU4=;
 b=hMmksEGWSUZpBKqcOjFyFH92UWrCGiva0c0xndE8A83SU3M71lvz8XkvA/YCRVI6iZOU04
 sbS43SIX+lOjnvCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1788456108;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RMd8IdGCwnq+gy4zBfMEIZRqLQzwpWzexL3DOc2IjU4=;
 b=nwelPjMiFEQQvtmf1db1kQkYI6z6oe97K3EytU2OjFGjK6NDbjvjUVjJKhnO6iiN1WZiCw
 uOH75A8c83+Jwv4kpEZK8v5A0P5au5UzvmDSHXtSJ1C0jtTzIK9EHvPgB5xdk6Cjj+jJNz
 yiQP/5T89HP6SgXKk+rDffaDKUxe6cA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1788456108;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RMd8IdGCwnq+gy4zBfMEIZRqLQzwpWzexL3DOc2IjU4=;
 b=7MR28+hV38np0hdIFQoZ2dP6G3l1PW+quxmDtYCo8BlVW/KiLOtZUVL9u46N7cvjxBhYV8
 08OsjbY/ksvG9/Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD164136E6;
 Thu,  3 Sep 2026 17:21:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UbyiMKusmWpmQQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 03 Sep 2026 17:21:47 +0000
Date: Thu, 3 Sep 2026 19:21:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20260903172142.GK1107507@pevik>
References: <20260827112157.1748734-1-chrubis@suse.cz>
 <20260827112157.1748734-29-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260827112157.1748734-29-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 28/31] testcases: sysfs: Add sys_hugepages02
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

Hi Cyril,

...
> +static void do_test(void)
> +{
> +	long hugepagesize;
> +
> +	if (FILE_LINES_SCANF("/proc/meminfo", MEMINFO_HPAGE_SIZE " %ld",
> +			     &hugepagesize)) {
> +		tst_res(TCONF, "No Hugepagesize in /proc/meminfo");
> +		return;
> +	}
> +
> +	if (!tst_sysfs_exists(PATH_MM_HUGEPAGES "/hugepages-%ldkB", hugepagesize)) {
> +		tst_res(TCONF,
> +			"Default hugepage pool hugepages-%ldkB not found in sysfs",
> +			hugepagesize);
> +		return;
> +	}
nit: We usually put this into setup() ...

> +
> +	tst_res(TPASS,
> +		"/proc/meminfo Hugepagesize (%ld kB) has a matching sysfs pool",
> +		hugepagesize);
> +
> +	compare("HugePages_Total", MEMINFO_HPAGE_TOTAL " %ld",
> +		"nr_hugepages", hugepagesize);
> +	compare("HugePages_Free", MEMINFO_HPAGE_FREE " %ld",
> +		"free_hugepages", hugepagesize);
> +	compare("HugePages_Rsvd", MEMINFO_HPAGE_RSVD " %ld",
> +		"resv_hugepages", hugepagesize);
> +	compare("HugePages_Surp", MEMINFO_HPAGE_SURP " %ld",
> +		"surplus_hugepages", hugepagesize);
> +}

... and have this struct for test parameters. But previous TPASS would have to
be removed or handled differently => ignore.

Nice test coverage, thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
