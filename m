Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C28B8C54798
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 01:29:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CDDB03D1D7A
	for <ltp@archiver.kernel.org>; Fri,  8 Mar 2024 02:29:44 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A73D3CC129
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 02:29:23 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 97064200761
 for <ltp@lists.linux.it>; Fri,  8 Mar 2024 02:29:22 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9EF4A20CEF;
 Thu,  7 Mar 2024 23:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709855428;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KWwClqL1kxY+wfaYKPsr0uaIZyAYVvfZR/tgQhywmXU=;
 b=O2fAbchqtBZebkgNuHyv8yVdB9tDsKqAYCBMFXoQI9F/u/z9kOi6Ighp+l9Ci9btFGTzxL
 mP+8ulrdS7i3pSk5b/jmh4IAo2ftm60PM2AQ+0k63WtMr4vgiw4LkoeBasOdfjx6hgyIrw
 TEwRPILEy1zTpOQVeTBYXWMsxHWN4rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709855428;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KWwClqL1kxY+wfaYKPsr0uaIZyAYVvfZR/tgQhywmXU=;
 b=VwNnKjcE40sCL3AUsUXQQgmJcmRK7N+sSRBcl1/2OYovwzbBzx/wU4X4zF5B41dAuxKh4H
 6tXJAe2Am0JvdZDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709855428;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KWwClqL1kxY+wfaYKPsr0uaIZyAYVvfZR/tgQhywmXU=;
 b=O2fAbchqtBZebkgNuHyv8yVdB9tDsKqAYCBMFXoQI9F/u/z9kOi6Ighp+l9Ci9btFGTzxL
 mP+8ulrdS7i3pSk5b/jmh4IAo2ftm60PM2AQ+0k63WtMr4vgiw4LkoeBasOdfjx6hgyIrw
 TEwRPILEy1zTpOQVeTBYXWMsxHWN4rA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709855428;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KWwClqL1kxY+wfaYKPsr0uaIZyAYVvfZR/tgQhywmXU=;
 b=VwNnKjcE40sCL3AUsUXQQgmJcmRK7N+sSRBcl1/2OYovwzbBzx/wU4X4zF5B41dAuxKh4H
 6tXJAe2Am0JvdZDg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6CB71132A4;
 Thu,  7 Mar 2024 23:50:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id LWr3F8RS6mWnTQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 07 Mar 2024 23:50:28 +0000
Date: Fri, 8 Mar 2024 00:50:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240307235026.GA233637@pevik>
References: <20240222153217.1046-1-andrea.cervesato@suse.de>
 <Zdh8tICfdo5Y79Qp@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zdh8tICfdo5Y79Qp@yuki>
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=O2fAbchq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VwNnKjcE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.71 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[30.25%]
X-Rspamd-Queue-Id: 9EF4A20CEF
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add more testcases in mkdir03
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

> Hi!
> > +#include <paths.h>
> > +#include <stdlib.h>
> >  #include <errno.h>
> >  #include <sys/types.h>
> >  #include <sys/stat.h>
> > @@ -19,6 +21,10 @@
> >  #include "tst_test.h"

> >  #define TST_EEXIST	"tst_eexist"
> > +#define TST_PIPE	"tst_pipe"
> > +#define TST_FOLDER	"tst_folder"
> > +#define TST_SYMLINK "tst_symlink"
> > +#define TST_NULLDEV	_PATH_DEVNULL

> I would just hardcode the "/dev/null" here, this has potential to
> explode on alternative libc implementations, possibly Android.

> Hmm looking around the file seems to exists on Android and Musl however
> _PATH_DEVNULL is just "/dev/null" everywhere anyways.

Yeah, IMHO not that readable as hardcoded value, but it's safe to use nowadays.

Anyway, merged.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
