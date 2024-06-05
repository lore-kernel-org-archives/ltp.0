Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1263DC27C53
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 14:12:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4978B3D0998
	for <ltp@archiver.kernel.org>; Wed,  5 Jun 2024 16:12:41 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 017D83D083A
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 16:12:25 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 62ABD1018999
 for <ltp@lists.linux.it>; Wed,  5 Jun 2024 16:12:24 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5A6411F821;
 Wed,  5 Jun 2024 14:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717596744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nmXIF5HLf4IWffvZ0QN7N4H4uh/E8W8DEg5v7uxiFgY=;
 b=Bb0UDMZy9ab6IzNuxt8szsKD9I1yx+j0KRQnRE6yUPkVrDEcrRsv2vjXNchOpOCaP3c7TB
 Zlr8MLVrNwgDzxY8rJS5ERrK0vob7oGU5y8GS98ggljrBynB9am52+unxbjEApumB/zEJs
 i/qEAi6poOwJq8UMX2feag4GgchlZWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717596744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nmXIF5HLf4IWffvZ0QN7N4H4uh/E8W8DEg5v7uxiFgY=;
 b=pxdPJdv/GV4POAkyQ3Aak+AKJuHADTGZ6SEUofW6ldEKRet6hHSxL8FB3b0beMDQ0UbP6C
 qo3KjqdRukZW3iCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1717596744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nmXIF5HLf4IWffvZ0QN7N4H4uh/E8W8DEg5v7uxiFgY=;
 b=Bb0UDMZy9ab6IzNuxt8szsKD9I1yx+j0KRQnRE6yUPkVrDEcrRsv2vjXNchOpOCaP3c7TB
 Zlr8MLVrNwgDzxY8rJS5ERrK0vob7oGU5y8GS98ggljrBynB9am52+unxbjEApumB/zEJs
 i/qEAi6poOwJq8UMX2feag4GgchlZWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1717596744;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nmXIF5HLf4IWffvZ0QN7N4H4uh/E8W8DEg5v7uxiFgY=;
 b=pxdPJdv/GV4POAkyQ3Aak+AKJuHADTGZ6SEUofW6ldEKRet6hHSxL8FB3b0beMDQ0UbP6C
 qo3KjqdRukZW3iCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2739913A24;
 Wed,  5 Jun 2024 14:12:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oZC8CEhyYGbeLQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 05 Jun 2024 14:12:24 +0000
Date: Wed, 5 Jun 2024 16:12:22 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240605141222.GA389506@pevik>
References: <20240604-unlink09-v1-1-dfd8e3e1cb2b@suse.com>
 <20240605065755.GB348321@pevik> <20240605073806.GA355314@pevik>
 <8aef8014-e4ea-407d-9b88-423449612665@suse.cz>
 <20240605121142.GA387399@pevik> <20240605122741.GB387399@pevik>
 <ad6558e0-e834-4b35-923a-7b519384f436@suse.cz>
 <20240605132134.GA393734@pevik> <ZmBro_t3U02xDNTe@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZmBro_t3U02xDNTe@yuki>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Fix unlink09 test
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
Cc: ltp@lists.linux.it, Sebastian Chlad <schlad@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi!
> > > It would be useful and prepare_device() implements everything that's needed
> > > for it but there's a bug in do_setup() which creates a conflict between the
> > > two attributes. The .all_filesystems attribute forces .needs_device but a
> > > few lines below that is a check that .needs_rofs and .needs_device are not
> > > set at the same time. This can be fixed.

> > Thanks for info, I'll have look into it.

> It may not be needed. The counter argument is that if you mix a read
> only filesystem tests and all_filesystems in one test you are combining
> two unrelated things that are probably better to be done in a separate
> tests.

I thought that we have use case for testing all (or most) filesystems in read
only mode, instead testing just whatever is in the default /tmp. But sure,
I'll will not do that unless others think it's an useful feature.

So does it mean that all read only filesystems behave the same?
So far we have 14 tests with .needs_rofs
testcases/kernel/syscalls/access/access04.c
testcases/kernel/syscalls/acct/acct01.c
testcases/kernel/syscalls/chmod/chmod06.c
testcases/kernel/syscalls/chown/chown04.c
testcases/kernel/syscalls/creat/creat06.c
testcases/kernel/syscalls/fchmod/fchmod06.c
testcases/kernel/syscalls/fchown/fchown04.c
testcases/kernel/syscalls/link/link08.c
testcases/kernel/syscalls/mkdir/mkdir03.c
testcases/kernel/syscalls/mkdirat/mkdirat02.c
testcases/kernel/syscalls/rmdir/rmdir02.c
testcases/kernel/syscalls/unlink/unlink09.c
testcases/kernel/syscalls/utime/utime06.c
testcases/kernel/syscalls/utimes/utimes01.c

From these at least mkdir, rmdir, link, unlink have member in struct
inode_operations [1] (thus custom operation per filesystem, right?)
I suppose update_time might be related to utime* tests.
There are other members, but for these we IMHO don't test wit rofs.

Then, there is struct file_operations with open, read, write,
{compat,unlocked}_ioctl, llseek, ... operations which (at least open) are used
in various tests.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/linux/fs.h#n2062

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
