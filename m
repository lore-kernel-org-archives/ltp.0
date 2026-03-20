Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49812109878D
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 14:38:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F0A913E55CE
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 15:38:05 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C65E3E48FF
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 15:37:48 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 99D4A601556
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 15:37:47 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 868E15BCF0;
 Fri, 20 Mar 2026 14:37:46 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 723114284F;
 Fri, 20 Mar 2026 14:37:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1n2vGrpbvWntQwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 20 Mar 2026 14:37:46 +0000
Date: Fri, 20 Mar 2026 15:37:49 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ab1bveCpTrEk5jEB@yuki.lan>
References: <20260318144113.30981-1-pvorel@suse.cz>
 <69bd15a1.050a0220.27cce5.4d03@mx.google.com>
 <20260320113040.GB140154@pevik> <ab01vxdLgFfeFSg2@yuki.lan>
 <ab02mGftGg-a4krj@yuki.lan> <20260320141859.GA158409@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260320141859.GA158409@pevik>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 868E15BCF0
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC PATCH 1/1] lib: Print tcnt in tst_{brk,res}()
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
> > > This looks good to me. Maybe we can also color the setup/lib/test
> > > differently if the output goes into the terminal.
> 
> 
> > And in order to make it work in the shell as well we would need a
> > function tst_set_context() that would set the current context so that we
> > can call it from shell. I suppose that this needs to be designed
> > carefuly in order to make ti work properly with threads/forked
> > processes.
> 
> How about having enum with few states (lib, setup, test, cleanup), which would
> be switched when context switches (and test_get_state() would just print the
> string). And test would get the number (idea from this patch).
> 
> I'm still missing how to call C API code from shell test, because C API code
> forks child and execute the script, how it could "talk back"?

Same as the test results the enum would have to be stored in shared
memory and updated with atomic operations.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
