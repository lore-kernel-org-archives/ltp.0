Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD167C46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 17:06:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58BBA3CFB50
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 18:06:06 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C5EA3CEC60
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 18:05:50 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 20E5E10000E1
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 18:05:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 043131FD75;
 Wed, 24 Jan 2024 17:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706115949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gDLKhDkUACLmDeF/rNRxvZIvcpSgSXvgxhnLMdMGt18=;
 b=lxAzMnGDT60EiqO5hUa9MPa0ilR7VqYfPMYyzDBU2gWD20cVdysFL/OPNMkMJjw/NQM0OK
 Ae1xApwQFyHnut620iSVQtkCRqXQ0P8PRrSrPkgAj/tfQvm1gECCiEoH1QL7LDr35BWbpN
 vNRaUOLJ78G5OwwSRAqPuEPkqk5VS6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706115949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gDLKhDkUACLmDeF/rNRxvZIvcpSgSXvgxhnLMdMGt18=;
 b=n5HFmWEmoH6io6GqrQOcCQPshFP4DxdOl2JCLY+A38wLmt4Zua9AStTgaXFPcWWm50Ppz8
 sQnW+krZjHmvgaDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706115949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gDLKhDkUACLmDeF/rNRxvZIvcpSgSXvgxhnLMdMGt18=;
 b=lxAzMnGDT60EiqO5hUa9MPa0ilR7VqYfPMYyzDBU2gWD20cVdysFL/OPNMkMJjw/NQM0OK
 Ae1xApwQFyHnut620iSVQtkCRqXQ0P8PRrSrPkgAj/tfQvm1gECCiEoH1QL7LDr35BWbpN
 vNRaUOLJ78G5OwwSRAqPuEPkqk5VS6A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706115949;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gDLKhDkUACLmDeF/rNRxvZIvcpSgSXvgxhnLMdMGt18=;
 b=n5HFmWEmoH6io6GqrQOcCQPshFP4DxdOl2JCLY+A38wLmt4Zua9AStTgaXFPcWWm50Ppz8
 sQnW+krZjHmvgaDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B6B5113786;
 Wed, 24 Jan 2024 17:05:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id vpSHKmxDsWUOMAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 17:05:48 +0000
Date: Wed, 24 Jan 2024 18:05:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240124170547.GA324363@pevik>
References: <325e7294-f6b1-4e27-a51b-8a8e146bf5bc@suse.cz>
 <20240124132603.16199-1-akumar@suse.de>
 <05c3fd69-cee6-4575-8c93-eaeec24af1b6@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <05c3fd69-cee6-4575-8c93-eaeec24af1b6@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-6.30 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; REPLY(-4.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Avinesh, Martin,

> Hi,
> Reviewed-by: Martin Doucha <mdoucha@suse.cz>

> On 24. 01. 24 14:26, Avinesh Kumar wrote:
> > We hit a scenario where new mapping was merged with existing mapping of
> > same permission and the return address from the mmap was hidden in the
> > merged mapping in /proc/self/maps, causing the test to fail.
> > To avoid this, we first  create a 2-page mapping with the different
> > permissions, and then remap the 2nd page with the perms being tested.

> > Signed-off-by: Avinesh Kumar <akumar@suse.de>
> > Reported-by: Martin Doucha <mdoucha@suse.cz>
> > Signed-off-by: Avinesh Kumar <akumar@suse.de>
> > ---
> >   testcases/kernel/syscalls/mmap/mmap04.c | 23 ++++++++++++++++-------
> >   1 file changed, 16 insertions(+), 7 deletions(-)

> > diff --git a/testcases/kernel/syscalls/mmap/mmap04.c b/testcases/kernel/syscalls/mmap/mmap04.c
> > index f6f4f7c98..fa85deed1 100644
> > --- a/testcases/kernel/syscalls/mmap/mmap04.c
> > +++ b/testcases/kernel/syscalls/mmap/mmap04.c
> > @@ -17,8 +17,8 @@
> >   #include "tst_test.h"
> >   #include <stdio.h>
> > -#define MMAPSIZE 1024
> > -static char *addr;
> > +static char *addr1;
> > +static char *addr2;
> >   static struct tcase {
> >   	int prot;
> > @@ -44,14 +44,23 @@ static struct tcase {
> >   static void run(unsigned int i)
> >   {
> >   	struct tcase *tc = &tcases[i];
> > -	char addr_str[20];
> >   	char perms[8];
> >   	char fmt[1024];
> > +	unsigned int pagesize;
> > +	int flag;
> > -	addr = SAFE_MMAP(NULL, MMAPSIZE, tc->prot, tc->flags, -1, 0);
> > +	pagesize = SAFE_SYSCONF(_SC_PAGESIZE);
> > -	sprintf(addr_str, "%" PRIxPTR, (uintptr_t)addr);
> > -	sprintf(fmt, "%s-%%*x %%s", addr_str);
> > +	/* To avoid new mapping getting merged with existing mappings, we first
> > +	 * create a 2-page mapping with the different permissions, and then remap
> > +	 * the 2nd page with the perms being tested.
> > +	 */
> > +	flag = (tc->flags & MAP_PRIVATE) ? MAP_SHARED : MAP_PRIVATE;
> > +	addr1 = SAFE_MMAP(NULL, pagesize * 2, PROT_NONE, MAP_ANONYMOUS | flag, -1, 0);
> > +
> > +	addr2 = SAFE_MMAP(addr1 + pagesize, pagesize, tc->prot, tc->flags | MAP_FIXED, -1, 0);
> > +
> > +	sprintf(fmt, "%" PRIxPTR "-%%*x %%s", (uintptr_t)addr2);
> >   	SAFE_FILE_LINES_SCANF("/proc/self/maps", fmt, perms);
> >   	if (!strcmp(perms, tc->exp_perms)) {
> > @@ -61,7 +70,7 @@ static void run(unsigned int i)
> >   						tc->exp_perms, perms);
> >   	}
> > -	SAFE_MUNMAP(addr, MMAPSIZE);
> > +	SAFE_MUNMAP(addr1, pagesize * 2);

Shouldn't there be also second munmap()?
SAFE_MUNMAP(addr2, pagesize);

Kind regards,
Petr

> >   }
> >   static struct tst_test test = {

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
