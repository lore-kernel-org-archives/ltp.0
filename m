Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A141C433F5
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 17:27:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E43413C93AC
	for <ltp@archiver.kernel.org>; Mon, 10 Jan 2022 18:27:30 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CAC563C042E
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 18:27:20 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8A61E653A63
 for <ltp@lists.linux.it>; Mon, 10 Jan 2022 18:27:19 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 864541F383;
 Mon, 10 Jan 2022 17:27:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1641835638;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QMe9ecP9kjQe1zasPYnpGKZNZJveC9azz8hzXaiWqsc=;
 b=ta+2AsdnowSvdRlpuIKoPJ/m4xBaLIrIVNdlpIAYRtDYVq0Km3T6tivcNImgzLqMfQijyb
 0kQ7IxE4T+J5PAA44bl4WrATdf8Dc3zdGuBHG8y7U0BpBSZgnvosndHe3vu/uQ8TChKk33
 Pwkgs4xLU6oFCmiy771+6W9yJzCMWx8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1641835638;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QMe9ecP9kjQe1zasPYnpGKZNZJveC9azz8hzXaiWqsc=;
 b=kYpCEETtuWAeMeE5xXACVnuTKI4xw70qh9Y4L3aufETZXEZBC7xI02WMDZ+/6ys6Nj4jii
 tQuIIPSyjpQ3UAAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5798813DC2;
 Mon, 10 Jan 2022 17:27:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id p1/IE3Zs3GFGQQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 10 Jan 2022 17:27:18 +0000
Date: Mon, 10 Jan 2022 18:27:16 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YdxsdDctFxoWI4E5@pevik>
References: <20211213132339.22770-1-pvorel@suse.cz>
 <YdxOS6zEp3KwY63X@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YdxOS6zEp3KwY63X@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] chdir01.c: Fix on enabled FIPS
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

Hi Cyril,

> Hi!
> > which causes 0 permission for user and group.

> This could be a bit more verbose.
I'll put more info.

...
> > -	if (tc->nobody_err == EACCES && skip_blocked) {
> > +	/* FIPS mode disables umask efect for group or other */
> > +	if (!(blocked_perm & S_IRGRP) && strcmp(tc->name, "/") != 0) {

> So on FIPS the directories we create have zeroed group and other flags
> regardless of the umask? Or is this just a different default umask on
> FIPS? If it's just different umask the easiest solution would be
> changing the umask in the test setup.
Thanks! It's really just different umask, 0077 (where group umask is important).

Kind regards,
Petr

> And if it's regardless of umask settings shouldn't this rather be:

> 	if (tst_fips_enabled() && !strcmp(tc->name, "/"))



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
