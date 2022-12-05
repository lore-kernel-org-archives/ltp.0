Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFCDC4332F
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 20:32:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7115F3CC222
	for <ltp@archiver.kernel.org>; Mon,  5 Dec 2022 21:32:19 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C6DBC3CC209
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 21:32:09 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4C1C3144AEC0
 for <ltp@lists.linux.it>; Mon,  5 Dec 2022 21:32:08 +0100 (CET)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 60B5F223C1;
 Mon,  5 Dec 2022 20:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1670272327;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Y3pW7zOmlTHM2w2w3q2dxhkAq10L0bb0Y6jSw/HB1Q=;
 b=m+kUMP4sqnQ8jX1S+IzTFYSRTZ7JNvuLt8czel5ibP2/oY5de2FjDMbHjwo9XZJOCnwIl6
 nGZNfG2N/zOb0wVSRrYFfg8/0XyN+qXP978D15oD6esRInC+faa9qsvD3/jbUnpjxmY+zf
 +0U8ly0ItJFFqVDEz51odjEE6QdXV/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1670272327;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5Y3pW7zOmlTHM2w2w3q2dxhkAq10L0bb0Y6jSw/HB1Q=;
 b=oKlwRcD2Z069El7nDycLpH0PM2ztJ+JtG8ingwmXKDuGXrAhW2rEDFcPkYiu7UW38eo4PJ
 EWeEbgNctZ9kzvBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id 1274B13326;
 Mon,  5 Dec 2022 20:32:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id WdjhAUdVjmMbRwAAGKfGzw
 (envelope-from <pvorel@suse.cz>); Mon, 05 Dec 2022 20:32:07 +0000
Date: Mon, 5 Dec 2022 21:32:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <Y45VRaJsqJYOLyK5@pevik>
References: <87v8mqt6lq.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87v8mqt6lq.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] text/html mails should now be rejected
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Richie,

> Hello,

> I have disallowed HTML message attachments in mailman because they are
> not supported by a variety of tooling. Please complain loudly if this
> breaks something.

Ack, thanks! IMHO we should mention it somewhere in docs.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
