Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBD50CCF9E3
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 07:45:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 479B83CEF0C
	for <ltp@archiver.kernel.org>; Fri,  7 Nov 2025 08:45:39 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B5E73CD2BC
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 08:45:24 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1717E200B62
 for <ltp@lists.linux.it>; Fri,  7 Nov 2025 08:45:22 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B30872123A;
 Fri,  7 Nov 2025 07:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762501521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R7q2RmReRIG1lU0C9b4Btaj4pDk8M+9GJo9aAb7vNaU=;
 b=MH4n+157cLod6lfRfBsJNN0GheUFbGiJx8T8hyXR1JamCVFMe85iVNgFFALLZDiia6j66o
 nP0/klykGlWjd7yCLGljo5HWGlbCSXtkIt9msNtbMQaKopeOlyaHauYojOfnKVGfnv7yPV
 rv4g8F/hQ0aA+78xQ5bt9ZcxRR93Epk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762501521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R7q2RmReRIG1lU0C9b4Btaj4pDk8M+9GJo9aAb7vNaU=;
 b=Z0X/qiutF7HyuKIMY4KLVOkyDIhanm6KXCDSTJhUbT8U1uXDPeg1ZFVqP2qSQLhXjZHgg6
 R9r/qA7zVNPXkTAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1762501521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R7q2RmReRIG1lU0C9b4Btaj4pDk8M+9GJo9aAb7vNaU=;
 b=MH4n+157cLod6lfRfBsJNN0GheUFbGiJx8T8hyXR1JamCVFMe85iVNgFFALLZDiia6j66o
 nP0/klykGlWjd7yCLGljo5HWGlbCSXtkIt9msNtbMQaKopeOlyaHauYojOfnKVGfnv7yPV
 rv4g8F/hQ0aA+78xQ5bt9ZcxRR93Epk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1762501521;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R7q2RmReRIG1lU0C9b4Btaj4pDk8M+9GJo9aAb7vNaU=;
 b=Z0X/qiutF7HyuKIMY4KLVOkyDIhanm6KXCDSTJhUbT8U1uXDPeg1ZFVqP2qSQLhXjZHgg6
 R9r/qA7zVNPXkTAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B6241395F;
 Fri,  7 Nov 2025 07:45:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pGFoIJGjDWnFHgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 07 Nov 2025 07:45:21 +0000
Date: Fri, 7 Nov 2025 08:45:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251107074516.GA1083033@pevik>
References: <20251031-kirk_move_submodule-v1-0-3cad4270a0b5@suse.com>
 <aQx4s5FFN7HG1KzE@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aQx4s5FFN7HG1KzE@yuki.lan>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:replyto];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] Move kirk sources from tools/kirk to
 tools/kirk/kirk-src
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

Hi Andrea,

it's not easy to merge the patch.

$ git am first.patch

Applying: kirk: remove submodule before moving it
warning: unable to rmdir 'tools/kirk': Directory not empty
Applying: kirk: move kirk source code inside tools/kirk/kirk-src
error: tools/kirk/Makefile: already exists in working directory
Patch failed at 0002 kirk: move kirk source code inside tools/kirk/kirk-src


After applying both patches removing whole tools it still does not work:

$ rm -rf tools/; git reset --hard; git submodule update --init
HEAD is now at 9b056c36d3 kirk: move kirk source code inside tools/kirk/kirk-src
error: submodule git dir 'ltp.git/modules/tools/kirk/kirk-src' is inside git dir 'ltp.git/modules/tools/kirk'
fatal: refusing to create/use 'ltp.git/modules/tools/kirk/kirk-src' in another submodule's git dir
Failed to clone 'tools/kirk/kirk-src'. Retry scheduled
error: submodule git dir 'ltp.git/modules/tools/kirk/kirk-src' is inside git dir 'ltp.git/modules/tools/kirk'
fatal: refusing to create/use 'ltp.git/modules/tools/kirk/kirk-src' in another submodule's git dir
Failed to clone 'tools/kirk/kirk-src' a second time, aborting

I'm ok to remove it, but IMHO after you merge people which has used kirk
previously will have to start with a fresh clone.

Also the reason for the move is in the cover letter only. Although it'd be nice
to have the reason in the git commit message I'm ok with it.

Acked-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
