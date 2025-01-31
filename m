Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F16AC0218D
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 11:02:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A45003C7A21
	for <ltp@archiver.kernel.org>; Fri, 31 Jan 2025 12:02:14 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3FFE33C7A21
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 12:01:57 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 853401BDF433
 for <ltp@lists.linux.it>; Fri, 31 Jan 2025 12:01:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 072531F38E;
 Fri, 31 Jan 2025 11:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738321313;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5htAS4MkmBxgf/EQCp+k29/9SIJHlmkhEIb0WtLF9vI=;
 b=fPKCFVGfxfQcXTCukG8PCXuwZExGyCgua345hfEqsuPsiNCyQtmaTjFf8YBGoR116JBD9j
 eu87ccT9vCBcQf/uw8SPBtGyxm5SIfqhApAwzkoLJVCE+ADSCE9VOGa4z7A4H6LxleWCUQ
 caJnPbMEnl41TEAA+h5G9K7BhXj+Yr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738321313;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5htAS4MkmBxgf/EQCp+k29/9SIJHlmkhEIb0WtLF9vI=;
 b=RVJESEzS1HorGa7l7IXECdJ40m6R2VEwVWXczgvTs/P9R9d4TidSFWPjIM745cHPF5OVNj
 Qmqx5PqGFpgxnmAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fPKCFVGf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RVJESEzS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1738321313;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5htAS4MkmBxgf/EQCp+k29/9SIJHlmkhEIb0WtLF9vI=;
 b=fPKCFVGfxfQcXTCukG8PCXuwZExGyCgua345hfEqsuPsiNCyQtmaTjFf8YBGoR116JBD9j
 eu87ccT9vCBcQf/uw8SPBtGyxm5SIfqhApAwzkoLJVCE+ADSCE9VOGa4z7A4H6LxleWCUQ
 caJnPbMEnl41TEAA+h5G9K7BhXj+Yr8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1738321313;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5htAS4MkmBxgf/EQCp+k29/9SIJHlmkhEIb0WtLF9vI=;
 b=RVJESEzS1HorGa7l7IXECdJ40m6R2VEwVWXczgvTs/P9R9d4TidSFWPjIM745cHPF5OVNj
 Qmqx5PqGFpgxnmAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C11441364B;
 Fri, 31 Jan 2025 11:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dZ4vLqCtnGdYOQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 31 Jan 2025 11:01:52 +0000
Date: Fri, 31 Jan 2025 12:01:36 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20250131110136.GB1097590@pevik>
References: <20240530144406.7626-1-akumar@suse.de>
 <20240530144846.10915-1-akumar@suse.de>
 <20241021195521.GA493656@pevik> <6145632.lOV4Wx5bFT@thinkpad>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6145632.lOV4Wx5bFT@thinkpad>
X-Rspamd-Queue-Id: 072531F38E
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] flock: Add test for verifying EINTR errno
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

> On Monday, October 21, 2024 9:55:21 PM CET Petr Vorel wrote:
> > Hi Avinesh, Yang Xu,

> > > Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> > > Signed-off-by: Avinesh Kumar <akumar@suse.de>
> > ...
> > > --- /dev/null
> > > +++ b/testcases/kernel/syscalls/flock/flock07.c
> > > @@ -0,0 +1,70 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * Copyright (c) 2024 FUJITSU LIMITED. All Rights Reserved.
> > > + * Author: Yang Xu <xuyang2018.jy@fujitsu.com>
> > > + * Copyright (c) 2024 Linux Test Project
> > > + */
> > > +
> > > +/*\
> > > + * [Description]
> > > + *
> > > + * Verify that flock(2) fails with errno EINTR when waiting to acquire a lock,
> > > + * and the call is interrupted by a signal.

> > Avinesh, you mentioned at Yang Xu's v1 [1] that EINTR test is getting timed out
> > randomly. I also experienced timeouts on aarch64 and ppc64le. v1 had 2 tests
> > (EINTR and EWOULDBLOCK), you here posted only EINTR. I would expect you would
> > put here only the other one - EWOULDBLOCK. Or am I missing something?
> Hi Petr,

> I am sorry, I completely missed this.
> I sent the patch for EWOULDBLOCK case now -
> https://lore.kernel.org/ltp/20250114155013.7644-1-akumar@suse.de/T/#u

Thanks for info. I'm closing this as rejected. Please let me know if I did not
understand you and this is a valid patch.

Kind regards,
Petr

> Regards,
> Avinesh

> > Kind regards,
> > Petr

> > [1] https://lore.kernel.org/ltp/1934768.7Z3S40VBb9@localhost/






-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
