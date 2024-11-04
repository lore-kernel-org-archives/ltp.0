Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E625D132D0
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 14:16:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 084723D0C03
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 15:16:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 52FAC3D0BA1
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 15:16:11 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5111263198A
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 15:16:09 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 371931F7DD;
 Mon,  4 Nov 2024 14:16:08 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F316813736;
 Mon,  4 Nov 2024 14:16:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WUH1OSfXKGcRfAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 04 Nov 2024 14:16:07 +0000
Date: Mon, 4 Nov 2024 15:16:06 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241104141606.GB1388681@pevik>
References: <20241101141111.104803-1-mdoucha@suse.cz>
 <20241101141111.104803-6-mdoucha@suse.cz>
 <20241101233221.GC1324664@pevik> <ZyjGiQ7-oyBZBG-S@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZyjGiQ7-oyBZBG-S@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00]; REPLY(-4.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Rspamd-Queue-Id: 371931F7DD
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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

> Hi!
> > Test timed out, sending SIGTERM!
> > If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
> > Sending SIGKILL to test process...
> > Test is still running... 10
> > Test is still running... 9
> > Test is still running... 8
> > Test is still running... 7
> > Test is still running... 6
> > Test is still running... 5
> > Test is still running... 4
> > Test is still running... 3
> > Test is still running... 2
> > Test is still running... 1
> > Test is still running, sending SIGKILL
> > Killed

> Isn't the propblem here that the fsplough.c itself does not have
> .max_runtime set?

It has timeout adjusted in the setup function:
tst_set_max_runtime(bufsize * loop_count / (8 * 1024 * 1024));

> I think that main problem here is that we have a LTP test that is being
> executed from another LTP test which means that we have two layers of
> everything including timeouts.

Similarly netstress.c, which is also called from tst_net.sh. But these tests
does not run on all filesystems.

> > The quickest way would be to use the same calculation (* $TST_CNT + 5% for spare
> > time) in nfs10.sh and increase tst_set_timeout with.

> > Or, I wonder if using tst_loader.sh and tst_run_shell.c would help to integrate
> > these. But I'm not sure how easily could be nfs_lib.sh integrated, e.g.
> > * isn't it too late, when it uses tst_net.sh (maybe this file would need to be
> >   integrated)
> > * should use keep using TST_ALL_FILESYSTEMS=1 from tst_test.sh or configure
> >   via all_filesystems=1 via json?

> I guess that the best solution would be to add NFS support into the
> tst_test.c as another filesystem. That way we would get much more
> coverate than we do now. I guess that it would be doable as long as the
> configuration on how to do that is passed to the test library somehow.

Test coverage would really increase a lot. Even there are more NFS testsuites,
IMHO it'd be useful to bring this to LTP - we test a different things then
fstests, pynfs, cthon, ....

But OTOH it does not have much sense to run NFS tests on a loop device which
backing file is on tmpfs (the default setup on distros which use tmpfs on /tmp).
It's a question, whether we should start using /var/tmp as a default for TMPDIR
(if exists). LTP does cleanup of the functions, unless it fails. Specially NFS
tests when they timeout, the cleanup is not done due mounted filesystem being
used. Then /var/tmp gets filled up quickly and reboot does not do automatic
cleanup.

Adding NFS support would require setup code from nfs_lib.sh (e.g. exportfs, run
mount binary or start using mount(2), doing various checks etc) to be run by
tst_test.c, via another process via fork() and execvp(), e.g. with LTP's
tst_cmd().  I'm not sure if minimal required subset should be put in some shell
script, which would be executed by tst_test.c (maybe using tst_loader.sh to join
shared memory to unify the counter) or run individual commands one by one. WDYT?

This simpler version would allow to add various NFS to all_filesystems. I wonder
if we want to support just single NFS version e.g. the newest NFSv4.2 or more.
I suppose we would test only on TCP (UDP is deprecated, not enabled by default
on newer kernels). But even the core of the NFS setup in nfs_mount() uses
tst_rhost_run() from tst_net.sh. E.g. some parts of tst_net.sh would need to be
rewritten into C code (or it would have to call tst_net.sh, if gluing with
tst_loader.sh would work).

My original idea to convert all NFS tests would basically mean to rewrite quite
to use even more nfs_lib.sh and tst_net.sh. code (there is a support for
setting NFS version and protocol and other things).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
