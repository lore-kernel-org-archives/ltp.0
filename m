Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4EEC433F5
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 08:02:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DE76D3CA59C
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 10:02:41 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 42F8C3C8977
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 10:02:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C9BF460084C
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 10:02:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1A1281F388;
 Wed, 27 Apr 2022 08:02:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651046551;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GX6fLheIVL9ThdCjqeGwHaw6V8Kaw6Px+OwLrrexYas=;
 b=MqEDCJRdBSWJi1MkVy/aXdDUdTIBFhYSYnLUMVIAlWHV2gDP7aF096QwRzEQZvKx/wRcmu
 hs+gbRCtmEheAWWPspifHKQYrqZ1zlGY5Y+JaNWMvcLjAUe++C4Lr7RO+0NwNOm42McO+b
 7L/WNXb9T6mETDIyG8gEoPSoQluxdpE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651046551;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GX6fLheIVL9ThdCjqeGwHaw6V8Kaw6Px+OwLrrexYas=;
 b=sdC0SZDluB/Nnn8LQ7PYfIb06JzRvvswL0nxxYGbOnkXCkrvZUSuQBNoJ8fuoWPW9ZViH8
 E9iJBSJGy7GrZhAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EDAC51323E;
 Wed, 27 Apr 2022 08:02:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QihOOJb4aGJkOAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 27 Apr 2022 08:02:30 +0000
Date: Wed, 27 Apr 2022 10:02:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <Ymj4lRlPK4KAb9iC@pevik>
References: <20220422144141.16848-1-pvorel@suse.cz>
 <20220422144141.16848-2-pvorel@suse.cz>
 <d448fbda-cbfb-e954-f5de-f1aa02b5bfd0@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d448fbda-cbfb-e954-f5de-f1aa02b5bfd0@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/4] shell: Use conditional expansion for
 library setup/cleanup
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

Hi Martin,

> Hi,
> there are a few files where the only change is in the copyright comment.
> I'll leave it up to you whether you want to keep those changes or drop
> them.
Very good point, I'll remove these changes before merging.

> I've also added a suggestion for another improvement in a separate
> patchset below.
Thx!

> I've also run new tests on this patchset and everything seems to work.
> Overall:

> Reviewed-by: Martin Doucha <mdoucha@suse.cz>

Thanks a lot for testing and review!
...
> > +++ b/testcases/network/busy_poll/busy_poll_lib.sh
> > @@ -1,10 +1,11 @@
> >  #!/bin/sh
> >  # SPDX-License-Identifier: GPL-2.0-or-later
> >  # Copyright (c) 2016-2018 Oracle and/or its affiliates. All Rights Reserved.
> > +# Copyright (c) Linux Test Project, 2016-2022

> > -TST_SETUP="setup"
> >  TST_TESTFUNC="test"
> > -TST_CLEANUP="cleanup"
> > +TST_SETUP="${TST_SETUP:-setup}"
> > +TST_CLEANUP="${TST_CLEANUP:-cleanup}"

> The setup() and cleanup() functions here should get a prefix, otherwise
> we're asking for duplicate definitions. But that can be added in a
> separate patchset.

Very good point, thx! Yes, I'll send it as a separate patch.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
