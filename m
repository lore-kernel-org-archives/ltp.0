Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C778CD5BD1
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 12:32:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDFF13E56ED
	for <ltp@archiver.kernel.org>; Mon,  1 Jun 2026 14:32:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 821E73CB98B
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 14:32:39 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B25231000366
 for <ltp@lists.linux.it>; Mon,  1 Jun 2026 14:32:38 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0AC6767EBF;
 Mon,  1 Jun 2026 12:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780317158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lacHBD/C0Xk8zaqwENBeAYzlRvSwLVwBux/uboUxiIM=;
 b=2Fkj8O121ifTgtim1oFeatxmxwXndcLZBuDoWX19oMeWsI50evsyJjM51r2THoVx0Dzi9l
 2T8mv23XOgsWAXv5U8TB3Wl8SqD8V9jPNgfK0fyidxyI9aYSRTjD/t4NzRZNckfjma2Vf8
 FuCPQYhXG2Cfq5pda1pwsDg0VbokK6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780317158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lacHBD/C0Xk8zaqwENBeAYzlRvSwLVwBux/uboUxiIM=;
 b=rt3so2/qKHUhRon2qGzhZF7y6qkrlf/SqVF8nt+inV5ZGphKOClmNY2WlfiCT6LmSvy0I0
 8wsVq7+YApWaPlBA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2Fkj8O12;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="rt3so2/q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1780317158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lacHBD/C0Xk8zaqwENBeAYzlRvSwLVwBux/uboUxiIM=;
 b=2Fkj8O121ifTgtim1oFeatxmxwXndcLZBuDoWX19oMeWsI50evsyJjM51r2THoVx0Dzi9l
 2T8mv23XOgsWAXv5U8TB3Wl8SqD8V9jPNgfK0fyidxyI9aYSRTjD/t4NzRZNckfjma2Vf8
 FuCPQYhXG2Cfq5pda1pwsDg0VbokK6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1780317158;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lacHBD/C0Xk8zaqwENBeAYzlRvSwLVwBux/uboUxiIM=;
 b=rt3so2/qKHUhRon2qGzhZF7y6qkrlf/SqVF8nt+inV5ZGphKOClmNY2WlfiCT6LmSvy0I0
 8wsVq7+YApWaPlBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E10E2779A7;
 Mon,  1 Jun 2026 12:32:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NZkFNuV7HWqiCgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 01 Jun 2026 12:32:37 +0000
Date: Mon, 1 Jun 2026 14:32:28 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260601123228.GA3383916@pevik>
References: <20260601-doc_add_missing_headers-v1-0-6f1ee31945df@suse.com>
 <20260601-doc_add_missing_headers-v1-1-6f1ee31945df@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260601-doc_add_missing_headers-v1-1-6f1ee31945df@suse.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 0AC6767EBF
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; TO_DN_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] doc: Add missing API references to
 api_c_tests.rst
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Fix broken kernel-doc reference to renamed tse_numa.h header and add
Not only this patch but none of the other two actually fixes it. I suppose you
forget to amend git commit.

How about to fix this one in a separate commit (which you can merge right now,
no need to even send it to ML) with the usual tag?

Fixes: eef750db28 ("libs: adopt tse_ prefix for extended (non-core) library")

Specially because Cyril might want to review if all the docs is correct (which
takes time).

Also there are still some unresolved problems, but we can fix it afterwards:

include/tst_test.h:302: WARNING: undefined label: 'struct tst_option'
include/tst_test.h:325: WARNING: undefined label: 'struct tst_device'
include/tst_test.h:361: WARNING: undefined label: 'struct tst_device'
include/tst_test.h:502: WARNING: undefined label: 'struct tst_path_val'
include/tst_test.h:523: WARNING: undefined label: 'struct tst_buffers'
include/tst_test.h:528: WARNING: undefined label: 'struct tst_cap'
include/tst_test.h:531: WARNING: undefined label: 'struct tst_tag'
include/tst_test.h:533: WARNING: undefined label: 'struct tst_cmd'
include/tst_kvercmp.h:97: WARNING: undefined label: 'struct tst_kern_exv'
doc/developers/api_shell_tests.rst:30: WARNING: undefined label: 'struct tst_test'
doc/developers/test_case_tutorial.rst:140: WARNING: undefined label: 'struct tst_test'
doc/developers/todo.rst:62: WARNING: undefined label: 'struct tst_test'
doc/developers/writing_tests.rst:141: WARNING: undefined label: 'struct tst_test'
doc/developers/writing_tests.rst:364: WARNING: undefined label: 'struct tst_test'
doc/developers/writing_tests.rst:558: WARNING: undefined label: 'struct tst_device'

Generally changes are good, thanks for finishing the transition.
With fixed tse_numa.h (preferably in a separate commit) you may add:

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> kernel-doc directives for 12 headers that were missing from the C API
> documentation page:

>   tst_clone.h, tst_device.h, tst_fs.h, tst_fuzzy_sync.h,
>   tst_hugepage.h, tst_kconfig.h, tst_memutils.h, tst_safe_file_ops.h,
>   tst_taint.h, tse_numa.h, tse_swap.h, tse_uinput.h

> Convert plain comments to kernel-doc format in tst_device.h,
> tst_hugepage.h, tst_clone.h, and tst_taint.h so the documentation
> builder can extract them.

> Sort all sections alphabetically under LTP C API.

FYI I quite liked that Core API was the first, but ok with the move.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
