Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893AFC433F5
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 22:39:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFF4F3C8B91
	for <ltp@archiver.kernel.org>; Fri, 19 Nov 2021 23:39:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 21F413C053E
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 23:39:26 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5C52E1A006F6
 for <ltp@lists.linux.it>; Fri, 19 Nov 2021 23:39:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 621911FD32;
 Fri, 19 Nov 2021 22:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637361565;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sZKQiLW0GBjSd5I99TiU3zoGy+TT/jaUvTzYZQ36Cw0=;
 b=mHsWkGZ1blMAYAzr0AzNzDCxSKrVYiOGxeSARhxFyYU8DWbq0OS3639YnqzSZnKwwf1q9z
 dWdIbI85865VrQ1SWCa03SQa8HPIRRleCPwqPmSulTTfN6C+BA7/Ls8E7zSzgDoFj3K7kz
 aOIXUiEMo/iX8kqhg5VNYIweF0dJi8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637361565;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sZKQiLW0GBjSd5I99TiU3zoGy+TT/jaUvTzYZQ36Cw0=;
 b=wzfxIhBBHMqSSOvbwtLpzfUCidSxA4rLF3R9oc1WzzSz+skTxdJB/q4vN+hdw9Tp28D2fx
 rVGU1e11Gdg16LAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 27E7213B53;
 Fri, 19 Nov 2021 22:39:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lxPxB50nmGFONQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 19 Nov 2021 22:39:25 +0000
Date: Fri, 19 Nov 2021 23:39:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>,
 Gabriel Krisman Bertazi <krisman@collabora.com>,
 Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.com>,
 Ext4 <linux-ext4@vger.kernel.org>, kernel@collabora.com,
 Khazhismel Kumykov <khazhy@google.com>, LTP List <ltp@lists.linux.it>
Message-ID: <YZgnm3XX6wGZA80L@pevik>
References: <20211118235744.802584-1-krisman@collabora.com>
 <20211118235744.802584-5-krisman@collabora.com>
 <CAOQ4uxjk8J48ASw2yJhd-OR2LVN6kirg7p6xQbX=xEofGYUghw@mail.gmail.com>
 <YZf6/YdyOUY8puWq@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YZf6/YdyOUY8puWq@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 4/9] syscalls/fanotify22: Validate the generic
 error info
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

> ...
> > > -AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header],,,[#include <sys/fanotify.h>])
> > > +AC_CHECK_TYPES([struct fanotify_event_info_fid, struct fanotify_event_info_header,
> > > +               struct fanotify_event_info_error],[],[],[#include <sys/fanotify.h>])

> > Doh! it seems like fanotify_event_info_pidfd was dropped between v2 ->
> > v3 in Matthew's patches.

> > Petr,

> > Can you please fix this.

> Hi Amir,

> thanks for info, sure I'll fix it on Monday.
Fixed now. Thanks!

Kind regards,
Petr

> Kind regards,
> Petr

> > Thanks,
> > Amir.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
