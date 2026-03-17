Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCFBFF6E9A
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 23:02:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E61963E6267
	for <ltp@archiver.kernel.org>; Wed, 18 Mar 2026 00:01:58 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 712843D0343
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 00:01:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D63D860095D
 for <ltp@lists.linux.it>; Wed, 18 Mar 2026 00:01:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 55E804D36C;
 Tue, 17 Mar 2026 23:01:40 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 357B44273B;
 Tue, 17 Mar 2026 23:01:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q6bKC1TduWnJDAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 17 Mar 2026 23:01:40 +0000
Date: Wed, 18 Mar 2026 00:01:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260317230137.GB371512@pevik>
References: <20260316122725.122719-3-japo@linux.ibm.com>
 <69b9505b.050a0220.133478.afd0@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <69b9505b.050a0220.133478.afd0@mx.google.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 55E804D36C
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:32098, ipnet:2800::/6, country:US]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/2] setxattr02: Adapt test for kernel 7.1.0+
 socket xattr support
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Hi!

> Sorry for jumping in a bit late, but...

> > +static bool socket_xattr_supported;
> > +
> >  struct test_case {
> >  	char *key;
> > @@ -57,7 +60,16 @@ struct test_case {
> >  	int flags;
> >  	int exp_err;
> >  	int needskeyset;
> > +	void (*fix_errno)(struct test_case *tc);

> Honestly I would have preferred a bool flag here instead of a function.
> The code would have been more readable as:

> static void verify_setxattr(unsigned int i)
> {
> ..
>     if (tc[i].check_xattr && socket_xattr_supported)
>         tc->exp_err = 0;
> ..
> }

> And only 1 testcase would have been touched with `.check_xattr = 1`.

OK, this is slightly simpler.

> Also, please, always run `make check` before sending the patch. There are a
> couple of issues to fix in the test description.

> Same for the other patch.

I wonder what error you mean. Modified tests are ok:

$ make check-setxattr02
CHECK testcases/kernel/syscalls/setxattr/setxattr02.c

$ make check-fsetxattr02
CHECK testcases/kernel/syscalls/fsetxattr/fsetxattr02.c

Also, I'm not aware that make check would check test description
(I guess it'd be part of checkpatch.pl check, but still no idea).

Kind regards,
Petr

> Regards,

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
