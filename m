Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36186D3B98A
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 19:38:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8D9323CAA5F
	for <ltp@archiver.kernel.org>; Tue,  9 Dec 2025 20:38:29 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92E163CA1ED
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 20:38:13 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 87D3B600279
 for <ltp@lists.linux.it>; Tue,  9 Dec 2025 20:38:10 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E9A82337E9;
 Tue,  9 Dec 2025 19:38:09 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BD0DD3EA63;
 Tue,  9 Dec 2025 19:38:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WZATLKF6OGlAbgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 09 Dec 2025 19:38:09 +0000
Date: Tue, 9 Dec 2025 20:38:04 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251209193804.GB20883@pevik>
References: <20251209120246.18435-1-chrubis@suse.cz>
 <CAASaF6yCjh6i9bm5WU4p7TmW4xNSD9+QkB=BfMWSbm_4Hvgptw@mail.gmail.com>
 <aThHKguxntl-ZJBb@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aThHKguxntl-ZJBb@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: E9A82337E9
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] doc: Add ground rules page
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

Hi all,

> Hi!
> > I don't recall if we have it mentioned already, but we also used to say that
> > changes introduced in early kernel -rc  builds were low priority for acceptance
> > and we favored behavior that is in a released kernel (or at least in last -rcs).

> Sounds good.

+1. We could also mention runtest/staging

:master:`runtest/staging`, which we use for tests written against -rc kernels.
(So far we had only fanotify23 there, which was of course later migrated to
syscalls.)

> Also we probably need something along the lines:

> Use runtime checks for kernel features
> ======================================

> What is and what isn't supported by kernel is determined by the version
> and configuration of the kernel the systems is currently running on.
> That especially means that any checks done during the compilation cannot
> be used to assume features supported by the kernel the tests end up
> running on. The compile time checks, done by configure script, are only

done by :master:`configure.ac` script, ...

> useful for enabling fallback kernel API definitions when missing, as we
> do in lapi/ directory.

do in :master:`include/lapi/`.

Also about my previous note about referencing TST_CHECKPOINT_WAIT(), I know this
is a high level document, but IMHO linking helps newcomers.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
