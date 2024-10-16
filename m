Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1162AD1AD5E
	for <ltp@archiver.kernel.org>; Wed, 16 Oct 2024 13:49:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 659833C681B
	for <ltp@archiver.kernel.org>; Wed, 16 Oct 2024 15:49:11 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 86DC73C67E0
 for <ltp@lists.linux.it>; Wed, 16 Oct 2024 15:48:56 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 1DC1E7E0F29
 for <ltp@lists.linux.it>; Wed, 16 Oct 2024 15:48:52 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 94FE11F7F3;
 Wed, 16 Oct 2024 13:48:51 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCA271376C;
 Wed, 16 Oct 2024 13:48:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id q19bKELED2f4EAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 16 Oct 2024 13:48:50 +0000
Date: Wed, 16 Oct 2024 15:48:48 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241016134848.GA88404@pevik>
References: <20240918100344.21316-1-wegao@suse.com>
 <20240925035756.14873-1-wegao@suse.com>
 <20241015193958.GC46536@pevik> <Zw-15cE2R0_5FOmJ@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Zw-15cE2R0_5FOmJ@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 94FE11F7F3
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ftp01.sh: Add support for test lftp
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
Cc: Martin Doucha <martin.doucha@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > To be honest, I would rather to remove this FTP test because FTP protocol is
> > legacy. I know it is supposed to be a smoke test, but maybe using modern tools
> > would be better than keeping test working among various old FTP implementations.
> > (Also nontrivial setup is required just for few FTP tests:
> > https://github.com/linux-test-project/ltp/tree/master/testcases/network )
> > But probably Cyril would be against. @Cyril @Martin WDYT?

First, there are 7 FTP related tests:

testcases/network/tcp_cmds/ftp/ftp01.sh
testcases/network/stress/ftp/ftp-upload-stress02-rmt.sh
testcases/network/stress/ftp/ftp-upload-stress01-rmt.sh
testcases/network/stress/ftp/ftp-upload-stress.sh
testcases/network/stress/ftp/ftp-download-stress02-rmt.sh
testcases/network/stress/ftp/ftp-download-stress01-rmt.sh
testcases/network/stress/ftp/ftp-download-stress.sh

rmt files are using in ftp-upload-stress.sh and ftp-download-stress.sh. They are
part of runtest/net_stress.appl. Others tools/protocols for testing are SSH and DNS,
I wonder if we should get rid of whole tests in runtest/net_stress.appl.

Only ftp01.sh is converted to the new API, the rest is using the legacy API.
While it wouldn't be difficult to convert them, I wonder if it's really useful
for modern kernel testing. Is it really worth to have these tests as a smoke
tests?

> So where is the ftp server setup code? Or do we expect ftp server to be
> installed and configured prior to the test execution?

ftp-download-stress.sh and ftp-upload-stress.sh have some vsftpd server setup.

Here is a description of some of the tests:

	ftp-download-stress01
		Verify the ftp server or the kernel is not down after a ftp client
		requests large data via IPv4/IPv6

	ftp-download-stress02
		Verify the ftp server or the kernel is not down after many ftp
		clients request data over IPv4/IPv6 asynchronously for a long time

	ftp-upload-stress01
		Verify the ftp server or the kernel is not down after a ftp client
		uploads a large data via IPv4/IPv6

	ftp-upload-stress02
		Verify the ftp server or the kernel is not down after many ftp clients
		uploads data over IPv4/IPv6 asynchronously for a long time

I doubt that FTP server would crash the kernel, IMHO it's more about testing the
FTP server itself.

Kind regards,
Petr

> The actuall test does not look that complex to me.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
