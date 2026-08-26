Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72B67C5DF97
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 06:16:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6629D3CBF08
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 08:16:28 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7B23A3C9EB4
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 08:16:11 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6A597200994
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 08:16:11 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 185A18730E;
 Wed, 26 Aug 2026 06:16:10 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E72FC13354;
 Wed, 26 Aug 2026 06:16:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xIYnN6mEjmoHLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 26 Aug 2026 06:16:09 +0000
Date: Wed, 26 Aug 2026 08:16:08 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Mimi Zohar <zohar@linux.ibm.com>
Message-ID: <20260826061608.GA26757@pevik>
References: <20260821200620.902699-1-zohar@linux.ibm.com>
 <20260821202613.4033-1-linuxtestproject.agent@gmail.com>
 <20260825044433.GB22725@pevik>
 <8564c18ee78ca4f308dc0b7f48ac2f63b295ee00.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8564c18ee78ca4f308dc0b7f48ac2f63b295ee00.camel@linux.ibm.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 185A18730E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] ima_selinux.sh: test2 assumes CONFIG_IMA_DISABLE_HTABLE
 is configured
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

Hi Mimi,

> Hi Petr.

> On Tue, 2026-08-25 at 06:44 +0200, Petr Vorel wrote:
> [...]
> > > On August 21, 2026, Mimi Zohar wrote:
> > > > ima_selinux.sh: test2 assumes CONFIG_IMA_DISABLE_HTABLE is configured

> > > > +		if ! tst_check_kconfigs "CONFIG_IMA_DISABLE_HTABLE=y"; then
> > > > +			tst_res TPASS "Duplicate \"selinux-state\" record missing (CONFIG_IMA_DISABLE_HTABLE not set)"

> > I would suggest the same, it makes sense to use TCONF to make it visible that
> > it's not an error but OTOH it was not actually tested due
> > CONFIG_IMA_DISABLE_HTABLE not set. If you don't mind, I'd change TPASS to TCONF
> > before merge (or feel free to send v2 with this change yourself with my
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>
> > ).

> > Thanks for the fix!

> Agreed, it should be TCONF.  Please make the change.

Thanks for your ack, merged with TCONF.

Kind regards,
Petr

> thanks,

> Mimi

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
