Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45EE3C433EF
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 13:12:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4B9D13CA637
	for <ltp@archiver.kernel.org>; Tue, 19 Apr 2022 15:12:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6C3473C217A
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 15:12:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E039C1A008AA
 for <ltp@lists.linux.it>; Tue, 19 Apr 2022 15:12:13 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 257821F38D;
 Tue, 19 Apr 2022 13:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650373933; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VYrp6bdnpaQ0LkVyYS26YwQnFCOrqXTCWxZ7WVofOis=;
 b=Hd0HhUoPOKqJyVtsDPCKJOmnGA6WSpNPCEVNxResAc2sVjQzrGYaDWD9ipvymiYtfYvFgH
 u9xuOIKFvIvZaLc6RlXfoQdmjY6l/e11rl8NoWvHrJEPPHIOqokqvchCcx/oqB9WyC6R2c
 zS0ukayDhJkb92svdgIl12+50UYr9+A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650373933;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VYrp6bdnpaQ0LkVyYS26YwQnFCOrqXTCWxZ7WVofOis=;
 b=saYn5I6owRU3RjVjcv2ytcffEF6pd+BjpqJaPOOTDqaKep9tlAYa7ylkctB3Ge2XQGQFud
 SOdD5n3jTn5QIRAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11FB4139BE;
 Tue, 19 Apr 2022 13:12:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BZQdAy21XmL8fwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 19 Apr 2022 13:12:13 +0000
Date: Tue, 19 Apr 2022 15:14:29 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: zhaogongyi <zhaogongyi@huawei.com>
Message-ID: <Yl61tZWzUo5gIq3f@yuki>
References: <09052cfe41694a07ad31c2919e16c4c6@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <09052cfe41694a07ad31c2919e16c4c6@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/io_submit: Add TTERRNO/TERRNO when test
 fail
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > 
> > NACK.
> > 
> > As far as I can tell the io_submit() calls returns negative error instead of
> > setting errno, at least that's what libaio documentation states.
> 
> Yes, according to linux manual, libaio interface don't set errno when calling failed, so, do we also need to remove the TREENO here?
> 
> 80         TEST(io_setup(1, &ctx));
> 81         if (TST_RET == -ENOSYS)
> 82                 tst_brk(TCONF | TRERRNO, "io_setup(): AIO not supported by kernel");
> 83         else if (TST_RET)
> 84                 tst_brk(TBROK | TRERRNO, "io_setup() failed");

Yes please, this should be replaced by manually printing
tst_strerrno(-TST_RET).

> > > diff --git a/testcases/kernel/syscalls/io_submit/io_submit02.c
> > > b/testcases/kernel/syscalls/io_submit/io_submit02.c
> > > index 38b8555d8..6ba4d99a5 100644
> > > --- a/testcases/kernel/syscalls/io_submit/io_submit02.c
> > > +++ b/testcases/kernel/syscalls/io_submit/io_submit02.c
> > > @@ -79,7 +79,7 @@ static void run(unsigned int i)
> > >  	if (TST_RET == tc[i].nr)
> > >  		tst_res(TPASS, "io_submit() %s", tc[i].desc);
> > >  	else
> > > -		tst_res(TFAIL, "io_submit() returns %ld, expected %ld", TST_RET,
> > tc[i].nr);
> > > +		tst_res(TFAIL | TTERRNO, "io_submit() returns %ld,
> > expected %ld",
> > > +TST_RET, tc[i].nr);
> > 
> > The best we can do here is to use tst_strerrno() to print the error as we do
> > in the io_submit().
> 
> According to linux manual, call io_submit through syscall, it will set errno:
> 	"If the system call is invoked via syscall(2), then the return value follows the usual conventions for indicating an error: -1, with  errno  set  to  a
>     (positive) value that indicates the error."

Ah right, as long as we use the syscall() wrapper the negative error
return value will be moved to the errno variable by the wrapper, so this
part is correct.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
