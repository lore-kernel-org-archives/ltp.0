Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E88FFC79FB9
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 08:57:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16C463E72DD
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 10:57:32 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B03BA3D00A3
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:57:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 135AC1A002F0
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 10:57:13 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5385B1FD97;
 Thu, 10 Sep 2026 08:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789030623;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A912oLd+UMZPSASV3gSzFeaYwfAsZuOeLBLeLY0B258=;
 b=nc7eFTkNbKRKgABAFwRg+72j96iRusIKmv+aQVPrkIjvfSowfqfvP8a485fScPgCk+aSxx
 SrF7yjQIyDD1lslOy2UrCBHQzJLmOkZ6eBO5Q0IIyZGyqaCadpkcI/V+kKuZBsiRLkwyhc
 RkIb/t+vLNcnWI7Khs2+NSMfh0iJEjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789030623;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A912oLd+UMZPSASV3gSzFeaYwfAsZuOeLBLeLY0B258=;
 b=jbfG/iSuT/RRsA/n46X/8i/7VkwEfsCwyCAUjbldwq43CVazOTMY1CJFSWlyIHo6+GnxC1
 UFL5SE27+yMvtmDQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JJrssLp+;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4b1ZsGns
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1789030619;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A912oLd+UMZPSASV3gSzFeaYwfAsZuOeLBLeLY0B258=;
 b=JJrssLp+xrn4rtQ5teWI2XtGFef2W6t9Z1an4IZR2TYMaafaqpj3jRQGIrtkHXcqTz6k5i
 1WOu8g81JuUOOGFoa6i9DNuvf7+tiHG9oWwjjBBsgdFIbMACUhUn5Zq+Y7RDZ7vz2aAOrR
 gFc0AkLT26oM/BtuERL5e+D3tL2auww=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1789030619;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A912oLd+UMZPSASV3gSzFeaYwfAsZuOeLBLeLY0B258=;
 b=4b1ZsGns2XLMq7uCJlrHAXdPgbcV35lCeJQSRenbbuuZlL3eO+gsGGv65WxPLqlxM27FnS
 0+aEHbQLGJFCN0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 15F2E1321C;
 Thu, 10 Sep 2026 08:56:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id f9CMA9twomo2cQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 10 Sep 2026 08:56:59 +0000
Date: Thu, 10 Sep 2026 10:56:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260910085649.GA1384688@pevik>
References: <20260908-kirk_4-2-0-v1-1-cb51dde0f5f6@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260908-kirk_4-2-0-v1-1-cb51dde0f5f6@suse.com>
X-Rspamd-Queue-Id: 5385B1FD97
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kirk: upgrade version to 4.2.0
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

> - Add --dry-run option to preview tests before execution
> - Add configurable fault injection interval option
> - Persist and export partial results when a session is aborted mid-suite
> - Fix --exec-timeout not killing tests in the shell channel
> - Fix JSON report file being opened in read/write instead of write-only
>   mode
> - Fix incorrect log message when test parameters are missing in LTP
>   metadata
> - Fix exception handling in the event subsystem
> - Fix --randomize command-line description
> - Major documentation update (quickstart, SSH, LTX, QEMU, and plugins)
> - Move IOBuffer implementations inside the sut module
> - Improve test suite coverage and fix flaky test cases

Thanks!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Link: https://github.com/linux-test-project/kirk/releases/tag/v4.2.0
> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
>  tools/kirk/kirk-src | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/tools/kirk/kirk-src b/tools/kirk/kirk-src
> index 7d4234c43..e65b84ba0 160000
> --- a/tools/kirk/kirk-src
> +++ b/tools/kirk/kirk-src
> @@ -1 +1 @@
> -Subproject commit 7d4234c4305ab8b7b4ec27e911798b5e7f65ef88
> +Subproject commit e65b84ba00de6e5b6bdb63d5259490d7f9d460b8

I see e65b84ba00de6e5b6bdb63d5259490d7f9d460b8 is actually newer than v4.2.0
(v4.2.0 does not have the version change).

Although it's not ideal, I'd consider either delete the current v4.2.0 tag and
point it to e65b84ba00de6e5b6bdb63d5259490d7f9d460b8 or at least add new tag
v4.2.0-fixed which would point to e65b84ba00de6e5b6bdb63d5259490d7f9d460b8.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
