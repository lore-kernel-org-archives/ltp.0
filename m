Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF70C47258
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 08:15:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 418093CE1E6
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 09:15:04 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05FE93C8B4B
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 09:14:45 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 69EFE140870E
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 09:14:44 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 51C361F846;
 Thu, 25 Jan 2024 08:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706170483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I8yBqshpZI6dDuYiNBBxXc6ykZxkVOm0qaLtTS7bmqU=;
 b=QjrdfIAV88rPV/fvOx2nh9cQUhSb1Yf57El2vqrPGSoXjJs959qlC/6B0C5fEtuPsDVPcq
 Yc3V0ipYPGnMen6d2SyVoMCpF0hNY8FsQ5Q1im76Yvf+qgW5/cSwmTDNU6KISYBh5M5dlB
 OjN4l5jO29OCZ+gU6bqvYt1LdtDBNNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706170483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I8yBqshpZI6dDuYiNBBxXc6ykZxkVOm0qaLtTS7bmqU=;
 b=qbXpEYbLJzGjsJkEeT7xguhGLTzU+WRm3qpwKDvfoge2G8/5HSX6iEggE/kKt2mzXk6Lya
 0LT/uK4FtV0vaVCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706170483; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I8yBqshpZI6dDuYiNBBxXc6ykZxkVOm0qaLtTS7bmqU=;
 b=QjrdfIAV88rPV/fvOx2nh9cQUhSb1Yf57El2vqrPGSoXjJs959qlC/6B0C5fEtuPsDVPcq
 Yc3V0ipYPGnMen6d2SyVoMCpF0hNY8FsQ5Q1im76Yvf+qgW5/cSwmTDNU6KISYBh5M5dlB
 OjN4l5jO29OCZ+gU6bqvYt1LdtDBNNU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706170483;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=I8yBqshpZI6dDuYiNBBxXc6ykZxkVOm0qaLtTS7bmqU=;
 b=qbXpEYbLJzGjsJkEeT7xguhGLTzU+WRm3qpwKDvfoge2G8/5HSX6iEggE/kKt2mzXk6Lya
 0LT/uK4FtV0vaVCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4002C13649;
 Thu, 25 Jan 2024 08:14:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ZajLDnMYsmWcIAAAD6G6ig
 (envelope-from <akumar@suse.de>); Thu, 25 Jan 2024 08:14:43 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Thu, 25 Jan 2024 09:14:42 +0100
Message-ID: <2729940.mvXUDI8C0e@localhost>
Organization: SUSE
In-Reply-To: <20240124170547.GA324363@pevik>
References: <325e7294-f6b1-4e27-a51b-8a8e146bf5bc@suse.cz>
 <05c3fd69-cee6-4575-8c93-eaeec24af1b6@suse.cz>
 <20240124170547.GA324363@pevik>
MIME-Version: 1.0
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=QjrdfIAV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=qbXpEYbL
X-Spamd-Result: default: False [-2.31 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_ORG_HEADER(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; CTE_CASE(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 51C361F846
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mmap04.c: Avoid vma merging
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

Hi Petr,

On Wednesday, January 24, 2024 6:05:47 PM CET Petr Vorel wrote:
> Hi Avinesh, Martin,
> 
> > Hi,
> > Reviewed-by: Martin Doucha <mdoucha@suse.cz>
> > 
> > On 24. 01. 24 14:26, Avinesh Kumar wrote:
> > > We hit a scenario where new mapping was merged with existing mapping of
> > > same permission and the return address from the mmap was hidden in the
> > > merged mapping in /proc/self/maps, causing the test to fail.
> > > To avoid this, we first  create a 2-page mapping with the different
> > > permissions, and then remap the 2nd page with the perms being tested.
> > > 
> > > Signed-off-by: Avinesh Kumar <akumar@suse.de>
> > > Reported-by: Martin Doucha <mdoucha@suse.cz>
> > > Signed-off-by: Avinesh Kumar <akumar@suse.de>
> > > ---
> > > 
> > >   testcases/kernel/syscalls/mmap/mmap04.c | 23 ++++++++++++++++-------
> > >   1 file changed, 16 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/testcases/kernel/syscalls/mmap/mmap04.c
> > > b/testcases/kernel/syscalls/mmap/mmap04.c index f6f4f7c98..fa85deed1
> > > 100644
> > > --- a/testcases/kernel/syscalls/mmap/mmap04.c
> > > +++ b/testcases/kernel/syscalls/mmap/mmap04.c
> > > @@ -17,8 +17,8 @@
> > > 
> > >   #include "tst_test.h"
> > >   #include <stdio.h>
> > > 
> > > -#define MMAPSIZE 1024
> > > -static char *addr;
> > > +static char *addr1;
> > > +static char *addr2;
> > > 
> > >   static struct tcase {
> > >   
> > >   	int prot;
> > > 
> > > @@ -44,14 +44,23 @@ static struct tcase {
> > > 
> > >   static void run(unsigned int i)
> > >   {
> > >   
> > >   	struct tcase *tc = &tcases[i];
> > > 
> > > -	char addr_str[20];
> > > 
> > >   	char perms[8];
> > >   	char fmt[1024];
> > > 
> > > +	unsigned int pagesize;
> > > +	int flag;
> > > -	addr = SAFE_MMAP(NULL, MMAPSIZE, tc->prot, tc->flags, -1, 0);
> > > +	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
> > > -	sprintf(addr_str, "%" PRIxPTR, (uintptr_t)addr);
> > > -	sprintf(fmt, "%s-%%*x %%s", addr_str);
> > > +	/* To avoid new mapping getting merged with existing mappings, we
> > > first
> > > +	 * create a 2-page mapping with the different permissions, and then
> > > remap
> > > +	 * the 2nd page with the perms being tested.
> > > +	 */
> > > +	flag = (tc->flags & MAP_PRIVATE) ? MAP_SHARED : MAP_PRIVATE;
> > > +	addr1 = SAFE_MMAP(NULL, pagesize * 2, PROT_NONE, MAP_ANONYMOUS | 
flag,
> > > -1, 0); +
> > > +	addr2 = SAFE_MMAP(addr1 + pagesize, pagesize, tc->prot, tc->flags |
> > > MAP_FIXED, -1, 0); +
> > > +	sprintf(fmt, "%" PRIxPTR "-%%*x %%s", (uintptr_t)addr2);
> > > 
> > >   	SAFE_FILE_LINES_SCANF("/proc/self/maps", fmt, perms);
> > >   	if (!strcmp(perms, tc->exp_perms)) {
> > > 
> > > @@ -61,7 +70,7 @@ static void run(unsigned int i)
> > > 
> > >   						tc-
>exp_perms, perms);
> > >   	
> > >   	}
> > > 
> > > -	SAFE_MUNMAP(addr, MMAPSIZE);
> > > +	SAFE_MUNMAP(addr1, pagesize * 2);
> 
> Shouldn't there be also second munmap()?
> SAFE_MUNMAP(addr2, pagesize);
No, we are unmapping both the mappings ( 2 pages ) together.

Regards,
Avinesh

> 
> Kind regards,
> Petr
> 
> > >   }
> > >   static struct tst_test test = {





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
