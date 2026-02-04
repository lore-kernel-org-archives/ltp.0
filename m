Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536F6EA7948
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 22:28:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A4DC73CE20E
	for <ltp@archiver.kernel.org>; Wed,  4 Feb 2026 23:28:15 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F39653CD3CA
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 23:27:57 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 40FD91000378
 for <ltp@lists.linux.it>; Wed,  4 Feb 2026 23:27:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AD8345BD6B;
 Wed,  4 Feb 2026 22:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770244075;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bzkywv8tRXHyPA71VXfkL0QXP2B0wNf4KxWkd6bAw7Y=;
 b=Brz//1h07Qbpn4HJ5h8CO/xr0MOmMZhp4V6f1SPIAX8Pm4Kat1Tmt5F/9dTiUi3eUXCFvu
 o2zwiAT72w38nxGkeV0eu67CMBLD55I2Y1hrkSdjOj4pe5C2JbgDMOj5rhNcFEYRN15wsX
 2DsIVPhVfjf3AkD0Eg4P4nfLqhwIcOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770244075;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bzkywv8tRXHyPA71VXfkL0QXP2B0wNf4KxWkd6bAw7Y=;
 b=tyhXHQ/KQgqbsa6hNTd4h6133y0xTsSD5c8T78MKiJAu0KW9z7k/sDA2LL3FPwDPGlUcH+
 1fcPymikUDTqJ2BQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Brz//1h0";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="tyhXHQ/K"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1770244075;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bzkywv8tRXHyPA71VXfkL0QXP2B0wNf4KxWkd6bAw7Y=;
 b=Brz//1h07Qbpn4HJ5h8CO/xr0MOmMZhp4V6f1SPIAX8Pm4Kat1Tmt5F/9dTiUi3eUXCFvu
 o2zwiAT72w38nxGkeV0eu67CMBLD55I2Y1hrkSdjOj4pe5C2JbgDMOj5rhNcFEYRN15wsX
 2DsIVPhVfjf3AkD0Eg4P4nfLqhwIcOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1770244075;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bzkywv8tRXHyPA71VXfkL0QXP2B0wNf4KxWkd6bAw7Y=;
 b=tyhXHQ/KQgqbsa6hNTd4h6133y0xTsSD5c8T78MKiJAu0KW9z7k/sDA2LL3FPwDPGlUcH+
 1fcPymikUDTqJ2BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 285893EA63;
 Wed,  4 Feb 2026 22:27:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Q+AzBevHg2k9RgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Feb 2026 22:27:55 +0000
Date: Wed, 4 Feb 2026 23:27:53 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20260204222753.GA279256@pevik>
References: <20260203024320.227453-1-liwang@redhat.com>
 <20260204122332.GC224465@pevik> <aYNVsiL4xf2P9R6A@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aYNVsiL4xf2P9R6A@redhat.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: AD8345BD6B
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] openat2: define _GNU_SOURCE and include
 <fcntl.h>
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

Hi Li,

...
> > lapi/openat2.h uses struct open_how directly, shouldn't be included lapi/fcntl.h
> > there?

> From my understand lapi/* are appendix for missing stuff in header file.

Yes, but we agreed in the past, that it's better to include relevant libc/kernel
header in the lapi header [1]:

	LAPI header should always include original header.

[1] https://github.com/linux-test-project/ltp/blob/master/doc/old/C-Test-API.asciidoc#lapi-headers

I thought we had a discussion about it, but now I see nobody acked the change in
ML (cfbc41d775), therefore I somehow pushed this approach without consensus with
others. I'm sorry for that, we can revise that. At the moment quite a few lapi
headers use this approach (likely majority).

IMHO it's better to include it than expect that all tests which use lapi header
will include relevant header *before* (otherwise tests can happily always depend
on fallback instead of using a real value from a system header).

It's a minor detail, but being consistent helps for newcomers to understand
LTP code.

And *if* we agree on it, it should be now doc/developers/ground_rules.rst.

Also there is a different approach where should be fallbacks. We use some lapi
headers (e.g. lapi/openat2.h but there are more) which don't have public
equivalent in libc (/usr/include/bits/openat2.h cannot be used directly, but via
<fcntl.h>). Therefore I would put content of lapi/openat2.h into lapi/fcntl.h,
but that's a minor detail.

> Test cases should only include standard header files, and lapi should
> only be used in case of missing or conflicting header files.

But lapi/openat2.h also uses struct open_how. I would either include <fcntl.h>
in both sources or just in lapi/openat2.h. Having it only in tests looks to me
as not ideal.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
