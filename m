Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90AB8C64EC4
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 11:48:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1EC633CD80A
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 12:48:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE5C73C2A67
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 12:47:50 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 523731000F67
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 12:47:49 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 46BF02293F;
 Fri, 10 Mar 2023 11:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678448869;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gXRe6knkwlDWiipwQQWgYsYXsolMhUX2cIRyJrI2QM0=;
 b=QLLxZ5nvYyyyYZYTy/vBRx5WMuD9R/RAEeKo4XUa6mLM/UMlae5Uati9OZRglcPqUHnVWG
 1aLa/3Tfq+4KGmR3D/c+F/0zy7ikQPPN0br47y9sANb6SKnPTrMPbgI9PS/krQoaEBqAx3
 4BOePRfQx5bxw/V6fF4CYXSuIJfxpGw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678448869;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gXRe6knkwlDWiipwQQWgYsYXsolMhUX2cIRyJrI2QM0=;
 b=+q2gKL/sZi0RuPiZZZpJPqO9ePQzrYyombbJX/MxDsR45CxVzqrVD8oQ3pEjOSd3JkHEvT
 7Pk4JrugaFQwwDCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 197D4134F7;
 Fri, 10 Mar 2023 11:47:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id qljcBOUYC2RCCAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 10 Mar 2023 11:47:49 +0000
Date: Fri, 10 Mar 2023 12:47:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "Bird, Tim" <Tim.Bird@sony.com>, "ltp@lists.linux.it" <ltp@lists.linux.it>
Message-ID: <20230310114747.GA5055@pevik>
References: <20230309145917.26846-1-pvorel@suse.cz>
 <BYAPR13MB2503F6AE85D17F078B806C0AFDBA9@BYAPR13MB2503.namprd13.prod.outlook.com>
 <20230310073406.GB2216@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230310073406.GB2216@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
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
Cc: Matus Marhefka <mmarhefk@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Hi Tim,

> > > +++ b/testcases/kernel/containers/share/ns_ifmove.c
> > > @@ -1,43 +1,31 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later

> > I don't see "or later" anywhere in the license header that was removed.

> > Is this the correct SPDX license identifier?
> > Maybe it should be 'GPL-2.0-only'
> Good catch, thank you!

FYI I contacted Matus Marhefka privately and got his ack:

	I am not on that mailing list anymore. Anyway, feel free to re-license any
	of my tests to GPL-v2+, you have my agreement :)

=> going to use the original version.

Kind regards,
Petr

> Kind regards,
> Petr

> >  -- Tim

> > >  /* Copyright (c) 2015 Red Hat, Inc.
> > > - *
> > > - * This program is free software: you can redistribute it and/or modify
> > > - * it under the terms of version 2 the GNU General Public License as
> > > - * published by the Free Software Foundation.
> > > - *
> > > - * This program is distributed in the hope that it will be useful,
> > > - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > - * GNU General Public License for more details.
> > > - *
> > > - * You should have received a copy of the GNU General Public License
> > > - * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> > > - *
> > > + * Copyright (c) Linux Test Project, 2015-2022
> > > + * Copyright (c) 2023 Petr Vorel <pvorel@suse.cz>
> > >   * Written by Matus Marhefka <mmarhefk@redhat.com>
> > > + */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
