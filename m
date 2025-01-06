Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82E17E77198
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 15:58:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D4F43C67B8
	for <ltp@archiver.kernel.org>; Mon,  6 Jan 2025 16:58:10 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7CFC53C672D
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 16:57:53 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 93B061021EA4
 for <ltp@lists.linux.it>; Mon,  6 Jan 2025 16:57:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 479DC1F44E;
 Mon,  6 Jan 2025 15:57:51 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 34F3A139AB;
 Mon,  6 Jan 2025 15:57:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id T97OCn/9e2fLUQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 06 Jan 2025 15:57:51 +0000
Date: Mon, 6 Jan 2025 16:57:37 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z3v9cajg2VQxozdl@yuki.lan>
References: <Z3vJ6zXDVPACBIGd@yuki.lan>
 <20250106154521.GC323533@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250106154521.GC323533@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 479DC1F44E
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > We are supposed to produce another LTP release at the end of January.
> > As usuall I will try to look at the patchwork and get as much as
> > possible reviewed in the next two weeks. If there is something that you
> > think should get reviewed ASAP please let me know.
> 
> When is actually the git freeze?

Well we usually need at least a week of pre release testing so somewhere
in the third week of January. I suppose that we can decide based on how
the patch queue would look like at that point.

> Do you plan to do tst_brk() change you had in RFC? Or you want to postpone after
> the release? I have related fixes, but whole tst_brk could be relaxed if we
> change the API.

It's a rather intrusive change, so I would like to get it more exposure
and testing. Generally it's not a good idea to do changes like that
right before the release.

> IMHO these could be merged:
> 
> * Li's patchset on fuzzy sync:
> https://patchwork.ozlabs.org/project/ltp/list/?series=437898
> 
> * device-drivers: Fix module build on kernel >= 5.18
> https://github.com/linux-test-project/ltp/issues/1216
> 
> * ci: run shell loader tests
> https://patchwork.ozlabs.org/project/ltp/list/?series=436135
> I already got review from Li, I'd like to merge it soon.
> 
> * doc: Update timeout related doc
> https://patchwork.ozlabs.org/project/ltp/patch/20241113151258.182353-1-pvorel@suse.cz/
>
> I also hoped to send v3 for IMA loading policy patchset. If I manage to add it
> and acked by Mimi Zohar it would be nice to have it in the release.

I will try to have a look.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
