Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47577F8A146
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 10:07:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E3B2D3E2EF7
	for <ltp@archiver.kernel.org>; Thu, 16 Apr 2026 12:07:28 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3A2023DCD6A
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:07:05 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7C9D76001EE
 for <ltp@lists.linux.it>; Thu, 16 Apr 2026 12:07:05 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3C1E05BD14;
 Thu, 16 Apr 2026 10:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776334024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mppv07pqdwTD/ibhMEtyQxrQEqW5Expq0E6DPW8ArZk=;
 b=u+KNim2eyYG1GtU9xAhLy8hJ/T1ag2Zkk5BGPlqR6QABIPFvWCCWlDyUWQKo7t9P0jzicU
 0a21pqL9V8thjsHWZAsNc76NF+UrrQQJOPEuBcSyz+btcrTavg2S/x0gK+/MKooRFE+EtD
 OPXb4fCAABf3KVG9k1WJpXFOv1AZGq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776334024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mppv07pqdwTD/ibhMEtyQxrQEqW5Expq0E6DPW8ArZk=;
 b=PSq3BnSceUsnAH0wgPEi5UV7ZZ22OrqUGKz3utku3gxU7CTP+XubjUAZ/kroQ/oykY4SXJ
 KElEU7NMGr5krTCQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=u+KNim2e;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PSq3BnSc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1776334024; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mppv07pqdwTD/ibhMEtyQxrQEqW5Expq0E6DPW8ArZk=;
 b=u+KNim2eyYG1GtU9xAhLy8hJ/T1ag2Zkk5BGPlqR6QABIPFvWCCWlDyUWQKo7t9P0jzicU
 0a21pqL9V8thjsHWZAsNc76NF+UrrQQJOPEuBcSyz+btcrTavg2S/x0gK+/MKooRFE+EtD
 OPXb4fCAABf3KVG9k1WJpXFOv1AZGq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1776334024;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mppv07pqdwTD/ibhMEtyQxrQEqW5Expq0E6DPW8ArZk=;
 b=PSq3BnSceUsnAH0wgPEi5UV7ZZ22OrqUGKz3utku3gxU7CTP+XubjUAZ/kroQ/oykY4SXJ
 KElEU7NMGr5krTCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2B9AD4BEDD;
 Thu, 16 Apr 2026 10:07:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gFVqCci04GnyEQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 16 Apr 2026 10:07:04 +0000
Date: Thu, 16 Apr 2026 12:07:18 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Cermak <mcermak@redhat.com>
Message-ID: <aeC01nkaA2jzhUVV@yuki.lan>
References: <20260414114758.7xtei7hyddxu2fic@lida.tpb.lab.eng.brq.redhat.com>
 <ad9l7MeJneX1LdCe@yuki.lan>
 <20260416092131.kkbfd3cdi3tv7z7l@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260416092131.kkbfd3cdi3tv7z7l@lida.tpb.lab.eng.brq.redhat.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid, suse.cz:dkim, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo, imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Queue-Id: 3C1E05BD14
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Avoid syscall param ioctl(generic) points to
 uninitialised byte(s)
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
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > > diff --git a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> > > index 7368d3863..d24766e7c 100644
> > > --- a/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> > > +++ b/testcases/kernel/syscalls/userfaultfd/userfaultfd01.c
> > > @@ -92,8 +92,8 @@ static void *handle_thread(void)
> > >  static void run(unsigned int i)
> > >  {
> > >  	pthread_t thr;
> > > -	struct uffdio_api uffdio_api = {};
> > > -	struct uffdio_register uffdio_register;
> > > +	struct uffdio_api uffdio_api = {0, };
> > > +	struct uffdio_register uffdio_register = {0, };
> > 
> > Given that we were using = {}; in the code before can we keep using that
> > and for all instances?
> 
> I saw both initializers in the LTP source, see `$ grep -rIn  '= {};'` and
> `$ grep -rIn  '= { 0, };'`.  The latter one is compliant with older standards.
> But to keep the coding style within this file, I've updated the initializer.
> 
> > Also I assume the problem is the ioctls field in the uffdio_api
> > structure that is not initialized beacuse is supposed to be set by
> > kernel before returning into userspace. Should valgrind warn about such
> > cases?
> 
> You are right that zeroing just this uffdio_register.ioctls = 0; is suffi-
> cient to to avoid the valgrind complaint.  Zeroing whole the struct seems
> syntactically more concise and also correct.

That's not what I was trying to point out. Some fields of structures
passed to ioctls are output-only. The question is if valgrind should
warn if we do not set output only field in such structure?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
