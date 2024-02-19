Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD62C48BF8
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 20:48:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D3A63D13A6
	for <ltp@archiver.kernel.org>; Mon, 19 Feb 2024 21:48:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 28E493CEFB7
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 21:48:23 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 447591000480
 for <ltp@lists.linux.it>; Mon, 19 Feb 2024 21:48:22 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 95D09221EA;
 Mon, 19 Feb 2024 20:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708375701;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8wBsvmQjGb0ZUDuEeyVBTgcpVkpHXaj1kQl+rRastDY=;
 b=Q5K4l0sSh3GMV6D984V21+jOlNcApDFYgQhY+1ou6DCHjQApRw9Sa0hzOgV7Gjq/iTW4Ca
 g9m1kWydZReffUMdD5aVgBoNILwPA2ZlG8BcdRcZP3wgBufPjudU4/3RJP2cSXPiqkCAT/
 hGL2edAVSp3szLaSQiPL6aQ5tYyhJZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708375701;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8wBsvmQjGb0ZUDuEeyVBTgcpVkpHXaj1kQl+rRastDY=;
 b=uDZUHenSNjm2x6UZl8wkFUSaSqi3mrZMV5WgMCFPcec7FJoO0DNGI3lGNizz4L+e9Z+Bkc
 K8A7KyQQWnZ5oOBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1708375701;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8wBsvmQjGb0ZUDuEeyVBTgcpVkpHXaj1kQl+rRastDY=;
 b=Q5K4l0sSh3GMV6D984V21+jOlNcApDFYgQhY+1ou6DCHjQApRw9Sa0hzOgV7Gjq/iTW4Ca
 g9m1kWydZReffUMdD5aVgBoNILwPA2ZlG8BcdRcZP3wgBufPjudU4/3RJP2cSXPiqkCAT/
 hGL2edAVSp3szLaSQiPL6aQ5tYyhJZI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1708375701;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8wBsvmQjGb0ZUDuEeyVBTgcpVkpHXaj1kQl+rRastDY=;
 b=uDZUHenSNjm2x6UZl8wkFUSaSqi3mrZMV5WgMCFPcec7FJoO0DNGI3lGNizz4L+e9Z+Bkc
 K8A7KyQQWnZ5oOBw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 64B55139F7;
 Mon, 19 Feb 2024 20:48:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id glUvFpW+02V/YQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 19 Feb 2024 20:48:21 +0000
Date: Mon, 19 Feb 2024 21:48:19 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240219204819.GA1057967@pevik>
References: <20240219134030.12693-1-mdoucha@suse.cz>
 <20240219160922.GB1021019@pevik>
 <86169685-b118-4186-951f-7919796dcb93@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <86169685-b118-4186-951f-7919796dcb93@suse.cz>
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Q5K4l0sS;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uDZUHenS
X-Spamd-Result: default: False [-2.51 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 95D09221EA
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] open07: Convert to new API
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

Hi Martin,

TL;DR: merged with fixes.

> On 19. 02. 24 17:09, Petr Vorel wrote:
> > Hi Martin,

> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > Few minor things below, can be fixed before merge.

> > ...
> > >   #define _GNU_SOURCE		/* for O_NOFOLLOW */
> > nit: This now works without _GNU_SOURCE (we compile with -std=gnu99 and it would
> > work for whatever gnu*).

> > > -#include <stdio.h>
> > > -#include <errno.h>
> > > -#include <sys/types.h>
> > >   #include <sys/stat.h>
> > nit: IMHO <sys/stat.h> was not needed even in the old API version.

> Good catch x2. <sys/stat.h> is needed for umask() but it's included through
> tst_safe_macros.h

Ah, good point. I removed it before merge (I hope we never reorganize lib/*.c
that much that we'd remove some includes in include/*.h, because quite a few
tests depends on these indirect includes already).

> > > -#include <fcntl.h>
> > > -#include "test.h"
> > > -#include "safe_macros.h"
> > ...
> > > +#include "tst_test.h"
> > > +#include "tst_safe_macros.h"
> > > +
> > > +#define TESTFILE "testfile"
> > > +#define TESTDIR "testdir"
> > > +#define SYMFILE1 "symfile1"
> > > +#define SYMFILE2 "symfile2"
> > > +#define SYMDIR1 "symdir1"
> > > +#define SYMDIR2 "symdir2"
> > > +#define PASSFILE "symdir1/testfile"
> > > +
> > > +static int fd = -1;
> > nit: any reason for -1? (We don't check the input.)

> I planned to have a cleanup() where the fd would be checked and closed if
> needed. But it wasn't needed in the end and I forgot to remove the
> initialization. The variable can be moved inside setup(). Should I send v2?

Nah, fixed before merge. +1 for pointing out it was for setup() only.

> > > +static struct testcase {
> > > +	const char *path;
> > > +	int err;
> > > +	const char *desc;
> > > +} testcase_list[] = {
> > > +	{SYMFILE1, ELOOP, "open(O_NOFOLLOW) a symlink to file"},
> > > +	{SYMFILE2, ELOOP, "open(O_NOFOLLOW) a double symlink to file"},
> > > +	{SYMDIR1, ELOOP, "open(O_NOFOLLOW) a symlink to directory"},
> > > +	{SYMDIR2, ELOOP, "open(O_NOFOLLOW) a double symlink to directory"},
> > > +	{PASSFILE, 0, "open(O_NOFOLLOW) a file in symlinked directory"},

> > ...
> > > +static void setup(void)
> > >   {
> > > -	char file1[100], file2[100];
> > > -
> > > -	sprintf(file1, "open11.3.%d", getpid());
> > > -	sprintf(file2, "open12.4.%d", getpid());
> > > -	SAFE_MKDIR(cleanup, file1, 00700);
> > > +	umask(0);
> > > +	fd = SAFE_CREAT(TESTFILE, 0644);
> > > +	SAFE_CLOSE(fd);
> > > +	SAFE_MKDIR(TESTDIR, 0755);

> > > -	SAFE_SYMLINK(cleanup, file1, file2);
> > > +	SAFE_SYMLINK(TESTFILE, SYMFILE1);
> > > +	SAFE_SYMLINK(SYMFILE1, SYMFILE2);
> > > +	SAFE_SYMLINK(TESTDIR, SYMDIR1);
> > > +	SAFE_SYMLINK(SYMDIR1, SYMDIR2);

> > > -	strcpy(TC[4].filename, file2);
> > > -	strcat(TC[4].filename, "/");
> > > +	fd = SAFE_CREAT(PASSFILE, 0644);
> > > +	SAFE_CLOSE(fd);
> > >   }

> > > -static void setup(void)
> > > +static void run(unsigned int n)
> > >   {
> > > -	umask(0);
> > > +	const struct testcase *tc = testcase_list + n;

> > > -	tst_sig(NOFORK, DEF_HANDLER, cleanup);
> > > +	TST_RET = -1;
> > nit: IMHO this is not needed (we have 0 for stdin, right? Therefore open()
> > should not get 0 and check below is correct).

> Zero is still a valid file descriptor whether it's used or not. On the other
> hand, TST_RET will be set by open() in both branches below so the
> initialization is not needed at all.

+1

Removed and merged.

Thanks for taking care for these tiny details.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
