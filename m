Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F69CD41D74
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 09:37:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7F0903CF932
	for <ltp@archiver.kernel.org>; Mon, 15 Dec 2025 10:37:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59B4A3CF55B
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 10:36:51 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ADC8E1A004CE
 for <ltp@lists.linux.it>; Mon, 15 Dec 2025 10:36:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4DD9C5BD16;
 Mon, 15 Dec 2025 09:36:49 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2132E3EA63;
 Mon, 15 Dec 2025 09:36:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 3+HhBrHWP2kOFgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 15 Dec 2025 09:36:49 +0000
Date: Mon, 15 Dec 2025 10:36:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20251215093639.GA236929@pevik>
References: <20251107003041.28929-1-wegao@suse.com>
 <20251110024805.31070-1-wegao@suse.com>
 <20251110024805.31070-2-wegao@suse.com> <aTvu4GJBC_G5kSNi@yuki.lan>
 <20251212111618.GA125889@pevik>
 <aT-5tkQkM_g2VZ35@autotest-wegao.qe.prg2.suse.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aT-5tkQkM_g2VZ35@autotest-wegao.qe.prg2.suse.org>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 4DD9C5BD16
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/3] lib: Add support option for .needs_cmds
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
> > Also, strictly speaking tst_cmd_present() is only defined, not used. The commit
> > is about changing .needs_cmds from char array (string) to struct tst_cmd.
> > Therefore it could be in a separate commit. We don't have to be too strict, but
> > given how many tests needed to be adapted adding tst_cmd_present() is somehow
> > buried with other changes.

> Thanks all for detail feedback. Let's me give some explaination why skip
> tst_brk in above function:
> tst_cmd_present will be used in latest ioctl_loop01.c and it should not
> use tst_brk otherwise we will brk out of test in setup() too early.
> The new support needs_cmds.optional in current patch is used for support 
> tst_cmd_present scenario in ioctl_loop01.c.
> Correct me if any mistake.

Sure, I noticed tst_cmd_present() usage in a later commit :).

My point was (while this patchset is also about ideal feature change split into
commits) that if you touch many files with struct tst_cmd change, adding
unrelated change (tst_cmd_present()) will hide this change. I would personally
move adding tst_cmd_present() to a separate commit. It's not that important,
just to make review easier.

The rules (which I've tried to explain on this patchset) are
* each commit must compile (even temporarily break build is not acceptable)
* split changes into small logical parts

People talk about atomic changes: "As small as possible, but complete" so that
they don't break CI.
https://dev.to/samuelfaure/how-atomic-git-commits-dramatically-increased-my-productivity-and-will-increase-yours-too-4a84

Kind regards,
Petr

> ioctl_loop01.c code:
> static void setup(void)
> {
>         parted_sup = tst_cmd_present("parted");  <=====

> .....
>         if (parted_sup)
>                 SAFE_CMD(cmd_parted, NULL, NULL);  <===

>         sprintf(partscan_path, "/sys/block/loop%d/loop/partscan", dev_num);
> }

> > Kind regards,
> > Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
