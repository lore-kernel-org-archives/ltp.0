Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0038BC46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 14:36:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 983E13CFB3F
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 15:36:56 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6FA5F3CEE6A
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 15:36:32 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 60AAB600798
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 15:36:31 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 9027E2200D;
 Wed, 24 Jan 2024 14:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706106990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U48GhGjTaGvY746EE7JSAuVTIxaEh/g3WDI4z+6SK74=;
 b=EBfl+/qnVrcgPDVMg41zhyisXvq+yHw+rwGNMt6XJDCe+dPWE9O2MlielLqyQ3xbqzB0ej
 csTE5/VIGzC7i0a/xZ+rnfDcj4gpJZpSnL6K2xDn3uj+3jmqqglJQX26G+t0pGgA/1dfsr
 G4MhgZtrjkyntiE65NsgCIwKui+akoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706106990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U48GhGjTaGvY746EE7JSAuVTIxaEh/g3WDI4z+6SK74=;
 b=aNwvDvmyLMxe9wNcyY2gsNupis552OFIWzh3vjTGxo9uu+rDMgQWjZ0lVaQ0G9Ti4vEBdJ
 yaS6cz2AjQJ/kPCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1706106990; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U48GhGjTaGvY746EE7JSAuVTIxaEh/g3WDI4z+6SK74=;
 b=EBfl+/qnVrcgPDVMg41zhyisXvq+yHw+rwGNMt6XJDCe+dPWE9O2MlielLqyQ3xbqzB0ej
 csTE5/VIGzC7i0a/xZ+rnfDcj4gpJZpSnL6K2xDn3uj+3jmqqglJQX26G+t0pGgA/1dfsr
 G4MhgZtrjkyntiE65NsgCIwKui+akoU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1706106990;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U48GhGjTaGvY746EE7JSAuVTIxaEh/g3WDI4z+6SK74=;
 b=aNwvDvmyLMxe9wNcyY2gsNupis552OFIWzh3vjTGxo9uu+rDMgQWjZ0lVaQ0G9Ti4vEBdJ
 yaS6cz2AjQJ/kPCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 804D81333E;
 Wed, 24 Jan 2024 14:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id N/t3Hm4gsWU5XQAAD6G6ig
 (envelope-from <akumar@suse.de>); Wed, 24 Jan 2024 14:36:30 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 24 Jan 2024 15:36:30 +0100
Message-ID: <2947768.e9J7NaK4W3@localhost>
Organization: SUSE
In-Reply-To: <325e7294-f6b1-4e27-a51b-8a8e146bf5bc@suse.cz>
References: <20240123165539.32514-1-akumar@suse.de>
 <325e7294-f6b1-4e27-a51b-8a8e146bf5bc@suse.cz>
