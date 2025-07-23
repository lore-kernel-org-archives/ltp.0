Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4140C83F17
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 12:42:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6CA9B3CCD7F
	for <ltp@archiver.kernel.org>; Wed, 23 Jul 2025 14:42:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AA4BD3CCD68
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 14:41:31 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0CCAF14004F5
 for <ltp@lists.linux.it>; Wed, 23 Jul 2025 14:41:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6CD0F21223;
 Wed, 23 Jul 2025 12:41:29 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3C4CA13302;
 Wed, 23 Jul 2025 12:41:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KOvADXnYgGitEgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 23 Jul 2025 12:41:29 +0000
Date: Wed, 23 Jul 2025 14:41:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250723124127.GA154226@pevik>
References: <20250722-xattr_bug_repr-v4-0-4be1e52e97c6@suse.com>
 <20250722-xattr_bug_repr-v4-1-4be1e52e97c6@suse.com>
 <20250722120635.GB22975@pevik>
 <a911cbc1-ad7e-4b0e-97f0-4e2c594c7084@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a911cbc1-ad7e-4b0e-97f0-4e2c594c7084@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 TAGGED_RCPT(0.00)[]
X-Rspamd-Queue-Id: 6CD0F21223
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] core: add tst_selinux_enabled() utility
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
Cc: Stephen Smalley <stephen.smalley.work@gmail.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> On 7/22/25 2:06 PM, Petr Vorel wrote:
> > +++ lib/tst_security.c
> > @@ -107,7 +107,7 @@ int tst_selinux_enabled(void)
> >   {
> >   	int res = 0;
> > -	if (tst_is_mounted(SELINUX_PATH))
> > +	if (access(SELINUX_STATUS_PATH, F_OK) == 0)
> >   		res = 1;
> >   	tst_res(TINFO, "SELinux enabled: %s", res ? "yes" : "no");

> This is more or less what I was doing at the beginning, but Cyril suggested
> this approach which is more similar to libselinux. Please, check v3.

Sure :). FYI I did check v3 before replying to v4 (I always try to get to the
context looking into older versions, I also noted v3 in one of my replies :)).

And yes, I think you were right, that's why I raised my concern again.

But ok, to quote it here Cyril's reply in v3:
https://lore.kernel.org/ltp/aG5v6enhdqFGgiBj@yuki.lan/

	> +	if (access(SELINUX_PATH, F_OK) == 0 && !tst_dir_is_empty(SELINUX_PATH, 0))
	> +		res = 1;

	Maybe we we can do tst_is_mounted(SELINUX_PATH) here instead. At least
	that seems to be what is_selinux_enabled() seems to be doing.
---

Enabled SELinux means both /sys/fs/selinux/enforce and mounted /sys/fs/selinux/.
I even checked to boot kernel with SELinux compiled in but disabled in the
command line via 'security=selinux selinux=0 enforcing=0' and the result is
expected: no /sys/fs/selinux directory.

Both ways of checking are OK, just "access(SELINUX_STATUS_PATH, F_OK) == 0" is
the quickest way (given test requires just SELinux enabled, not enforcing mode).

This can be changed before merge. Or, feel free to keep the original version as
it also works.

Kind regards,
Petr

> - Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
