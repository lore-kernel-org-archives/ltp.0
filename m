Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C684CE7AF9
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 12:09:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0ABBC3CF84E
	for <ltp@archiver.kernel.org>; Fri, 14 Nov 2025 13:09:57 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2EFBE3CDF71
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 13:09:40 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 7EF101000482
 for <ltp@lists.linux.it>; Fri, 14 Nov 2025 13:09:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4C790211D2;
 Fri, 14 Nov 2025 12:09:39 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1A9433EA61;
 Fri, 14 Nov 2025 12:09:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id FGQmBQMcF2n6bwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 14 Nov 2025 12:09:39 +0000
Date: Fri, 14 Nov 2025 13:09:37 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20251114120937.GD43654@pevik>
References: <20251106163500.1063704-1-pvorel@suse.cz>
 <20251106163500.1063704-6-pvorel@suse.cz>
 <12777454.O9o76ZdvQC@thinkpad> <20251114102457.GC52218@pevik>
 <aRcEIpgvi9C8NKLd@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aRcEIpgvi9C8NKLd@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Queue-Id: 4C790211D2
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 5/5] swapon03: Remove grep dependency
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
> > This change requires to normalize TMPDIR via realpath() otherwise grep will
> > fail. Either in the test or in the library [1] (I'll submit it separately, no
> > need to be part of Wei's cleanup).

> I was wondering if we can avoid matching the full path. Maybe we can
> just do strstr() on the line from the /proc/mounts matching the filename
> before we attempt to do the scanf().

Do you mean to use full swap file path from /proc/mounts, i.e.
/tmp/LTP_swaNzeMJr/mntpoint/testswap, /tmp/LTP_swamEVVAc/mntpoint/testswap03,
... (example from run which created /tmp/LTP_swamEVVAc with all swap files,
cleanup interrupted by ctrl+C and following one which created /tmp/LTP_swaNzeMJr
single swap file only):

# cat /proc/swaps
Filename				Type		Size		Used		Priority
/dev/vda3                               partition	2098152		0		-2
/tmp/LTP_swaNzeMJr/mntpoint/testswap    file		1004		0		-25
/tmp/LTP_swamEVVAc/mntpoint/testswap03  file		1000		0		-3
/tmp/LTP_swamEVVAc/mntpoint/testswap04  file		1000		0		-4
/tmp/LTP_swamEVVAc/mntpoint/testswap05  file		1000		0		-5
/tmp/LTP_swamEVVAc/mntpoint/testswap06  file		1000		0		-6
/tmp/LTP_swamEVVAc/mntpoint/testswap07  file		996		0		-7
/tmp/LTP_swamEVVAc/mntpoint/testswap08  file		996		0		-8
/tmp/LTP_swamEVVAc/mntpoint/testswap09  file		996		0		-9
/tmp/LTP_swamEVVAc/mntpoint/testswap10  file		1000		0		-10
/tmp/LTP_swamEVVAc/mntpoint/testswap11  file		1000		0		-11
/tmp/LTP_swamEVVAc/mntpoint/testswap12  file		1000		0		-12
/tmp/LTP_swamEVVAc/mntpoint/testswap13  file		1000		0		-13
/tmp/LTP_swamEVVAc/mntpoint/testswap14  file		1000		0		-14
/tmp/LTP_swamEVVAc/mntpoint/testswap15  file		1000		0		-15
/tmp/LTP_swamEVVAc/mntpoint/testswap16  file		996		0		-16
/tmp/LTP_swamEVVAc/mntpoint/testswap17  file		996		0		-17
/tmp/LTP_swamEVVAc/mntpoint/testswap18  file		996		0		-18
/tmp/LTP_swamEVVAc/mntpoint/testswap19  file		1000		0		-19
/tmp/LTP_swamEVVAc/mntpoint/testswap20  file		1000		0		-20
/tmp/LTP_swamEVVAc/mntpoint/testswap21  file		1000		0		-21
/tmp/LTP_swamEVVAc/mntpoint/testswap22  file		1000		0		-22
/tmp/LTP_swamEVVAc/mntpoint/testswap23  file		1000		0		-23
/tmp/LTP_swamEVVAc/mntpoint/testswap    file		1000		0		-24

This way would swapoff all LTP swaps including possible previous ones.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
