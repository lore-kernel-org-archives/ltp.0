Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C90CAC021A4
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 13:01:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1FEFB3C9AE9
	for <ltp@archiver.kernel.org>; Fri, 14 Feb 2025 14:01:50 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CE673C1AFC
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 14:01:32 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ipv4:195.135.223.131/32) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 66977622483
 for <ltp@lists.linux.it>; Fri, 14 Feb 2025 14:01:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A29992118B;
 Fri, 14 Feb 2025 13:01:31 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92D87137DB;
 Fri, 14 Feb 2025 13:01:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K3rKIqs+r2caAwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 14 Feb 2025 13:01:31 +0000
Date: Fri, 14 Feb 2025 14:01:33 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Rhythm Mahajan <rhythm.m.mahajan@oracle.com>
Message-ID: <Z68-rXnMHNi2LEY3@yuki.lan>
References: <BLAPR10MB53806691A64D8003A5D0FD5CBCFF2@BLAPR10MB5380.namprd10.prod.outlook.com>
 <40043b19-65a9-47b1-a759-4f1478d3faba@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <40043b19-65a9-47b1-a759-4f1478d3faba@oracle.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: A29992118B
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fcntl27 and fcntl27_64 tests fail on nfsv3& nfsv4 for
 mainline 6.14 kernels
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
Cc: "andrea.manzini@suse.com" <andrea.manzini@suse.com>,
 Darren Kenny <darren.kenny@oracle.com>,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > The test no longer fails with the revert of the commit
> >
> > cce93d3a3 Refactor with new API and merge fcntl27 + fcntl28
> >
> > https://github.com/linux-test-project/ltp/commit/cce93d3a3 <https://github.com/
> > linux-test-project/ltp/commit/cce93d3a3>
> >
> > Could you please confirm if this is a test case issue or a kernel issue?

Before the test cleanup it did only check if an attempt to set read
lease on a file opened for writing failed. Now the test checks that it
fails with a specific errno i.e. EAGAIN, since that is returned by the
rest of the filesystems.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
