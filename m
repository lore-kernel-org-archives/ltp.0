Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A50F9CA0EC4
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 14:08:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 296433CB62D
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 16:08:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 947B13CB310
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 16:07:59 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DE4D81A006E9
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 16:07:58 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C48821F45A;
 Tue, 12 Aug 2025 14:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755007677;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PA7VjBHEnJtXOyqDY4iJrnEHeOhNpAKjEtd6BwqBUcY=;
 b=pHPCw5tBHfLJd1CCbd+tg0B1+zTBINbFT83tyXrq6N0NRAEIn+DuU2JC4LlE2e0GUvL8ZV
 2hpdaU9s7ewiLLpR6ihN4cjdZqbnMmWYFTGsbvXmAdPcBk4YFpZrJc1Hb6TFFTGo54vHJ1
 KRK0u25BOSQF8Vy4+vg15mZNvtcTOME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755007677;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PA7VjBHEnJtXOyqDY4iJrnEHeOhNpAKjEtd6BwqBUcY=;
 b=KglJN2Pm8SAVuqgCFjtP3DDUaBQpYa9HXC+Uy4eQMV96DjLPjeqxllo516772U6Yjr53Ad
 hOWHfvJc06sbt3DA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pHPCw5tB;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=KglJN2Pm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1755007677;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PA7VjBHEnJtXOyqDY4iJrnEHeOhNpAKjEtd6BwqBUcY=;
 b=pHPCw5tBHfLJd1CCbd+tg0B1+zTBINbFT83tyXrq6N0NRAEIn+DuU2JC4LlE2e0GUvL8ZV
 2hpdaU9s7ewiLLpR6ihN4cjdZqbnMmWYFTGsbvXmAdPcBk4YFpZrJc1Hb6TFFTGo54vHJ1
 KRK0u25BOSQF8Vy4+vg15mZNvtcTOME=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1755007677;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PA7VjBHEnJtXOyqDY4iJrnEHeOhNpAKjEtd6BwqBUcY=;
 b=KglJN2Pm8SAVuqgCFjtP3DDUaBQpYa9HXC+Uy4eQMV96DjLPjeqxllo516772U6Yjr53Ad
 hOWHfvJc06sbt3DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7E277136C7;
 Tue, 12 Aug 2025 14:07:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id qYB9HL1Km2j8SAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Aug 2025 14:07:57 +0000
Date: Tue, 12 Aug 2025 16:07:52 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250812140752.GB861768@pevik>
References: <20250808163045.2033518-1-wegao@suse.com>
 <20250812061435.21209-1-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250812061435.21209-1-wegao@suse.com>
X-Rspamd-Queue-Id: C48821F45A
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ioctl11.c: New case check PROCMAP_QUERY
 ioctl() errnos
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

Hi Wei, Andrea,

> +/*\
> + * [Description]
nit: we stopped using this. Could it be removed before merge?

> + *
> + * Test PROCMAP_QUERY ioctl() errnos:
> + *
> + * - EINVAL if q->size is too small
> + * - E2BIG if q->size is larger than page size
> + * - EINVAL on invalid q->flags
> + * - EINVAL if only one of q->vma_name_size and q->vma_name_addr is set
> + * - EINVAL if only one of q->build_id_size and q->build_id_addr is set
> + * - ENAMETOOLONG if build_id_size or name_buf_size is too small
> + * - ESRCH if attempt to get memory map of a process that did exit and was waited for
> + *
> + *   [1] https://kernelnewbies.org/Linux_6.11#Memory_management
> + *   [2] https://kernelnewbies.org/Linux_6.11#Binary_interface_for_.2Fproc.2F.3Cpid.3E.2Fmaps
> + *   [3] https://lore.kernel.org/all/20240627170900.1672542-1-andrii@kernel.org/
> + *       ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps")

nit: [1] and other numbers will look ugly in generated doc:

[1] https://kernelnewbies.org/Linux_6.11#Memory_management [2] https://kernelnewbies.org/Linux_6.11#Binary_interface_for_.2Fproc.2F.3Cpid.3E.2Fmaps [3] https://lore.kernel.org/all/20240627170900.1672542-1-andrii@kernel.org/

=> inlined and [1] [2] [3] does not make sense when they refer to nothing.

Instead of
> + *   [1] https://kernelnewbies.org/Linux_6.11#Memory_management
> + *   [2] https://kernelnewbies.org/Linux_6.11#Binary_interface_for_.2Fproc.2F.3Cpid.3E.2Fmaps
> + *   [3] https://lore.kernel.org/all/20240627170900.1672542-1-andrii@kernel.org/
> + *       ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps")

I suggest to change before merge to something like:

PROCMAP_QUERY was introduced in 6.11.

 * * https://kernelnewbies.org/Linux_6.11#Binary_interface_for_.2Fproc.2F.3Cpid.3E.2Fmaps
 * * ed5d583a88a9 ("fs/procfs: implement efficient VMA querying API for /proc/<pid>/maps")

Reviewed-by: Petr Vorel <pvorel@suse.cz>

...
> +static void fork_child_setup(void)
> +{
> +	int pid = SAFE_FORK();
> +
> +	if (pid == 0) {
> +		TST_CHECKPOINT_WAKE(0);
> +		TST_CHECKPOINT_WAIT(1);
> +		exit(0);
> +	}
> +
> +	TST_CHECKPOINT_WAIT(0);
> +
> +	char proc_path[PATH_MAX];
> +
> +	snprintf(proc_path, PATH_MAX, "/proc/%d/maps", pid);
> +	fd = SAFE_OPEN(proc_path, O_RDONLY);
> +
> +	TST_CHECKPOINT_WAKE(1);

Using of the checkpoints LGTM, but hopefully somebody else recheck it.

Kind regards,
Petr

> +	SAFE_WAITPID(pid, NULL, 0);
> +}

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
