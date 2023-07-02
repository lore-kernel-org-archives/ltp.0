Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C43AEB64D9
	for <ltp@archiver.kernel.org>; Sun,  2 Jul 2023 19:18:34 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9259F3CC268
	for <ltp@archiver.kernel.org>; Sun,  2 Jul 2023 21:18:31 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7792B3CC258
 for <ltp@lists.linux.it>; Sun,  2 Jul 2023 21:18:16 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CB35614001F7
 for <ltp@lists.linux.it>; Sun,  2 Jul 2023 21:18:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 89F7E21885;
 Sun,  2 Jul 2023 19:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1688325494;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2izP3zjHbc8sSFeDZeNJWMZwa/+m4bedo7NhOuIgp4w=;
 b=qqRQczxlYXDrMk3IgMAMihLK0do5CIt9+OVxh1oNhCrRT9VzikP2Q3ZpOYEpCqvU1K3clk
 I+7DVRvMFTTShZFcoIleLMh9Qi4WqrYX0NopYAegM1aVzFqhvcTTBhZgH3e1p4U8gW0Tb2
 ekj1ykoU4jePiEo1oTj69hwQQWxWAsI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1688325494;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2izP3zjHbc8sSFeDZeNJWMZwa/+m4bedo7NhOuIgp4w=;
 b=5mWlyO4IB4g25qpBHMH+U72hR99Zc9KpCi0axBMs3+vCt/lphwdagaJ2U4sUxEY09PqD1X
 cyIKBp1W5tyE7bDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 72BA11348D;
 Sun,  2 Jul 2023 19:18:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ENOWGnbNoWTnUAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Sun, 02 Jul 2023 19:18:14 +0000
Date: Sun, 2 Jul 2023 21:18:13 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Alexander Aring <aahringo@redhat.com>
Message-ID: <20230702191813.GB360317@pevik>
References: <20230530203707.2965684-1-aahringo@redhat.com>
 <20230530203707.2965684-2-aahringo@redhat.com>
 <20230621090331.GA365741@pevik>
 <CAK-6q+jVapf==Sg_BqWr0KTGA+uKgaaSZQwO=5tWzve9=Dok2Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAK-6q+jVapf==Sg_BqWr0KTGA+uKgaaSZQwO=5tWzve9=Dok2Q@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] fcntl40: test for owner values on classic
 posix lock
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

Hi Alex,

...
> > > + * [Description]
> > > + * Tests gfs2 dlm posix op queue handling in the kernel.
> > > + * It is recommended to run watch -n 0.1 "dlm_tool plocks $LS"
> > > + * aside to monitor dlm plock handling.
> > > + *
> > > + * [How to use it]
> > > + * Call it with TMPDIR=/mnt ./fcntl40 where TMPDIR is a gfs2 mountpoint.
> > I wonder if we could check for GFS2_MAGIC (we'd need to add it to
> > include/tst_fs.h => 0x01161970) and quit the test with tst_brk(TCONF) if TMPDIR
> > is not on gfs2.

> > ATM we don't have any helper in struct tst_test, which would do it.


> I will mention that gfs2 is only an example here. It becomes
> interesting when a file system implements its own .lock() callback OR
> if somebody wants to test file system core, when a filesystem does not
> implement its own .lock().

I see .lock is implemented in 9p, afs, ceph, cifs, ocfs2, orangefs, even NFS.
"file system core": do you mean VFS? Because that would be more usable than the
filesystems above (which are quite exotic).

...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
