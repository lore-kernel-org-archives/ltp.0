Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274EDCD5850
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 10:38:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B87FD3C2F97
	for <ltp@archiver.kernel.org>; Wed,  7 Jan 2026 11:38:47 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86A073C298C
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 11:38:29 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id CDDDE600661
 for <ltp@lists.linux.it>; Wed,  7 Jan 2026 11:38:28 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1158233C0B;
 Wed,  7 Jan 2026 10:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767782308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PBsyxLEAVdHDfmOZx9BQR1Vf4cKRyKxhzMLxo/Nnc4s=;
 b=fw1MRxvcIdax+/iF4OsG1CO6y15GBaoApqrG1u6MhZUnBzGIEnELqMbzRf4x3LZLSARChy
 JBpLFOGsVjOCcf4YuurVguBh9Sb9mheUAwvoV9D0GSLdD2nwJCn3yjuCIPJr9d14bCKzbp
 s0V/HlD8QD9MOedyd60bVPKivl5iS/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767782308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PBsyxLEAVdHDfmOZx9BQR1Vf4cKRyKxhzMLxo/Nnc4s=;
 b=YCOOwH/bs73rilInSQicQp0xUHr9O8L5SYLvXt+O7u+sVkfYaVQJIF8e/ewJJMpwihydZR
 fOaRA0NB6P9xAHAQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=fw1MRxvc;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="YCOOwH/b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767782308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PBsyxLEAVdHDfmOZx9BQR1Vf4cKRyKxhzMLxo/Nnc4s=;
 b=fw1MRxvcIdax+/iF4OsG1CO6y15GBaoApqrG1u6MhZUnBzGIEnELqMbzRf4x3LZLSARChy
 JBpLFOGsVjOCcf4YuurVguBh9Sb9mheUAwvoV9D0GSLdD2nwJCn3yjuCIPJr9d14bCKzbp
 s0V/HlD8QD9MOedyd60bVPKivl5iS/M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767782308;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PBsyxLEAVdHDfmOZx9BQR1Vf4cKRyKxhzMLxo/Nnc4s=;
 b=YCOOwH/bs73rilInSQicQp0xUHr9O8L5SYLvXt+O7u+sVkfYaVQJIF8e/ewJJMpwihydZR
 fOaRA0NB6P9xAHAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EEE2B3EA63;
 Wed,  7 Jan 2026 10:38:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id DtLGOKM3XmndYAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 07 Jan 2026 10:38:27 +0000
Date: Wed, 7 Jan 2026 11:38:22 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Message-ID: <20260107103822.GA753482@pevik>
References: <20260102115147.2256900-1-po-hsu.lin@canonical.com>
 <20260106120447.GB712536@pevik>
 <CAMy_GT-hM3d=hwF8+e6H85Y4zN3PKH=XFAWCZDLFLc4pUEXpGg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAMy_GT-hM3d=hwF8+e6H85Y4zN3PKH=XFAWCZDLFLc4pUEXpGg@mail.gmail.com>
X-Rspamd-Queue-Id: 1158233C0B
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] listmount04.c: update struct mnt_id_req support
 to kernel >= 6.17
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

...
> > > -     if (tst_kvercmp(6, 18, 0) >= 0)
> > > -             kver = AFTER_6_18;
> > > +     if (tst_kvercmp(6, 17, 0) >= 0)

> > Shouldn't we match 6.17.9 then?
> > It's not about the fix but about a kernel change.

> > Hi Petr,
> thanks for the feedback,
> in this case should I also modify the macros to BEFORE_6_17_9 and
> AFTER_6_17_9?

Yes, probably the best will be to use BEFORE_6_17_9 and put a comment that
78f0e33cd6c93 ("fs/namespace: correctly handle errors > > > returned by grab_requested_mnt_ns")
from 6.18 was backported to 6.17.9.

Thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
