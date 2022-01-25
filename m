Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6DF2C433F5
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 17:09:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF7463C96DB
	for <ltp@archiver.kernel.org>; Tue, 25 Jan 2022 18:09:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 216A93C54C9
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 18:09:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4618A140118C
 for <ltp@lists.linux.it>; Tue, 25 Jan 2022 18:09:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2EF66212C9;
 Tue, 25 Jan 2022 17:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643130546;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ABdZqwnAiXI6pekD0H6X2cQbJqC0ASZ0KbSPN1k3w7k=;
 b=Da0fCOjjg9tqWN8+e4jdWs6H9HwJz/ucTeD6DHFyH51G6fivZPwjT1rYx4q506qke5MYwL
 itfrnSQ1k9qOlugr7SLh4WxlCPdf/vp9Ig9pPoQtT+0yxIoyrgfbBtBU7o1CzgtfiU0BLn
 g+k8yQ4gxTffnhAiKLK4EkRbzdy4o3I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643130546;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ABdZqwnAiXI6pekD0H6X2cQbJqC0ASZ0KbSPN1k3w7k=;
 b=b+7JCUS4NEr6Pup0b4guJ+vseIZ+0U8ZbJtst4o19RR0Lv4ap7Pd5wK8DyjAq5urmKtrIm
 VfOc37Fxh5ULkrAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0477913E05;
 Tue, 25 Jan 2022 17:09:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id CYH9ObEu8GHISgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 25 Jan 2022 17:09:05 +0000
Date: Tue, 25 Jan 2022 18:09:03 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YfAur2HsIJMHaKc+@pevik>
References: <20211208082625.26324-1-pvorel@suse.cz>
 <Ye7CwmegfyHXgN2N@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ye7CwmegfyHXgN2N@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] m4: Fix warnings
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
> > diff --git a/m4/ltp-eventfd.m4 b/m4/ltp-eventfd.m4
> > index 5d729a33d..580df00a3 100644
> > --- a/m4/ltp-eventfd.m4
> > +++ b/m4/ltp-eventfd.m4
> > @@ -12,12 +12,10 @@ AC_DEFUN([LTP_CHECK_SYSCALL_EVENTFD], [
> >  		AC_SUBST(AIO_LIBS, "-laio")

> >  		AC_MSG_CHECKING([io_set_eventfd is defined in aio library or aio header])
> > -		AC_TRY_LINK([#include <stdio.h>
> > +		AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include <stdio.h>
> >                               #include <libaio.h>
> > -		            ],
> > -		            [io_set_eventfd(NULL, 0); return 0;],
> > +		            ]], [[io_set_eventfd(NULL, 0); return 0;]])],
> >  		            [AC_DEFINE(HAVE_IO_SET_EVENTFD, 1, [Define to 1 if you have `io_set_eventfd' function.])
> > -						AC_MSG_RESULT(yes)],
> > -		            [AC_MSG_RESULT(no)])
> > +						AC_MSG_RESULT(yes)],[AC_MSG_RESULT(no)])

> Shouldn't we convert this bit into AC_CHECK_FUNCS() (in a separte patch)?

Well, this function is defined as inline in libaio.h.
I was not able to check it with AC_CHECK_FUNCS, nor with AC_CHECK_LIB nor
AC_SEARCH_LIBS.

It was added in Jan 2008 in libaio-0.3.108, even Centos 6 has 0.3.109 (which
cannot compile at least 2 releases back), SLES11-SP4 and Debian stretch
(oldoldstable) have 0.3.110. I guess it's time to expect io_set_eventfd is in
libaio.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
