Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E369EEB59F
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 12:19:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5AC323C26A6
	for <ltp@archiver.kernel.org>; Thu, 12 Sep 2024 14:19:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 84ED53C2403
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 14:19:34 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DE6741A01162
 for <ltp@lists.linux.it>; Thu, 12 Sep 2024 14:19:33 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1FF1C21AF9;
 Thu, 12 Sep 2024 12:19:31 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0D57713AD8;
 Thu, 12 Sep 2024 12:19:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id dlH2AlPc4maEWAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 12 Sep 2024 12:19:31 +0000
Date: Thu, 12 Sep 2024 14:18:25 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZuLcEWTfDxozp8QH@yuki.lan>
References: <20240911163443.95398-1-mdoucha@suse.cz>
 <20240911163443.95398-6-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240911163443.95398-6-mdoucha@suse.cz>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 1FF1C21AF9
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] getdents02: Enable .all_filesystems
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
I did merged the patchset, thanks.

I've also notice that there are failures on -m32 build but that happens
before these patches as well:

$ ./getdents02
tst_tmpdir.c:316: TINFO: Using /tmp/LTP_getxryBmt as tmpdir (ext2/ext3/ext4 filesystem)
tst_test.c:1809: TINFO: LTP version: 20240524-236-g0ae6bcc6f
tst_test.c:1813: TINFO: Tested kernel: 6.9.3 #1 SMP PREEMPT_DYNAMIC Fri Jun  7 11:00:48 CEST 2024 x86_64
tst_test.c:1652: TINFO: Timeout per run is 0h 00m 30s
getdents.h:148: TINFO: Testing the SYS_getdents syscall
tst_buffers.c:57: TINFO: Test is using guarded buffers
getdents02.c:86: TPASS: getdents failed as expected: EBADF (9)
getdents02.c:86: TPASS: getdents failed as expected: EINVAL (22)
getdents02.c:86: TPASS: getdents failed as expected: ENOTDIR (20)
getdents02.c:86: TPASS: getdents failed as expected: ENOENT (2)
getdents02.c:90: TFAIL: getdents failed unexpectedly: EINVAL (22)
getdents.h:151: TINFO: Testing the SYS_getdents64 syscall
tst_buffers.c:57: TINFO: Test is using guarded buffers
getdents02.c:86: TPASS: getdents failed as expected: EBADF (9)
getdents02.c:86: TPASS: getdents failed as expected: EINVAL (22)
getdents02.c:86: TPASS: getdents failed as expected: ENOTDIR (20)
getdents02.c:86: TPASS: getdents failed as expected: ENOENT (2)
getdents02.c:90: TFAIL: getdents failed unexpectedly: EINVAL (22)
getdents.h:157: TCONF: libc getdents() is not implemented
getdents.h:162: TINFO: Testing libc getdents64()
tst_buffers.c:57: TINFO: Test is using guarded buffers
getdents02.c:86: TPASS: getdents failed as expected: EBADF (9)
getdents02.c:86: TPASS: getdents failed as expected: EINVAL (22)
getdents02.c:86: TPASS: getdents failed as expected: ENOTDIR (20)
getdents02.c:86: TPASS: getdents failed as expected: ENOENT (2)
getdents02.c:86: TPASS: getdents failed as expected: EFAULT (14)

It looks like the tst_dirp_size() function does not work properly when
the code is compiled with -m32. Do we see these failures anywhere in
openQA?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
