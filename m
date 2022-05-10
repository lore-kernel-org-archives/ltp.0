Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B10B2C433EF
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 05:23:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C9D0C3CA96A
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 07:23:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 341263CA93A
 for <ltp@lists.linux.it>; Tue, 10 May 2022 07:23:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0003060069D
 for <ltp@lists.linux.it>; Tue, 10 May 2022 07:23:31 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 15C961F9F8;
 Tue, 10 May 2022 05:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652160211;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yHN2M/LpoX08wn42WsWU93aSdbUOe3VjXjfYgeYn6AQ=;
 b=u8zypzEFwGF6/aFEU5FwKje56Jd6AVAdW3685fi5xO0iFELC4RQdj162dim7svAqBY4MmZ
 xiXDGRaSQmpdlVzM+Ce7JRVZHCHMisdSAE7cM9ii7o6VaqEo3pBi6V4SnU22rh75DgxDWr
 rjylFfrdY7CuhC2r/OUqkfwbjjJMzSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652160211;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yHN2M/LpoX08wn42WsWU93aSdbUOe3VjXjfYgeYn6AQ=;
 b=9fDF23OwsvFtPgBAqiZUfCSpoUMdK/NPLuR9OaVvTy03Bxt4CYO4QGfH3RCCi///v91qSf
 ejsdVyPr/KDflrCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CE78D13AA5;
 Tue, 10 May 2022 05:23:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DrjlMNL2eWLLRAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 May 2022 05:23:30 +0000
Date: Tue, 10 May 2022 07:23:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Ynn20aeavm2pvA3M@pevik>
References: <20220427125003.20815-1-pvorel@suse.cz>
 <20220427125003.20815-5-pvorel@suse.cz> <YnU0XII0YSf0CUnb@yuki>
 <d4552f0b-9f73-ec2b-0c81-3d86eeb36fc1@suse.cz>
 <Ynkftw55rbyVFXb0@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ynkftw55rbyVFXb0@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 4/5] tst_test.sh: Cleanup getopts usage
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

> Hi!
> > >> +. netns_helper.sh
> > >> +
> > >> +PROG=$1
> > >> +IP_VER=$2
> > >> +COM_TYPE=$3

> > > Can't we just keep these at the top along with the rest of the
> > > variables? I do not see them redefined anywhere but maybe I miss
> > > something.

> > tst_test.sh has to process command line arguments before these variables
> > can be set. Otherwise you'd have to put all command line switches
> > *AFTER* the positional arguments.

> I did sleep on this and I guess that the cleanest solution for this is
> to pass the positional arguments to the test setup function instead.
> What do you think?

Sure. That's what I already did in "[v2,3/3] netns: Rewrite to use tst_net.sh"
[1]. That's why I didn't care in this patchset. I plan to send rebased "shell:
Fixes for disabled IPv6" patchset today or tomorrow.

Kind regards,
Petr

[1] https://patchwork.ozlabs.org/project/ltp/patch/20220204194648.32165-4-pvorel@suse.cz/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
