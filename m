Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE969C3DA61
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 07:33:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E8CF3D1D92
	for <ltp@archiver.kernel.org>; Tue, 30 Jul 2024 09:33:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B98F3D0B1D
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 09:33:43 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 7E6E61400E70
 for <ltp@lists.linux.it>; Tue, 30 Jul 2024 09:33:43 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 72A7C21A64;
 Tue, 30 Jul 2024 07:33:42 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3770A13983;
 Tue, 30 Jul 2024 07:33:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NeJ6C1aXqGbKcAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 30 Jul 2024 07:33:42 +0000
Date: Tue, 30 Jul 2024 09:33:42 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240730073342.GA1327610@pevik>
References: <20240722145443.19104-1-chrubis@suse.cz>
 <20240729205112.GA1287954@pevik> <ZqiRaf0bPloFV3LI@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZqiRaf0bPloFV3LI@yuki>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 72A7C21A64
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] sched: starvation: Autocallibrate the timeout
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
Cc: joe.liu@mediatek.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > tst_tmpdir.c:316: TINFO: Using /tmp/LTP_starv8seE as tmpdir (tmpfs filesystem)
> > tst_test.c:1806: TINFO: LTP version: 20240524
> > tst_test.c:1650: TINFO: Timeout per run is 0h 00m 30s
> > starvation.c:71: TINFO: Setting affinity to CPU 0
> > tst_test.c:1658: TINFO: Updating max runtime to 0h 04m 00s
> > tst_test.c:1650: TINFO: Timeout per run is 0h 04m 30s
> > starvation.c:117: TPASS: wait_for_pid(child_pid) passed

> > => test runs ~ 13s - 19s on aarch64, ppc64le and x86_64. Therefore not sure if
> > 04m max runtime is good.

> Are you sure that you have run the test with the patch?

Ah, single missing variable, I tested just the master. I'm sorry, I'll retest.

Kind regards,
Petr

> Because it's missing the messages produced by the autocallibration and
> the wait_for_pid() should not be there after the patch.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
