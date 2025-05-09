Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86286C3ABBC
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 10:01:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C3D6A3CC1C9
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 12:01:24 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D11E13CA013
 for <ltp@lists.linux.it>; Fri,  9 May 2025 12:01:07 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3BCAE2002B5
 for <ltp@lists.linux.it>; Fri,  9 May 2025 12:01:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B025D21167;
 Fri,  9 May 2025 10:01:05 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A09DF1399F;
 Fri,  9 May 2025 10:01:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FkAdJmHSHWg5eAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 09 May 2025 10:01:05 +0000
Date: Fri, 9 May 2025 12:01:47 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <aB3Si02rxzhhZYFv@yuki.lan>
References: <20250505105310.15072-1-mdoucha@suse.cz>
 <aBts4kDaqLKLJUuw@yuki.lan>
 <3ff8ee4c-881a-435d-a416-8bd32c35a17e@suse.cz>
 <aB3JFz8PK2okhULz@yuki.lan>
 <f3cbed38-82b1-45e3-b037-a943f9956ae8@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f3cbed38-82b1-45e3-b037-a943f9956ae8@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: B025D21167
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] memcontrol03: Account for process size in cgroup
 allocation
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
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> >>> Here we depend on the fact that process memory has been properly
> >>> accounted for when it starts running its code. Are you sure that we can
> >>> rely on this or does this just happen to work?
> >>
> >> Actually, my commit message is slightly misleading because the existing
> >> process memory does not get migrated to the new cgroup. But the cgroup
> >> itself may already have non-zero memory usage even when empty, likely
> >> for internal kernel structures. Any new allocations of kernel structures
> >> should also be finished when the process migration completes. So unless
> >> the migration behavior changes in the near future, we can rely on this.
> > 
> > I suppose that the cgroup is charged for the memory it needs to track
> > the resources, that makes sense. I wonder if we can read that once at
> > the start of the test when we create the cgroups and use that value
> > later on.
> 
> Unfortunately, we can't. I've tested this and memory.current can change 
> a lot during the first process migration.

That does sound strange. @Michal any idea what happens here?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
