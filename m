Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5766CC87FCB
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 11:46:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C7A593CB50C
	for <ltp@archiver.kernel.org>; Tue, 12 Aug 2025 13:46:08 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7AA383C06B5
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 13:45:52 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5127B60029C
 for <ltp@lists.linux.it>; Tue, 12 Aug 2025 13:45:50 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C47DE1F6E6;
 Tue, 12 Aug 2025 11:45:49 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8911136C7;
 Tue, 12 Aug 2025 11:45:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id frS3J20pm2jjHwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Aug 2025 11:45:49 +0000
Date: Tue, 12 Aug 2025 13:45:40 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250812114540.GC843668@pevik>
References: <20250812-cve_2025_38236-v1-1-e3617ada69c6@suse.com>
 <20250812101237.GA835467@pevik> <aJsg11G8hOAqoGkw@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aJsg11G8hOAqoGkw@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: C47DE1F6E6
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [doc,
 runtest] [was: Re:  [PATCH] cve: add CVE-2025-38236 test]
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

Hi Cyril, all,

> Hi!
> > >  testcases/cve/.gitignore       |   1 +
> > >  testcases/cve/cve-2025-38236.c | 101 +++++++++++++++++++++++++++++++++++++++++

> > File not added into runtest/cve.

> > Maybe we need to enhance 'make check' to check this via 'git grep'.

> > checkpatch.pl looks into resulted file, IMHO we have no tool to check the patch
> > itself. But maybe enhance b4 (kind of plugin) to check this :).

> Or we can genereate the cve runtest file. It should be possible to build
> it from the metadata during the build.

This problem happen on all runtest files, fixing just one does not fix the
problem.

Sure, it'd be possible to generate runtest/cve from metadata. Do we really want
to implement it? (I can create a ticket). I guess we would use C and ujson to
not require json-c or python3 for building LTP.

I would be more interested to have section "CVE reproducers" in Statistics page [1].
While the same tool could be used to do both goals, when only doc page
implemented, it could be easily done in python3 (doc/conf.py already parses
ltp.json).

When we are at Statistics page, also generating list of reproducers (based on
kernel fixes) would be also nice. Because this was implemented in the previous
asciidoctor implementation. How about having these lists Statistics, where are
other tables already (and linking each test to "Test Catalog")?

Also I find "Statistics" name confusing. It says nothing about the content. I
wonder if people curiously click on the page or just ignore the page (if they
don't like math :)). Maybe "Kernel coverage" or something like that would be
more informative.

Kind regards,
Petr

[1] https://linux-test-project.readthedocs.io/en/latest/users/stats.html

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
