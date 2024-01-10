Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00C7C4707B
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 18:06:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0E00C3CE4C8
	for <ltp@archiver.kernel.org>; Wed, 10 Jan 2024 19:06:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 951AB3CE4B6
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 19:06:24 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E8231100288F
 for <ltp@lists.linux.it>; Wed, 10 Jan 2024 19:06:23 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BB8EB221EB;
 Wed, 10 Jan 2024 18:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704909968;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dtrgv2ijM+nGFKmAZ8yGyZHKgC2qOpbECUmx6BKJzv8=;
 b=B1rnhXjor1P/dcIJDRoBP2k83Ii6erllB1SKenF4/R0OURYRIGiDXTlcdQtC2061Q00ucp
 bQ0ugN62Wv4iPljR0iZBWoFwLV37UNlt7f1rjP7n1sKbNl3B4heqwAxWBJ2bbyjlakOy7b
 OXDymVOFW2aEGzQ9jzRC4bufORjTNzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704909968;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dtrgv2ijM+nGFKmAZ8yGyZHKgC2qOpbECUmx6BKJzv8=;
 b=NFs958sk+CioLzcfnkeclYISrZEH1C/g8dFsUbQaibJjyAMBvwHVoBj/2UH7JSmKA00Uym
 RujBO4sXRufelgCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704909968;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dtrgv2ijM+nGFKmAZ8yGyZHKgC2qOpbECUmx6BKJzv8=;
 b=B1rnhXjor1P/dcIJDRoBP2k83Ii6erllB1SKenF4/R0OURYRIGiDXTlcdQtC2061Q00ucp
 bQ0ugN62Wv4iPljR0iZBWoFwLV37UNlt7f1rjP7n1sKbNl3B4heqwAxWBJ2bbyjlakOy7b
 OXDymVOFW2aEGzQ9jzRC4bufORjTNzE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704909968;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Dtrgv2ijM+nGFKmAZ8yGyZHKgC2qOpbECUmx6BKJzv8=;
 b=NFs958sk+CioLzcfnkeclYISrZEH1C/g8dFsUbQaibJjyAMBvwHVoBj/2UH7JSmKA00Uym
 RujBO4sXRufelgCQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 30835139C6;
 Wed, 10 Jan 2024 18:04:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id Asn8CUTcnmU8FwAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 10 Jan 2024 18:04:52 +0000
Date: Wed, 10 Jan 2024 19:06:20 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>, LTP List <ltp@lists.linux.it>
Message-ID: <20240110180620.GA1767461@pevik>
References: <ZZQHPkwg-W2R1ejJ@yuki>
 <20240102210150.GA942817@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240102210150.GA942817@pevik>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-3.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril, all,

> Hi Cyril, all,
...
> * .modprobe_module
> I'm not sure about .modprobe_module [2]. I have draft of v3, but I'm not sure if
> it's needed. My motivation was to fix setsockopt08.c failure on openSUSE
> Tumbleweed, but that turns out to be procps package issue due broken symlink
> (bsc#1217990). Calling modprobe is is needed on these tests:

It looks like also keyctl05 requires modprobe for part of the functionality
https://lore.kernel.org/ltp/20240110175931.GA1766165@pevik/
=> it would be another user of .modprobe_module (unless there is a way to
trigger automatic loading of dns_resolver module).

Kind regards,
Petr

>  ** testcases/network/can/cve/can_bcm01.c
> 	modprobe on can_bcm01.c is required to fix failures on sle-12-SP3 which uses
> 	4.4 based kernel (I'm not sure if the problem is on mainline as well):
> 	can_bcm01.c:44: TBROK: Failed to create vcan device ltp_vcan0: EOPNOTSUPP
> 	can_bcm01.c:126: TWARN: Failed to remove netdevice ltp_vcan0: ENODEV

> 	Maybe we should call modprobe only on kernel <= 4.4 (to test automatic
> 	module loading on newer kernels where it's supposed to work), but it would
> 	not be possible to implement it via .modprobe_module. Adding
> 	tst_modprobe_module(), which I was asked by Li would allow to call it only
> 	for older kernel.

>  ** testcases/kernel/syscalls/madvise/madvise11.c
> 	.modprobe_module does a lot of simplification here (I should verify, if it
> 	really detects a bug on kernels with reverted d4ae9916ea29).

>     BTW madvise11.c writes to /dev/kmsg, which is also done in kmsg01.c (+
> 	deprecated ltp-pan.c). I'm not sure if it's worth to move this code to
> 	library when only 2 tests use it, but generic code like this certainly
> 	belongs to the library. Maybe we could write starting of the test in
> 	/dev/kmsg in the library for tests which runs under root (getuid() == 0 or
> 	on tests with .needs_root = 1).

> Also I mentioned in the pathset tests which use modprobe but using
> .modprobe_module is not usable:

>  ** kvm_pagefault01.c would require module parameters, which can be actually
> 	useful. But it also uses reloading module (via test specific reload_module()
> 	function), e.g. something used only in this test.

>  ** zram03.c, zram_lib.sh (too complicated check due /sys/class/zram-control
> 	introduced in v4.2-rc1 vs. the old API, but maybe this could be simplified).
> 	Again, tst_modprobe_module() would remove code duplication.

>  ** netstress.c (used only when testing dccp, which is determined by getopts)
> 	=> use tst_modprobe_module()

> Implementing tst_modprobe_module() in the library would reduce some code, I'll
> probably implement it.

> What about .modprobe_module?  We have tests which load kernel modules from LTP
> via insmod and rmmod via tst_module_load(), tst_module_unload() (at least
> delete_module03.c needs it, possibly others). Maybe rename them to
> tst_insmod_module() and tst_rmmod_module() and create tst_module_unload() which
> would use "modprobe -r" which would be used in can_bcm01.c, madvise11.c,
> netstress.c, zram03.c and in .modprobe_module (in cleanup phase) if implemented?
...

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
