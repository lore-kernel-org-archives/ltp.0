Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37794C4332F
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 12:08:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CBD1B3CED75
	for <ltp@archiver.kernel.org>; Thu, 14 Dec 2023 13:08:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1890E3CB4DA
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 13:08:30 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A87961BD50D0
 for <ltp@lists.linux.it>; Thu, 14 Dec 2023 13:08:29 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 921DB21FD3;
 Thu, 14 Dec 2023 12:08:28 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3A488138F2;
 Thu, 14 Dec 2023 12:08:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 3aCTCzzwemXNbAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Thu, 14 Dec 2023 12:08:28 +0000
Date: Thu, 14 Dec 2023 13:08:26 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20231214120826.GA798106@pevik>
References: <20231211161807.526714-1-pvorel@suse.cz>
 <20231211161807.526714-3-pvorel@suse.cz> <ZXoC6LUE8ePDPRIU@rei>
 <20231213231115.GA768049@pevik> <ZXrN3frwGPiLZPgN@rei>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZXrN3frwGPiLZPgN@rei>
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 921DB21FD3
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] lib: Add support for TDEBUG tst_res() flag
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

...
> > > >  	{"h",  "-h       Prints this help"},
> > > >  	{"i:", "-i n     Execute test n times"},
> > > >  	{"I:", "-I x     Execute test for n seconds"},
> > > > +	{"v",  "-v       Prints debug information"},

> > > Maybe this should now be called -d since we call it TDEBUG and that will
> > > avoid having a bit confusing parameters with both -v and -V used.

> > Yes, I didn't like the flag name does not correspond to the option.
> > I previously wrote that more tests use -d for something else:

> > $ git grep '"d:"' $(git grep -l tst_option)
> > testcases/kernel/fs/read_all/read_all.c:                {"d:", &root_dir,
> > testcases/kernel/io/ltp-aiodio/aio-stress.c:            { "d:", &str_depth, "Number of pending aio requests for each file (default 64)" },
> > testcases/network/netstress/netstress.c:                {"d:", &rpath, "Path to file where result is saved"},
> > testcases/network/nfs/nfs_stress/nfs05_make_tree.c:     {"d:", &d_arg, "Number of subdirs to generate, default: 100"},
> > testcases/network/stress/route/route-change-netlink.c:          {"d:", &d_opt, "Interface to work on (mandatory)"},

> > Hopefully all could be changed to -D in separate commits.

> Or we can use -D for TDEBUG. I suppose that we use -V for version for
> the same reason.

Good point, thanks! -D is still used, but in less C tests.

$ git grep '"D:"' $(git grep -l tst_option)
testcases/kernel/syscalls/ioctl/ioctl02.c:              {"D:", &device, "Tty device. For example, /dev/tty[0-9]"},
testcases/network/can/filter-tests/can_filter.c:                {"D:", &can_dev_name, "CAN device name"},
testcases/network/can/filter-tests/can_rcv_own_msgs.c:          {"D:", &can_dev_name, "CAN device name"},
testcases/network/netstress/netstress.c:                {"D:", &dev, "Bind to device x"},

But at least -D is not used in shell.
$ git grep "TST_OPTS=.*D"

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
