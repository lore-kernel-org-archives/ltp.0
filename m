Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780A8C433F5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 08:57:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E056A3C96CF
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 09:57:12 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3EC73C732F
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 09:57:01 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 78EC41000456
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 09:57:01 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 644F51F45E;
 Fri, 21 Jan 2022 08:57:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642755420;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XkjioRvTgw8FhqG0mca/Jy55sYS44ULfIwKXhOkGsuE=;
 b=ioRESfBaauetDe+nyyPTUVb/8Mk5/02srpHWRNj8dzi3cadGWTphf+RX2wtgwEiyl+KLpm
 hZskhoVPVM0sOGyAQn5MNMzxMzR9MejA7W5tHspCNDeTif/6/KcdMwyHBuualEw/qq0VTR
 djIT9x2x4RZQb0HwHYMSf4ZOV2REfh0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642755420;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XkjioRvTgw8FhqG0mca/Jy55sYS44ULfIwKXhOkGsuE=;
 b=xGBbYuqWxR2iMZC0Ra1ZwTQRXgppD/7z1hEhEnHLXCGFw3mJeU+X+ZaQGjMcxzF3NnNQ3q
 EJuvRW4SnczgprCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E85F13C09;
 Fri, 21 Jan 2022 08:57:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1GyICVx16mF0RAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 21 Jan 2022 08:57:00 +0000
Date: Fri, 21 Jan 2022 09:56:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <Yep1Wm84sKzl3iB6@pevik>
References: <20220120150421.26639-1-andrea.cervesato@suse.de>
 <YemAQcXuJMGLh/kc@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YemAQcXuJMGLh/kc@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Reduce needed memory by the dio_read test
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

Hi all,

> Hi!
> > Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.de>
> > ---
> >  runtest/ltp-aiodio.part4 | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)

> > diff --git a/runtest/ltp-aiodio.part4 b/runtest/ltp-aiodio.part4
> > index fc1e1d479..8c10f67fb 100644
> > --- a/runtest/ltp-aiodio.part4
> > +++ b/runtest/ltp-aiodio.part4
> > @@ -62,7 +62,7 @@ DIT002 dio_truncate
> >  #Running read_checkzero
> >  #gread_checkzero
> >  #Running dio_read
> > -DOR000 dio_read -n 1 -i 100
> > -DOR001 dio_read -n 10 -i 30
> > -DOR002 dio_read -n 20 -i 15
> > -DOR003 dio_read -n 100 -i 4
> > +DOR000 dio_read -n 1 -i 100 -r 512k -w 512k -s 5M
> > +DOR001 dio_read -n 10 -i 30 -r 512k -w 512k -s 5M
> > +DOR002 dio_read -n 20 -i 15 -r 512k -w 512k -s 5M
> > +DOR003 dio_read -n 100 -i 4 -r 512k -w 512k -s 5M

> Limiting the child buffer to 512k makes sense, at least in the cases
> where n > 1 as by default the child allocates 32MB buffer, with 100
> children that makes up to ~3GB. Also this really should have been in the
> patch description, which should really describe why the changes have
> been done.

> But I'm not sure about the -s 5M part, the file size was always 128MB
> before and reducing it to 5M sounds like too much. On my machine that
> reduces the testing time from about one minute to a few seconds, that sounds
> like change that is too radical without further explanation. If we want
> to run the test with smaller file size I would go for 64M, that reduces
> the runtime to half without reducing the changes for triggering a bug
> too much.
Good catch.

I'm also going to verify ADSP075 dio_sparse  -w 518192k -s 518192k -n 1000
from ltp-aiodio.part2. Cyril's suggestion is to use '-n 1' to emulate
only single children in previous implementation.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
