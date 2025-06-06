Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1261C5AD49
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 12:33:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 358903CA5CB
	for <ltp@archiver.kernel.org>; Fri,  6 Jun 2025 14:33:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C17403C2205
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 14:33:18 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B8FAC6000FC
 for <ltp@lists.linux.it>; Fri,  6 Jun 2025 14:33:17 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BAE111F8BE;
 Fri,  6 Jun 2025 12:33:16 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B49F1369F;
 Fri,  6 Jun 2025 12:33:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id V3efJAzgQmhYZQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 06 Jun 2025 12:33:16 +0000
Date: Fri, 6 Jun 2025 14:33:15 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250606123315.GA1306605@pevik>
References: <20250605-conversions-mknod-v5-0-0b5cff90c21c@suse.com>
 <20250605-conversions-mknod-v5-3-0b5cff90c21c@suse.com>
 <20250606114953.GE1289709@pevik>
 <DAFFK4OBLBWY.3VACS2RP961A8@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DAFFK4OBLBWY.3VACS2RP961A8@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: BAE111F8BE
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 3/8] syscalls/mknod03: Convert to new API
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

Hi Ricardo,

> On Fri Jun 6, 2025 at 8:49 AM -03, Petr Vorel wrote:
> > Hi Ricardo,

> >>  testcases/kernel/syscalls/mknod/mknod03.c | 313 ++++--------------------------
> >>  1 file changed, 39 insertions(+), 274 deletions(-)

> >> diff --git a/testcases/kernel/syscalls/mknod/mknod03.c b/testcases/kernel/syscalls/mknod/mknod03.c
> >> index 7ecadb5b37c3ab7eded90aa8a6d1e27f07236b1f..00a6133f7a15c1dd9c9e67ba08315f218f16d0d6 100644
> >> --- a/testcases/kernel/syscalls/mknod/mknod03.c
> >> +++ b/testcases/kernel/syscalls/mknod/mknod03.c
> >> @@ -1,296 +1,61 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> > nit: This should be v2+

> > // SPDX-License-Identifier: GPL-2.0-or-later

> Weird, I have that as a snippet but must have copied from another file
> on that occasion.

Although the default license for new files is GPL-2.0-or-later,
unfortunately it can be taken as a default when rewriting the file.
We had a lovely lawsuits with some companies, that's why it's also good to pay
attention to the license.

Anyway, thank you for your work, merged with this change.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
