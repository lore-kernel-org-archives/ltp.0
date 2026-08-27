Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA2EC61DC2
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 08:09:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9FB413D0F88
	for <ltp@archiver.kernel.org>; Thu, 27 Aug 2026 10:09:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E4F103CF2A2
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 10:09:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5326C1000484
 for <ltp@lists.linux.it>; Thu, 27 Aug 2026 10:09:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B23561F823;
 Thu, 27 Aug 2026 08:09:33 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A2D2313354;
 Thu, 27 Aug 2026 08:09:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KIiaJr3wj2r1KAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 27 Aug 2026 08:09:33 +0000
Date: Thu, 27 Aug 2026 10:09:39 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ao_wwyjEOo4MVyao@yuki.lan>
References: <ao8E9xmRqH35vJrz@yuki.lan>
 <6a8feaa4.c69142e7.26d8ab.d0a0@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a8feaa4.c69142e7.26d8ab.d0a0@mx.google.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: B23561F823
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] fallocate01: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> mmmh...I guess we need to keep the gate on ENOSYS and to check for
> ENOTSUPP in here, but we can't use TST_EXP_PASS_OR_FAIL(). That will
> TFAIL on succeed, so I need to use the same test function for both
> setup() and run()
> 
> static int test_fallocate(int fd, int mode, long len, long off)
> {
> 	TEST(fallocate(fd, mode, len, off));
> 	if (TST_RET != 0) {
> 		if (TST_ERR == EOPNOTSUPP || TST_ERR == ENOSYS)
> 			tst_brk(TCONF, "fallocate() not supported");
> 
> 		tst_brk(TBROK | TTERRNO, "fallocate() failed");
> 	}
> 
> 	return TST_RET;
> }
> 
> and use it into setup() + run() with TST_EXP_PASS()

We can handle ENOSYS in the test setup(). ENOSYS means that the syscall
is missing completely. But we can get EOPNOTSUPP for only subset of
flags, this needs to be handled in run().

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
