Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53619C46CD2
	for <ltp@archiver.kernel.org>; Tue,  2 Jan 2024 21:02:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 131453D0805
	for <ltp@archiver.kernel.org>; Tue,  2 Jan 2024 22:02:06 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3E28B3CAB18
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 22:01:56 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CA918140026E
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 22:01:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E23C51F802;
 Tue,  2 Jan 2024 21:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704229314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jdvmYpcoRNTvIyj+6pGw6a50tTdN2HsiQBuxbtyZnxg=;
 b=bX/6lKNJtFcSGk7WVMriEl4Hvw0DajPLk4rhVRd2ci7jJ0jxn6MV/RTd9BVgEEhjuveksN
 API+0mgXBnRWJAbPJYWEVJN7kRAfTabVEhExqpooV6BbfkFI0f8Gp6FNkMOKcmEbGptkXX
 X5IOeomfMilgEQfVTRAAe277/DzJbwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704229314;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jdvmYpcoRNTvIyj+6pGw6a50tTdN2HsiQBuxbtyZnxg=;
 b=546Du1UOzU0G1q/3hGdWop4FiiGA2iFMpD+JncIqiMAuMWr2ELRXEjPtZ0MGt7zBY+FDqR
 I85FCzVCsZtUttDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704229312;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jdvmYpcoRNTvIyj+6pGw6a50tTdN2HsiQBuxbtyZnxg=;
 b=ZhtiTaUILv6igP9LunmutFZXZwaYPJp21oATIzQFC9F7ndAgZh2LPl3thUJQfGH/INJOqa
 2UQqsrSaS8qIEWugG9e6gdsvGiDp+YTrLV48OAPsxPL7nDSicS8rGMwuwXinoeacPm4fWm
 BivvBN1Zu3qTsIx4NwFxDJspl3283K4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704229312;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jdvmYpcoRNTvIyj+6pGw6a50tTdN2HsiQBuxbtyZnxg=;
 b=yaYAdhIm+mW1DTBoVn5mRni6iCSIwchTmvoeTsebl9/j2+LkItB0gtla3TlTnjko1b0WhX
 qebWBDLHvdkH9TAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9232D1340C;
 Tue,  2 Jan 2024 21:01:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +wDaIcB5lGXPQgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 02 Jan 2024 21:01:52 +0000
Date: Tue, 2 Jan 2024 22:01:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240102210150.GA942817@pevik>
References: <ZZQHPkwg-W2R1ejJ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZZQHPkwg-W2R1ejJ@yuki>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 DBL_BLOCKED_OPENRESOLVER(0.00)[ozlabs.org:url,zram_lib.sh:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, all,

> Hi!
> Firstly happy new year to everyone.
:)

> Secondly as usually we are supposed to produce a release at the end of
> the month. I will start by going over patchwork this week and try to
> review and merge as much as possible. Given that it's the start of the
> January we have about two weeks for this before we have to declare a git
> freeze and start pre-release testing. Does that sound fine to everyone?

> If you have any patches that should be reviewed before the release,
> please let me know.

I would like to have these patchsets merged:

* Add support bcachefs filesystem
https://patchwork.ozlabs.org/project/ltp/list/?series=385735&state=*
We have 6.7-rc8, fanotify were fixed by fix from Jan Kara:
8bf771972b84 ("bcachefs: Fix determining required file handle length").

statvfs01.c ENAMETOOLONG issue is still failing, but there are fixes pending
[1], but even with it (bcachefs-2024-01-01) it does not fix the problem.
I'll report it to the patch itself.

* net: tst_netload_compare(): Ignore performance failures
https://patchwork.ozlabs.org/project/ltp/patch/20231219123709.339435-1-pvorel@suse.cz/

* .modprobe_module
I'm not sure about .modprobe_module [2]. I have draft of v3, but I'm not sure if
it's needed. My motivation was to fix setsockopt08.c failure on openSUSE
Tumbleweed, but that turns out to be procps package issue due broken symlink
(bsc#1217990). Calling modprobe is is needed on these tests:

 ** testcases/network/can/cve/can_bcm01.c
	modprobe on can_bcm01.c is required to fix failures on sle-12-SP3 which uses
	4.4 based kernel (I'm not sure if the problem is on mainline as well):
	can_bcm01.c:44: TBROK: Failed to create vcan device ltp_vcan0: EOPNOTSUPP
	can_bcm01.c:126: TWARN: Failed to remove netdevice ltp_vcan0: ENODEV

	Maybe we should call modprobe only on kernel <= 4.4 (to test automatic
	module loading on newer kernels where it's supposed to work), but it would
	not be possible to implement it via .modprobe_module. Adding
	tst_modprobe_module(), which I was asked by Li would allow to call it only
	for older kernel.

 ** testcases/kernel/syscalls/madvise/madvise11.c
	.modprobe_module does a lot of simplification here (I should verify, if it
	really detects a bug on kernels with reverted d4ae9916ea29).

    BTW madvise11.c writes to /dev/kmsg, which is also done in kmsg01.c (+
	deprecated ltp-pan.c). I'm not sure if it's worth to move this code to
	library when only 2 tests use it, but generic code like this certainly
	belongs to the library. Maybe we could write starting of the test in
	/dev/kmsg in the library for tests which runs under root (getuid() == 0 or
	on tests with .needs_root = 1).

Also I mentioned in the pathset tests which use modprobe but using
.modprobe_module is not usable:

 ** kvm_pagefault01.c would require module parameters, which can be actually
	useful. But it also uses reloading module (via test specific reload_module()
	function), e.g. something used only in this test.

 ** zram03.c, zram_lib.sh (too complicated check due /sys/class/zram-control
	introduced in v4.2-rc1 vs. the old API, but maybe this could be simplified).
	Again, tst_modprobe_module() would remove code duplication.

 ** netstress.c (used only when testing dccp, which is determined by getopts)
	=> use tst_modprobe_module()

Implementing tst_modprobe_module() in the library would reduce some code, I'll
probably implement it.

What about .modprobe_module?  We have tests which load kernel modules from LTP
via insmod and rmmod via tst_module_load(), tst_module_unload() (at least
delete_module03.c needs it, possibly others). Maybe rename them to
tst_insmod_module() and tst_rmmod_module() and create tst_module_unload() which
would use "modprobe -r" which would be used in can_bcm01.c, madvise11.c,
netstress.c, zram03.c and in .modprobe_module (in cleanup phase) if implemented?

> I do have one patch this time, please have a look if you have time:

> http://patchwork.ozlabs.org/project/ltp/patch/20231031125114.5879-1-chrubis@suse.cz/

I'll try to have look in next days.

> I would like to finish the tst_fd iterator patchset if possible, but
> depending on the amount of patches that I will have to review I may not
> make it.

+1

Kind regards,
Petr

[1] https://lore.kernel.org/linux-bcachefs/o7py4ia3s75popzz7paf3c6347te6h3qms675lz3s2k5eltskl@cklacfnvxb7k/
[2] https://patchwork.ozlabs.org/project/ltp/list/?series=377451&state=*

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
