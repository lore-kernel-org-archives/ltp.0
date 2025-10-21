Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6879CCCD1A5
	for <ltp@archiver.kernel.org>; Tue, 21 Oct 2025 11:24:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFDBD3CF02E
	for <ltp@archiver.kernel.org>; Tue, 21 Oct 2025 13:24:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5E4A3C8535
 for <ltp@lists.linux.it>; Tue, 21 Oct 2025 13:24:04 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4017E2000A3
 for <ltp@lists.linux.it>; Tue, 21 Oct 2025 13:24:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 802962116F;
 Tue, 21 Oct 2025 11:23:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761045838;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6tdiNHS3uTcxTHFKesm1sIdOP+e0li8OP8DZrgbA7EE=;
 b=pKlyTfC8iCi3PfXSyDtkearwPR2RIroCHO3p8uzHGq/sLhz8fz6zJtbtgGlueqZ1F6shDt
 S/fvhLzxCslthAl4a38BrH4ZmWVphdRI1Ze86JI3dfmgGQpEqEzZH9HL2p9aQPbYNTd1pv
 s2jPidiXqTFR2YjbIFCacExrhH0cntA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761045838;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6tdiNHS3uTcxTHFKesm1sIdOP+e0li8OP8DZrgbA7EE=;
 b=+my+oC7BMFAySCnYZraOuORxzNGdiTeKx8cKsuQ9GGotL1Ku+UhCtf66JcvzaIZeqyqrlu
 tfjKZGSQJk68gXDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1761045834;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6tdiNHS3uTcxTHFKesm1sIdOP+e0li8OP8DZrgbA7EE=;
 b=GC2JIQ6bwKNy1ZcAhVDA3kwTmLcVWBsIf3z6Izq8t4JgSgDcdN0s4PKOFdm/cjVqETgsOp
 oQorMKGAJyedhwwOP6eMdrcZzHSRAdKJt24Ob7bbjH9097oMfMtWgxVu7TvYB/CcywL0pk
 1k4crAkDfFSA7o982dIlsiJr19LI88A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1761045834;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6tdiNHS3uTcxTHFKesm1sIdOP+e0li8OP8DZrgbA7EE=;
 b=fylZ09aZwWNpCpM/E6Hd0zf310QJnNVDBXr5OeSWrSMOgp/7YPA0bh82S8uAFRuzGT9eWC
 rXOs8i8uI/qRrNDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5F5B1139D2;
 Tue, 21 Oct 2025 11:23:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cfBIFkpt92i/OgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 21 Oct 2025 11:23:54 +0000
Date: Tue, 21 Oct 2025 13:23:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Jan Kara <jack@suse.cz>
Message-ID: <20251021112349.GB429244@pevik>
References: <20251021095828.28779-1-jack@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251021095828.28779-1-jack@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_THREE(0.00)[3];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[lists.linux.it,gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] name_to_handle_at: Add test cases for
 AT_HANDLE_FID
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

Hi Jan, Amir,

> Add a few testcases verifying AT_HANDLE_FID flag.

> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  include/lapi/fcntl.h                          |  4 +
>  .../name_to_handle_at/name_to_handle_at03.c   | 88 +++++++++++++++++++
>  2 files changed, 92 insertions(+)
>  create mode 100644 testcases/kernel/syscalls/name_to_handle_at/name_to_handle_at03.c

> Changes since v1:
> * Added kernel commit fixing the issue
> * Fixed up test description

Thanks! Merged with added entry to runtest/syscalls and .gitignore.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
