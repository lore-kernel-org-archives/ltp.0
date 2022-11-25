Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21189C4332F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 18:58:43 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2AEBA3CE31F
	for <ltp@archiver.kernel.org>; Fri, 25 Nov 2022 19:58:40 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BF91B3CDCC0
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 19:58:30 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 177256008C0
 for <ltp@lists.linux.it>; Fri, 25 Nov 2022 19:58:29 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C5AA1FD87;
 Fri, 25 Nov 2022 18:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1669402709; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QWScvZMkOqP0GVVnq5gKCLLJ1MF7MD6cvBAtRoY81F8=;
 b=MO4lhe6eIYLhcD+pbTu9Gw1fiXzula9nd8ONxTM8rjnewoqoz3xYEBwKDSKN1Wbf9vvRa3
 IDHGkZ4cAWON9U16I79lZ+J5elMEEWY+OZh89pLCm3qOoCv4BNRMYSXrziQ8HJPf44hYkI
 qt2ERvVqpcet9f0aatK+Ummq+vg4fow=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1669402709;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QWScvZMkOqP0GVVnq5gKCLLJ1MF7MD6cvBAtRoY81F8=;
 b=AXJO4sznxGly4IHOnIzQ0MXCqWiRQnY6/1vRTgaAwszbR24qaiu1n87MOqlcmfJo+V7IRQ
 QQKvqfpe7o0jJIAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1025E1361C;
 Fri, 25 Nov 2022 18:58:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id V3RQAVUQgWN2aAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 25 Nov 2022 18:58:29 +0000
Date: Fri, 25 Nov 2022 19:59:51 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y4EQp/E1AyLq8L2F@yuki>
References: <20221120191533.164848-1-tsahu@linux.ibm.com>
 <20221120191533.164848-5-tsahu@linux.ibm.com>
 <Y39cpPahJWYvQ4cT@yuki> <20221125173459.cwujma4km7gcd4vq@tarunpc>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221125173459.cwujma4km7gcd4vq@tarunpc>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 4/7] Hugetlb: Safe macro for posix_fadvise call
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, ltp@lists.linux.it, mike.kravetz@oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > >  include/tst_safe_macros.h | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > 
> > > diff --git a/include/tst_safe_macros.h b/include/tst_safe_macros.h
> > > index 81c4b0844..4965e44d0 100644
> > > --- a/include/tst_safe_macros.h
> > > +++ b/include/tst_safe_macros.h
> > > @@ -298,6 +298,23 @@ static inline int safe_ftruncate(const char *file, const int lineno,
> > >  #define SAFE_FTRUNCATE(fd, length) \
> > >  	safe_ftruncate(__FILE__, __LINE__, (fd), (length))
> > >  
> > > +static inline int safe_posix_fadvise(const char *file, const int lineno,
> > > +                                int fd, off_t offset, off_t len, int advice)
> > > +{
> > > +	int rval;
> > > +
> > > +	rval = posix_fadvise(fd, offset, len, advice);
> > > +
> > > +	if (rval)
> > > +		tst_brk_(file, lineno, TBROK | TERRNO,
> > > +			"posix_fadvise(%d,%ld,%ld,%d) failed",
> > > +			fd, (long)offset, (long)len, advice);
> > 
> > I did a closer look at the posix_fadvise() manual and it returns an
> > error in case of a failure, so the TERRNO is wrong here since that
> > would print whatever was the last error stored in there.
> > 
> > So we either have to do errno = rval; in the if (rval) branch or use
> > tst_strerrno() to print the errno ourselves.
> > 
> > Looking at the code we have the safe_pthread.c does use tst_strerrno()
> > to print the error, so I would be inclined to do so here as well.
> > 
> 
> posix_fadvise should be inline, and so for the convention it will be part of
> tst_safe_macros.h
> tst_strerrno is defined in lib/errnos.h
> 
> there are only two such header file declared in this way. errnos.h and
> signame.h. To be able to use tst_strerrno, it will require some cleanup
> (like converting .h to .c and transfer PAIR, STRPAIR macros definition to
> header files too from tst_res.c).
> 
> As, Even looking at past commits, I am not sure why these two file are
> implememnted as .h, and not available as in general. I am currently
> thinking of errno = rval way.
> 
> Can those file be converted?

Isn't the tst_strerrno() prototype defined in the tst_test.h?

The headers in lib/ are strictly internal implementation and shouldn't
be used from tests at all. And they don't have to be included at all,
since these are included in the test library in order to provide the
implementation for these functions.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
