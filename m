Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6A0C4332F
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 11:19:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B610F3CA95A
	for <ltp@archiver.kernel.org>; Tue, 10 May 2022 13:19:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5D9513CA600
 for <ltp@lists.linux.it>; Tue, 10 May 2022 13:19:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D3049600760
 for <ltp@lists.linux.it>; Tue, 10 May 2022 13:19:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D1D2521B75;
 Tue, 10 May 2022 11:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652181579;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+zemE8dYCf7V7StNpe0fDcBIj/3Ts0rgT4Qyc09QM1g=;
 b=OIAo/dYCMG/bdKVQxeYgFvoczjZZCRfILujnxTZ48a3S5aOiLvNMQ4bn5T3LRe0slryTJf
 taw4i/GrQfkWUwDf1l4MZQRsUZKGaYojCWpGWJgPdBgr/q6H4/OhzgRdnyG+jsMDNgNHgR
 bbq6FmdEa+vCICWlZNYRvW97plkCB2k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652181579;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+zemE8dYCf7V7StNpe0fDcBIj/3Ts0rgT4Qyc09QM1g=;
 b=yYUDizOzwU/1ER6ycbhhvAfIfI4kqn2YNaUX4P/liRNB7i1MaJ0iUMkexRkWtkbvTWh7eQ
 RtUjRzeyu8o7wwBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 90B1413AA5;
 Tue, 10 May 2022 11:19:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id +2V7IUtKemKhZgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 10 May 2022 11:19:39 +0000
Date: Tue, 10 May 2022 13:19:37 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YnpKSTal7IG3jtAx@pevik>
References: <cover.1651176645.git.luke.nowakowskikrijger@canonical.com>
 <3d85635f6b87c73a2389627bc94c847c52165dc7.1651176646.git.luke.nowakowskikrijger@canonical.com>
 <YnOH4h8rTbg1NzCO@pevik> <YnPW0gfMAUGZYPSM@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YnPW0gfMAUGZYPSM@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 11/19] controllers: Expand cgroup_lib shell
 library
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
Cc: ltp@lists.linux.it,
 Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Luke, Cyril,

> Hi!
> > > +_cgroup_check_return()
> > > +{
> > > +	local ret="$1"
> > > +	local msg="$2"
> > > +
> > > +	tst_flag2mask TBROK
> > > +	[ "$ret" = "$?" ] && tst_brk TBROK "$msg"
> > > +
> > > +	tst_flag2mask TCONF
> > > +	[ "$ret" = "$?" ] && tst_brk TCONF "$msg"
> > > +}
> > As I wrote in previous patch likely we can avoid tst_flag2mask in new API.

> > In few cases where needed we hardwired numbers (IMHO POSIX shell does not
> > support constants, which would be better than variables which can be changed).

> > In this case you could probably use ROD() or EXPECT_PASS_BRK().

> Or we can just passthrough the result, as long as it's non-zero we can
> do exit $ret and be done with it.
+1 (that would suggest to use ROD)

Please, rebase the code for new version. You'll have to for cgroup_lib.sh put
'. tst_test.sh' to the end and also '. cgroup_lib.sh' in the tests also at the
end - required by 04021637f ("tst_test.sh: Cleanup getopts usage").

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
