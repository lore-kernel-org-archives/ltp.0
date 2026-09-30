Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF4FFCA5FBB
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 13:53:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E2A5B3E56AC
	for <ltp@archiver.kernel.org>; Wed, 30 Sep 2026 15:53:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7F1BF3C5493
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 15:53:41 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C1C186008F1
 for <ltp@lists.linux.it>; Wed, 30 Sep 2026 15:53:40 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B38EA21E26;
 Wed, 30 Sep 2026 13:53:39 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B5F713722;
 Wed, 30 Sep 2026 13:53:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id W2XJF2IUvWqRTwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 30 Sep 2026 13:53:38 +0000
Date: Wed, 30 Sep 2026 15:53:33 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Anders Roxell <anders.roxell@linaro.org>
Message-ID: <20260930135333.GA2721643@pevik>
References: <20260929084253.3093742-1-anders.roxell@linaro.org>
 <20260929142156.GB2462033@pevik>
 <CADYN=9Jh83y=n55DbM-niXBE0kot87jECtuM778_WSo6e3p=8g@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CADYN=9Jh83y=n55DbM-niXBE0kot87jECtuM778_WSo6e3p=8g@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: B38EA21E26
X-Rspamd-Action: no action
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_clone: Fix child detection on sparc
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

Hi Anders,

> On Tue, 29 Sept 2026 at 16:22, Petr Vorel <pvorel@suse.cz> wrote:

> > Hi Anders,

> > > On sparc the clone syscall does not return 0 in the child. It returns
> > > the parent pid, so the child thinks it is the parent.

> > So, somebody still test sparc :). Before applying a workaround few questions.

> > I suppose this is because we did not updated our syscalls numbers.

> Yes, clone3 was missing...

Thanks for info.



> > I send a patch which regenerated syscall numbers to have clone3 on sparc (both
> > 32 and 64 bit) v7.0:

> > $ include/lapi/syscalls/generate_arch.sh ../linux

> > Can you please verify it works with clone3()? It was added this year in v7.0 in
> > 2153b2e8917b7 ("sparc: Add architecture support for clone3")

> Yes, it works. I tested on sparc64 in QEMU with a v7.3-rc4 kernel and
> a buildroot
> rootfs with LTP 20260529 + your patch only. All 94 fs_bind tests pass.

FYI there is v2 from Andrea, your testing is highly appreciated (although the
might be some additional changes to script which generates it.

https://patchwork.kernel.org/project/ltp/list/?series=1176684&state=*

> > Do we care about the past?

> That's a good question, I think we do, because of the LTS kernels...
> We run the latest LTP on the LTS kernels...

Yeah, it should be probably merged. I'm sorry that we did not make it to this
LTP release (Cyril is tagging today). Could you please send v3, which address
agent issues?

https://lore.kernel.org/ltp/CADYN=9Jh83y=n55DbM-niXBE0kot87jECtuM778_WSo6e3p=8g@mail.gmail.com/

Kind regards,
Petr

> Cheers,
> Anders

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