MIME-Version: 1.0
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-6.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; MID_RHS_NOT_FQDN(0.50)[];
 REPLY(-4.00)[]; HAS_ORG_HEADER(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; CTE_CASE(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap04.c: Avoid vma merging
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

Hi Martin,

On Wednesday, January 24, 2024 12:56:58 PM CET Martin Doucha wrote:
> Hi,
> some comments below.
> 
> On 23. 01. 24 17:55, Avinesh Kumar wrote:
> > We hit a scenario where new mapping was merged with existing mapping of
> > same permission and the return address from the mmap was hidden in the
> > merged mapping in /proc/self/maps, causing the test to fail.
> > To avoid this, we first  create a 2-page mapping with the different
> > permissions, and then remap the 2nd page with the perms being tested.
> > 
> > Signed-off-by: Avinesh Kumar <akumar@suse.de>
> > Reported-by: Martin Doucha <mdoucha@suse.cz>
> > ---
> > 
> >   testcases/kernel/syscalls/mmap/mmap04.c | 49 +++++++++++++++----------
> >   1 file changed, 30 insertions(+), 19 deletions(-)
> > 
> > diff --git a/testcases/kernel/syscalls/mmap/mmap04.c
> > b/testcases/kernel/syscalls/mmap/mmap04.c index f6f4f7c98..f0f87b7f5
> > 100644
> > --- a/testcases/kernel/syscalls/mmap/mmap04.c
> > +++ b/testcases/kernel/syscalls/mmap/mmap04.c
> > @@ -17,28 +17,28 @@
> > 
> >   #include "tst_test.h"
> >   #include <stdio.h>
> > 
> > -#define MMAPSIZE 1024
> > -static char *addr;
> > +static char *addr1;
> > +static char *addr2;
> > 
> >   static struct tcase {
> >   
> >   	int prot;
> >   	int flags;
> >   	char *exp_perms;
> >   
> >   } tcases[] = {
> > 
> > -	{PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE, "---p"},
> > -	{PROT_NONE, MAP_ANONYMOUS | MAP_SHARED, "---s"},
> > -	{PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE, "r--p"},
> > -	{PROT_READ, MAP_ANONYMOUS | MAP_SHARED, "r--s"},
> > -	{PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, "-w-p"},
> > -	{PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, "-w-s"},
> > -	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE, "rw-p"},
> > -	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED, "rw-s"},
> > -	{PROT_READ | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, "r-xp"},
> > -	{PROT_READ | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, "r-xs"},
> > -	{PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE, "-wxp"},
> > -	{PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED, "-wxs"},
> > -	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE,
> > "rwxp"}, -	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS |
> > MAP_SHARED, "rwxs"} +	{PROT_NONE, MAP_ANONYMOUS | MAP_PRIVATE |
> > MAP_FIXED, "---p"},
> > +	{PROT_NONE, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "---s"},
> > +	{PROT_READ, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "r--p"},
> > +	{PROT_READ, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "r--s"},
> > +	{PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "-w-p"},
> > +	{PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "-w-s"},
> > +	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED,
> > "rw-p"}, +	{PROT_READ | PROT_WRITE, MAP_ANONYMOUS | MAP_SHARED |
> > MAP_FIXED, "rw-s"}, +	{PROT_READ | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE
> > | MAP_FIXED, "r-xp"}, +	{PROT_READ | PROT_EXEC, MAP_ANONYMOUS |
> > MAP_SHARED | MAP_FIXED, "r-xs"}, +	{PROT_WRITE | PROT_EXEC, 
MAP_ANONYMOUS
> > | MAP_PRIVATE | MAP_FIXED, "-wxp"}, +	{PROT_WRITE | PROT_EXEC,
> > MAP_ANONYMOUS | MAP_SHARED | MAP_FIXED, "-wxs"}, +	{PROT_READ |
> > PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_PRIVATE | MAP_FIXED, "rwxp"},
> > +	{PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_SHARED |
> > MAP_FIXED, "rwxs"}
> The MAP_FIXED flag doesn't belong in the testcases, it should be added
> in the mmap() call instead: SAFE_MMAP(..., tc->flags | MAP_FIXED, ...);
> It's an implementation detail not related to the testcases themselves.
> You don't want to rewrite all the test cases again if we decide to not
> use MAP_FIXED for whatever reason in the future.
> 
Thank you for review and all the corrections/suggestions. I have send the 
updated patch.

> >   };
> >   
> >   static void run(unsigned int i)
> > 
> > @@ -47,10 +47,21 @@ static void run(unsigned int i)
> > 
> >   	char addr_str[20];
> >   	char perms[8];
> >   	char fmt[1024];
> > 
> > +	unsigned int pagesize;
> > 
> > -	addr = SAFE_MMAP(NULL, MMAPSIZE, tc->prot, tc->flags, -1, 0);
> > +	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
> > 
> > -	sprintf(addr_str, "%" PRIxPTR, (uintptr_t)addr);
> > +	/* To avoid new mapping getting merged with existing mappings, we 
first
> > +	   create a 2-page mapping with the different permissions, and then
> > remap
> > +	   the 2nd page with the perms being tested. */
> > +	if ((tc->prot == PROT_NONE) && (tc->flags == (MAP_ANONYMOUS |
> > MAP_PRIVATE | MAP_FIXED))) +		addr1 = SAFE_MMAP(NULL, 
pagesize * 2,
> > PROT_READ, MAP_ANONYMOUS | MAP_SHARED, -1, 0); +	else
> > +		addr1 = SAFE_MMAP(NULL, pagesize * 2, PROT_NONE, 
MAP_ANONYMOUS |
> > MAP_PRIVATE, -1, 0);
> This would be cleaner (just invert the shared/private flag):
> int flags = (tc->flags & MAP_PRIVATE) ? MAP_SHARED : MAP_PRIVATE;
> addr1 = SAFE_MMAP(NULL, pagesize * 2, PROT_NONE, MAP_ANONYMOUS | flags,
> -1, 0);
> 
> > +
> > +	addr2 = SAFE_MMAP(addr1 + pagesize, pagesize, tc->prot, tc->flags, 
-1,
> > 0); +
> > +	sprintf(addr_str, "%" PRIxPTR, (uintptr_t)addr2);
> 
> Why not merge the two sprintf()s into one?
> sprintf(fmt, "%" PRIxPTR "-%%*x %%s", (uintptr_t)addr2);
> 
> >   	sprintf(fmt, "%s-%%*x %%s", addr_str);
> >   	SAFE_FILE_LINES_SCANF("/proc/self/maps", fmt, perms);
> > 
> > @@ -61,7 +72,7 @@ static void run(unsigned int i)
> > 
> >   						tc-
>exp_perms, perms);
> >   	
> >   	}
> > 
> > -	SAFE_MUNMAP(addr, MMAPSIZE);
> > +	SAFE_MUNMAP(addr1, pagesize * 2);
> > 
> >   }
> >   
> >   static struct tst_test test = {




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
