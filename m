Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23F5CCD18D
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 14:27:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 45D413CEBCC
	for <ltp@archiver.kernel.org>; Mon, 13 Oct 2025 16:27:16 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6A01B3CEBA3
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 16:27:00 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D1BD61A00901
 for <ltp@lists.linux.it>; Mon, 13 Oct 2025 16:26:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6F33C219CB;
 Mon, 13 Oct 2025 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760365616;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xqPFoVQ+hYKPxug+R9lPcpQVupV3+lCOYZiPMBoeG1s=;
 b=kJmFpFtqgeiPDCkhvHMODy9EXMM9XVUPFbrfbqgh8weAhBEHXDnJhvADPJhh8l3czVVQxn
 mUolZ/CtenGpNmuEZVZ0HzUNmdKRuj+YG6VrPX7ikq8at9vb1IbA2uoiwF6Uyw5lzg8Gtt
 x/C/EuSuX5AsSsDd9Omzh1VmwV29chM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760365616;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xqPFoVQ+hYKPxug+R9lPcpQVupV3+lCOYZiPMBoeG1s=;
 b=JsOOAT4JZbnxqx7G8bbLcDtxmDXh9mefjmtKb7JzaBHhMjHtCjh2PxOc7bbJbwo6Wwgrly
 ku1qF3W20a8DebCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=kJmFpFtq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=JsOOAT4J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1760365616;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xqPFoVQ+hYKPxug+R9lPcpQVupV3+lCOYZiPMBoeG1s=;
 b=kJmFpFtqgeiPDCkhvHMODy9EXMM9XVUPFbrfbqgh8weAhBEHXDnJhvADPJhh8l3czVVQxn
 mUolZ/CtenGpNmuEZVZ0HzUNmdKRuj+YG6VrPX7ikq8at9vb1IbA2uoiwF6Uyw5lzg8Gtt
 x/C/EuSuX5AsSsDd9Omzh1VmwV29chM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1760365616;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xqPFoVQ+hYKPxug+R9lPcpQVupV3+lCOYZiPMBoeG1s=;
 b=JsOOAT4JZbnxqx7G8bbLcDtxmDXh9mefjmtKb7JzaBHhMjHtCjh2PxOc7bbJbwo6Wwgrly
 ku1qF3W20a8DebCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 339D313874;
 Mon, 13 Oct 2025 14:26:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gA9jCjAM7WjAFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 13 Oct 2025 14:26:56 +0000
Date: Mon, 13 Oct 2025 16:26:54 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>,
 Avinesh Kumar <akumar@suse.de>, ltp@lists.linux.it
Message-ID: <20251013142654.GA102670@pevik>
References: <aOODn-CZ7F1A777o@yuki.lan> <20251007143207.27848-1-akumar@suse.de>
 <6213145.lOV4Wx5bFT@thinkpad> <20251007213713.GB160168@pevik>
 <DDH3SBAZQOWD.PPCDX4YW7KBZ@suse.com> <20251013112947.GA78221@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251013112947.GA78221@pevik>
X-Rspamd-Queue-Id: 6F33C219CB
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; SINGLE_SHORT_PART(0.00)[];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] openposix: update invalid clock id to
 accomodate new auxiliary clock ids
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

FYI merged.

Thanks!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
