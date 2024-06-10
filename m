Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C35C27C5E
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 12:57:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 058093D0B4E
	for <ltp@archiver.kernel.org>; Mon, 10 Jun 2024 14:57:52 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4834C3D0B19
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 14:57:36 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 51C0A20116E
 for <ltp@lists.linux.it>; Mon, 10 Jun 2024 14:57:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D55971F7EE;
 Mon, 10 Jun 2024 12:57:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718024253;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CJrnkhGobmBGYBvSf2s8/0JzaeI+sKA2Iavt/D1dmbQ=;
 b=2jKo5/G4lV3zI2+kHVPOIW0uRG0GEfaL11WRBfxZ3zYwY/15ktfPyPG0Hq+pe5wYfBEdlC
 6DLS944hr7iB494OMsjPY73dStjlPL8qatAkuEwMTQyXm0B0rZzhDWyqRByG9gcWQ+aguy
 JioKn/FjX1Gvgc1/7f+3q4FpHAfR0W4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718024253;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CJrnkhGobmBGYBvSf2s8/0JzaeI+sKA2Iavt/D1dmbQ=;
 b=OsS2fGjyEpB0wwOYMFNmmoY4t7jHMaj+6XFXe9cGBbAj4IlEcnlfFaCDP0tGeUGfm3NCKL
 LtuhQ7wcj8dxyUCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718024252;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CJrnkhGobmBGYBvSf2s8/0JzaeI+sKA2Iavt/D1dmbQ=;
 b=W4U7r98jZL35CAyta9GpmZfGpX7eGlQhF26MMig2lgzdJaD4R9Xy+KXVtJrY0UmFb3oF8l
 M35jyAN2b0NuZXqlVa+3EU0S24VIJJ7iNHAI/ziwjtD9BoGOCmOGUpIYX4TJp06gJ38Zxo
 lvuXuH5NfI05v+aIuMWrM+HHQPoClhI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718024252;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CJrnkhGobmBGYBvSf2s8/0JzaeI+sKA2Iavt/D1dmbQ=;
 b=FdogBV343J6hxK/TlUBObFxB9AZcW/c8CFjiOelAtYhpltbMO5EfbDSAPvq3DFqfH+jZYj
 /JzO3fYJtnQorOBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BEF513A51;
 Mon, 10 Jun 2024 12:57:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b2CBGDz4ZmbyKgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Jun 2024 12:57:32 +0000
Date: Mon, 10 Jun 2024 14:57:30 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Message-ID: <20240610125730.GB723984@pevik>
References: <20240609130120.62790-1-vineethr@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240609130120.62790-1-vineethr@linux.ibm.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ebizzy: Fix a typo in README
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

Hi,

> Fixed a spelling mistake in the README ("anre" to "are").

> Signed-off-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
> ---
>  utils/benchmark/ebizzy-0.3/README | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/utils/benchmark/ebizzy-0.3/README b/utils/benchmark/ebizzy-0.3/README
> index 6552f420d..57797d3b2 100644
> --- a/utils/benchmark/ebizzy-0.3/README
> +++ b/utils/benchmark/ebizzy-0.3/README
> @@ -11,7 +11,7 @@ Compiling
>  ---------

>  First configure ebizzy for your platform by typing "./configure".
> -Currently Linux and Solaris anre supported.  Then type "make".  The
> +Currently Linux and Solaris are supported.  Then type "make".  The

Thanks, obviously correct, thus merged.

But we don't support Solaris any more, also ebizzy is not in any runtest,
thus it's unused (we were discussing it in the past but nothing has changed).

Kind regards,
Petr

>  resulting binary will be named "ebizzy".

>  Running

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
