Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E3D6C04FFE
	for <ltp@archiver.kernel.org>; Thu,  2 May 2024 10:10:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25BA33CC169
	for <ltp@archiver.kernel.org>; Thu,  2 May 2024 12:10:18 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0F7533CB7ED
 for <ltp@lists.linux.it>; Thu,  2 May 2024 12:10:02 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id B96C520723D
 for <ltp@lists.linux.it>; Thu,  2 May 2024 12:10:01 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AC291351C6;
 Thu,  2 May 2024 10:09:58 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8F18613957;
 Thu,  2 May 2024 10:09:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mO6nInZmM2ZFCQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 02 May 2024 10:09:58 +0000
Date: Thu, 2 May 2024 12:09:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Filippo Storniolo <fstornio@redhat.com>
Message-ID: <ZjNmQBfgqBzyUow7@yuki>
References: <20240429133336.3166386-1-fstornio@redhat.com>
 <Zi-lJZW244sciuW9@yuki>
 <CAHzY_-7DrwOOtawRziNo0CRS=VbEeNWF_sX_COpPaw_9s+J2nw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHzY_-7DrwOOtawRziNo0CRS=VbEeNWF_sX_COpPaw_9s+J2nw@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: AC291351C6
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/mlock05: add mlock test for locking
 and pre-faulting of memory
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
> After some investigation, I realized the issue is caused by the
> unreliability of the VmRSS field in /proc/$pid/status.
> Documentation suggests to use /proc/$pid/smaps for reliable information.
> 
> This file contains information about each memory mapping, so it contains
> multiple instances of the VmRss field (In this file is simply referred as
> Rss).
> 
> I managed to run the test without any failures using a custom function.
> What we need to do is to iterate through the memory mappings until we find
> the one we need. We can use the memory address retrieved by mmap to locate
> the desired one.
> 
> Once we find the mapping, we can then search the Rss field.
> 
> This is the output I had using this approach:
> 
> TPASS: Expect: (VmRSS=1048576) >= (MMAPLEN=1048576)
> TPASS: VmLck == MMAPLEN (1048576)
> 
> Summary:
> passed  20000
> failed   0
> broken   0
> skipped  0
> warnings 0
> 
> Do you think this can work as a solution or you prefer another way around?

Looking up the right mapping and checking that the size of the resident
set is as expected sounds good to me.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
