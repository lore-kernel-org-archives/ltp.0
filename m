Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B5A2C02181
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 12:28:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 668113C2F72
	for <ltp@archiver.kernel.org>; Wed, 22 Jan 2025 13:28:32 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EF5CF3C2BC2
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 13:28:16 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 493D91BD33FE
 for <ltp@lists.linux.it>; Wed, 22 Jan 2025 13:28:14 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3FC0C216E0;
 Wed, 22 Jan 2025 12:28:14 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2EFFE136A1;
 Wed, 22 Jan 2025 12:28:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LFhwC17kkGdqPgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 22 Jan 2025 12:28:14 +0000
Date: Wed, 22 Jan 2025 13:28:00 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Sven Schnelle <svens@linux.ibm.com>
Message-ID: <Z5DkUNyjq9x-jY7v@yuki.lan>
References: <20250122100915.3126008-1-svens@linux.ibm.com>
 <20250122102648.GA29598@pevik> <Z5DQFuQiIAGAqtK4@yuki.lan>
 <yt9da5bj6o7f.fsf@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <yt9da5bj6o7f.fsf@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 3FC0C216E0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap01: initialize buffer in check_file()
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >> > mmap01 reported random test failures. Turns out the
> >> > the temporary buffer in check_file() isn't initialized.
> >> > The SAFE_READ reads less then sizeof(buf) bytes so the
> >> > rest stays initialized and might contain bytes check_file()
> >> > is looking for.
> >> 
> >> Looks reasonable to me.
> >> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> >> 
> >> @Cyril a candidate for merge before the release.
> >
> > Alternatively we could use the return value from the SAFE_READ() instead
> > of the buf_len. Also I suppose that we could check that we read at least
> > something.
> 
> I wonder whether a check that strlen(STRING) bytes was read is
> sufficient, and if it's more just FAIL the test? My understanding of the
> test is that the data written beyond file's end isn't yet synced, so
> if we can read more bytes that would already be an error?

I would say yes, but it does not hurt to keep the check that the file
data were not corrupted by the write after the file end. So maybe we
just need to:

1. check that we read right size
2. check that the buffer has correct bytes

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
