Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDCD1D3B993
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 19:51:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5C50E3CB820
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 20:51:07 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B5423CA1ED
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 20:50:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8613960020E
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 20:50:51 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 424A133893;
 Tue,  9 Dec 2025 19:50:50 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F341F3EA63;
 Tue,  9 Dec 2025 19:50:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id g7PTM5l9OGl1eQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 19:50:49 +0000
Date: Tue, 9 Dec 2025 20:50:44 +0100
From: Petr Vorel <pvorel@suse.cz>
To: simplemessager@163.com
Message-ID: <20251209195044.GA24146@pevik>
References: <20251208150542.704006-1-pvorel@suse.cz>
 <20251209124041.216542-1-simplemessager@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251209124041.216542-1-simplemessager@163.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 424A133893
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/2] safe_keyctl: Skip with TCONF on EOPNOTSUPP
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

> >At 2025-12-08 23:05:40, "Petr Vorel" <pvorel@suse.cz> wrote:
> >Hi Meng, Mingyu,

> >this is another approach for your patchset
> >https://lore.kernel.org/ltp/20251205031719.53914-1-simplemessager@163.com/

> >Could you please test it?
> Thanks for your suggestion, it's better when we using the SAFE_KEYCTL
> interface.
> I have already tested those two patches. It always return TBRK as res
> variable is not suitable for our purpose, so I modified the first patch.

Good catch, thanks!

> >Kind regards,
> >Petr

> >Petr Vorel (2):
> >  safe_keyctl: Skip with TCONF on EOPNOTSUPP
> >  wqueue0*: Use SAFE_KEYCTL()

> > include/lapi/keyctl.h                | 3 ++-
> > testcases/kernel/watchqueue/common.h | 4 ++--
> > 2 files changed, 4 insertions(+), 3 deletions(-)

> >--
> >2.51.0


> >--
> >Mailing list info: https://lists.linux.it/listinfo/ltp

> And sorry for previous broken mail, I spent sometime to figure out how
> to reply this mail properly.

Don't worry, I've cleanup the patchwork state by setting the state of the first
patch as superseded. The one send later should be used for a discussion /
reviews.

https://patchwork.ozlabs.org/project/ltp/patch/20251209124041.216542-2-simplemessager@163.com/

Kind regards,
Petr

> Mingyu Li


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
