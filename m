Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5EEA1CCA470
	for <ltp@archiver.kernel.org>; Wed,  8 Oct 2025 12:16:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D06FA3CE754
	for <ltp@archiver.kernel.org>; Wed,  8 Oct 2025 14:16:25 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8E5D3C9B09
 for <ltp@lists.linux.it>; Wed,  8 Oct 2025 14:16:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 10ABB1A00A49
 for <ltp@lists.linux.it>; Wed,  8 Oct 2025 14:16:08 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 397D21F395;
 Wed,  8 Oct 2025 12:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759925768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RzfRyjI9BlYptmL/dJj7VbryvCXXqWiZfd+cya1foNA=;
 b=R8YGVG0vi1l3DWJrSPujS/itE0GKf0rKFoR41sJIMHYdLZiUd3345fEphlzgmR+aZQk1i3
 xFfAW54dk1MS2B3dfQ6TEUetpPLshE12ARe8B++K+lP9DqGvzJ+rW4efCQv4c072yy5d3c
 plsNc3MxTS3E/6t8UuJ4Mu0TTyhYuUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759925768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RzfRyjI9BlYptmL/dJj7VbryvCXXqWiZfd+cya1foNA=;
 b=fzfgg8lgDyIwRWFe+0KluI2RbIPyveVdBVFlXhDw6PbLqrY/y5EhE1PH1S94SfhNE/7Pql
 fVMwwtDoRULHzlBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759925768; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RzfRyjI9BlYptmL/dJj7VbryvCXXqWiZfd+cya1foNA=;
 b=R8YGVG0vi1l3DWJrSPujS/itE0GKf0rKFoR41sJIMHYdLZiUd3345fEphlzgmR+aZQk1i3
 xFfAW54dk1MS2B3dfQ6TEUetpPLshE12ARe8B++K+lP9DqGvzJ+rW4efCQv4c072yy5d3c
 plsNc3MxTS3E/6t8UuJ4Mu0TTyhYuUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759925768;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RzfRyjI9BlYptmL/dJj7VbryvCXXqWiZfd+cya1foNA=;
 b=fzfgg8lgDyIwRWFe+0KluI2RbIPyveVdBVFlXhDw6PbLqrY/y5EhE1PH1S94SfhNE/7Pql
 fVMwwtDoRULHzlBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 254A613A3D;
 Wed,  8 Oct 2025 12:16:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mQ+iBwhW5mjJOAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 08 Oct 2025 12:16:08 +0000
Date: Wed, 8 Oct 2025 14:16:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aOZWOueZOhTA0NzE@yuki.lan>
References: <20251007-xattrat-v2-0-bf458fa66358@suse.com>
 <20251007-xattrat-v2-3-bf458fa66358@suse.com>
 <aOUHqfyqp8IVne7S@yuki.lan> <DDC49J0CRCSN.3K67TAS5U4VES@suse.com>
 <aOUlNrZj7O0yFDBP@yuki.lan> <DDCVLBLAGO0H.3TXR2BW8Z5D5N@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DDCVLBLAGO0H.3TXR2BW8Z5D5N@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 03/10] setxattr01: add setxattrat variant
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
> > And as for filesystem support, it looks like TMPFS has
> > CONFIG_TMPFS_XATTR option so it could be enabled or disabled, however
> > they should be supported for native Linux filesystems such as ext, btrfs
> > or xfs.
> >
> > And we have to handle EOPNOTSUPP for setxattr() as well, so the test
> > setup would look like:
> >
> > 	if (tst_variant)
> > 		setxattrat_supported();
> > 	else
> > 		setxattr_supported();
> 
> The problem I have with this approach is that the whole kernel
> implementation of setxattr() is based on setxattrat() and this test is
> just moving through the same code.

The problem at hand is that the *attrat() syscalls were added to 6.13,
we are going to be stuck for a decade with kernels that does not support
these. Which means that we have to make sure to check for ENOSYS for
the at family of the xattr syscalls somewhere anyways and we have to
make sure that the coverage for the older syscalls is sufficient too.

> I would like to give a bare minimum attention. At the same time, we
> need to test a syscall by calling it with the right data, on files,
> that is something we are already doing during the test. For instance,
> we don't have a "foo" run and we are just going around setup() which
> is really slow only for filesystems testing.  In general, letting the
> syscall to fail inside test won't get much time.

Technically you can call the setxattrat() with a dummy parameters, they
does not even have to be correct, because if the syscall is not
supported in the kernel you will get ENOSYS as soon as the kernel
attempts to fetch the handler form the syscall table.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
