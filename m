Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 683A1CC6B1A
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 15:10:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 80A7B3EA7A7
	for <ltp@archiver.kernel.org>; Wed, 14 Oct 2026 17:10:43 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 041C43E213A
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 17:10:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C52921A00784
 for <ltp@lists.linux.it>; Wed, 14 Oct 2026 17:10:25 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 57AAE2211F;
 Wed, 14 Oct 2026 15:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791990623; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sou6RcWQNumo9f5r/jHgrbU+mPVWH9Ow2w5ufj4uFR8=;
 b=gJOU93ZlsxFrCypuddEQOVB8TPqbrFx9CEg23m+cJQOr5SvjbRATEJPfCwiac1Qpv6wkaC
 sdpJOz8RWJ/xUrJff+8s6Ajlg4a7i0fyAKKZ9oGOp2ParTlW3YAFZbam2YCxJcevscoNXl
 VogLS/HsxMVdAZbiNTzonici9bUAq0g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791990623;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sou6RcWQNumo9f5r/jHgrbU+mPVWH9Ow2w5ufj4uFR8=;
 b=d/Cc5NAyU+wsOEBEtuKKEF3Xamfjtl03Sarpwn7pcjDILTRpdKjh77qkIAXqrVV4OIbJ19
 szYCjrS73iBMxpBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=piAtbOq9;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Sm6parpv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1791990622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sou6RcWQNumo9f5r/jHgrbU+mPVWH9Ow2w5ufj4uFR8=;
 b=piAtbOq9lC2vSb/+4UfG7qS7Mu7rNlk8gI0xl+EJJZGCGIFskGRz16T59ak0cmhLTSrCI1
 tyD8t9f5myaK0M071wJYfRoyGteRQCBPNYVPPuuFVUVn1ti/nXA7dACUMAVnsfT3IsJ5n8
 jA6fKZsbSYjjrnp1v++OWdQxOLTodAA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1791990622;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sou6RcWQNumo9f5r/jHgrbU+mPVWH9Ow2w5ufj4uFR8=;
 b=Sm6parpva94KkovJ03ahsmYAmihE0ilVrHMYmCcOyNyMPHxB5S70AkRndmvLTXAgP47xRe
 UANamsAhz9mYx0Dw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D64F61368E;
 Wed, 14 Oct 2026 15:10:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sL+aGl2bz2qsMQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 14 Oct 2026 15:10:21 +0000
Date: Wed, 14 Oct 2026 17:10:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <as-ba7aQXWfl_jX5@yuki.lan>
References: <20260831-fchroot-v4-0-57cceb68f927@suse.com>
 <20260831-fchroot-v4-15-57cceb68f927@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260831-fchroot-v4-15-57cceb68f927@suse.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 57AAE2211F
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH STAGING v4 15/16] fchroot12: test failfs entry
 with shared fs_struct
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
> +	TST_EXP_FAIL(tst_syscall(__NR_fchroot, FD_FAILFS_ROOT, 0),
> +		EINVAL, "fchroot() with a shared fs_struct");
> +
> +	SAFE_KILL(sib, SIGKILL);
> +	SAFE_WAITPID(sib, NULL, 0);
> +
> +	exit(0);

Here as well, no need for the exit(0), otherwise:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
