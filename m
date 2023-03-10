Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807FAC64EC4
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 07:34:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 351753CB842
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 08:34:22 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 414F33C2A67
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 08:34:12 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 40CDC200DC5
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 08:34:08 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7C74722363;
 Fri, 10 Mar 2023 07:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678433648;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D7uUdxr5T69z0EAqpIm8ocI+9mq0CKEmfgj92Iw58rI=;
 b=SQagF58Pv+1jWcPcmr4bKmf3kAuiXiSLp7i0lx9jrus79Eja0KcLAs2WtF8mdM9Y4GklhH
 WXKkXa/vBVoASzHgSDbFHIXbvi/WlHkf5jniDzAsHsGYNL4fY6eomTnrKW5dcsW6AhtjQD
 wQTinTg43aku8JXbDFMI++KC9DzNmoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678433648;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=D7uUdxr5T69z0EAqpIm8ocI+9mq0CKEmfgj92Iw58rI=;
 b=qe5BHz45WWib5Bhe5Pvau1ogT6He1kKxaNooq7RvvqcK303Yf9ENhSEULOyEr+4aZ32WAt
 08jZlwLCnGUkCaBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5571C13A77;
 Fri, 10 Mar 2023 07:34:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id pHxLE3DdCmRHAgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 10 Mar 2023 07:34:08 +0000
Date: Fri, 10 Mar 2023 08:34:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Bird, Tim" <Tim.Bird@sony.com>
Message-ID: <20230310073406.GB2216@pevik>
References: <20230309145917.26846-1-pvorel@suse.cz>
 <BYAPR13MB2503F6AE85D17F078B806C0AFDBA9@BYAPR13MB2503.namprd13.prod.outlook.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <BYAPR13MB2503F6AE85D17F078B806C0AFDBA9@BYAPR13MB2503.namprd13.prod.outlook.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] ns_ifmove.c: Rewrite to new API
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Tim,

> > +++ b/testcases/kernel/containers/share/ns_ifmove.c
> > @@ -1,43 +1,31 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later

> I don't see "or later" anywhere in the license header that was removed.

> Is this the correct SPDX license identifier?
> Maybe it should be 'GPL-2.0-only'
Good catch, thank you!

Kind regards,
Petr

>  -- Tim

> >  /* Copyright (c) 2015 Red Hat, Inc.
> > - *
> > - * This program is free software: you can redistribute it and/or modify
> > - * it under the terms of version 2 the GNU General Public License as
> > - * published by the Free Software Foundation.
> > - *
> > - * This program is distributed in the hope that it will be useful,
> > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > - * GNU General Public License for more details.
> > - *
> > - * You should have received a copy of the GNU General Public License
> > - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > - *
> > + * Copyright (c) Linux Test Project, 2015-2022
> > + * Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
> >   * Written by Matus Marhefka <mmarhefk@redhat.com>
> > + */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
