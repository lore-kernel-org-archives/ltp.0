Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B83B71076370
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 06:02:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E93D73E2F67
	for <ltp@archiver.kernel.org>; Wed,  1 Apr 2026 08:02:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C2E43E2A32
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 08:01:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 077252010FD
 for <ltp@lists.linux.it>; Wed,  1 Apr 2026 08:01:51 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 430BB4D1E2;
 Wed,  1 Apr 2026 06:01:51 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F30B4A0B0;
 Wed,  1 Apr 2026 06:01:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XNhtCs+0zGnnbwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 01 Apr 2026 06:01:51 +0000
Date: Wed, 1 Apr 2026 08:01:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo Branco <rbranco@suse.de>
Message-ID: <20260401060149.GA121545@pevik>
References: <20260330185759.398559-1-rbranco@suse.de>
 <20260331101800.GA40946@pevik>
 <e24009c4-8563-4f3f-9ad2-a05c5c35e861@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e24009c4-8563-4f3f-9ad2-a05c5c35e861@suse.de>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 430BB4D1E2
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] userfaultfd: Add new test using UFFDIO_CONTINUE
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

Hi Ricardo,

> On 3/31/26 12:18 PM, Petr Vorel wrote:
> > Maybe SAFE_SYSCONF(_SC_PAGE_SIZE) or because it should be safe:
> > getpagesize();

> Opted for SAFE_SYSCONF as getpagesize() returns int.
+1

> > > +	}
> > > +
> > > +	if (uffd != -1) {
> > > +		SAFE_CLOSE(uffd);
> > > +		uffd = -1;
> > And here.

> Andrea pointed me to this LLM suggestion that got it wrong:
> https://github.com/acerv/ltp-agent/actions/runs/23788068990

> It's a cool thing that we're reviewing code that I used as template
> to fix the userfaultfd tests in the other PR with fixes.

Yeah, I already asked him yesterday to teach agent to have look into includes as
well :).

Kind regards,
Petr

> Best,
> Ricardo.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
