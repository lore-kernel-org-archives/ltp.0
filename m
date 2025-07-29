Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1586EC87FC9
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 08:47:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79B4B3CA31A
	for <ltp@archiver.kernel.org>; Tue, 29 Jul 2025 10:47:47 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 338CB3C0565
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 10:47:32 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9C516600BA6
 for <ltp@lists.linux.it>; Tue, 29 Jul 2025 10:47:30 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CA5391F789;
 Tue, 29 Jul 2025 08:47:29 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8EC8813A73;
 Tue, 29 Jul 2025 08:47:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3dnXIaGKiGi6QgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 29 Jul 2025 08:47:29 +0000
Date: Tue, 29 Jul 2025 10:47:20 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20250729084720.GA13357@pevik>
References: <20250729-ioctl_pidfd01_selinux-v1-1-432e100a5a53@suse.com>
 <5913636.DvuYhMxLoT@thinkpad>
 <ea4c0dbb-c4ba-46dd-b10c-c628d6093936@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ea4c0dbb-c4ba-46dd-b10c-c628d6093936@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: CA5391F789
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Disable io_uring fd in ioctl_pidfd01 for selinux
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


> On 7/29/25 10:32 AM, Avinesh Kumar wrote:
> > We also have same failure for memfd_secret case in this test:

> > ioctl_pidfd01.c:37: TINFO: memfd secret -> ...
> > ioctl_pidfd01.c:28: TFAIL: ioctl(memfd secret, PIDFD_GET_INFO, info) expected EINVAL, EBADF, ENOTTY: EACCES (13)

> > If we are opting for skipping the tests when selinux is enforcing mode,
> > this also needs to be skipped.

> In this case we will probably need to disable the test for SELinux
> enforcing.

Well, all tests (ioctl_pidfd01.c, this ioctl_pidfd01.c, mount08.c) are testing
with TST_EXP_FAIL_ARR(), i.e. negative tests.  Wouldn't be better to just expect
a different errno? At least this is what I suggested to mount08.c [1].

Whichever of these to approaches we agree on, I wonder if we should document the
recommended way somewhere, maybe in Writing tests [2].

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20250728103141.GA756176@pevik/
[2] https://linux-test-project.readthedocs.io/en/latest/developers/writing_tests.html

> - Andrea


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
