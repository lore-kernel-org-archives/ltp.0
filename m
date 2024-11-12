Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD1BD597A9
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 21:40:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 39E333D62AF
	for <ltp@archiver.kernel.org>; Tue, 12 Nov 2024 22:40:36 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB9DE3D62AF
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 22:40:20 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5808E658F49
 for <ltp@lists.linux.it>; Tue, 12 Nov 2024 22:40:18 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BEFAE1F365;
 Tue, 12 Nov 2024 21:40:17 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5140A13721;
 Tue, 12 Nov 2024 21:40:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FeQHD0HLM2c0dgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 12 Nov 2024 21:40:17 +0000
Date: Tue, 12 Nov 2024 22:40:15 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20241112214015.GA235246@pevik>
References: <20241101141111.104803-1-mdoucha@suse.cz>
 <20241101141111.104803-6-mdoucha@suse.cz>
 <20241101233221.GC1324664@pevik>
 <e4209eb0-1d9c-4908-948f-3e2f987cc79e@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <e4209eb0-1d9c-4908-948f-3e2f987cc79e@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: BEFAE1F365
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] Add test for data integrity over NFS
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

> On 02. 11. 24 0:32, Petr Vorel wrote:
> > Hi Martin,

> > BTW I got timeout when testing nfs10.sh -v 4 -t tcp on Tumbleweed VM (2 CPU,
> > 1.4 GB RAM, 2 GB SWAP) on my laptop:
> > ...

> > The quickest way would be to use the same calculation (* $TST_CNT + 5% for spare
> > time) in nfs10.sh and increase tst_set_timeout with.

> Yes, that is expected for now, we need to add separate timeouts for each
> subtest, including per-filesystem.

Right, I suppose you post v2.

I wonder why you did not get timeouts on your laptop. I suppose calculation for
fsplough was below 5 min, right?

> > Or, I wonder if using tst_loader.sh and tst_run_shell.c would help to integrate
> > these. But I'm not sure how easily could be nfs_lib.sh integrated, e.g.
> > * isn't it too late, when it uses tst_net.sh (maybe this file would need to be
> >    integrated)
> > * should use keep using TST_ALL_FILESYSTEMS=1 from tst_test.sh or configure
> >    via all_filesystems=1 via json?

> I'm not sure I understand your idea.

Second idea (TST_ALL_FILESYSTEMS=1 => .all_filesystems=1) is wrong.

I was thinking how to run fsplough in nfs10.sh similarly to
testcases/lib/tests/shell_loader_c_child.sh to use $LTP_IPC_PATH.  That would
help better integration (e.g. common results counter, maybe even timeout on
single place). This should be quite easy.

I was also thinking whether rewrite nfs_lib.sh into C (much more work,
there would probably  need to be tst_net.sh equivalent in C questionable if
worth of the effort).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
