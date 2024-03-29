Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8225BCD1283
	for <ltp@archiver.kernel.org>; Fri, 29 Mar 2024 21:33:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62A063C6A9F
	for <ltp@archiver.kernel.org>; Fri, 29 Mar 2024 22:33:02 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B73E3C01AF
 for <ltp@lists.linux.it>; Fri, 29 Mar 2024 22:32:46 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2AE3110009E3
 for <ltp@lists.linux.it>; Fri, 29 Mar 2024 22:32:45 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4A66D21066;
 Fri, 29 Mar 2024 21:32:45 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 1048A13A89;
 Fri, 29 Mar 2024 21:32:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap2.dmz-prg2.suse.org with ESMTPSA id macTO3wzB2aWTAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 29 Mar 2024 21:32:44 +0000
Date: Fri, 29 Mar 2024 22:32:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20240329213239.GA159482@pevik>
References: <20231018054357.29035-1-wegao@suse.com>
 <20240118073215.10026-1-wegao@suse.com>
 <20240228170729.GA1618063@pevik> <ZgZ7swC75rxF9hFq@wegao.21.28.32>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZgZ7swC75rxF9hFq@wegao.21.28.32>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 4A66D21066
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl_fiemap01: New test for fiemap ioctl()
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

Hi Wei,

...
> > > +	fiemap->fm_flags =  -1;
> > > +	TST_EXP_FAIL(ioctl(fd, FS_IOC_FIEMAP, fiemap), EBADR);

> > I get on Tumbleweed with 6.8.0-rc4-1.g9b23bf2-default EOPNOTSUPP:
> > ioctl_fiemap01.c:52: TFAIL: ioctl(fd, FS_IOC_FIEMAP, fiemap) expected EBADR: EOPNOTSUPP (95)
> > What is the missing dependency for FS_IOC_FIEMAP? Or is there wrong fiemap use
> > which causes that?
> Thanks for your test and i also reproduce this issue.
> This is caused by Tumbleweed mount tmpfs on /tmp and tmpfs seems not support fiemap action.
> tmpfs on /tmp type tmpfs (rw,nosuid,nodev,size=494452k,nr_inodes=1048576,inode64)

+1. You probably knows that you need .skip_filesystems, which works even
.all_filesystems is not set.

	.skip_filesystems = (const char *const []) {
		"tmpfs",
		NULL
	},

But actually when this is filesystem dependent, I guess .all_filesystems = 1
would make sense, right?

> I will sent new patch for cover all supported filesystem.

I suppose you agree :).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
