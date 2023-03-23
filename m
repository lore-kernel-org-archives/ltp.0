Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E957C6FD1C
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 12:18:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 076E53C03E4
	for <ltp@archiver.kernel.org>; Thu, 23 Mar 2023 13:18:16 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0F613C03E4
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 13:18:05 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 475B01400421
 for <ltp@lists.linux.it>; Thu, 23 Mar 2023 13:18:04 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6BF4021D35;
 Thu, 23 Mar 2023 12:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1679573884; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SXiDEC9XEX3ZzYCzoPNjpo3NNW7pgbHhtRedag9jAQQ=;
 b=YwU5Llt68XJIvW3s/rtGK0a/lViSmVDx20L66kxd9DmTFbwKPWfKH9NLPmRw6a4pXfyvMy
 L3VFA+MiGMIOFowdfkJmcBZm1Tfd+xzZ1VeV8my10hsApUSc5DhTvcRwwYFB0zvKhCAqBl
 I/46KrX8FiUSSMU2HyTbbI4gZtG8WOs=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F2E45132C2;
 Thu, 23 Mar 2023 12:18:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0im0KXpDHGRmLwAAMHmgww
 (envelope-from <wegao@suse.com>); Thu, 23 Mar 2023 12:18:02 +0000
Date: Thu, 23 Mar 2023 08:17:57 -0400
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <20230323121757.GA30319@localhost>
References: <20230226003526.8733-1-wegao@suse.com>
 <20230323092655.GF405493@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230323092655.GF405493@pevik>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] clone3: Add clone3's clone_args cgroup
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu, Mar 23, 2023 at 10:26:55AM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> Do you plan to use this somewhere? Otherwise I don't see the point to just
> add it.
Sorry i need add another commit above this and start using new added args, will
create test case later, maybe you can put ChangRequest firstly, thanks.
> 
> Kind regards,
> Petr
> 
> > Signed-off-by: Wei Gao <wegao@suse.com>
> > ---
> >  include/lapi/sched.h | 3 +++
> >  include/tst_clone.h  | 1 +
> >  lib/tst_clone.c      | 1 +
> >  3 files changed, 5 insertions(+)
> 
> > diff --git a/include/lapi/sched.h b/include/lapi/sched.h
> > index 1065665d1..3ad16d136 100644
> > --- a/include/lapi/sched.h
> > +++ b/include/lapi/sched.h
> > @@ -54,6 +54,9 @@ struct clone_args {
> >  	uint64_t __attribute__((aligned(8))) stack;
> >  	uint64_t __attribute__((aligned(8))) stack_size;
> >  	uint64_t __attribute__((aligned(8))) tls;
> > +	uint64_t __attribute__((aligned(8))) set_tid;
> > +	uint64_t __attribute__((aligned(8))) set_tid_size;
> > +	uint64_t __attribute__((aligned(8))) cgroup;
> >  };
> 
> >  static inline int clone3(struct clone_args *args, size_t size)
> > diff --git a/include/tst_clone.h b/include/tst_clone.h
> > index 9ffdc68d1..7b278dfa7 100644
> > --- a/include/tst_clone.h
> > +++ b/include/tst_clone.h
> > @@ -11,6 +11,7 @@
> >  struct tst_clone_args {
> >  	uint64_t flags;
> >  	uint64_t exit_signal;
> > +	uint64_t cgroup;
> >  };
> 
> >  /* clone3 with fallbacks to clone when possible. Be aware that it
> > diff --git a/lib/tst_clone.c b/lib/tst_clone.c
> > index ecc84408c..2aa00beb1 100644
> > --- a/lib/tst_clone.c
> > +++ b/lib/tst_clone.c
> > @@ -15,6 +15,7 @@ pid_t tst_clone(const struct tst_clone_args *tst_args)
> >  	struct clone_args args = {
> >  		.flags = tst_args->flags,
> >  		.exit_signal = tst_args->exit_signal,
> > +		.cgroup = tst_args->cgroup,
> >  	};
> >  	int flags;
> >  	pid_t pid = -1;

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
