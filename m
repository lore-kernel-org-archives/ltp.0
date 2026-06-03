Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C3EACD6E64
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 09:27:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C5313E5602
	for <ltp@archiver.kernel.org>; Wed,  3 Jun 2026 11:27:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75B1A3E489E
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 11:27:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id EE9FC20075D
 for <ltp@lists.linux.it>; Wed,  3 Jun 2026 11:27:12 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 43AFC5D2C2;
 Wed,  3 Jun 2026 09:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780478831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EEdSwpZsGCnD+QnDNidmg0CTvtLcpFImEYbfKdU36Dk=;
 b=r+C9r9WhkYoYK+wbFkjaT8bRpWdQ+yYZ1+moQfyGGyUsWdd3b505hoeY/CblxSj1UxIRly
 zNpEYd8ijJLdhMwcA233I7a8HIISO9e998endUIgZe8uGyA+OjnshlTPsyfTLFcHgoua67
 PyPs01i6cBLpTF6LcZsQICd3tEOn7Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780478831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EEdSwpZsGCnD+QnDNidmg0CTvtLcpFImEYbfKdU36Dk=;
 b=rFpG7xRdtY0MBQIkEmfb0IU1zb0A9LmwBBLcdzjGqbEZ4JjswxVKxV9JdsAbuFubmWXvyK
 jsRFecTCqYkVPKDg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780478831; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EEdSwpZsGCnD+QnDNidmg0CTvtLcpFImEYbfKdU36Dk=;
 b=r+C9r9WhkYoYK+wbFkjaT8bRpWdQ+yYZ1+moQfyGGyUsWdd3b505hoeY/CblxSj1UxIRly
 zNpEYd8ijJLdhMwcA233I7a8HIISO9e998endUIgZe8uGyA+OjnshlTPsyfTLFcHgoua67
 PyPs01i6cBLpTF6LcZsQICd3tEOn7Zk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780478831;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EEdSwpZsGCnD+QnDNidmg0CTvtLcpFImEYbfKdU36Dk=;
 b=rFpG7xRdtY0MBQIkEmfb0IU1zb0A9LmwBBLcdzjGqbEZ4JjswxVKxV9JdsAbuFubmWXvyK
 jsRFecTCqYkVPKDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 32D105A4BD;
 Wed,  3 Jun 2026 09:27:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xqhdDG/zH2pSVgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 03 Jun 2026 09:27:11 +0000
Date: Wed, 3 Jun 2026 11:27:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Darren Chang <chihsheng@google.com>
Message-ID: <ah_zZ5jmnKGl5mFF@yuki.lan>
References: <20260603051401.658906-1-chihsheng@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260603051401.658906-1-chihsheng@google.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/listmount04: Detect backported commit
 78f0e33cd6c9 dynamically
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
>  static void setup(void)
>  {
> -	if (tst_kvercmp(6, 17, 9) >= 0)
> -		kver = AFTER_6_17_9;
> -	else
> -		kver = BEFORE_6_17_9;
> +	/* 1. If kernel is 6.17.9 or newer, it definitively has the new behavior */
> +	if (tst_kvercmp(6, 17, 9) >= 0) {
> +		current_fd_err_behavior = INVALID_FD_RET_EBADF;
> +		return;
> +	}
> +
> +	/* 2. Runtime probe for older kernels:
> +	 * Check if commit 78f0e33cd6c9 was backported by manually issuing
> +	 * a syscall with an invalid mnt_ns_fd (-1).
> +	 */
> +	mnt_id_req probe_req = {
> +		.size = MNT_ID_REQ_SIZE_VER0,
> +		.mnt_id = LSMT_ROOT,
> +		.mnt_ns_fd = -1,
> +		.param = 0
> +	};
> +
> +	tst_syscall(__NR_listmount, &probe_req, mnt_ids, MNT_SIZE, 0);
> +
> +	/* 3. Set global behavior flag based on actual kernel response */
> +	if (errno == EBADF) {
> +		tst_res(TINFO, "Detected backported commit 78f0e33cd6c9 (returns EBADF)");
> +		current_fd_err_behavior = INVALID_FD_RET_EBADF;
> +	} else {
> +		current_fd_err_behavior = INVALID_FD_RET_EINVAL;
> +	}

This is too complicated. I think that we want to settle for:

* new behavior after 6.17.9 (i.e. EBADF)
* any of the two errnos before that (i.e. either EINVAL or EBADF)

For that we should skip to TST_EXP_FAIL_ARR() pass array with only single
errno for all cases but the one one where we need to allow both EINVAL
and EBADF.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
