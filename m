Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C47AE6F095
	for <ltp@archiver.kernel.org>; Fri,  1 Nov 2024 23:32:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79E603CE47B
	for <ltp@archiver.kernel.org>; Sat,  2 Nov 2024 00:32:57 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A4393CE47B
 for <ltp@lists.linux.it>; Sat,  2 Nov 2024 00:32:41 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 46BE11413E70
 for <ltp@lists.linux.it>; Sat,  2 Nov 2024 00:32:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3238621C88;
 Fri,  1 Nov 2024 23:32:38 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C81F136C7;
 Fri,  1 Nov 2024 23:32:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +9RMARZlJWceBwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 01 Nov 2024 23:32:38 +0000
Date: Sat, 2 Nov 2024 00:32:21 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20241101233221.GC1324664@pevik>
References: <20241101141111.104803-1-mdoucha@suse.cz>
 <20241101141111.104803-6-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241101141111.104803-6-mdoucha@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 3238621C88
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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

Hi Martin,

[ Cc Li and Cyril due tst_set_timeout vs. tst_loader.sh and tst_run_shell.c. ]

> Add NFS test which checks data integrity of random writes into a file,
> with both buffered and direct I/O.

LGTM.
Reviewed-by: Petr Vorel <pvorel@suse.cz>

I'll try to have look on the core work (fsplough.c) on Monday.
Hopefully Li or Cyril would have look into this as well.

> The lower loop count is necessary because NFS has very large block size,
> up to 256KB on x86_64. The new tests take ~50 minutes to complete in total
> on my laptop. With the default loop count, the TCP tests would all time out.

BTW I got timeout when testing nfs10.sh -v 4 -t tcp on Tumbleweed VM (2 CPU,
1.4 GB RAM, 2 GB SWAP) on my laptop:
...
nfs10 1 TINFO: === Testing on ext4 ===
nfs10 1 TINFO: Formatting ext4 with opts='/dev/loop0'
nfs10 1 TINFO: Mounting device: mount -t ext4 /dev/loop0 /var/tmp/LTP_nfs10.zWBiahjI48/mntpoint
nfs10 1 TINFO: timeout per run is 0h 5m 0s

=> nfs10.sh runs only for 5 min.

nfs10 1 TINFO: mount.nfs: (linux nfs-utils 2.6.3)
nfs10 1 TINFO: setup NFSv4, socket type tcp
nfs10 1 TINFO: Mounting /var/tmp/LTP_nfs10.zWBiahjI48/4/0
nfs10 1 TINFO: Mounting NFS: mount -v -t nfs -o proto=tcp,vers=4 10.0.0.2:/var/tmp/LTP_nfs10.zWBiahjI48/mntpoint/4/tcp /var/tmp/LTP_nfs10.zWBiahjI48/4/0
nfs10 1 TINFO: Testing buffered write, buffered read
tst_tmpdir.c:316: TINFO: Using /var/tmp//LTP_fspL4p41F as tmpdir (btrfs filesystem)
tst_test.c:1890: TINFO: LTP version: 20240930-49-g3facdd035
tst_test.c:1894: TINFO: Tested kernel: 6.12.0-rc4-1.gf83465d-default #1 SMP PREEMPT_DYNAMIC Sun Oct 20 22:44:57 UTC 2024 (f83465d) x86_64
tst_test.c:1725: TINFO: Timeout per run is 0h 00m 30s
fsplough.c:186: TINFO: Block size: 262144
tst_test.c:1733: TINFO: Updating max runtime to 0h 08m 32s
tst_test.c:1725: TINFO: Timeout per run is 0h 09m 02s

=> fsplough.c is updated to 9 min, but that does not help due nfs10.sh not
having updated.

Test timed out, sending SIGTERM!
If you are running on slow machine, try exporting LTP_TIMEOUT_MUL > 1
Sending SIGKILL to test process...
Test is still running... 10
Test is still running... 9
Test is still running... 8
Test is still running... 7
Test is still running... 6
Test is still running... 5
Test is still running... 4
Test is still running... 3
Test is still running... 2
Test is still running... 1
Test is still running, sending SIGKILL
Killed

The quickest way would be to use the same calculation (* $TST_CNT + 5% for spare
time) in nfs10.sh and increase tst_set_timeout with.

Or, I wonder if using tst_loader.sh and tst_run_shell.c would help to integrate
these. But I'm not sure how easily could be nfs_lib.sh integrated, e.g.
* isn't it too late, when it uses tst_net.sh (maybe this file would need to be
  integrated)
* should use keep using TST_ALL_FILESYSTEMS=1 from tst_test.sh or configure
  via all_filesystems=1 via json?

OT: Other tests which are considerable are these which use netstress.c (via
tst_netload_compare).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
