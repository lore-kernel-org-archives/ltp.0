Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 892E3C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 09:42:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8CB1A3C98A3
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 10:42:02 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EE5D63C986C
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:41:46 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 485D32206F9
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 10:41:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 85F8C1F390;
 Mon, 10 Feb 2025 09:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739180503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EzCyUdU+jrZvJlo/M0xIrHMtHD0Z2C1ZnZ0Y2tsczb0=;
 b=MuCJtgpe/7txZ2VnzkBmo97scB5Hjzdm8yb4umD5s84rF29GrAu+UPw3vfjds06K4liTqn
 CNMTsh9TeutMoxLDRegeGwnemFA+ymDAWZmK1620S1/nqpQlYZxdsDm0vo9AkEBYnYid3m
 jk7sM+gTnREZM10XdrZ1x2HLDgscxUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739180503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EzCyUdU+jrZvJlo/M0xIrHMtHD0Z2C1ZnZ0Y2tsczb0=;
 b=6NNNL5lZGys8V6J6wIUe46otRjkdejOiQLCPYaMfmAql9JeXxHXd7Jcf9mysK+FKDkehxN
 lVJBTj5nZgH2n4CA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739180503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EzCyUdU+jrZvJlo/M0xIrHMtHD0Z2C1ZnZ0Y2tsczb0=;
 b=MuCJtgpe/7txZ2VnzkBmo97scB5Hjzdm8yb4umD5s84rF29GrAu+UPw3vfjds06K4liTqn
 CNMTsh9TeutMoxLDRegeGwnemFA+ymDAWZmK1620S1/nqpQlYZxdsDm0vo9AkEBYnYid3m
 jk7sM+gTnREZM10XdrZ1x2HLDgscxUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739180503;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EzCyUdU+jrZvJlo/M0xIrHMtHD0Z2C1ZnZ0Y2tsczb0=;
 b=6NNNL5lZGys8V6J6wIUe46otRjkdejOiQLCPYaMfmAql9JeXxHXd7Jcf9mysK+FKDkehxN
 lVJBTj5nZgH2n4CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 58FE713A62;
 Mon, 10 Feb 2025 09:41:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id D3FXFNfJqWf2OwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Feb 2025 09:41:43 +0000
Date: Mon, 10 Feb 2025 10:41:41 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20250210094141.GA1826068@pevik>
References: <20250210-mmap_suite_refactoring-v2-0-6edea3a4363a@suse.com>
 <20250210-mmap_suite_refactoring-v2-1-6edea3a4363a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250210-mmap_suite_refactoring-v2-1-6edea3a4363a@suse.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,imap1.dmz-prg2.suse.org:helo]; 
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/8] Refactor mmap03 test
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
Cc: rbm@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea, all,

...
> - *	07/2001 Ported by Wayne Boyer
> + * With ia64 and PARISC/hppa, an attempt to access the contents of the
> + * mapped region should rise signal SIGSEGV.

You kept this:
 * With ia64 and PARISC/hppa, an attempt to access the contents of the
 * mapped region should rise signal SIGSEGV.

You kept checking SIGSEGV, but not sigsetjmp() which should cause it (IMHO it
will not work).

I wonder if we should care about these old archs. Both ia64 and hppa are
dropped. The only still living arch is __mips__. But looking at change when it
mips was added it's quite recent - 2021:
c7f979b3d ("syscalls/mmap03: Fix SegFault on MIPS")

@Cyril? Should we keep only mips? And I strongly suspect nobody is testing LTP
on mips, but we should probably not kill a still living arch.
If all these archs removed whole fork could be removed.

...
> +	tst_res(TINFO, "Map temporary file in memory with PROT_EXEC");
nit: I would remove it. In case of the problem SAFE_MMAP() will notify,
otherwise not important.

Also, can we move SAFE_MALLOC() to setup and free to cleanup()

data = SAFE_MALLOC(page_sz);

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
