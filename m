Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1D39CA0FED
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 12:47:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 083CA3CD4F0
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 14:46:59 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 739F63CB87F
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 14:46:43 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CF30E1400BD7
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 14:46:42 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8DB524E647;
 Fri,  5 Sep 2025 12:46:41 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C496139B9;
 Fri,  5 Sep 2025 12:46:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id O2h0FbHbumhXaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 05 Sep 2025 12:46:41 +0000
Date: Fri, 5 Sep 2025 14:46:32 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250905124632.GA12403@pevik>
References: <20250904102609.133359-1-liwang@redhat.com>
 <20250904110018.GA56668@pevik> <aLl7ConfYPBglqhx@rei.lan>
 <CAEemH2f=6MRZTk95ZctgPG-MKdyw5oK9WNgh3Tm8WNHQ9NcW_g@mail.gmail.com>
 <aLmwLn9RDo2qmk7K@yuki.lan>
 <CAEemH2cK3idxQHmpSGs8VuWSOosHrFNYK=ic0s90B_WNh7AVjw@mail.gmail.com>
 <CAEemH2cXQ=_F=Bq5CZN1j=SbeceDCKCdZh4jDdGSz-x10XZLtA@mail.gmail.com>
 <aLqq9o9Dkbhr957V@yuki.lan>
 <CAEemH2cRQVq4N-SdRTFEuUzyUbqfCVg_mpQ58t1BeaNSO9NuvQ@mail.gmail.com>
 <aLrYUvN7UMpd64iJ@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aLrYUvN7UMpd64iJ@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 8DB524E647
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] sched_football: synchronize with kickoff flag
 to reduce skew
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
> > This has improved something, but still observes sporadic fail on RHEL stock
> > kernel.
> > However, both the RHEL RT-kernel and the mainline v6.17-rc4 stock kernel
> > pass.

FYI I run tests all SLES and Tumbleweed versions on non-RT kernels, with -i50,
for both master and your v2 (with enabled non-RT kernels).  All are passing.


* 6.16.3-1 (Tumbleweed, very close to kernel stable - it has very few patches unlike the others)
CONFIG_PREEMPT_VOLUNTARY=y
$ cat /sys/kernel/debug/sched/preempt
none (voluntary) full lazy

SLES (these are heavily modified)

* 6.4
* 5.14
CONFIG_PREEMPT_VOLUNTARY=y
$ cat /sys/kernel/debug/sched/preempt
(none) voluntary full

* 5.3
* 4.12
* 4.4
CONFIG_PREEMPT_NONE=y
(/sys/kernel/debug/sched/preempt not enabled)

Later I recheck what was your config which breaks it.

> Maybe add a short usleep() before the referee sets the kickoff_flag so
> that the system has more time to shuffle processes?

+1

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
