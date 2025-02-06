Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA5A5C02194
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 13:23:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 605CA3C9282
	for <ltp@archiver.kernel.org>; Thu,  6 Feb 2025 14:23:18 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9C5E93C04A5
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 14:23:02 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id DAB9D651791
 for <ltp@lists.linux.it>; Thu,  6 Feb 2025 14:23:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 36AC421164;
 Thu,  6 Feb 2025 13:23:00 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 24D9013694;
 Thu,  6 Feb 2025 13:23:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fPvwB7S3pGc9EAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 06 Feb 2025 13:23:00 +0000
Date: Thu, 6 Feb 2025 14:22:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Z6S3sYucYPK6DuZu@yuki.lan>
References: <700f4d3bc73f0deebe7fe0e41305d365135c53eb.1738835278.git.jstancek@redhat.com>
 <Z6Sux-uScF-o3g7W@yuki.lan>
 <CAASaF6zuFMWJhph-8U4RRMhd0uHt1_mOVU5Bu0pZ=CVoLf+igw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6zuFMWJhph-8U4RRMhd0uHt1_mOVU5Bu0pZ=CVoLf+igw@mail.gmail.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 36AC421164
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/mallinfo02: introduce LTP_VAR_USED to
 avoid optimization
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
> > > gcc 15 is a bit more clever and noticed that 'buf' isn't used
> > > for anything so it optimized it out, including call to malloc.
> > > So, there's also no mmap() call behind it and test fails,
> > > because nothing was allocated.
> >
> > Huh, that sounds like the optimizations are getting more and more evil
> > over the time.
> 
> Also see the next patch for bpf.

Sigh...

> > > Introduce LTP_VAR_USED macro, that makes compiler aware of the
> > > variable and doesn't optimize it out.
> > >
> > > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > > ---
> > >  include/tst_common.h                               | 2 ++
> > >  testcases/kernel/syscalls/mallinfo2/mallinfo2_01.c | 2 +-
> > >  2 files changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/include/tst_common.h b/include/tst_common.h
> > > index b14bbae04077..3de826acd0ec 100644
> > > --- a/include/tst_common.h
> > > +++ b/include/tst_common.h
> > > @@ -13,6 +13,8 @@
> > >  #define LTP_ATTRIBUTE_UNUSED         __attribute__((unused))
> > >  #define LTP_ATTRIBUTE_UNUSED_RESULT  __attribute__((warn_unused_result))
> > >
> > > +#define LTP_VAR_USED(p) asm volatile("" :: "m"(p)); p
> >
> > Shouldn't __attribute__((used)) suffice?
> 
> It's ignored for local variables. It does work for global ones.

Maybe mention that in the commit description...

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
