Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64B1FC47DA2
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 15:32:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AB9C3CE32E
	for <ltp@archiver.kernel.org>; Tue, 16 Jan 2024 16:31:59 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF22F3CB25E
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 16:31:43 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0B4D760296F
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 16:31:42 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2870D221ED;
 Tue, 16 Jan 2024 15:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705419102;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gg/DtIXuzXXb0ZG3ufY/V/JkFk+J4DJKM248s9Mih9k=;
 b=EIDiTvWzQfBIcB0lDN9nreVVHPXDuw7FERqu9jX9dvGSL6WxO1qJcQmR4ixn37/+qYrb0J
 aVx4yABVQdSETgZUM0PZE2fGWjEKhigV90LZDhcnU950G+HNheu0zBmZpjlk6JjjiybtKp
 e/aD3pnc3Se9bBOzRAyge3MZzi4GZ+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705419102;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gg/DtIXuzXXb0ZG3ufY/V/JkFk+J4DJKM248s9Mih9k=;
 b=iDRnElRuF9lWJ9uy8t8kcpImjwij52nuc+rGBfgx3s4YTV6f7TKM0Yg0z/uPvM0KwBclBy
 nSUrHV6WDr5k12Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1705419102;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gg/DtIXuzXXb0ZG3ufY/V/JkFk+J4DJKM248s9Mih9k=;
 b=EIDiTvWzQfBIcB0lDN9nreVVHPXDuw7FERqu9jX9dvGSL6WxO1qJcQmR4ixn37/+qYrb0J
 aVx4yABVQdSETgZUM0PZE2fGWjEKhigV90LZDhcnU950G+HNheu0zBmZpjlk6JjjiybtKp
 e/aD3pnc3Se9bBOzRAyge3MZzi4GZ+8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1705419102;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Gg/DtIXuzXXb0ZG3ufY/V/JkFk+J4DJKM248s9Mih9k=;
 b=iDRnElRuF9lWJ9uy8t8kcpImjwij52nuc+rGBfgx3s4YTV6f7TKM0Yg0z/uPvM0KwBclBy
 nSUrHV6WDr5k12Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9699313751;
 Tue, 16 Jan 2024 15:31:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lVrNIF2hpmWUBAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 16 Jan 2024 15:31:41 +0000
Date: Tue, 16 Jan 2024 16:31:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240116153139.GA2600095@pevik>
References: <20240115125351.7266-1-chrubis@suse.cz>
 <20240115125351.7266-2-chrubis@suse.cz>
 <20240115230952.GA2535088@pevik> <20240116003219.GD2535088@pevik>
 <ZaaeZmg8mi2dWVPn@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZaaeZmg8mi2dWVPn@yuki>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.64 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.11)[-0.560];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-2.23)[96.36%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/4] lib: Add tst_fd iterator
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > In file included from ../include/lapi/io_uring.h:17:0,
> >                  from tst_fd.c:21:
> > /usr/include/sys/mount.h:35:3: error: expected identifier before numeric constant
> >    MS_RDONLY = 1,  /* Mount read-only.  */
> >    ^

> Looks like the best solution for now is:

> diff --git a/include/lapi/io_uring.h b/include/lapi/io_uring.h
> index a63741a08..03c45190e 100644
> --- a/include/lapi/io_uring.h
> +++ b/include/lapi/io_uring.h
> @@ -14,7 +14,6 @@
>  #include <sys/types.h>
>  #include <sys/uio.h>
>  #include <stdlib.h>
> -#include <linux/fs.h>

>  #include "lapi/syscalls.h"


> As far as I can tell the only reason this header is included is the
> __kernel_rwf_t definition which has a fallback definition just a few
> lines below.

Great!
Feel free to merge with my ack before the patchset + whole patchset.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
